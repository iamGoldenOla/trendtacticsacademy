-- ============================================================================
-- FIX MODULE 3 CONNECTION
-- ============================================================================
-- The previous verification showed that Module 3 lessons have videos but 
-- are missing their 'module_id' (it was NULL).
-- This script ensures Module 3 exists and links the lessons to it.
-- ============================================================================

DO $$
DECLARE
    cid UUID;
    m3_id UUID;
BEGIN
    -- 1. Find Vibe Coding Course
    SELECT id INTO cid FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1;
    IF cid IS NULL THEN RAISE EXCEPTION 'Vibe Coding Course NOT found.'; END IF;

    -- 2. Find Module 3 (or Create it if missing)
    SELECT id INTO m3_id FROM modules WHERE course_id = cid AND (title ILIKE '%Core Workflow%' OR ordering = 3) LIMIT 1;

    IF m3_id IS NULL THEN
        RAISE NOTICE 'Module 3 missing. Creating it...';
        INSERT INTO modules (course_id, title, ordering, description)
        VALUES (cid, 'Module 3: The Core Vibe Coding Workflow', 3, 'Mastering the loops and logic of vibe coding.')
        RETURNING id INTO m3_id;
    END IF;

    RAISE NOTICE 'Linking lessons to Module 3 ID: %', m3_id;

    -- 3. Link the 3 Orphans
    UPDATE lessons SET module_id = m3_id, ordering = 1 
    WHERE title ILIKE '%System Prompts vs User Prompts%' AND course_id = cid;

    UPDATE lessons SET module_id = m3_id, ordering = 2 
    WHERE title ILIKE '%The Vibe Coding Loop%' AND course_id = cid;

    UPDATE lessons SET module_id = m3_id, ordering = 3 
    WHERE title ILIKE '%Modular Thinking%' AND course_id = cid;

END $$;

-- VERIFICATION
SELECT 
    l.title, 
    l.module_id, 
    l.video_url
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%' 
AND l.title ILIKE '%System Prompts%' 
OR  l.title ILIKE '%Vibe Coding Loop%' 
OR  l.title ILIKE '%Modular Thinking%';
