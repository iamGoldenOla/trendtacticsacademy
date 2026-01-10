-- Adaptive fix script for existing table structure
-- This script will work with your current table structure

-- First, let's see what columns exist in each table
SELECT 
    table_name,
    column_name, 
    data_type, 
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name IN ('courses', 'modules', 'lessons', 'assessments')
ORDER BY table_name, ordinal_position;

-- Fix the lessons table duration column if it's INTEGER
DO $$ 
BEGIN
  -- Check if lessons table has duration column as INTEGER
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' 
    AND column_name = 'duration' 
    AND data_type = 'integer'
  ) THEN
    -- Alter column to TEXT
    ALTER TABLE lessons ALTER COLUMN duration TYPE TEXT;
    RAISE NOTICE 'Changed lessons.duration from INTEGER to TEXT';
  ELSE
    RAISE NOTICE 'lessons.duration is already correct or does not exist';
  END IF;
  
  -- Add missing columns to lessons table if needed
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'ordering'
  ) THEN
    ALTER TABLE lessons ADD COLUMN ordering INTEGER;
    RAISE NOTICE 'Added ordering column to lessons table';
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'resources'
  ) THEN
    ALTER TABLE lessons ADD COLUMN resources JSONB;
    RAISE NOTICE 'Added resources column to lessons table';
  END IF;
  
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Error in lessons table fix: %', SQLERRM;
END $$;

-- Fix the courses table columns
DO $$ 
BEGIN
  -- Fix courses duration column if it's INTEGER
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' 
    AND column_name = 'duration' 
    AND data_type = 'integer'
  ) THEN
    ALTER TABLE courses ALTER COLUMN duration TYPE TEXT;
    RAISE NOTICE 'Changed courses.duration from INTEGER to TEXT';
  ELSE
    RAISE NOTICE 'courses.duration is already correct or does not exist';
  END IF;
  
  -- Add missing columns to courses table if needed
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'status'
  ) THEN
    ALTER TABLE courses ADD COLUMN status TEXT DEFAULT 'draft';
    RAISE NOTICE 'Added status column to courses table';
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'instructor_id'
  ) THEN
    ALTER TABLE courses ADD COLUMN instructor_id UUID;
    RAISE NOTICE 'Added instructor_id column to courses table';
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'category'
  ) THEN
    ALTER TABLE courses ADD COLUMN category TEXT;
    RAISE NOTICE 'Added category column to courses table';
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'level'
  ) THEN
    ALTER TABLE courses ADD COLUMN level TEXT;
    RAISE NOTICE 'Added level column to courses table';
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'objectives'
  ) THEN
    ALTER TABLE courses ADD COLUMN objectives JSONB;
    RAISE NOTICE 'Added objectives column to courses table';
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'prerequisites'
  ) THEN
    ALTER TABLE courses ADD COLUMN prerequisites JSONB;
    RAISE NOTICE 'Added prerequisites column to courses table';
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'price'
  ) THEN
    ALTER TABLE courses ADD COLUMN price DECIMAL(10,2) DEFAULT 0;
    RAISE NOTICE 'Added price column to courses table';
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'thumbnail_url'
  ) THEN
    ALTER TABLE courses ADD COLUMN thumbnail_url TEXT;
    RAISE NOTICE 'Added thumbnail_url column to courses table';
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'published_at'
  ) THEN
    ALTER TABLE courses ADD COLUMN published_at TIMESTAMP WITH TIME ZONE;
    RAISE NOTICE 'Added published_at column to courses table';
  END IF;
  
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Error in courses table fix: %', SQLERRM;
END $$;

-- Fix the modules table
DO $$ 
BEGIN
  -- Fix modules duration column if it's INTEGER
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'modules' 
    AND column_name = 'duration' 
    AND data_type = 'integer'
  ) THEN
    ALTER TABLE modules ALTER COLUMN duration TYPE TEXT;
    RAISE NOTICE 'Changed modules.duration from INTEGER to TEXT';
  ELSE
    RAISE NOTICE 'modules.duration is already correct or does not exist';
  END IF;
  
  -- Add missing columns to modules table if needed
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'modules' AND column_name = 'ordering'
  ) THEN
    ALTER TABLE modules ADD COLUMN ordering INTEGER;
    RAISE NOTICE 'Added ordering column to modules table';
  END IF;
  
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Error in modules table fix: %', SQLERRM;
END $$;

-- Fix the assessments table
DO $$ 
BEGIN
  -- Add missing columns to assessments table if needed
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'assessments' AND column_name = 'ordering'
  ) THEN
    ALTER TABLE assessments ADD COLUMN ordering INTEGER;
    RAISE NOTICE 'Added ordering column to assessments table';
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'assessments' AND column_name = 'questions'
  ) THEN
    ALTER TABLE assessments ADD COLUMN questions JSONB;
    RAISE NOTICE 'Added questions column to assessments table';
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'assessments' AND column_name = 'passing_score'
  ) THEN
    ALTER TABLE assessments ADD COLUMN passing_score INTEGER DEFAULT 70;
    RAISE NOTICE 'Added passing_score column to assessments table';
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'assessments' AND column_name = 'attempts_allowed'
  ) THEN
    ALTER TABLE assessments ADD COLUMN attempts_allowed INTEGER DEFAULT 3;
    RAISE NOTICE 'Added attempts_allowed column to assessments table';
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'assessments' AND column_name = 'time_limit'
  ) THEN
    ALTER TABLE assessments ADD COLUMN time_limit INTEGER;
    RAISE NOTICE 'Added time_limit column to assessments table';
  END IF;
  
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Error in assessments table fix: %', SQLERRM;
END $$;

-- Create indexes if they don't exist
CREATE INDEX IF NOT EXISTS idx_courses_status ON courses(status);
CREATE INDEX IF NOT EXISTS idx_courses_category ON courses(category);
CREATE INDEX IF NOT EXISTS idx_modules_course ON modules(course_id) WHERE course_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_modules_ordering ON modules(ordering) WHERE ordering IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_lessons_module ON lessons(module_id) WHERE module_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_lessons_ordering ON lessons(ordering) WHERE ordering IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_assessments_module ON assessments(module_id) WHERE module_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_assessments_ordering ON assessments(ordering) WHERE ordering IS NOT NULL;