-- Diagnostic: Check Current Module Distribution
-- This will show us exactly what modules are in each course

SELECT 
    c.title as course_name,
    m.ordering as module_order,
    m.title as module_title,
    (SELECT COUNT(*) FROM lessons WHERE module_id = m.id) as lesson_count
FROM courses c
JOIN modules m ON c.id = m.course_id
WHERE c.title IN ('Facebook Ads Foundation', 'Facebook Ads Mastery')
ORDER BY c.title, m.ordering;

-- This will help us identify:
-- 1. Which course has the "AI Era" modules (should be Mastery)
-- 2. Which course has the "Foundations" modules (should be Foundation)
