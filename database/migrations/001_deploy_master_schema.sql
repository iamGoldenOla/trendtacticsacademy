-- ============================================================================
-- MIGRATION: Deploy Master Schema (Safe for Existing Databases)
-- ============================================================================
-- Version: 1.0.0
-- Date: January 10, 2026
-- Description: Safely deploys master schema to existing or new databases
-- 
-- This migration:
-- - Creates tables if they don't exist
-- - Adds missing columns to existing tables
-- - Creates indexes, functions, triggers, and RLS policies
-- - Is idempotent (can be run multiple times safely)
-- ============================================================================

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================================
-- STEP 1: Create or update tables
-- ============================================================================

-- Import the master schema
\i '../schema/master-schema.sql'

-- ============================================================================
-- STEP 2: Add missing columns to existing tables (if any)
-- ============================================================================

-- Add missing columns to courses table
DO $$ 
BEGIN
  -- Add featured column if missing
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'featured'
  ) THEN
    ALTER TABLE courses ADD COLUMN featured BOOLEAN DEFAULT FALSE;
  END IF;
  
  -- Add total_lessons column if missing
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'total_lessons'
  ) THEN
    ALTER TABLE courses ADD COLUMN total_lessons INTEGER DEFAULT 0;
  END IF;
  
  -- Add published_at column if missing
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'published_at'
  ) THEN
    ALTER TABLE courses ADD COLUMN published_at TIMESTAMPTZ;
  END IF;
END $$;

-- Add missing columns to modules table
DO $$ 
BEGIN
  -- Add objectives column if missing
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'modules' AND column_name = 'objectives'
  ) THEN
    ALTER TABLE modules ADD COLUMN objectives JSONB;
  END IF;
END $$;

-- Add missing columns to lessons table
DO $$ 
BEGIN
  -- Add AI tracking columns if missing
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'ai_generated'
  ) THEN
    ALTER TABLE lessons ADD COLUMN ai_generated BOOLEAN DEFAULT FALSE;
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'ai_prompt_used'
  ) THEN
    ALTER TABLE lessons ADD COLUMN ai_prompt_used TEXT;
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'ai_model'
  ) THEN
    ALTER TABLE lessons ADD COLUMN ai_model TEXT;
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'ai_generation_date'
  ) THEN
    ALTER TABLE lessons ADD COLUMN ai_generation_date TIMESTAMPTZ;
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'content_hash'
  ) THEN
    ALTER TABLE lessons ADD COLUMN content_hash TEXT;
  END IF;
  
  -- Add interactive feature flags if missing
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'has_whiteboard'
  ) THEN
    ALTER TABLE lessons ADD COLUMN has_whiteboard BOOLEAN DEFAULT FALSE;
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'has_code_playground'
  ) THEN
    ALTER TABLE lessons ADD COLUMN has_code_playground BOOLEAN DEFAULT FALSE;
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'has_quiz'
  ) THEN
    ALTER TABLE lessons ADD COLUMN has_quiz BOOLEAN DEFAULT FALSE;
  END IF;
END $$;

-- ============================================================================
-- STEP 3: Update existing data (if needed)
-- ============================================================================

-- Calculate total_lessons for existing courses
UPDATE courses c
SET total_lessons = (
  SELECT COUNT(*)
  FROM lessons l
  JOIN modules m ON m.id = l.module_id
  WHERE m.course_id = c.id
)
WHERE total_lessons = 0 OR total_lessons IS NULL;

-- ============================================================================
-- STEP 4: Verification
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
  AND p.proname IN ('get_student_courses', 'get_course_structure', 
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

