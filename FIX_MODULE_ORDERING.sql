-- Fix Module Ordering for Vibe Coding 3.0
-- Handles duplicates by moving lessons to the correct module first

DO $$
DECLARE
    v_course_id UUID;
    v_module_3_old UUID := '7db6e281-1c87-4faa-91dc-64b8d479a045'; -- The original Module 3 (null ordering)
    v_module_3_new UUID := 'f9475da2-01e9-4196-b750-ab663becdd6b'; -- The duplicate Module 3 (ordering=3)
BEGIN
    -- Get the Vibe Coding 3.0 course ID
    SELECT id INTO v_course_id
    FROM courses
    WHERE title ILIKE '%Vibe Coding%'
    LIMIT 1;

    IF v_course_id IS NULL THEN
        RAISE EXCEPTION 'Vibe Coding course not found';
    END IF;

    RAISE NOTICE 'Found course ID: %', v_course_id;

    -- Move all lessons from the duplicate Module 3 to the original Module 3
    UPDATE lessons
    SET module_id = v_module_3_old
    WHERE module_id = v_module_3_new;

    RAISE NOTICE 'Moved lessons from duplicate Module 3 to original';

    -- Now delete the duplicate Module 3
    DELETE FROM modules WHERE id = v_module_3_new;

    RAISE NOTICE 'Deleted duplicate Module 3';

    -- Drop the unique constraint temporarily
    ALTER TABLE modules DROP CONSTRAINT IF EXISTS modules_course_id_ordering_key;
    
    RAISE NOTICE 'Dropped unique constraint';

    -- Now update all modules to correct ordering
    UPDATE modules SET ordering = 1 WHERE id = 'a405b6db-0c1f-44d6-b3d3-bbd0a59b5cce'; -- Module 1
    UPDATE modules SET ordering = 2 WHERE id = '79f49b21-6b11-4c58-b279-db3604688bc1'; -- Module 2
    UPDATE modules SET ordering = 3 WHERE id = '7db6e281-1c87-4faa-91dc-64b8d479a045'; -- Module 3
    UPDATE modules SET ordering = 4 WHERE id = 'a30fd3ee-e2ef-467e-89a3-d126889bf34a'; -- Module 4
    UPDATE modules SET ordering = 5 WHERE id = '9aa8ab54-55c0-457a-857d-e57474c3a6aa'; -- Module 5
    UPDATE modules SET ordering = 6 WHERE id = '18e2854e-169f-42d8-9f73-131ee53463ea'; -- Module 6
    UPDATE modules SET ordering = 7 WHERE id = '60a74daf-1778-426d-86c8-59f9a8d0e9ea'; -- Module 7
    UPDATE modules SET ordering = 8 WHERE id = '1cd9e719-f05f-436b-b52a-fb6d6c958b7d'; -- Module 8

    RAISE NOTICE 'Updated all module ordering values';

    -- Re-add the unique constraint
    ALTER TABLE modules ADD CONSTRAINT modules_course_id_ordering_key UNIQUE (course_id, ordering);
    
    RAISE NOTICE 'Re-added unique constraint';
    RAISE NOTICE '✅ Module ordering fixed successfully!';
END $$;

-- Verify the ordering
SELECT 
    m.ordering,
    m.title,
    COUNT(l.id) as lesson_count
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id = (SELECT id FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1)
GROUP BY m.id, m.ordering, m.title
ORDER BY m.ordering;
