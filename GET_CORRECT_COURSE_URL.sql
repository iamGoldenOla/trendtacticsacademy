-- ============================================================================
-- FIND THE CORRECT COURSE URL
-- ============================================================================

-- Get the actual Prompt Engineering course ID
SELECT 
    id,
    title,
    'https://academy.trendtacticsdigital.com/course.html?id=' || id as correct_url
FROM courses 
WHERE title ILIKE '%Prompt%Engineering%'
LIMIT 1;

-- Also check all courses to see what you have
SELECT 
    id,
    title,
    'https://academy.trendtacticsdigital.com/course.html?id=' || id as url
FROM courses
ORDER BY created_at DESC;
