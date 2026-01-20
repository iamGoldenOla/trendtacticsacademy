-- ==========================================
-- CHECK PROMPT ENGINEERING COURSE STRUCTURE
-- Run this first to see what exists
-- ==========================================

-- Check if course exists
SELECT id, title, description 
FROM courses 
WHERE title ILIKE '%Prompt%' OR title ILIKE '%Engineering%';

-- Check modules for Prompt Engineering course
SELECT m.id, m.title, m.ordering, m.course_id
FROM modules m
JOIN courses c ON m.course_id = c.id
WHERE c.title ILIKE '%Prompt%'
ORDER BY m.ordering;

-- Check lessons for Prompt Engineering course
SELECT l.id, l.title, l.ordering, l.module_id, m.title as module_title
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title ILIKE '%Prompt%'
ORDER BY m.ordering, l.ordering;

-- Count of modules and lessons
SELECT 
    c.title as course_title,
    COUNT(DISTINCT m.id) as module_count,
    COUNT(l.id) as lesson_count
FROM courses c
LEFT JOIN modules m ON c.id = m.course_id
LEFT JOIN lessons l ON m.id = l.module_id
WHERE c.title ILIKE '%Prompt%'
GROUP BY c.title;
