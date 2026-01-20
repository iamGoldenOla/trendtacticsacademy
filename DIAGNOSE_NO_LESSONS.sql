-- ============================================================================
-- DIAGNOSTIC: Check why course shows "No lessons"
-- ============================================================================

-- 1. Check if course exists
SELECT id, title FROM courses WHERE id = 'c3d4e5f6-a7b8-9012-cdef-012345678912';

-- 2. Check modules for this course
SELECT id, title, ordering FROM modules 
WHERE course_id = 'c3d4e5f6-a7b8-9012-cdef-012345678912'
ORDER BY ordering;

-- 3. Check lessons for this course
SELECT l.id, l.title, l.module_id, l.order_index, m.title as module_title
FROM lessons l
LEFT JOIN modules m ON l.module_id = m.id
WHERE l.course_id = 'c3d4e5f6-a7b8-9012-cdef-012345678912'
ORDER BY l.order_index
LIMIT 10;

-- 4. Check if lessons have the correct course_id
SELECT 
    COUNT(*) as total_lessons,
    COUNT(DISTINCT module_id) as modules_with_lessons
FROM lessons
WHERE course_id = 'c3d4e5f6-a7b8-9012-cdef-012345678912';
