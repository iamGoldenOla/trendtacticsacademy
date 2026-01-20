-- ============================================================================
-- COMPREHENSIVE DIAGNOSTIC: Find the Real Issue
-- ============================================================================

-- 1. What's the actual course ID being used?
SELECT id, title FROM courses WHERE title ILIKE '%Prompt%' OR title ILIKE '%Engineering%';

-- 2. Check if lessons table has 'ordering' or 'order_index' column
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'lessons' 
AND column_name LIKE '%order%';

-- 3. Check a sample lesson to see which column has values
SELECT id, title, ordering, order_index, module_id, course_id
FROM lessons
LIMIT 5;

-- 4. Count lessons for Prompt Engineering course (try both possible course IDs)
SELECT 
    c.id as course_id,
    c.title as course_title,
    COUNT(l.id) as lesson_count
FROM courses c
LEFT JOIN lessons l ON l.course_id = c.id
WHERE c.title ILIKE '%Prompt%'
GROUP BY c.id, c.title;

-- 5. Check if lessons are linked to modules correctly
SELECT 
    m.id as module_id,
    m.title as module_title,
    COUNT(l.id) as lesson_count
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id IN (SELECT id FROM courses WHERE title ILIKE '%Prompt%')
GROUP BY m.id, m.title
ORDER BY m.ordering;
