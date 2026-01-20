-- ============================================================================
-- FINAL CLEANUP: Remove Facebook Ads Module Lessons
-- ============================================================================
-- These lessons belong to a different course and shouldn't be in Prompt Engineering
-- ============================================================================

-- Delete the Facebook Ads Foundations module entirely from this course
DELETE FROM modules 
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
AND title ILIKE '%Facebook%';

-- If that doesn't work (foreign key constraint), delete lessons first, then module
DELETE FROM lessons
WHERE module_id IN (
    SELECT id FROM modules 
    WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
    AND title ILIKE '%Facebook%'
);

DELETE FROM modules 
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
AND title ILIKE '%Facebook%';

SELECT 'Facebook Ads module and lessons removed ✅' as status;

-- Show final clean course structure
SELECT 
    m.ordering,
    m.title as module,
    COUNT(l.id) as lesson_count
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id = '123e4567-e89b-12d3-a456-426614174001'
GROUP BY m.id, m.ordering, m.title
ORDER BY m.ordering;

-- Show all final lessons
SELECT 
    m.ordering as mod_order,
    m.title as module,
    l.title as lesson,
    l.order_index
FROM lessons l
JOIN modules m ON l.module_id = m.id
WHERE l.course_id = '123e4567-e89b-12d3-a456-426614174001'
ORDER BY m.ordering, l.order_index;
