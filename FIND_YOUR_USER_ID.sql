-- FIND YOUR USER ID
-- Run this query to find your specific user account

-- Look for your email address in the results
SELECT 
    id,
    email,
    created_at,
    updated_at
FROM auth.users 
WHERE email ILIKE '%your-email%'  -- Replace %your-email% with part of your email
ORDER BY created_at DESC;

-- If you don't know your exact email, try this to see all users:
SELECT 
    id,
    email,
    created_at
FROM auth.users
ORDER BY created_at DESC;

-- Once you find your user ID, use it in the insert statement like:
-- INSERT INTO student_course_access (user_id, course_id, access_status)
-- VALUES ('YOUR_ACTUAL_USER_ID', 'SOME_COURSE_ID', 'active');