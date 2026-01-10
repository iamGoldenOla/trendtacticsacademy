-- Clean fix script that works with existing table structure
-- This script adds missing columns without referencing non-existent ones

-- Add missing columns to courses table
ALTER TABLE courses ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'draft';
ALTER TABLE courses ADD COLUMN IF NOT EXISTS instructor_id UUID;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS category TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS level TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS duration TEXT;  -- This will be added as TEXT
ALTER TABLE courses ADD COLUMN IF NOT EXISTS objectives JSONB;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS prerequisites JSONB;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS price DECIMAL(10,2) DEFAULT 0;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS thumbnail_url TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS published_at TIMESTAMP WITH TIME ZONE;

-- Fix duration column type if it exists as INTEGER
DO $$ 
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' 
    AND column_name = 'duration' 
    AND data_type = 'integer'
  ) THEN
    ALTER TABLE courses ALTER COLUMN duration TYPE TEXT;
  END IF;
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Could not alter courses.duration column: %', SQLERRM;
END $$;

-- Add missing columns to modules table
ALTER TABLE modules ADD COLUMN IF NOT EXISTS ordering INTEGER;
ALTER TABLE modules ADD COLUMN IF NOT EXISTS duration TEXT;  -- This will be added as TEXT

-- Fix duration column type if it exists as INTEGER
DO $$ 
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'modules' 
    AND column_name = 'duration' 
    AND data_type = 'integer'
  ) THEN
    ALTER TABLE modules ALTER COLUMN duration TYPE TEXT;
  END IF;
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Could not alter modules.duration column: %', SQLERRM;
END $$;

-- Add missing columns to lessons table
ALTER TABLE lessons ADD COLUMN IF NOT EXISTS ordering INTEGER;
ALTER TABLE lessons ADD COLUMN IF NOT EXISTS duration TEXT;  -- This will be added as TEXT
ALTER TABLE lessons ADD COLUMN IF NOT EXISTS resources JSONB;

-- Fix duration column type if it exists as INTEGER
DO $$ 
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' 
    AND column_name = 'duration' 
    AND data_type = 'integer'
  ) THEN
    ALTER TABLE lessons ALTER COLUMN duration TYPE TEXT;
  END IF;
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Could not alter lessons.duration column: %', SQLERRM;
END $$;

-- Add missing columns to assessments table
ALTER TABLE assessments ADD COLUMN IF NOT EXISTS ordering INTEGER;
ALTER TABLE assessments ADD COLUMN IF NOT EXISTS questions JSONB;
ALTER TABLE assessments ADD COLUMN IF NOT EXISTS passing_score INTEGER DEFAULT 70;
ALTER TABLE assessments ADD COLUMN IF NOT EXISTS attempts_allowed INTEGER DEFAULT 3;
ALTER TABLE assessments ADD COLUMN IF NOT EXISTS time_limit INTEGER;
ALTER TABLE assessments ADD COLUMN IF NOT EXISTS type TEXT;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_courses_status ON courses(status);
CREATE INDEX IF NOT EXISTS idx_courses_category ON courses(category);
CREATE INDEX IF NOT EXISTS idx_modules_course ON modules(course_id) WHERE course_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_modules_ordering ON modules(ordering) WHERE ordering IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_lessons_module ON lessons(module_id) WHERE module_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_lessons_ordering ON lessons(ordering) WHERE ordering IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_assessments_module ON assessments(module_id) WHERE module_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_assessments_ordering ON assessments(ordering) WHERE ordering IS NOT NULL;

-- Insert sample data with proper conflict handling
INSERT INTO courses (title, description, category, level, duration, status) VALUES
  ('Introduction to Web Development', 'Learn the fundamentals of web development', 'Web Development', 'Beginner', '4 weeks', 'published')
ON CONFLICT DO NOTHING;

INSERT INTO courses (title, description, category, level, duration, status) VALUES
  ('Mobile App Development with React Native', 'Build cross-platform mobile apps', 'App Development', 'Intermediate', '6 weeks', 'published')
ON CONFLICT DO NOTHING;

INSERT INTO courses (title, description, category, level, duration, status) VALUES
  ('Digital Marketing Mastery', 'Master digital marketing strategies', 'Digital Marketing', 'Beginner', '5 weeks', 'draft')
ON CONFLICT DO NOTHING;