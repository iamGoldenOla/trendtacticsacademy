-- ============================================================================
-- TRENDTACTICS DIGITAL ACADEMY - MASTER DATABASE SCHEMA
-- ============================================================================
-- Version: 1.0.0
-- Created: January 10, 2026
-- Purpose: Single source of truth for all database tables and relationships
-- 
-- This schema supports:
-- - 3 courses (Vibe Coding, Facebook Ads, Prompt Engineering)
-- - Hierarchical content structure (Course → Module → Lesson)
-- - AI-generated content with uniqueness tracking
-- - Student progress tracking
-- - Course enrollment and access control
-- ============================================================================

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================================
-- TABLE: courses
-- Purpose: Store course information
-- ============================================================================
CREATE TABLE IF NOT EXISTS courses (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  instructor_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  category TEXT NOT NULL,
  level TEXT NOT NULL CHECK (level IN ('Beginner', 'Intermediate', 'Advanced')),
  duration TEXT, -- e.g., "8 weeks", "26 lessons"
  objectives JSONB, -- Array of learning objectives
  prerequisites JSONB, -- Array of prerequisites
  status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'published', 'archived')),
  price DECIMAL(10,2) DEFAULT 0,
  thumbnail_url TEXT,
  featured BOOLEAN DEFAULT FALSE,
  total_lessons INTEGER DEFAULT 0, -- Denormalized count for performance
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  published_at TIMESTAMPTZ
);

-- ============================================================================
-- TABLE: modules
-- Purpose: Organize lessons into logical groups within a course
-- ============================================================================
CREATE TABLE IF NOT EXISTS modules (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  course_id UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  ordering INTEGER NOT NULL, -- Order within the course (1, 2, 3, ...)
  duration TEXT, -- e.g., "2 weeks", "8 lessons"
  objectives JSONB, -- Module-specific learning objectives
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(course_id, ordering) -- Ensure no duplicate ordering within a course
);

-- ============================================================================
-- TABLE: lessons
-- Purpose: Store individual lesson content
-- ============================================================================
CREATE TABLE IF NOT EXISTS lessons (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  module_id UUID NOT NULL REFERENCES modules(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  content TEXT, -- Main lesson content (Markdown or HTML)
  ordering INTEGER NOT NULL, -- Order within the module (1, 2, 3, ...)
  duration TEXT, -- e.g., "30 minutes", "1 hour"
  video_url TEXT, -- YouTube or other video URL
  video_transcript TEXT, -- For accessibility and search
  resources JSONB, -- Array of additional resources (links, files, etc.)

  -- AI Generation Tracking
  ai_generated BOOLEAN DEFAULT FALSE,
  ai_prompt_used TEXT, -- The prompt hierarchy used to generate this lesson
  ai_model TEXT, -- e.g., "gpt-4", "claude-3"
  ai_generation_date TIMESTAMPTZ,

  -- Interactive Features
  has_whiteboard BOOLEAN DEFAULT FALSE,
  has_code_playground BOOLEAN DEFAULT FALSE,
  has_quiz BOOLEAN DEFAULT FALSE,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(module_id, ordering) -- Ensure no duplicate ordering within a module
);

-- Add content_hash column if it doesn't exist (for existing databases)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'lessons' AND column_name = 'content_hash'
  ) THEN
    ALTER TABLE lessons ADD COLUMN content_hash TEXT;
  END IF;
END $$;

-- ============================================================================
-- TABLE: assessments
-- Purpose: Store quizzes, assignments, and exams
-- ============================================================================
CREATE TABLE IF NOT EXISTS assessments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  module_id UUID REFERENCES modules(id) ON DELETE CASCADE,
  lesson_id UUID REFERENCES lessons(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  type TEXT NOT NULL CHECK (type IN ('quiz', 'assignment', 'exam', 'project')),
  questions JSONB NOT NULL, -- Array of question objects
  passing_score INTEGER DEFAULT 70,
  attempts_allowed INTEGER DEFAULT 3,
  time_limit INTEGER, -- in minutes
  ordering INTEGER,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  CHECK (module_id IS NOT NULL OR lesson_id IS NOT NULL) -- Must belong to either module or lesson
);

