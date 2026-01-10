-- ============================================================================
-- MIGRATION: Deploy Master Schema (Safe for Existing Databases)
-- ============================================================================
-- Version: 1.0.1
-- Date: January 10, 2026
-- Description: Safely deploys master schema to existing or new databases
--
-- This migration:
-- - Creates tables if they don't exist
-- - Adds missing columns to existing tables
-- - Creates indexes, functions, triggers, and RLS policies
-- - Is idempotent (can be run multiple times safely)
--
-- IMPORTANT: Run 000_diagnose_current_schema.sql first to see current state
-- ============================================================================

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================================
-- STEP 1: Create base tables if they don't exist
-- ============================================================================

-- Create courses table
CREATE TABLE IF NOT EXISTS courses (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  instructor_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  category TEXT NOT NULL,
  level TEXT NOT NULL CHECK (level IN ('Beginner', 'Intermediate', 'Advanced')),
  duration TEXT,
  objectives JSONB,
  prerequisites JSONB,
  status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'published', 'archived')),
  price DECIMAL(10,2) DEFAULT 0,
  thumbnail_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create modules table
CREATE TABLE IF NOT EXISTS modules (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  course_id UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  ordering INTEGER NOT NULL,
  duration TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create lessons table
CREATE TABLE IF NOT EXISTS lessons (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  module_id UUID NOT NULL REFERENCES modules(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  content TEXT,
  ordering INTEGER NOT NULL,
  duration TEXT,
  video_url TEXT,
  video_transcript TEXT,
  resources JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create assessments table
CREATE TABLE IF NOT EXISTS assessments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  module_id UUID REFERENCES modules(id) ON DELETE CASCADE,
  lesson_id UUID REFERENCES lessons(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  type TEXT NOT NULL CHECK (type IN ('quiz', 'assignment', 'exam', 'project')),
  questions JSONB NOT NULL,
  passing_score INTEGER DEFAULT 70,
  attempts_allowed INTEGER DEFAULT 3,
  time_limit INTEGER,
  ordering INTEGER,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  CHECK (module_id IS NOT NULL OR lesson_id IS NOT NULL)
);

-- Create student_course_access table
CREATE TABLE IF NOT EXISTS student_course_access (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  course_id UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  purchase_date TIMESTAMPTZ DEFAULT NOW(),
  access_status TEXT DEFAULT 'active' CHECK (access_status IN ('active', 'expired', 'cancelled', 'trial')),
  enrollment_type TEXT DEFAULT 'paid' CHECK (enrollment_type IN ('paid', 'free', 'trial', 'scholarship')),
  expires_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create user_progress table
CREATE TABLE IF NOT EXISTS user_progress (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  lesson_id UUID NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  completed BOOLEAN DEFAULT FALSE,
  score DECIMAL(5,2),
  time_spent INTEGER,
  last_accessed_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create ai_content_generations table
CREATE TABLE IF NOT EXISTS ai_content_generations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  content_type TEXT NOT NULL CHECK (content_type IN ('lesson', 'module', 'assessment', 'resource')),
  content_id UUID NOT NULL,
  prompt_hierarchy JSONB NOT NULL,
  content_hash TEXT NOT NULL,
  model_used TEXT NOT NULL,
  tokens_used INTEGER,
  generation_time_ms INTEGER,
  is_unique BOOLEAN DEFAULT TRUE,
  duplicate_of UUID REFERENCES ai_content_generations(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- STEP 2: Add missing columns to existing tables
-- ============================================================================

-- Add missing columns to courses table
DO $$
BEGIN
  -- Add featured column if missing
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'courses' AND column_name = 'featured'
  ) THEN
    ALTER TABLE courses ADD COLUMN featured BOOLEAN DEFAULT FALSE;
    RAISE NOTICE 'Added column: courses.featured';
  END IF;

  -- Add total_lessons column if missing
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'courses' AND column_name = 'total_lessons'
  ) THEN
    ALTER TABLE courses ADD COLUMN total_lessons INTEGER DEFAULT 0;
    RAISE NOTICE 'Added column: courses.total_lessons';
  END IF;

  -- Add published_at column if missing
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'courses' AND column_name = 'published_at'
  ) THEN
    ALTER TABLE courses ADD COLUMN published_at TIMESTAMPTZ;
    RAISE NOTICE 'Added column: courses.published_at';
  END IF;
END $$;

-- Add missing columns to modules table
DO $$
BEGIN
  -- Add objectives column if missing
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'modules' AND column_name = 'objectives'
  ) THEN
    ALTER TABLE modules ADD COLUMN objectives JSONB;
    RAISE NOTICE 'Added column: modules.objectives';
  END IF;

  -- Add unique constraint if missing
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'modules_course_id_ordering_key'
  ) THEN
    ALTER TABLE modules ADD CONSTRAINT modules_course_id_ordering_key UNIQUE(course_id, ordering);
    RAISE NOTICE 'Added constraint: modules_course_id_ordering_key';
  END IF;
END $$;

-- Add missing columns to lessons table
DO $$
BEGIN
  -- Add AI tracking columns if missing
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'lessons' AND column_name = 'ai_generated'
  ) THEN
    ALTER TABLE lessons ADD COLUMN ai_generated BOOLEAN DEFAULT FALSE;
    RAISE NOTICE 'Added column: lessons.ai_generated';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'lessons' AND column_name = 'ai_prompt_used'
  ) THEN
    ALTER TABLE lessons ADD COLUMN ai_prompt_used TEXT;
    RAISE NOTICE 'Added column: lessons.ai_prompt_used';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'lessons' AND column_name = 'ai_model'
  ) THEN
    ALTER TABLE lessons ADD COLUMN ai_model TEXT;
    RAISE NOTICE 'Added column: lessons.ai_model';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'lessons' AND column_name = 'ai_generation_date'
  ) THEN
    ALTER TABLE lessons ADD COLUMN ai_generation_date TIMESTAMPTZ;
    RAISE NOTICE 'Added column: lessons.ai_generation_date';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'lessons' AND column_name = 'content_hash'
  ) THEN
    ALTER TABLE lessons ADD COLUMN content_hash TEXT;
    RAISE NOTICE 'Added column: lessons.content_hash';
  END IF;

  -- Add interactive feature flags if missing
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'lessons' AND column_name = 'has_whiteboard'
  ) THEN
    ALTER TABLE lessons ADD COLUMN has_whiteboard BOOLEAN DEFAULT FALSE;
    RAISE NOTICE 'Added column: lessons.has_whiteboard';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'lessons' AND column_name = 'has_code_playground'
  ) THEN
    ALTER TABLE lessons ADD COLUMN has_code_playground BOOLEAN DEFAULT FALSE;
    RAISE NOTICE 'Added column: lessons.has_code_playground';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'lessons' AND column_name = 'has_quiz'
  ) THEN
    ALTER TABLE lessons ADD COLUMN has_quiz BOOLEAN DEFAULT FALSE;
    RAISE NOTICE 'Added column: lessons.has_quiz';
  END IF;

  -- Add unique constraint if missing
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'lessons_module_id_ordering_key'
  ) THEN
    ALTER TABLE lessons ADD CONSTRAINT lessons_module_id_ordering_key UNIQUE(module_id, ordering);
    RAISE NOTICE 'Added constraint: lessons_module_id_ordering_key';
  END IF;
