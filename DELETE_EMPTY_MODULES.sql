-- ============================================================================
-- SIMPLE FIX: Delete Empty Duplicate Modules
-- ============================================================================
-- Looking at your data, the duplicate modules (30000000-...) already have
-- lessons in them. So we just need to delete the OLD empty modules instead!
-- ============================================================================

DO $$
DECLARE
    v_course_id UUID;
BEGIN
    SELECT id INTO v_course_id FROM courses WHERE title ILIKE '%Prompt Engineering%' LIMIT 1;

    -- Delete the OLD modules that have only 1 lesson (they're the originals we don't need)
    -- Keep the new ones (30000000-...) that have 3-6 lessons
    
    DELETE FROM modules 
    WHERE course_id = v_course_id 
    AND id IN (
        SELECT m.id FROM modules m
        LEFT JOIN lessons l ON l.module_id = m.id
        WHERE m.course_id = v_course_id
        AND m.ordering IN (1, 2, 3, 4)
        GROUP BY m.id
        HAVING COUNT(l.id) <= 1  -- Delete modules with 0 or 1 lesson
    );

    RAISE NOTICE '✅ Deleted empty/old modules';

    -- Now rename the remaining modules to have better names
    UPDATE modules SET title = 'Module 1: Foundations & Behavior Architecture', ordering = 1
    WHERE course_id = v_course_id AND title = 'Foundations';

    UPDATE modules SET title = 'Module 2: Core Techniques & Orchestration', ordering = 2
    WHERE course_id = v_course_id AND title = 'Core Techniques';

    UPDATE modules SET title = 'Module 3: Advanced Workflows & Meta-Prompting', ordering = 3
    WHERE course_id = v_course_id AND title = 'Advanced Workflows';

    UPDATE modules SET title = 'Module 4: Professional Mastery & Ethics', ordering = 4
    WHERE course_id = v_course_id AND title = 'Professional Mastery';

    RAISE NOTICE '✅ Renamed modules';
END $$;

-- Verify the final structure
SELECT m.id, m.title, m.ordering, COUNT(l.id) as lesson_count
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id IN (SELECT id FROM courses WHERE title ILIKE '%Prompt Engineering%')
GROUP BY m.id, m.title, m.ordering
ORDER BY m.ordering;
