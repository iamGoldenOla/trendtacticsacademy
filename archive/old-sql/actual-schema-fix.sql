-- Actual schema fix based on your real database structure

-- First, let's check constraints on courses table
SELECT conname, pg_get_constraintdef(c.oid) 
FROM pg_constraint c 
JOIN pg_namespace n ON n.oid = c.connamespace 
WHERE conrelid = 'courses'::regclass AND contype = 'c';

-- Check constraints on lessons table
SELECT conname, pg_get_constraintdef(c.oid) 
FROM pg_constraint c 
JOIN pg_namespace n ON n.oid = c.connamespace 
WHERE conrelid = 'lessons'::regclass AND contype = 'c';

-- Fix courses table - add missing columns without violating constraints
ALTER TABLE courses ADD COLUMN IF NOT EXISTS instructor_id UUID;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS category TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS objectives JSONB;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS prerequisites JSONB;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS price DECIMAL(10,2) DEFAULT 0;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS thumbnail_url TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS published_at TIMESTAMP WITH TIME ZONE;

-- Handle courses duration column (it might have constraints)
DO $$ 
BEGIN
  -- If courses duration column exists as TEXT, we'll keep it as TEXT for now
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'duration' AND data_type = 'text'
  ) THEN
    RAISE NOTICE 'courses.duration is already TEXT, keeping as is';
  -- If courses duration column doesn't exist, create it as TEXT to match existing pattern
  ELSIF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'duration'
  ) THEN
    ALTER TABLE courses ADD COLUMN duration TEXT;
    RAISE NOTICE 'Added duration column as TEXT to courses table';
  END IF;
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Could not modify courses.duration column: %', SQLERRM;
END $$;

-- Fix modules table
ALTER TABLE modules ADD COLUMN IF NOT EXISTS ordering INTEGER;

-- Handle modules duration column
DO $$ 
BEGIN
  -- If modules duration column doesn't exist, create it as TEXT to match existing pattern
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'modules' AND column_name = 'duration'
  ) THEN
    ALTER TABLE modules ADD COLUMN duration TEXT;
    RAISE NOTICE 'Added duration column as TEXT to modules table';
  END IF;
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Could not modify modules.duration column: %', SQLERRM;
END $$;

-- Fix lessons table - it already has most columns based on your output
ALTER TABLE lessons ADD COLUMN IF NOT EXISTS resources JSONB;
ALTER TABLE lessons ADD COLUMN IF NOT EXISTS ordering INTEGER;  -- This will be in addition to order_index

-- Handle lessons duration column - it's already TEXT based on your output
-- We'll keep it as TEXT to match existing data

-- Create assessments table since it's required but missing
CREATE TABLE IF NOT EXISTS assessments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  module_id UUID REFERENCES modules(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  type TEXT, -- 'quiz', 'assignment', 'exam'
  questions JSONB,
  passing_score INTEGER DEFAULT 70,
  attempts_allowed INTEGER DEFAULT 3,
  time_limit INTEGER, -- in minutes
  ordering INTEGER,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_courses_category ON courses(category) WHERE category IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_courses_is_published ON courses(is_published) WHERE is_published IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_modules_course ON modules(course_id) WHERE course_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_modules_ordering ON modules(ordering) WHERE ordering IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_lessons_module ON lessons(module_id) WHERE module_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_lessons_ordering ON lessons(ordering) WHERE ordering IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_lessons_order_index ON lessons(order_index) WHERE order_index IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_assessments_module ON assessments(module_id) WHERE module_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_assessments_ordering ON assessments(ordering) WHERE ordering IS NOT NULL;

-- Insert sample data respecting constraints
-- First check what values are allowed for level
DO $$ 
BEGIN
  -- Try inserting with a valid level value
  INSERT INTO courses (title, description, category, level, duration, is_published) VALUES
    ('Introduction to Web Development', 'Learn the fundamentals of web development', 'Web Development', 'beginner', '4 weeks', true)
  ON CONFLICT DO NOTHING;
  
  RAISE NOTICE 'Inserted sample course with level=beginner';
EXCEPTION WHEN OTHERS THEN
  -- If that fails, try without specifying level
  BEGIN
    INSERT INTO courses (title, description, category, duration, is_published) VALUES
      ('Introduction to Web Development', 'Learn the fundamentals of web development', 'Web Development', '4 weeks', true)
    ON CONFLICT DO NOTHING;
    RAISE NOTICE 'Inserted sample course without level';
  EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Could not insert sample course: %', SQLERRM;
  END;
END $$;