END $$;

-- NOTE: user_progress columns are added by 000_fix_user_progress_columns.sql
-- Run that script FIRST before running this one!

-- Add missing constraints to student_course_access
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'student_course_access_user_id_course_id_key'
  ) THEN
    ALTER TABLE student_course_access ADD CONSTRAINT student_course_access_user_id_course_id_key UNIQUE(user_id, course_id);
    RAISE NOTICE 'Added constraint: student_course_access_user_id_course_id_key';
  END IF;
END $$;

-- Add missing constraints to user_progress
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'user_progress_user_id_lesson_id_key'
  ) THEN
    ALTER TABLE user_progress ADD CONSTRAINT user_progress_user_id_lesson_id_key UNIQUE(user_id, lesson_id);
    RAISE NOTICE 'Added constraint: user_progress_user_id_lesson_id_key';
  END IF;
END $$;

-- Add missing constraints to ai_content_generations
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'ai_content_generations_content_hash_key'
  ) THEN
    ALTER TABLE ai_content_generations ADD CONSTRAINT ai_content_generations_content_hash_key UNIQUE(content_hash);
    RAISE NOTICE 'Added constraint: ai_content_generations_content_hash_key';
  END IF;
END $$;

-- ============================================================================
-- STEP 3: Create indexes
-- ============================================================================

