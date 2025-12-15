-- Safe final fix script - checks existence before making changes

-- Check what columns exist in courses table
SELECT column_name, data_type FROM information_schema.columns 
WHERE table_name = 'courses' ORDER BY ordinal_position;

-- Check what columns exist in lessons table
SELECT column_name, data_type FROM information_schema.columns 
WHERE table_name = 'lessons' ORDER BY ordinal_position;

-- Add columns to courses table one by one, safely
ALTER TABLE courses ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'draft';
ALTER TABLE courses ADD COLUMN IF NOT EXISTS instructor_id UUID;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS category TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS level TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS objectives JSONB;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS prerequisites JSONB;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS price DECIMAL(10,2) DEFAULT 0;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS thumbnail_url TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS published_at TIMESTAMP WITH TIME ZONE;

-- Handle duration column separately to avoid type conflicts
DO $$ 
BEGIN
  -- If duration column doesn't exist, create it as TEXT
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'duration'
  ) THEN
    ALTER TABLE courses ADD COLUMN duration TEXT;
    RAISE NOTICE 'Added duration column as TEXT to courses table';
  -- If duration column exists as INTEGER, change it to TEXT
  ELSIF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' AND column_name = 'duration' AND data_type = 'integer'
  ) THEN
    ALTER TABLE courses ALTER COLUMN duration TYPE TEXT;
    RAISE NOTICE 'Changed duration column from INTEGER to TEXT in courses table';
  ELSE
    RAISE NOTICE 'courses.duration column is already correct';
  END IF;
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Could not modify courses.duration column: %', SQLERRM;
END $$;

-- Add columns to modules table
ALTER TABLE modules ADD COLUMN IF NOT EXISTS ordering INTEGER;

DO $$ 
BEGIN
  -- Handle modules duration column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'modules' AND column_name = 'duration'
  ) THEN
    ALTER TABLE modules ADD COLUMN duration TEXT;
    RAISE NOTICE 'Added duration column as TEXT to modules table';
  ELSIF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'modules' AND column_name = 'duration' AND data_type = 'integer'
  ) THEN
    ALTER TABLE modules ALTER COLUMN duration TYPE TEXT;
    RAISE NOTICE 'Changed duration column from INTEGER to TEXT in modules table';
  ELSE
    RAISE NOTICE 'modules.duration column is already correct';
  END IF;
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Could not modify modules.duration column: %', SQLERRM;
END $$;

-- Add columns to lessons table
ALTER TABLE lessons ADD COLUMN IF NOT EXISTS ordering INTEGER;
ALTER TABLE lessons ADD COLUMN IF NOT EXISTS resources JSONB;

DO $$ 
BEGIN
  -- Handle lessons duration column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'duration'
  ) THEN
    ALTER TABLE lessons ADD COLUMN duration TEXT;
    RAISE NOTICE 'Added duration column as TEXT to lessons table';
  ELSIF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'duration' AND data_type = 'integer'
  ) THEN
    ALTER TABLE lessons ALTER COLUMN duration TYPE TEXT;
    RAISE NOTICE 'Changed duration column from INTEGER to TEXT in lessons table';
  ELSE
    RAISE NOTICE 'lessons.duration column is already correct';
  END IF;
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Could not modify lessons.duration column: %', SQLERRM;
END $$;

-- Add columns to assessments table
ALTER TABLE assessments ADD COLUMN IF NOT EXISTS ordering INTEGER;
ALTER TABLE assessments ADD COLUMN IF NOT EXISTS questions JSONB;
ALTER TABLE assessments ADD COLUMN IF NOT EXISTS passing_score INTEGER DEFAULT 70;
ALTER TABLE assessments ADD COLUMN IF NOT EXISTS attempts_allowed INTEGER DEFAULT 3;
ALTER TABLE assessments ADD COLUMN IF NOT EXISTS time_limit INTEGER;
ALTER TABLE assessments ADD COLUMN IF NOT EXISTS type TEXT;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_courses_status ON courses(status);
CREATE INDEX IF NOT EXISTS idx_courses_category ON courses(category);