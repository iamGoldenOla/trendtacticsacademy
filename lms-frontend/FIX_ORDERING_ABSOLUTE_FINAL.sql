-- ============================================================================
-- ABSOLUTE FINAL FIX - Delete and Recreate Ordering
-- ============================================================================
-- This script completely removes the unique constraint temporarily,
-- fixes all ordering, then recreates the constraint.

BEGIN;

DO $$
DECLARE 
    cid UUID;
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
    
    -- Now we can freely update without conflicts
    UPDATE modules SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Foundations%';
    UPDATE modules SET ordering = 2 WHERE course_id = cid AND title ILIKE '%How AI%';
    UPDATE modules SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Core Vibe%';
    UPDATE modules SET ordering = 4 WHERE course_id = cid AND title ILIKE '%Toolkit%';
    UPDATE modules SET ordering = 5 WHERE course_id = cid AND title ILIKE '%Real Software%';
    UPDATE modules SET ordering = 6 WHERE course_id = cid AND title ILIKE '%Data%';
    UPDATE modules SET ordering = 7 WHERE course_id = cid AND title ILIKE '%Advanced%';
    UPDATE modules SET ordering = 8 WHERE course_id = cid AND title ILIKE '%Career%';
    
    RAISE NOTICE 'Updated all module ordering';
    
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

    RAISE NOTICE '✅ SUCCESS: All modules and lessons re-ordered!';
END $$;

COMMIT;

-- Verify
SELECT ordering, title FROM modules 
WHERE course_id = (SELECT id FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1)
ORDER BY ordering;
