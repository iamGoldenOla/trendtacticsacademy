-- VERIFY DATABASE SETUP
-- Run this script after completing the step-by-step setup to verify everything is working

-- 1. Check if the student_course_access table exists
SELECT 
    'student_course_access table exists' as check,
    CASE 
        WHEN EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'student_course_access') 
        THEN '✅ YES' 
        ELSE '❌ NO' 
    END as result;

-- 2. Check the structure of the student_course_access table
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'student_course_access'
ORDER BY ordinal_position;

-- 3. Check if the get_student_courses function exists
SELECT 
    'get_student_courses function exists' as check,
    CASE 
        WHEN EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'get_student_courses') 
        THEN '✅ YES' 
        ELSE '❌ NO' 
    END as result;

-- 4. Check RLS policies
SELECT 
    policyname,
    permissive,
    roles,
    cmd,
    qual
FROM pg_policies
WHERE tablename = 'student_course_access';

-- 5. Check if there are any records in the table (should be empty initially)
SELECT 
    'student_course_access records count' as check,
    COUNT(*) as count
FROM student_course_access;

-- 6. Test the function with a sample UUID (this will return empty but should not error)
-- Note: Replace '00000000-0000-0000-0000-000000000000' with an actual user UUID to test properly
-- SELECT * FROM get_student_courses('00000000-0000-0000-0000-000000000000');