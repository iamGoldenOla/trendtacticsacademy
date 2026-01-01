-- GET ACTUAL IDs FOR TESTING
-- Run these queries to find real user IDs and course IDs

-- 1. Get all users from auth.users table
SELECT 
    id,
    email,
    created_at
FROM auth.users
ORDER BY created_at DESC;

-- 2. Get all courses from the courses table
SELECT 
    id,
    title,
    description,
    category,
    level,
    created_at
FROM courses
ORDER BY created_at DESC;

-- 3. Check if the student_course_access table exists and has any records
SELECT 
    'student_course_access table check' as info,
    COUNT(*) as total_records
FROM student_course_access;

-- 4. If you want to see existing records (if any)
SELECT 
    id,
    user_id,
    course_id,
    access_status,
    purchase_date
FROM student_course_access
LIMIT 10;

-- 5. Once you have real IDs from the queries above, use them in an insert like this:
-- INSERT INTO student_course_access (user_id, course_id, access_status)
-- VALUES 
--   ('ACTUAL_USER_ID_FROM_QUERY_1', 'ACTUAL_COURSE_ID_FROM_QUERY_2', 'active');

-- Example with actual UUID format (replace with real IDs from your queries):
-- INSERT INTO student_course_access (user_id, course_id, access_status)
-- VALUES 
--   ('12345678-1234-1234-1234-123456789012', '87654321-4321-4321-4321-210987654321', 'active');