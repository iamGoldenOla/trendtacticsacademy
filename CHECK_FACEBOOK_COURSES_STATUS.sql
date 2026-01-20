-- Check which Facebook Ads course is empty and causing loading issues
SELECT 
    c.id,
    c.title,
    COUNT(DISTINCT m.id) as module_count,
    COUNT(DISTINCT l.id) as lesson_count,
    COUNT(DISTINCT CASE WHEN LENGTH(l.content) > 100 THEN l.id END) as lessons_with_content
FROM courses c
LEFT JOIN modules m ON m.course_id = c.id
LEFT JOIN lessons l ON l.module_id = m.id
WHERE c.title ILIKE '%Facebook%'
GROUP BY c.id, c.title
ORDER BY c.title;
