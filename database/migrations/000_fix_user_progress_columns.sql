-- ============================================================================
-- CRITICAL FIX: Add missing columns to user_progress table
-- ============================================================================
-- Run this FIRST before running 001_deploy_master_schema.sql
-- This ensures user_progress table has all required columns
-- ============================================================================

-- Check if user_progress table exists, if not create it
CREATE TABLE IF NOT EXISTS user_progress (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add user_id column if missing
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'user_progress' 
    AND column_name = 'user_id'
  ) THEN
    ALTER TABLE user_progress ADD COLUMN user_id UUID;
    RAISE NOTICE '✅ Added column: user_progress.user_id';
  ELSE
    RAISE NOTICE '⏭️  Column already exists: user_progress.user_id';
  END IF;
END $$;

-- Add lesson_id column if missing (CRITICAL!)
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'user_progress' 
    AND column_name = 'lesson_id'
  ) THEN
    ALTER TABLE user_progress ADD COLUMN lesson_id UUID;
    RAISE NOTICE '✅ Added column: user_progress.lesson_id';
  ELSE
    RAISE NOTICE '⏭️  Column already exists: user_progress.lesson_id';
  END IF;
END $$;

-- Add completed column if missing
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'user_progress' 
    AND column_name = 'completed'
  ) THEN
    ALTER TABLE user_progress ADD COLUMN completed BOOLEAN DEFAULT FALSE;
    RAISE NOTICE '✅ Added column: user_progress.completed';
  ELSE
    RAISE NOTICE '⏭️  Column already exists: user_progress.completed';
  END IF;
END $$;

-- Add score column if missing
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'user_progress' 
    AND column_name = 'score'
  ) THEN
    ALTER TABLE user_progress ADD COLUMN score DECIMAL(5,2);
    RAISE NOTICE '✅ Added column: user_progress.score';
  ELSE
    RAISE NOTICE '⏭️  Column already exists: user_progress.score';
  END IF;
END $$;

-- Add time_spent column if missing
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'user_progress' 
    AND column_name = 'time_spent'
  ) THEN
    ALTER TABLE user_progress ADD COLUMN time_spent INTEGER;
    RAISE NOTICE '✅ Added column: user_progress.time_spent';
  ELSE
    RAISE NOTICE '⏭️  Column already exists: user_progress.time_spent';
  END IF;
END $$;

-- Add last_accessed_at column if missing
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'user_progress' 
    AND column_name = 'last_accessed_at'
  ) THEN
    ALTER TABLE user_progress ADD COLUMN last_accessed_at TIMESTAMPTZ;
    RAISE NOTICE '✅ Added column: user_progress.last_accessed_at';
  ELSE
    RAISE NOTICE '⏭️  Column already exists: user_progress.last_accessed_at';
  END IF;
END $$;

-- Add completed_at column if missing
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'user_progress' 
    AND column_name = 'completed_at'
  ) THEN
    ALTER TABLE user_progress ADD COLUMN completed_at TIMESTAMPTZ;
    RAISE NOTICE '✅ Added column: user_progress.completed_at';
  ELSE
    RAISE NOTICE '⏭️  Column already exists: user_progress.completed_at';
  END IF;
END $$;

-- Add notes column if missing
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'user_progress' 
    AND column_name = 'notes'
  ) THEN
    ALTER TABLE user_progress ADD COLUMN notes TEXT;
    RAISE NOTICE '✅ Added column: user_progress.notes';
  ELSE
    RAISE NOTICE '⏭️  Column already exists: user_progress.notes';
  END IF;
END $$;

-- Verify all columns exist
DO $$
DECLARE
  column_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO column_count
  FROM information_schema.columns
  WHERE table_schema = 'public' 
  AND table_name = 'user_progress'
  AND column_name IN ('id', 'user_id', 'lesson_id', 'completed', 'score', 
                      'time_spent', 'last_accessed_at', 'completed_at', 'notes',
                      'created_at', 'updated_at');
  
  RAISE NOTICE '';
  RAISE NOTICE '========================================';
  RAISE NOTICE '✅ USER_PROGRESS TABLE READY';
  RAISE NOTICE '========================================';
  RAISE NOTICE 'Total columns: %', column_count;
  RAISE NOTICE '';
  
  IF column_count >= 11 THEN
    RAISE NOTICE '✅ All required columns exist!';
    RAISE NOTICE '✅ You can now run 001_deploy_master_schema.sql';
  ELSE
    RAISE WARNING '⚠️  Expected 11 columns, found %', column_count;
  END IF;
  
  RAISE NOTICE '========================================';
END $$;

