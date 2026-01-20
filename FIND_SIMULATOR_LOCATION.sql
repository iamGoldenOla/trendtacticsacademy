-- Check which course has the simulator integrated
SELECT 
    c.title as course_title,
    m.title as module_title,
    l.title as lesson_title,
    l.playground IS NOT NULL as has_playground,
    l.playground->>'url' as simulator_url
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title ILIKE '%Facebook%'
AND l.playground IS NOT NULL
ORDER BY c.title, m.ordering, l.ordering;