-- Courses indexes
CREATE INDEX IF NOT EXISTS idx_courses_status ON courses(status);
CREATE INDEX IF NOT EXISTS idx_courses_category ON courses(category);
CREATE INDEX IF NOT EXISTS idx_courses_instructor ON courses(instructor_id);
CREATE INDEX IF NOT EXISTS idx_courses_created_at ON courses(created_at DESC);

-- Add featured index if column exists
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'courses' AND column_name = 'featured'
  ) THEN
    CREATE INDEX IF NOT EXISTS idx_courses_featured ON courses(featured);
  END IF;
END $$;

-- Modules indexes
CREATE INDEX IF NOT EXISTS idx_modules_course ON modules(course_id);
CREATE INDEX IF NOT EXISTS idx_modules_ordering ON modules(course_id, ordering);

-- Lessons indexes
CREATE INDEX IF NOT EXISTS idx_lessons_module ON lessons(module_id);
CREATE INDEX IF NOT EXISTS idx_lessons_ordering ON lessons(module_id, ordering);

-- Add ai_generated index if column exists
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'lessons' AND column_name = 'ai_generated'
  ) THEN
    CREATE INDEX IF NOT EXISTS idx_lessons_ai_generated ON lessons(ai_generated);
  END IF;
END $$;

-- Add content_hash index if column exists
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'lessons' AND column_name = 'content_hash'
  ) THEN
    CREATE INDEX IF NOT EXISTS idx_lessons_content_hash ON lessons(content_hash);
  END IF;
END $$;

-- Assessments indexes
CREATE INDEX IF NOT EXISTS idx_assessments_module ON assessments(module_id);
CREATE INDEX IF NOT EXISTS idx_assessments_lesson ON assessments(lesson_id);

-- Student course access indexes
CREATE INDEX IF NOT EXISTS idx_student_course_access_user ON student_course_access(user_id);
CREATE INDEX IF NOT EXISTS idx_student_course_access_course ON student_course_access(course_id);
CREATE INDEX IF NOT EXISTS idx_student_course_access_status ON student_course_access(access_status);

-- User progress indexes
CREATE INDEX IF NOT EXISTS idx_user_progress_user ON user_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_user_progress_lesson ON user_progress(lesson_id);
CREATE INDEX IF NOT EXISTS idx_user_progress_completed ON user_progress(user_id, completed);

-- AI generations indexes
CREATE INDEX IF NOT EXISTS idx_ai_generations_content ON ai_content_generations(content_type, content_id);
CREATE INDEX IF NOT EXISTS idx_ai_generations_hash ON ai_content_generations(content_hash);

-- ============================================================================
-- STEP 4: Create functions
-- ============================================================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = NOW();
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function to generate content hash
CREATE OR REPLACE FUNCTION generate_content_hash(content TEXT)
RETURNS TEXT AS $$
BEGIN
   RETURN encode(digest(content, 'sha256'), 'hex');
END;
$$ LANGUAGE plpgsql;

-- Function to check content uniqueness
CREATE OR REPLACE FUNCTION check_content_uniqueness(p_content_hash TEXT)
RETURNS BOOLEAN AS $$
BEGIN
   RETURN NOT EXISTS (
      SELECT 1 FROM lessons WHERE content_hash = p_content_hash
   );
END;
$$ LANGUAGE plpgsql;

-- Function to get student's enrolled courses
CREATE OR REPLACE FUNCTION get_student_courses(p_user_id UUID)
RETURNS TABLE(
    course_id UUID,
    course_title TEXT,
    course_description TEXT,
    course_level TEXT,
    course_category TEXT,
    course_image_url TEXT,
    total_lessons INTEGER,
    completed_lessons INTEGER,
    progress_percentage DECIMAL(5,2),
    enrollment_date TIMESTAMPTZ,
    access_status TEXT
) AS $$
DECLARE
    has_total_lessons BOOLEAN;
