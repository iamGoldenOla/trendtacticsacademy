-- Correct schema fix based on actual table structure
-- Using is_published instead of status, and integer for duration

-- First, check what tables actually exist
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';

-- Check structure of existing courses table
SELECT column_name, data_type FROM information_schema.columns 
WHERE table_name = 'courses' ORDER BY ordinal_position;

-- Check structure of existing lessons table
SELECT column_name, data_type FROM information_schema.columns 
WHERE table_name = 'lessons' ORDER BY ordinal_position;

-- Check structure of existing modules table
SELECT column_name, data_type FROM information_schema.columns 
WHERE table_name = 'modules' ORDER BY ordinal_position;

-- Fix courses table columns
ALTER TABLE courses ADD COLUMN IF NOT EXISTS instructor_id UUID;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS category TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS level TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS duration INTEGER;  -- INTEGER, not TEXT
ALTER TABLE courses ADD COLUMN IF NOT EXISTS objectives JSONB;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS prerequisites JSONB;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS price DECIMAL(10,2) DEFAULT 0;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS thumbnail_url TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS published_at TIMESTAMP WITH TIME ZONE;

-- Ensure duration is INTEGER (not TEXT as we tried before)
DO $$ 
BEGIN
  -- If duration column exists as TEXT, change it to INTEGER
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'duration' AND data_type = 'text'
  ) THEN
    ALTER TABLE courses ALTER COLUMN duration TYPE INTEGER USING duration::INTEGER;
    RAISE NOTICE 'Changed courses.duration from TEXT to INTEGER';
  -- If duration column doesn't exist, create it as INTEGER
  ELSIF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'duration'
  ) THEN
    ALTER TABLE courses ADD COLUMN duration INTEGER;
    RAISE NOTICE 'Added duration column as INTEGER to courses table';
  ELSE
    RAISE NOTICE 'courses.duration column is already correct';
  END IF;
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Could not modify courses.duration column: %', SQLERRM;
END $$;

-- Fix modules table columns
ALTER TABLE modules ADD COLUMN IF NOT EXISTS ordering INTEGER;

-- Ensure modules duration is INTEGER
DO $$ 
BEGIN
  -- If duration column exists as TEXT, change it to INTEGER
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'modules' AND column_name = 'duration' AND data_type = 'text'
  ) THEN
    ALTER TABLE modules ALTER COLUMN duration TYPE INTEGER USING duration::INTEGER;
    RAISE NOTICE 'Changed modules.duration from TEXT to INTEGER';
  -- If duration column doesn't exist, create it as INTEGER
  ELSIF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'modules' AND column_name = 'duration'
  ) THEN
    ALTER TABLE modules ADD COLUMN duration INTEGER;
    RAISE NOTICE 'Added duration column as INTEGER to modules table';
  ELSE
    RAISE NOTICE 'modules.duration column is already correct';
  END IF;
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Could not modify modules.duration column: %', SQLERRM;
END $$;

-- Fix lessons table columns
ALTER TABLE lessons ADD COLUMN IF NOT EXISTS ordering INTEGER;
ALTER TABLE lessons ADD COLUMN IF NOT EXISTS resources JSONB;

-- Ensure lessons duration is INTEGER
DO $$ 
BEGIN
  -- If duration column exists as TEXT, change it to INTEGER
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'duration' AND data_type = 'text'
  ) THEN
    ALTER TABLE lessons ALTER COLUMN duration TYPE INTEGER USING duration::INTEGER;
    RAISE NOTICE 'Changed lessons.duration from TEXT to INTEGER';
  -- If duration column doesn't exist, create it as INTEGER
  ELSIF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'duration'
  ) THEN
    ALTER TABLE lessons ADD COLUMN duration INTEGER;
    RAISE NOTICE 'Added duration column as INTEGER to lessons table';
  ELSE
    RAISE NOTICE 'lessons.duration column is already correct';
  END IF;
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Could not modify lessons.duration column: %', SQLERRM;
END $$;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_courses_category ON courses(category);
CREATE INDEX IF NOT EXISTS idx_modules_course ON modules(course_id) WHERE course_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_modules_ordering ON modules(ordering) WHERE ordering IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_lessons_module ON lessons(module_id) WHERE module_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_lessons_ordering ON lessons(ordering) WHERE ordering IS NOT NULL;

-- Insert sample data with INTEGER durations (not text)
INSERT INTO courses (title, description, category, level, duration, is_published) VALUES
  ('Introduction to Web Development', 'Learn the fundamentals of web development', 'Web Development', 'Beginner', 4, true)
ON CONFLICT DO NOTHING;

INSERT INTO courses (title, description, category, level, duration, is_published) VALUES
  ('Mobile App Development with React Native', 'Build cross-platform mobile apps', 'App Development', 'Intermediate', 6, true)
ON CONFLICT DO NOTHING;

INSERT INTO courses (title, description, category, level, duration, is_published) VALUES
  ('Digital Marketing Mastery', 'Master digital marketing strategies', 'Digital Marketing', 'Beginner', 5, false)
ON CONFLICT DO NOTHING;