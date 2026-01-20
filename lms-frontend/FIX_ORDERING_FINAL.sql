-- ============================================================================
-- FIX CRITICAL ORDERING V4 (Vibe Coding) - DEFERRED CONSTRAINTS
-- ============================================================================
-- This uses a transaction with constraint deferral to avoid conflicts

BEGIN;

-- Defer unique constraints for this transaction
SET CONSTRAINTS ALL DEFERRED;

DO $$
DECLARE 
    cid UUID;
BEGIN
    SELECT id INTO cid FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1;
    IF cid IS NULL THEN RAISE EXCEPTION 'Vibe Coding course not found'; END IF;

    -- FIX MODULE ORDERING (constraints deferred, so no conflicts)
    UPDATE modules SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Foundations%';
    UPDATE modules SET ordering = 2 WHERE course_id = cid AND title ILIKE '%How AI%';
    UPDATE modules SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Core Vibe%';
    UPDATE modules SET ordering = 4 WHERE course_id = cid AND title ILIKE '%Toolkit%';
    UPDATE modules SET ordering = 5 WHERE course_id = cid AND title ILIKE '%Real Software%';
    UPDATE modules SET ordering = 6 WHERE course_id = cid AND title ILIKE '%Data%';
    UPDATE modules SET ordering = 7 WHERE course_id = cid AND title ILIKE '%Advanced%';
    UPDATE modules SET ordering = 8 WHERE course_id = cid AND title ILIKE '%Career%';

    -- FIX LESSON ORDERING (constraints deferred)
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

    RAISE NOTICE 'SUCCESS: Modules 1-8 and all lessons re-ordered';
END $$;

COMMIT;
