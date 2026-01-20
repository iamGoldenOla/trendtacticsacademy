-- Inspect Facebook Courses and their Modules
SELECT c.id, c.title, c.description, count(m.id) as module_count
FROM courses c
LEFT JOIN modules m ON m.course_id = c.id
WHERE c.title ILIKE '%Facebook%'
GROUP BY c.id, c.title, c.description;

-- Check Module Titles for each course to see the content difference
SELECT c.title as course_title, m.title as module_title, m.ordering
FROM modules m
JOIN courses c ON m.course_id = c.id
WHERE c.title ILIKE '%Facebook%'
ORDER BY c.title, m.ordering;