BEGIN
    -- Check if total_lessons column exists
    SELECT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
        AND table_name = 'courses'
        AND column_name = 'total_lessons'
    ) INTO has_total_lessons;

    IF has_total_lessons THEN
        -- Use total_lessons column if it exists
        RETURN QUERY
        SELECT
            c.id,
            c.title,
            c.description,
            c.level,
            c.category,
            c.thumbnail_url,
            COALESCE(c.total_lessons, 0),
            COUNT(DISTINCT CASE WHEN up.completed = TRUE THEN up.lesson_id END)::INTEGER as completed_lessons,
            CASE
                WHEN COALESCE(c.total_lessons, 0) > 0 THEN
                    (COUNT(DISTINCT CASE WHEN up.completed = TRUE THEN up.lesson_id END)::DECIMAL / c.total_lessons * 100)
                ELSE 0
            END as progress_percentage,
            sca.purchase_date,
            sca.access_status
        FROM courses c
        INNER JOIN student_course_access sca ON c.id = sca.course_id
        LEFT JOIN modules m ON m.course_id = c.id
        LEFT JOIN lessons l ON l.module_id = m.id
        LEFT JOIN user_progress up ON up.lesson_id = l.id AND up.user_id = p_user_id
        WHERE sca.user_id = p_user_id
          AND sca.access_status = 'active'
        GROUP BY c.id, c.title, c.description, c.level, c.category, c.thumbnail_url,
                 c.total_lessons, sca.purchase_date, sca.access_status
        ORDER BY sca.purchase_date DESC;
    ELSE
        -- Calculate total_lessons on the fly if column doesn't exist
        RETURN QUERY
        SELECT
            c.id,
            c.title,
            c.description,
            c.level,
            c.category,
            c.thumbnail_url,
            COUNT(DISTINCT l.id)::INTEGER as total_lessons,
            COUNT(DISTINCT CASE WHEN up.completed = TRUE THEN up.lesson_id END)::INTEGER as completed_lessons,
            CASE
                WHEN COUNT(DISTINCT l.id) > 0 THEN
                    (COUNT(DISTINCT CASE WHEN up.completed = TRUE THEN up.lesson_id END)::DECIMAL / COUNT(DISTINCT l.id) * 100)
                ELSE 0
            END as progress_percentage,
            sca.purchase_date,
            sca.access_status
        FROM courses c
        INNER JOIN student_course_access sca ON c.id = sca.course_id
        LEFT JOIN modules m ON m.course_id = c.id
        LEFT JOIN lessons l ON l.module_id = m.id
        LEFT JOIN user_progress up ON up.lesson_id = l.id AND up.user_id = p_user_id
        WHERE sca.user_id = p_user_id
          AND sca.access_status = 'active'
        GROUP BY c.id, c.title, c.description, c.level, c.category, c.thumbnail_url,
                 sca.purchase_date, sca.access_status
        ORDER BY sca.purchase_date DESC;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- STEP 5: Update existing data (if needed)
-- ============================================================================

-- Calculate total_lessons for existing courses (only if column exists)
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'courses' AND column_name = 'total_lessons'
  ) THEN
    UPDATE courses c
    SET total_lessons = (
      SELECT COUNT(*)
      FROM lessons l
      JOIN modules m ON m.id = l.module_id
      WHERE m.course_id = c.id
    )
    WHERE total_lessons = 0 OR total_lessons IS NULL;

    RAISE NOTICE 'Updated total_lessons for existing courses';
  END IF;
END $$;

-- ============================================================================
-- STEP 6: Verification
-- ============================================================================

DO $$
DECLARE
  table_count INTEGER;
  function_count INTEGER;
BEGIN
  -- Count tables
  SELECT COUNT(*) INTO table_count
  FROM information_schema.tables
  WHERE table_schema = 'public'
  AND table_name IN ('courses', 'modules', 'lessons', 'assessments', 
                     'student_course_access', 'user_progress', 'ai_content_generations');
  
  -- Count functions
  SELECT COUNT(*) INTO function_count
  FROM pg_proc p
  JOIN pg_namespace n ON p.pronamespace = n.oid
  WHERE n.nspname = 'public'
  AND p.proname IN ('get_student_courses', 'update_updated_at_column',
                    'generate_content_hash', 'check_content_uniqueness');

  RAISE NOTICE '✅ Migration complete!';
  RAISE NOTICE 'Tables created/updated: %', table_count;
  RAISE NOTICE 'Functions created: %', function_count;

  IF table_count < 7 THEN
    RAISE WARNING 'Expected 7 tables, found %', table_count;
  END IF;

  IF function_count < 4 THEN
    RAISE WARNING 'Expected 4 functions, found %', function_count;
  END IF;
END $$;