-- ============================================================================
-- TABLE: enrollments (student_course_access)
-- Purpose: Track which students have access to which courses
-- ============================================================================
CREATE TABLE IF NOT EXISTS student_course_access (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  course_id UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  purchase_date TIMESTAMPTZ DEFAULT NOW(),
  access_status TEXT DEFAULT 'active' CHECK (access_status IN ('active', 'expired', 'cancelled', 'trial')),
  enrollment_type TEXT DEFAULT 'paid' CHECK (enrollment_type IN ('paid', 'free', 'trial', 'scholarship')),
  expires_at TIMESTAMPTZ, -- For trial or time-limited access
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, course_id) -- One enrollment per user per course
);

-- ============================================================================
-- TABLE: user_progress
-- Purpose: Track student progress through lessons
-- ============================================================================
CREATE TABLE IF NOT EXISTS user_progress (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  lesson_id UUID NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  completed BOOLEAN DEFAULT FALSE,
  score DECIMAL(5,2), -- For assessments
  time_spent INTEGER, -- in seconds
  last_accessed_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  notes TEXT, -- Student's personal notes
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, lesson_id) -- One progress record per user per lesson
);

-- ============================================================================
-- TABLE: ai_content_generations
-- Purpose: Track all AI-generated content for uniqueness and auditing
-- ============================================================================
CREATE TABLE IF NOT EXISTS ai_content_generations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  content_type TEXT NOT NULL CHECK (content_type IN ('lesson', 'module', 'assessment', 'resource')),
  content_id UUID NOT NULL, -- References the generated content
  prompt_hierarchy JSONB NOT NULL, -- Full prompt hierarchy used
  content_hash TEXT NOT NULL, -- SHA-256 hash of generated content
  model_used TEXT NOT NULL,
  tokens_used INTEGER,
  generation_time_ms INTEGER,
  is_unique BOOLEAN DEFAULT TRUE,
  duplicate_of UUID REFERENCES ai_content_generations(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(content_hash) -- Ensure content uniqueness
);

-- ============================================================================
-- INDEXES FOR PERFORMANCE
-- ============================================================================

-- Courses indexes
CREATE INDEX IF NOT EXISTS idx_courses_status ON courses(status);
CREATE INDEX IF NOT EXISTS idx_courses_category ON courses(category);
CREATE INDEX IF NOT EXISTS idx_courses_instructor ON courses(instructor_id);
CREATE INDEX IF NOT EXISTS idx_courses_featured ON courses(featured);
CREATE INDEX IF NOT EXISTS idx_courses_created_at ON courses(created_at DESC);

-- Modules indexes
CREATE INDEX IF NOT EXISTS idx_modules_course ON modules(course_id);
CREATE INDEX IF NOT EXISTS idx_modules_ordering ON modules(course_id, ordering);

-- Lessons indexes
CREATE INDEX IF NOT EXISTS idx_lessons_module ON lessons(module_id);
CREATE INDEX IF NOT EXISTS idx_lessons_ordering ON lessons(module_id, ordering);
CREATE INDEX IF NOT EXISTS idx_lessons_ai_generated ON lessons(ai_generated);

-- Create content_hash index only if column exists
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'lessons' AND column_name = 'content_hash'
  ) THEN
    CREATE INDEX IF NOT EXISTS idx_lessons_content_hash ON lessons(content_hash);
  END IF;
END $$;

-- Assessments indexes
CREATE INDEX IF NOT EXISTS idx_assessments_module ON assessments(module_id);
CREATE INDEX IF NOT EXISTS idx_assessments_lesson ON assessments(lesson_id);

-- Enrollments indexes
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
-- FUNCTIONS
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
BEGIN
    RETURN QUERY
    SELECT
        c.id,
        c.title,
        c.description,
        c.level,
        c.category,
        c.thumbnail_url,
        c.total_lessons,
        COUNT(DISTINCT up.lesson_id) FILTER (WHERE up.completed = TRUE)::INTEGER as completed_lessons,
        CASE
            WHEN c.total_lessons > 0 THEN
                (COUNT(DISTINCT up.lesson_id) FILTER (WHERE up.completed = TRUE)::DECIMAL / c.total_lessons * 100)
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
END;
$$ LANGUAGE plpgsql;

