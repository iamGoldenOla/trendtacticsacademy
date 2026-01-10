-- VALID INSERT EXAMPLE WITH REAL UUID FORMAT
-- This script provides the correct format for inserting records

-- Step 1: First, run these queries to get real IDs from your database:

-- Get real user IDs
SELECT id, email FROM auth.users LIMIT 10;

-- Get real course IDs  
SELECT id, title FROM courses LIMIT 10;

-- Step 2: Once you have real IDs, use them in an insert like this:
-- NOTE: Make sure the UUIDs you use are actual IDs from your database

-- Example format (replace with YOUR actual IDs from the queries above):
-- INSERT INTO student_course_access (user_id, course_id, access_status)
-- VALUES 
--   ('ACTUAL_USER_ID_FROM_AUTH_USERS', 'ACTUAL_COURSE_ID_FROM_COURSES', 'active');

-- CORRECT UUID FORMAT EXAMPLE (using valid UUIDs):
-- INSERT INTO student_course_access (user_id, course_id, access_status)
-- VALUES 
--   ('12345678-1234-1234-1234-123456789abc', 'abcdef12-3456-7890-1234-567890abcdef', 'active');

-- Step 3: Verify your insert worked
SELECT * FROM student_course_access ORDER BY created_at DESC LIMIT 5;

-- Step 4: Test the function with your user ID
-- Replace 'YOUR_USER_ID' with an actual user ID from auth.users
-- SELECT * FROM get_student_courses('YOUR_USER_ID');