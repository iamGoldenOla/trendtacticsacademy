-- INSERT TEST COURSES FOR VERIFICATION
-- This script adds sample course access records to test the system

-- First, let's check if there are any courses in the courses table
SELECT 
    'Available courses in the system:' as info,
    id,
    title,
    category,
    level
FROM courses
LIMIT 10;

-- Insert some sample course access records for testing
-- NOTE: Replace 'YOUR_USER_ID_HERE' with your actual user ID from auth.users table
-- You can find your user ID by running: SELECT id, email FROM auth.users LIMIT 10;

-- Example (replace with actual user ID):
-- INSERT INTO student_course_access (user_id, course_id, access_status)
-- VALUES 
--   ('YOUR_USER_ID_HERE', 'COURSE_ID_HERE', 'active'),
--   ('YOUR_USER_ID_HERE', 'ANOTHER_COURSE_ID_HERE', 'active');

-- For testing purposes, let's insert a few sample records with placeholder IDs
-- You'll need to replace these with actual UUIDs from your auth.users and courses tables

-- To find your user ID, run this query in Supabase:
-- SELECT id, email FROM auth.users WHERE email = 'your-email@example.com';

-- To find course IDs, run this query in Supabase:
-- SELECT id, title FROM courses;

-- Sample insert (this will fail with placeholder IDs, use as template):
/*
INSERT INTO student_course_access (user_id, course_id, access_status)
VALUES 
  ('123e4567-e89b-12d3-a456-426614174000', '98765432-e12b-4d3a-b567-789012345678', 'active'),
  ('123e4567-e89b-12d3-a456-426614174000', '87654321-d21c-3c2b-a456-678901234567', 'active');
*/

-- Check if the student_course_access table is empty
SELECT 
    'Current student_course_access records:' as info,
    COUNT(*) as total_records
FROM student_course_access;

-- Show existing records (if any)
SELECT 
    id,
    user_id,
    course_id,
    access_status,
    purchase_date
FROM student_course_access
ORDER BY purchase_date DESC;

-- Verification query to test the get_student_courses function
-- Replace 'TEST_USER_ID' with an actual user ID to test the function
-- SELECT * FROM get_student_courses('TEST_USER_ID');