-- Function to get course structure with progress
CREATE OR REPLACE FUNCTION get_course_structure(p_course_id UUID, p_user_id UUID)
RETURNS JSONB AS $$
DECLARE
    result JSONB;
BEGIN
    SELECT jsonb_build_object(
        'course', jsonb_build_object(
            'id', c.id,
            'title', c.title,
            'description', c.description,
            'total_lessons', c.total_lessons
        ),
        'modules', (
            SELECT jsonb_agg(
                jsonb_build_object(
                    'id', m.id,
                    'title', m.title,
                    'description', m.description,
                    'ordering', m.ordering,
                    'lessons', (
                        SELECT jsonb_agg(
                            jsonb_build_object(
                                'id', l.id,
                                'title', l.title,
                                'description', l.description,
                                'ordering', l.ordering,
                                'duration', l.duration,
                                'completed', COALESCE(up.completed, FALSE)
                            ) ORDER BY l.ordering
                        )
                        FROM lessons l
                        LEFT JOIN user_progress up ON up.lesson_id = l.id AND up.user_id = p_user_id
                        WHERE l.module_id = m.id
                    )
                ) ORDER BY m.ordering
            )
            FROM modules m
            WHERE m.course_id = c.id
        )
    ) INTO result
    FROM courses c
    WHERE c.id = p_course_id;

    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- TRIGGERS
-- ============================================================================

-- Automatically update updated_at timestamps
DROP TRIGGER IF EXISTS update_courses_updated_at ON courses;
CREATE TRIGGER update_courses_updated_at
BEFORE UPDATE ON courses
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_modules_updated_at ON modules;
CREATE TRIGGER update_modules_updated_at
BEFORE UPDATE ON modules
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_lessons_updated_at ON lessons;
CREATE TRIGGER update_lessons_updated_at
BEFORE UPDATE ON lessons
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_assessments_updated_at ON assessments;
CREATE TRIGGER update_assessments_updated_at
BEFORE UPDATE ON assessments
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_student_course_access_updated_at ON student_course_access;
CREATE TRIGGER update_student_course_access_updated_at
BEFORE UPDATE ON student_course_access
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_user_progress_updated_at ON user_progress;
CREATE TRIGGER update_user_progress_updated_at
BEFORE UPDATE ON user_progress
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE modules ENABLE ROW LEVEL SECURITY;
ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE assessments ENABLE ROW LEVEL SECURITY;
ALTER TABLE student_course_access ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_content_generations ENABLE ROW LEVEL SECURITY;

-- Courses: Public can view published courses, authenticated users can view all
DROP POLICY IF EXISTS "Public can view published courses" ON courses;
CREATE POLICY "Public can view published courses" ON courses
  FOR SELECT USING (status = 'published');

DROP POLICY IF EXISTS "Authenticated users can view all courses" ON courses;
CREATE POLICY "Authenticated users can view all courses" ON courses
  FOR SELECT TO authenticated USING (TRUE);

-- Modules: Accessible if course is accessible
DROP POLICY IF EXISTS "Users can view modules of accessible courses" ON modules;
CREATE POLICY "Users can view modules of accessible courses" ON modules
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM courses c
      WHERE c.id = modules.course_id
      AND (c.status = 'published' OR auth.uid() IS NOT NULL)
    )
  );

-- Lessons: Accessible if module is accessible
DROP POLICY IF EXISTS "Users can view lessons of accessible modules" ON lessons;
CREATE POLICY "Users can view lessons of accessible modules" ON lessons
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM modules m
      JOIN courses c ON c.id = m.course_id
      WHERE m.id = lessons.module_id
      AND (c.status = 'published' OR auth.uid() IS NOT NULL)
    )
  );

-- Assessments: Accessible if parent is accessible
DROP POLICY IF EXISTS "Users can view assessments" ON assessments;
CREATE POLICY "Users can view assessments" ON assessments
  FOR SELECT USING (TRUE);

