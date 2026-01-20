-- ============================================================================
-- GUARANTEED FIX - Handles duplicate modules and fixes ordering
-- ============================================================================
-- This script finds and fixes ALL duplicates before recreating the constraint

BEGIN;

DO $$
DECLARE 
    cid UUID;
    duplicate_count INTEGER;
BEGIN
    -- Find the Vibe Coding course
    SELECT id INTO cid FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1;
    
    IF cid IS NULL THEN 
        RAISE EXCEPTION 'Vibe Coding course not found';
    END IF;
    
    RAISE NOTICE 'Found Vibe Coding course: %', cid;
    
    -- Drop the unique constraint temporarily
    ALTER TABLE modules DROP CONSTRAINT IF EXISTS modules_course_id_ordering_key;
    RAISE NOTICE 'Dropped unique constraint';
    
    -- Check for duplicate modules (same title)
    SELECT COUNT(*) INTO duplicate_count 
    FROM (
        SELECT title, COUNT(*) as cnt 
        FROM modules 
        WHERE course_id = cid 
        GROUP BY title 
        HAVING COUNT(*) > 1
    ) duplicates;
    
    IF duplicate_count > 0 THEN
        RAISE NOTICE 'Found % duplicate module titles - keeping only the first occurrence', duplicate_count;
        
        -- Delete duplicate modules (keep only the one with lowest id)
        DELETE FROM modules m1
        WHERE course_id = cid
        AND EXISTS (
            SELECT 1 FROM modules m2
            WHERE m2.course_id = cid
            AND m2.title = m1.title
            AND m2.id < m1.id
        );
    END IF;
    
    -- Now update ordering (no duplicates exist)
    UPDATE modules SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Foundations%';
    UPDATE modules SET ordering = 2 WHERE course_id = cid AND title ILIKE '%How AI%';
    UPDATE modules SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Core Vibe%';
    UPDATE modules SET ordering = 4 WHERE course_id = cid AND title ILIKE '%Toolkit%';
    UPDATE modules SET ordering = 5 WHERE course_id = cid AND title ILIKE '%Real Software%';
    UPDATE modules SET ordering = 6 WHERE course_id = cid AND title ILIKE '%Data%';
    UPDATE modules SET ordering = 7 WHERE course_id = cid AND title ILIKE '%Advanced%';
    UPDATE modules SET ordering = 8 WHERE course_id = cid AND title ILIKE '%Career%';
    
    RAISE NOTICE 'Updated all module ordering';
    
    -- Verify no duplicates before recreating constraint
    SELECT COUNT(*) INTO duplicate_count
    FROM (
        SELECT ordering, COUNT(*) as cnt
        FROM modules
        WHERE course_id = cid
        GROUP BY ordering
        HAVING COUNT(*) > 1
    ) dups;
    
    IF duplicate_count > 0 THEN
        RAISE EXCEPTION 'Still have duplicate ordering values - cannot recreate constraint';
    END IF;
    
    -- Recreate the unique constraint
    ALTER TABLE modules ADD CONSTRAINT modules_course_id_ordering_key UNIQUE (course_id, ordering);
    RAISE NOTICE 'Recreated unique constraint';
    
    -- Fix lesson ordering
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Intent Is the New%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%What Is Vibe Coding%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%From Writing Code%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%How AI Thinks%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Context%Memory%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Preventing Repetition%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%System Prompts%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Loop%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Modular Thinking%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%UI%Frontend%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Full-Stack%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Backend%';
    UPDATE lessons SET ordering = 4 WHERE course_id = cid AND title ILIKE '%Agentic%';
    UPDATE lessons SET ordering = 5 WHERE course_id = cid AND title ILIKE '%Orchestration%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Debugging%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%SaaS%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%LMS%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Databases%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Auth%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%State%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Verification%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Cost%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%When NOT%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Internal Tools%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Client Work%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Future%';
    UPDATE lessons SET ordering = 4 WHERE course_id = cid AND title ILIKE '%Recommended Resources%';

    RAISE NOTICE '✅ SUCCESS: All modules (1-8) and lessons fixed!';
END $$;

COMMIT;

-- Show final result
SELECT ordering, title, id FROM modules 
WHERE course_id = (SELECT id FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1)
ORDER BY ordering;
