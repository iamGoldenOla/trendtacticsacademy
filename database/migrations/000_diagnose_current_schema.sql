-- ============================================================================
-- DIAGNOSTIC: Check Current Database Schema
-- ============================================================================
-- Run this first to see what exists in your database
-- ============================================================================

-- Check which tables exist
SELECT 
  'TABLES' as check_type,
  table_name,
  'EXISTS' as status
FROM information_schema.tables
WHERE table_schema = 'public'
AND table_name IN ('courses', 'modules', 'lessons', 'assessments', 
                   'student_course_access', 'user_progress', 'ai_content_generations')
ORDER BY table_name;

-- Check columns in courses table
SELECT 
  'COURSES COLUMNS' as check_type,
  column_name,
  data_type,
  is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'courses'
ORDER BY ordinal_position;

-- Check columns in modules table
SELECT 
  'MODULES COLUMNS' as check_type,
  column_name,
  data_type,
  is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'modules'
ORDER BY ordinal_position;

-- Check columns in lessons table
SELECT 
  'LESSONS COLUMNS' as check_type,
  column_name,
  data_type,
  is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'lessons'
ORDER BY ordinal_position;

-- Check columns in assessments table (if exists)
SELECT 
  'ASSESSMENTS COLUMNS' as check_type,
  column_name,
  data_type,
  is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'assessments'
ORDER BY ordinal_position;

-- Check columns in student_course_access table (if exists)
SELECT 
  'STUDENT_COURSE_ACCESS COLUMNS' as check_type,
  column_name,
  data_type,
  is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'student_course_access'
ORDER BY ordinal_position;

-- Check columns in user_progress table (if exists)
SELECT 
  'USER_PROGRESS COLUMNS' as check_type,
  column_name,
  data_type,
  is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'user_progress'
ORDER BY ordinal_position;

-- Check which functions exist
SELECT 
  'FUNCTIONS' as check_type,
  p.proname as function_name,
  pg_get_function_arguments(p.oid) as arguments
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public'
AND p.proname IN ('get_student_courses', 'get_course_structure', 
                  'generate_content_hash', 'check_content_uniqueness',
                  'update_updated_at_column')
ORDER BY p.proname;

-- Check RLS status
SELECT 
  'RLS STATUS' as check_type,
  tablename as table_name,
  rowsecurity as rls_enabled
FROM pg_tables
WHERE schemaname = 'public'
AND tablename IN ('courses', 'modules', 'lessons', 'assessments', 
                  'student_course_access', 'user_progress', 'ai_content_generations')
ORDER BY tablename;

-- Summary
SELECT 
  'SUMMARY' as report,
  (SELECT COUNT(*) FROM information_schema.tables 
   WHERE table_schema = 'public' 
   AND table_name IN ('courses', 'modules', 'lessons', 'assessments', 
                      'student_course_access', 'user_progress', 'ai_content_generations')) as tables_exist,
  (SELECT COUNT(*) FROM pg_proc p
   JOIN pg_namespace n ON p.pronamespace = n.oid
   WHERE n.nspname = 'public'
   AND p.proname IN ('get_student_courses', 'get_course_structure', 
                     'generate_content_hash', 'check_content_uniqueness')) as functions_exist;

