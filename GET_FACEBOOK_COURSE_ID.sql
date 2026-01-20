-- Get the exact course ID for Facebook Ads course
SELECT 
    id as course_id,
    title,
    description
FROM courses
WHERE title ILIKE '%Building Profitable%'
OR title ILIKE '%Facebook Ads%'
ORDER BY title;
