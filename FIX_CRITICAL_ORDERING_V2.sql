-- ============================================================================
-- FIX CRITICAL ORDERING V2 (Vibe Coding) - WITH MODULE PARKING
-- ============================================================================

DO $$
DECLARE 
    cid UUID;
BEGIN
    SELECT id INTO cid FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1;
    IF cid IS NULL THEN RAISE EXCEPTION 'Vibe Coding course not found'; END IF;

    -- STEP 1: PARK MODULES (avoid duplicate key on modules table)
    UPDATE modules SET ordering = ordering + 1000 WHERE course_id = cid AND ordering < 100;
    
    -- STEP 2: PARK LESSONS (avoid duplicate key on lessons table)
    UPDATE lessons SET ordering = ordering + 3000 WHERE course_id = cid AND ordering < 1000;

    -- STEP 3: FIX MODULE ORDERING
    UPDATE modules SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Foundations%';
    UPDATE modules SET ordering = 2 WHERE course_id = cid AND title ILIKE '%How AI%';
    UPDATE modules SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Core Vibe%';
    UPDATE modules SET ordering = 4 WHERE course_id = cid AND title ILIKE '%Toolkit%';
    UPDATE modules SET ordering = 5 WHERE course_id = cid AND title ILIKE '%Real Software%';
    UPDATE modules SET ordering = 6 WHERE course_id = cid AND title ILIKE '%Data%';
    UPDATE modules SET ordering = 7 WHERE course_id = cid AND title ILIKE '%Advanced%';
    UPDATE modules SET ordering = 8 WHERE course_id = cid AND title ILIKE '%Career%';

    -- STEP 4: FIX LESSON ORDERING
    -- Module 1
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Intent Is the New%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%What Is Vibe Coding%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%From Writing Code%';
    
    -- Module 2
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%How AI Thinks%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Context%Memory%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Preventing Repetition%';
    
    -- Module 3
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%System Prompts%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Loop%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Modular Thinking%';
    
    -- Module 4
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%UI%Frontend%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Full-Stack%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Backend%';
    UPDATE lessons SET ordering = 4 WHERE course_id = cid AND title ILIKE '%Agentic%';
    UPDATE lessons SET ordering = 5 WHERE course_id = cid AND title ILIKE '%Orchestration%';
    
    -- Module 5
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Debugging%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%SaaS%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%LMS%';
    
    -- Module 6
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Databases%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Auth%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%State%';
    
    -- Module 7
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Verification%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Cost%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%When NOT%';
    
    -- Module 8
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Internal Tools%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Client Work%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Future%';
    UPDATE lessons SET ordering = 4 WHERE course_id = cid AND title ILIKE '%Recommended Resources%';

    RAISE NOTICE 'SUCCESS: Modules and Lessons re-ordered';
END $$;
