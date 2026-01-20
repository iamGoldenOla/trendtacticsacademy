-- ============================================================================
-- FIX CRITICAL ORDERING & CONSTRAINTS (Vibe Coding)
-- ============================================================================
-- This script fixes:
-- 1. Chaotic Module Ordering (Random shuffle in dashboard)
-- 2. "Duplicate Key" errors when updating lessons (Constraint Violation)
-- ============================================================================

DO $$
DECLARE 
    cid UUID;
BEGIN
    -- Get Course ID
    SELECT id INTO cid FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1;
    
    IF cid IS NULL THEN RAISE EXCEPTION 'Vibe Coding course not found'; END IF;

    RAISE NOTICE 'Fixing Course ID: %', cid;

    -- ========================================================================
    -- 1. FIX MODULE ORDERING
    -- ========================================================================
    -- We simply force the correct ordering number for each known module title.
    
    UPDATE modules SET ordering = 1 WHERE course_id = cid AND (title ILIKE '%Foundations%' OR title ILIKE '%Module 1%');
    UPDATE modules SET ordering = 2 WHERE course_id = cid AND (title ILIKE '%How AI%' OR title ILIKE '%Module 2%');
    UPDATE modules SET ordering = 3 WHERE course_id = cid AND (title ILIKE '%Core Vibe%' OR title ILIKE '%Module 3%');
    UPDATE modules SET ordering = 4 WHERE course_id = cid AND (title ILIKE '%Toolkit%' OR title ILIKE '%Module 4%');
    UPDATE modules SET ordering = 5 WHERE course_id = cid AND (title ILIKE '%Real Software%' OR title ILIKE '%Module 5%');
    UPDATE modules SET ordering = 6 WHERE course_id = cid AND (title ILIKE '%Data%' OR title ILIKE '%Module 6%');
    UPDATE modules SET ordering = 7 WHERE course_id = cid AND (title ILIKE '%Advanced%' OR title ILIKE '%Module 7%');
    UPDATE modules SET ordering = 8 WHERE course_id = cid AND (title ILIKE '%Career%' OR title ILIKE '%Module 8%');

    RAISE NOTICE 'Modules re-ordered 1-8';

    -- ========================================================================
    -- 2. RESET LESSON ORDERING (Avoid Unique Constraint)
    -- ========================================================================
    -- We adhere to the "Parking" strategy: move everything to a high number first.
    -- This prevents "Key (module_id, ordering)=(..., 4) already exists" errors.

    UPDATE lessons 
    SET ordering = ordering + 3000 
    WHERE course_id = cid AND ordering < 1000;

    RAISE NOTICE 'Lessons parked at 3000+ to clear slots';

    -- ========================================================================
    -- 3. APPLY CORRECT LESSON ORDERING
    -- ========================================================================
    
    -- MODULE 1
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Intent Is the New Programming%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%What Is Vibe Coding%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%From Writing Code%';
    UPDATE lessons SET ordering = 4 WHERE course_id = cid AND title ILIKE '%Recommended Resources%'; -- Shared title, handled carefully? No, distinct per module is better, but assume uniqueness by context or Accept random for now if title shared? 
    -- Actually "Recommended Resources" appears in Mod 1 and Mod 8. We need to distinguish.
    -- Mod 1 "Recommended" usually doesn't exist in Gold Standard, but if it does:
    UPDATE lessons SET ordering = 4 WHERE course_id = cid AND title ILIKE '%Recommended Resources%' AND module_id IN (SELECT id FROM modules WHERE ordering = 1);

    -- MODULE 2
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%How AI Thinks%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Context%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Preventing Repetition%';

    -- MODULE 3
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%System Prompts%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Loop%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Modular Thinking%';

    -- MODULE 4
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%UI / Frontend%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Full-Stack%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Backend%';
    UPDATE lessons SET ordering = 4 WHERE course_id = cid AND title ILIKE '%Agentic%';
    UPDATE lessons SET ordering = 5 WHERE course_id = cid AND title ILIKE '%Orchestration%';

    -- MODULE 5
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Debugging%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%SaaS%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%LMS%';

    -- MODULE 6
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Databases%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Auth%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%State%';

    -- MODULE 7
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Verification%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Cost%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%When NOT to Use%';

    -- MODULE 8
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND title ILIKE '%Internal Tools%';
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND title ILIKE '%Client Work%';
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND title ILIKE '%Future%';
    UPDATE lessons SET ordering = 4 AND module_id IN (SELECT id FROM modules WHERE ordering = 8) WHERE course_id = cid AND title ILIKE '%Recommended Resources%';

    -- FINAL CLEANUP: Set any remaining parked items to visible spots (append)
    -- This handles any custom lessons the user might have added
    WITH parked AS (
        SELECT id, ROW_NUMBER() OVER (PARTITION BY module_id ORDER BY title) as new_ord
        FROM lessons 
        WHERE course_id = cid AND ordering >= 3000
    )
    UPDATE lessons l
    SET ordering = p.new_ord + 10 -- Append after 10
    FROM parked p
    WHERE l.id = p.id;

    RAISE NOTICE 'Lessons re-ordered successfully';

END $$;
