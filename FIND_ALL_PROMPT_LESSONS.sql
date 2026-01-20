-- ============================================================================
-- FIND ALL PROMPT ENGINEERING LESSONS ACROSS ALL COURSES
-- ============================================================================

-- Find ALL Prompt Engineering courses
SELECT id, title FROM courses WHERE title ILIKE '%Prompt%';

-- Find lessons in BOTH Prompt Engineering courses
SELECT 
    c.title as course_title,
    l.title as lesson_title,
    l.id as lesson_id,
    CASE WHEN l.key_takeaways IS NOT NULL THEN '✅' ELSE '❌' END as complete
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Prompt%'
ORDER BY c.title, l.title;

-- Count lessons per course
SELECT 
    c.title as course,
    COUNT(l.id) as lesson_count
FROM courses c
LEFT JOIN lessons l ON l.course_id = c.id
WHERE c.title ILIKE '%Prompt%'
GROUP BY c.id, c.title;
