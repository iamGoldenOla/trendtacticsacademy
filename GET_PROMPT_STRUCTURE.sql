-- ==========================================
-- GET PROMPT ENGINEERING MASTERY STRUCTURE
-- Run this to see module and lesson details
-- ==========================================

-- Get the course ID
SELECT id, title FROM courses WHERE title = 'Prompt Engineering Mastery';

-- Get all modules with their ordering
SELECT id, title, ordering, description
FROM modules 
WHERE course_id = (SELECT id FROM courses WHERE title = 'Prompt Engineering Mastery')
ORDER BY ordering;

-- Get all lessons with module info
SELECT 
    m.ordering as module_num,
    m.title as module_title,
    l.ordering as lesson_num,
    l.title as lesson_title,
    l.id as lesson_id,
    LENGTH(l.content) as content_length
FROM lessons l
JOIN modules m ON l.module_id = m.id
WHERE m.course_id = (SELECT id FROM courses WHERE title = 'Prompt Engineering Mastery')
ORDER BY m.ordering, l.ordering;