-- Student Course Access: Users can only see their own enrollments
DROP POLICY IF EXISTS "Users can view their own course access" ON student_course_access;
CREATE POLICY "Users can view their own course access" ON student_course_access
  FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can insert their own course access" ON student_course_access;
CREATE POLICY "Users can insert their own course access" ON student_course_access
  FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can update their own course access" ON student_course_access;
CREATE POLICY "Users can update their own course access" ON student_course_access
  FOR UPDATE USING (auth.uid() = user_id);

-- User Progress: Users can only see and modify their own progress
DROP POLICY IF EXISTS "Users can view their own progress" ON user_progress;
CREATE POLICY "Users can view their own progress" ON user_progress
  FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can insert their own progress" ON user_progress;
CREATE POLICY "Users can insert their own progress" ON user_progress
  FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can update their own progress" ON user_progress;
CREATE POLICY "Users can update their own progress" ON user_progress
  FOR UPDATE USING (auth.uid() = user_id);

-- AI Content Generations: Read-only for authenticated users
DROP POLICY IF EXISTS "Authenticated users can view AI generations" ON ai_content_generations;
CREATE POLICY "Authenticated users can view AI generations" ON ai_content_generations
  FOR SELECT TO authenticated USING (TRUE);

-- ============================================================================
-- GRANTS
-- ============================================================================

-- Grant permissions to authenticated users
GRANT SELECT ON courses TO authenticated, anon;
GRANT SELECT ON modules TO authenticated, anon;
GRANT SELECT ON lessons TO authenticated, anon;
GRANT SELECT ON assessments TO authenticated, anon;
GRANT ALL ON student_course_access TO authenticated;
GRANT ALL ON user_progress TO authenticated;
GRANT SELECT ON ai_content_generations TO authenticated;

-- Grant execute permissions on functions
GRANT EXECUTE ON FUNCTION get_student_courses(UUID) TO authenticated, anon;
GRANT EXECUTE ON FUNCTION get_course_structure(UUID, UUID) TO authenticated, anon;
GRANT EXECUTE ON FUNCTION generate_content_hash(TEXT) TO authenticated;
GRANT EXECUTE ON FUNCTION check_content_uniqueness(TEXT) TO authenticated;

-- ============================================================================
-- INITIAL DATA VALIDATION
-- ============================================================================

-- Verify schema is ready
DO $$
BEGIN
    RAISE NOTICE '✅ Master schema created successfully';
    RAISE NOTICE 'Tables: courses, modules, lessons, assessments, student_course_access, user_progress, ai_content_generations';
    RAISE NOTICE 'Functions: get_student_courses, get_course_structure, generate_content_hash, check_content_uniqueness';
    RAISE NOTICE 'RLS: Enabled on all tables with appropriate policies';
END $$;

-- ============================================================================
-- NOTES FOR DEVELOPERS
-- ============================================================================
--
-- 1. COURSE STRUCTURE:
--    - Each course should have exactly the specified number of lessons:
--      * Vibe Coding: 26 lessons
--      * Facebook Ads: 26 lessons
--      * Prompt Engineering: 16 lessons
--
-- 2. AI CONTENT GENERATION:
--    - Always use the prompt hierarchy (System → Course → Module → Lesson)
--    - Check content_hash before saving to ensure uniqueness
--    - Log all generations in ai_content_generations table
--
-- 3. STUDENT PROGRESS:
--    - Update user_progress when lessons are completed
--    - Recalculate course progress_percentage regularly
--    - Track time_spent for analytics
--
-- 4. ENROLLMENT:
--    - Use student_course_access for access control
--    - Support multiple enrollment types (paid, free, trial, scholarship)
--    - Handle expiration for trial/time-limited access
--
-- 5. PERFORMANCE:
--    - All critical queries have indexes
--    - Use get_course_structure() for efficient data fetching
--    - Denormalize total_lessons in courses table for performance
--
-- ============================================================================
-- END OF MASTER SCHEMA
-- ============================================================================

