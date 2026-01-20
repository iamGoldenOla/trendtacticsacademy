-- Diagnose Facebook Ads Courses Issue
-- Check both courses and their content

-- 1. List all Facebook Ads related courses
SELECT 
    c.id,
    c.title,
    c.description,
    c.created_at,
    COUNT(DISTINCT m.id) as module_count,
    COUNT(DISTINCT l.id) as lesson_count
FROM courses c
LEFT JOIN modules m ON m.course_id = c.id
LEFT JOIN lessons l ON l.module_id = m.id
WHERE c.title ILIKE '%Facebook%'
GROUP BY c.id, c.title, c.description, c.created_at
ORDER BY c.title;

-- 2. Check modules for each Facebook course
SELECT 
    c.title as course_title,
    m.id as module_id,
    m.title as module_title,
    m.ordering,
    COUNT(l.id) as lesson_count
FROM courses c
JOIN modules m ON m.course_id = c.id
LEFT JOIN lessons l ON l.module_id = m.id
WHERE c.title ILIKE '%Facebook%'
GROUP BY c.id, c.title, m.id, m.title, m.ordering
ORDER BY c.title, m.ordering;

-- 3. Check if there are any lessons without modules
SELECT 
    l.id,
    l.title,
    l.module_id,
    m.title as module_title,
    c.title as course_title
FROM lessons l
LEFT JOIN modules m ON l.module_id = m.id
LEFT JOIN courses c ON m.course_id = c.id
WHERE c.title ILIKE '%Facebook%'
ORDER BY c.title, l.title
LIMIT 20;
