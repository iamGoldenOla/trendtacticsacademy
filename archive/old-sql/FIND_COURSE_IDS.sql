-- FIND COURSE IDS
-- Run this query to see all available courses in your database

SELECT 
    id,
    title,
    description,
    category,
    level,
    created_at
FROM courses
ORDER BY created_at DESC;

-- Once you identify a course you want to enroll in, use its ID in the insert statement like:
-- INSERT INTO student_course_access (user_id, course_id, access_status)
-- VALUES ('YOUR_ACTUAL_USER_ID', 'THE_COURSE_ID_YOU_CHOSE', 'active');