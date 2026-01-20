-- ============================================================================
-- FIX MISSING MODULE 1 (Foundations of Vibe Coding)
-- ============================================================================

DO $$
DECLARE
    cid UUID;
    m1_id UUID;
BEGIN
    -- 1. Get Course ID
    SELECT id INTO cid FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1;
    
    IF cid IS NULL THEN
        RAISE EXCEPTION 'Course not found!';
    END IF;

    -- 2. Check/Create Module 1
    SELECT id INTO m1_id FROM modules WHERE course_id = cid AND (title ILIKE '%Foundations%' OR ordering = 1) LIMIT 1;

    IF m1_id IS NULL THEN
        INSERT INTO modules (course_id, title, description, ordering, is_published)
        VALUES (cid, 'Module 1: Foundations of Vibe Coding', 'The paradigm shift from syntax to intent.', 1, true)
        RETURNING id INTO m1_id;
        RAISE NOTICE 'Created missing Module 1';
    ELSE
        -- Ensure it's published and ordering is 1
        UPDATE modules SET ordering = 1, is_published = true WHERE id = m1_id;
        RAISE NOTICE 'Updated existing Module 1';
    END IF;

    -- 3. Link Lessons to Module 1
    UPDATE lessons SET module_id = m1_id, course_id = cid, ordering = 1 
    WHERE title ILIKE '%Intent Is the New Programming%';

    UPDATE lessons SET module_id = m1_id, course_id = cid, ordering = 2 
    WHERE title ILIKE '%What Is Vibe Coding%';

    UPDATE lessons SET module_id = m1_id, course_id = cid, ordering = 3 
    WHERE title ILIKE '%From Writing Code%';

END $$;
