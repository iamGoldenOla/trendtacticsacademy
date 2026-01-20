-- ============================================================================
-- MOVE LESSONS TO THE CORRECT COURSE
-- ============================================================================
-- This moves all lessons from the long-titled course to the simple "Prompt Engineering" course
-- ============================================================================

-- First, move the modules
UPDATE modules 
SET course_id = '123e4567-e89b-12d3-a456-426614174001'
WHERE course_id = 'c3d4e5f6-a7b8-9012-cdef-012345678912';

-- Then, move the lessons
UPDATE lessons
SET course_id = '123e4567-e89b-12d3-a456-426614174001'
WHERE course_id = 'c3d4e5f6-a7b8-9012-cdef-012345678912';

-- Verify the move
SELECT 
    c.id,
    c.title,
    COUNT(l.id) as lesson_count
FROM courses c
LEFT JOIN lessons l ON l.course_id = c.id
WHERE c.id IN ('123e4567-e89b-12d3-a456-426614174001', 'c3d4e5f6-a7b8-9012-cdef-012345678912')
GROUP BY c.id, c.title;

-- Optional: Delete the old empty course
-- DELETE FROM courses WHERE id = 'c3d4e5f6-a7b8-9012-cdef-012345678912';
