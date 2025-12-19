-- Verify the complete Vibe Coding course setup

-- Check course
SELECT 'Course' as item, title, id FROM courses WHERE id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890';

-- Check modules
SELECT 'Module' as item, title, id, course_id FROM modules WHERE course_id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890' ORDER BY ordering;

-- Check lessons count per module
SELECT 
    m.title as module_title,
    COUNT(l.id) as lesson_count
FROM modules m
LEFT JOIN lessons l ON m.id = l.module_id
WHERE m.course_id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
GROUP BY m.title, m.ordering
ORDER BY m.ordering;

-- Check one lesson content to verify it's populated
SELECT 
    l.title as lesson_title,
    LENGTH(l.content::text) as content_length
FROM lessons l
JOIN modules m ON l.module_id = m.id
WHERE m.course_id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
LIMIT 3;

-- Total counts
SELECT 
    (SELECT COUNT(*) FROM courses WHERE id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890') as course_count,
    (SELECT COUNT(*) FROM modules WHERE course_id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890') as module_count,
    (SELECT COUNT(*) FROM lessons WHERE module_id IN (
        SELECT id FROM modules WHERE course_id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
    )) as lesson_count;