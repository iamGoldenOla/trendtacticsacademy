-- ============================================================================
-- SCHEMA VERIFICATION SCRIPT
-- ============================================================================
-- Run this first to check what columns actually exist in your database
-- ============================================================================

-- Check courses table structure
SELECT 
  column_name, 
  data_type, 
  is_nullable,
  column_default
FROM information_schema.columns 
WHERE table_name = 'courses' 
  AND table_schema = 'public'
ORDER BY ordinal_position;

-- Check modules table structure
SELECT 
  column_name, 
  data_type, 
  is_nullable,
  column_default
FROM information_schema.columns 
WHERE table_name = 'modules' 
  AND table_schema = 'public'
ORDER BY ordinal_position;

-- Check lessons table structure
SELECT 
  column_name, 
  data_type, 
  is_nullable,
  column_default
FROM information_schema.columns 
WHERE table_name = 'lessons' 
  AND table_schema = 'public'
ORDER BY ordinal_position;

-- Check courses level constraint
SELECT 
  con.conname AS constraint_name,
  pg_get_constraintdef(con.oid) AS constraint_definition
FROM pg_constraint con
JOIN pg_class rel ON rel.oid = con.conrelid
WHERE rel.relname = 'courses'
  AND con.contype = 'c';

-- Check existing data counts
SELECT 
  'courses' as table_name,
  COUNT(*) as row_count
FROM courses
UNION ALL
SELECT 
  'modules' as table_name,
  COUNT(*) as row_count
FROM modules
UNION ALL
SELECT 
  'lessons' as table_name,
  COUNT(*) as row_count
FROM lessons;

