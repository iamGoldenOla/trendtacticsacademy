-- Diagnostic: Check for duplicates causing "Cannot coerce to single JSON object"

SELECT id, title, created_at 
FROM courses 
WHERE title ILIKE '%Facebook%';

SELECT m.id, m.course_id, m.title, m.ordering, count(l.id) as lesson_count
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id IN (SELECT id FROM courses WHERE title ILIKE '%Facebook%')
GROUP BY m.id, m.course_id, m.title, m.ordering
ORDER BY m.course_id, m.ordering;
