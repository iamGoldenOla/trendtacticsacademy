-- Check what modules exist
SELECT id, course_id, title, ordering 
FROM modules 
ORDER BY course_id, ordering;

-- Check module count by course
SELECT 
  c.title as course,
  COUNT(m.id) as module_count
FROM courses c
LEFT JOIN modules m ON m.course_id = c.id
GROUP BY c.id, c.title
ORDER BY c.title;

-- Check if any modules exist at all
SELECT COUNT(*) as total_modules FROM modules;

