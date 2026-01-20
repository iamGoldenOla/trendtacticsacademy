-- ============================================================================
-- FIX MODULE ORDERING - SAFE TWO-PHASE APPROACH
-- ============================================================================
-- This script safely updates module ordering by using temporary negative values
-- to avoid unique constraint violations during the update process.
--
-- USAGE: Run this in your PostgreSQL database
-- psql -d your_database_name -f FIX_ORDERING_SAFE.sql

BEGIN;

DO $$
DECLARE 
    cid UUID;
    module_count INTEGER;
BEGIN
    -- Find the Vibe Coding course
    SELECT id INTO cid FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1;
    
    IF cid IS NULL THEN 
        RAISE EXCEPTION 'Vibe Coding course not found. Please check the course title.';
    END IF;
    
    RAISE NOTICE 'Found Vibe Coding course: %', cid;
    
    -- Check how many modules exist
    SELECT COUNT(*) INTO module_count FROM modules WHERE course_id = cid;
    RAISE NOTICE 'Found % modules for this course', module_count;
    
    -- PHASE 1: Set all modules to temporary negative ordering values
    -- This clears the way for the final ordering without conflicts
    RAISE NOTICE 'PHASE 1: Setting temporary ordering values...';
    
    UPDATE modules SET ordering = -1 WHERE course_id = cid AND title ILIKE '%Foundations%';
    UPDATE modules SET ordering = -2 WHERE course_id = cid AND title ILIKE '%How AI%';
    UPDATE modules SET ordering = -3 WHERE course_id = cid AND title ILIKE '%Core Vibe%';
    UPDATE modules SET ordering = -4 WHERE course_id = cid AND title ILIKE '%Toolkit%';
    UPDATE modules SET ordering = -5 WHERE course_id = cid AND title ILIKE '%Real Software%';
    UPDATE modules SET ordering = -6 WHERE course_id = cid AND title ILIKE '%Data%';
    UPDATE modules SET ordering = -7 WHERE course_id = cid AND title ILIKE '%Advanced%';
    UPDATE modules SET ordering = -8 WHERE course_id = cid AND title ILIKE '%Career%';
    
    -- PHASE 2: Set final ordering values (1-8)
    RAISE NOTICE 'PHASE 2: Setting final ordering values...';
    
    UPDATE modules SET ordering = 1 WHERE course_id = cid AND ordering = -1;
    UPDATE modules SET ordering = 2 WHERE course_id = cid AND ordering = -2;
    UPDATE modules SET ordering = 3 WHERE course_id = cid AND ordering = -3;
    UPDATE modules SET ordering = 4 WHERE course_id = cid AND ordering = -4;
    UPDATE modules SET ordering = 5 WHERE course_id = cid AND ordering = -5;
    UPDATE modules SET ordering = 6 WHERE course_id = cid AND ordering = -6;
    UPDATE modules SET ordering = 7 WHERE course_id = cid AND ordering = -7;
    UPDATE modules SET ordering = 8 WHERE course_id = cid AND ordering = -8;
    
    -- FIX LESSON ORDERING (same two-phase approach)
    RAISE NOTICE 'Fixing lesson ordering...';
    
    -- Module 1: Foundations (3 lessons)
    UPDATE lessons SET ordering = -101 WHERE course_id = cid AND title ILIKE '%Intent Is the New%';
    UPDATE lessons SET ordering = -102 WHERE course_id = cid AND title ILIKE '%What Is Vibe Coding%';
    UPDATE lessons SET ordering = -103 WHERE course_id = cid AND title ILIKE '%From Writing Code%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = -101;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = -102;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = -103;
    
    -- Module 2: How AI Thinks (3 lessons)
    UPDATE lessons SET ordering = -201 WHERE course_id = cid AND title ILIKE '%How AI Thinks%';
    UPDATE lessons SET ordering = -202 WHERE course_id = cid AND title ILIKE '%Context%Memory%';
    UPDATE lessons SET ordering = -203 WHERE course_id = cid AND title ILIKE '%Preventing Repetition%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = -201;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = -202;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = -203;
    
    -- Module 3: Core Vibe Coding (3 lessons)
    UPDATE lessons SET ordering = -301 WHERE course_id = cid AND title ILIKE '%System Prompts%';
    UPDATE lessons SET ordering = -302 WHERE course_id = cid AND title ILIKE '%Loop%';
    UPDATE lessons SET ordering = -303 WHERE course_id = cid AND title ILIKE '%Modular Thinking%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = -301;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = -302;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = -303;
    
    -- Module 4: Toolkit (5 lessons)
    UPDATE lessons SET ordering = -401 WHERE course_id = cid AND title ILIKE '%UI%Frontend%';
    UPDATE lessons SET ordering = -402 WHERE course_id = cid AND title ILIKE '%Full-Stack%';
    UPDATE lessons SET ordering = -403 WHERE course_id = cid AND title ILIKE '%Backend%';
    UPDATE lessons SET ordering = -404 WHERE course_id = cid AND title ILIKE '%Agentic%';
    UPDATE lessons SET ordering = -405 WHERE course_id = cid AND title ILIKE '%Orchestration%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = -401;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = -402;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = -403;
    UPDATE lessons SET ordering = 4 WHERE course_id = cid AND ordering = -404;
    UPDATE lessons SET ordering = 5 WHERE course_id = cid AND ordering = -405;
    
    -- Module 5: Real Software (3 lessons)
    UPDATE lessons SET ordering = -501 WHERE course_id = cid AND title ILIKE '%Debugging%';
    UPDATE lessons SET ordering = -502 WHERE course_id = cid AND title ILIKE '%SaaS%';
    UPDATE lessons SET ordering = -503 WHERE course_id = cid AND title ILIKE '%LMS%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = -501;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = -502;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = -503;
    
    -- Module 6: Data (3 lessons)
    UPDATE lessons SET ordering = -601 WHERE course_id = cid AND title ILIKE '%Databases%';
    UPDATE lessons SET ordering = -602 WHERE course_id = cid AND title ILIKE '%Auth%';
    UPDATE lessons SET ordering = -603 WHERE course_id = cid AND title ILIKE '%State%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = -601;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = -602;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = -603;
    
    -- Module 7: Advanced (3 lessons)
    UPDATE lessons SET ordering = -701 WHERE course_id = cid AND title ILIKE '%Verification%';
    UPDATE lessons SET ordering = -702 WHERE course_id = cid AND title ILIKE '%Cost%';
    UPDATE lessons SET ordering = -703 WHERE course_id = cid AND title ILIKE '%When NOT%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = -701;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = -702;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = -703;
    
    -- Module 8: Career (4 lessons)
    UPDATE lessons SET ordering = -801 WHERE course_id = cid AND title ILIKE '%Internal Tools%';
    UPDATE lessons SET ordering = -802 WHERE course_id = cid AND title ILIKE '%Client Work%';
    UPDATE lessons SET ordering = -803 WHERE course_id = cid AND title ILIKE '%Future%';
    UPDATE lessons SET ordering = -804 WHERE course_id = cid AND title ILIKE '%Recommended Resources%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = -801;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = -802;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = -803;
    UPDATE lessons SET ordering = 4 WHERE course_id = cid AND ordering = -804;

    RAISE NOTICE '✅ SUCCESS: All modules (1-8) and lessons have been re-ordered correctly!';
END $$;

COMMIT;

-- Verify the results
SELECT 
    m.ordering as module_order,
    m.title as module_title,
    COUNT(l.id) as lesson_count
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id = (SELECT id FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1)
GROUP BY m.id, m.ordering, m.title
ORDER BY m.ordering;
