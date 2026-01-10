-- Fix table structure script
-- This script will safely update existing tables to fix data type issues

-- Fix courses table duration column if it's INTEGER
DO $$ 
BEGIN
  -- Check if duration column exists and is INTEGER
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' 
    AND column_name = 'duration' 
    AND data_type = 'integer'
  ) THEN
    -- Alter column to TEXT
    ALTER TABLE courses ALTER COLUMN duration TYPE TEXT;
  END IF;
  
  -- Check if duration column doesn't exist, create it as TEXT
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' 
    AND column_name = 'duration'
  ) THEN
    ALTER TABLE courses ADD COLUMN duration TEXT;
  END IF;
  
  -- Check if ordering column exists in courses (should not exist)
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'courses' 
    AND column_name = 'ordering'
  ) THEN
    -- Rename to avoid confusion
    ALTER TABLE courses RENAME COLUMN ordering TO course_ordering;
  END IF;
EXCEPTION WHEN OTHERS THEN
  -- Handle any errors
  RAISE NOTICE 'Error occurred while fixing courses table: %', SQLERRM;
END $$;

-- Fix modules table duration column if it's INTEGER
DO $$ 
BEGIN
  -- Check if duration column exists and is INTEGER
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'modules' 
    AND column_name = 'duration' 
    AND data_type = 'integer'
  ) THEN
    -- Alter column to TEXT
    ALTER TABLE modules ALTER COLUMN duration TYPE TEXT;
  END IF;
  
  -- Check if duration column doesn't exist, create it as TEXT
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'modules' 
    AND column_name = 'duration'
  ) THEN
    ALTER TABLE modules ADD COLUMN duration TEXT;
  END IF;
EXCEPTION WHEN OTHERS THEN
  -- Handle any errors
  RAISE NOTICE 'Error occurred while fixing modules table: %', SQLERRM;
END $$;

-- Fix lessons table duration column if it's INTEGER
DO $$ 
BEGIN
  -- Check if duration column exists and is INTEGER
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' 
    AND column_name = 'duration' 
    AND data_type = 'integer'
  ) THEN
    -- Alter column to TEXT
    ALTER TABLE lessons ALTER COLUMN duration TYPE TEXT;
  END IF;
  
  -- Check if duration column doesn't exist, create it as TEXT
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' 
    AND column_name = 'duration'
  ) THEN
    ALTER TABLE lessons ADD COLUMN duration TEXT;
  END IF;
EXCEPTION WHEN OTHERS THEN
  -- Handle any errors
  RAISE NOTICE 'Error occurred while fixing lessons table: %', SQLERRM;
END $$;

-- Ensure all ordering columns are INTEGER (they should be)
DO $$ 
BEGIN
  -- Check modules.ordering
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'modules' 
    AND column_name = 'ordering' 
    AND data_type != 'integer'
  ) THEN
    -- Alter column to INTEGER
    ALTER TABLE modules ALTER COLUMN ordering TYPE INTEGER USING ordering::INTEGER;
  END IF;
  
  -- Check lessons.ordering
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' 
    AND column_name = 'ordering' 
    AND data_type != 'integer'
  ) THEN
    -- Alter column to INTEGER
    ALTER TABLE lessons ALTER COLUMN ordering TYPE INTEGER USING ordering::INTEGER;
  END IF;
  
  -- Check assessments.ordering
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'assessments' 
    AND column_name = 'ordering' 
    AND data_type != 'integer'
  ) THEN
    -- Alter column to INTEGER
    ALTER TABLE assessments ALTER COLUMN ordering TYPE INTEGER USING ordering::INTEGER;
  END IF;
EXCEPTION WHEN OTHERS THEN
  -- Handle any errors
  RAISE NOTICE 'Error occurred while fixing ordering columns: %', SQLERRM;
END $$;