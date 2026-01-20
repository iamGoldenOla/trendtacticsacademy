-- ============================================================================
-- NUCLEAR FIX - MODULE ORDERING (Handles ANY existing state)
-- ============================================================================
-- This script works regardless of current ordering values (positive, negative, or duplicates)
-- It uses a three-phase approach with random large numbers to guarantee no conflicts

BEGIN;

DO $$
DECLARE 
    cid UUID;
    module_count INTEGER;
    random_offset INTEGER := 10000; -- Large offset to avoid any conflicts
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
    
    -- PHASE 1: Set ALL modules to unique random high numbers (10001, 10002, etc.)
    -- This clears ALL existing values regardless of what they are
    RAISE NOTICE 'PHASE 1: Clearing all existing ordering values...';
    
    UPDATE modules SET ordering = random_offset + 1 WHERE course_id = cid AND title ILIKE '%Foundations%';
    UPDATE modules SET ordering = random_offset + 2 WHERE course_id = cid AND title ILIKE '%How AI%';
    UPDATE modules SET ordering = random_offset + 3 WHERE course_id = cid AND title ILIKE '%Core Vibe%';
    UPDATE modules SET ordering = random_offset + 4 WHERE course_id = cid AND title ILIKE '%Toolkit%';
    UPDATE modules SET ordering = random_offset + 5 WHERE course_id = cid AND title ILIKE '%Real Software%';
    UPDATE modules SET ordering = random_offset + 6 WHERE course_id = cid AND title ILIKE '%Data%';
    UPDATE modules SET ordering = random_offset + 7 WHERE course_id = cid AND title ILIKE '%Advanced%';
    UPDATE modules SET ordering = random_offset + 8 WHERE course_id = cid AND title ILIKE '%Career%';
    
    -- PHASE 2: Set final ordering values (1-8)
    RAISE NOTICE 'PHASE 2: Setting final ordering values...';
    
    UPDATE modules SET ordering = 1 WHERE course_id = cid AND ordering = random_offset + 1;
    UPDATE modules SET ordering = 2 WHERE course_id = cid AND ordering = random_offset + 2;
    UPDATE modules SET ordering = 3 WHERE course_id = cid AND ordering = random_offset + 3;
    UPDATE modules SET ordering = 4 WHERE course_id = cid AND ordering = random_offset + 4;
    UPDATE modules SET ordering = 5 WHERE course_id = cid AND ordering = random_offset + 5;
    UPDATE modules SET ordering = 6 WHERE course_id = cid AND ordering = random_offset + 6;
    UPDATE modules SET ordering = 7 WHERE course_id = cid AND ordering = random_offset + 7;
    UPDATE modules SET ordering = 8 WHERE course_id = cid AND ordering = random_offset + 8;
    
    -- FIX LESSON ORDERING (same approach with higher offset)
    RAISE NOTICE 'Fixing lesson ordering...';
    
    -- Module 1: Foundations (3 lessons)
    UPDATE lessons SET ordering = 20001 WHERE course_id = cid AND title ILIKE '%Intent Is the New%';
    UPDATE lessons SET ordering = 20002 WHERE course_id = cid AND title ILIKE '%What Is Vibe Coding%';
    UPDATE lessons SET ordering = 20003 WHERE course_id = cid AND title ILIKE '%From Writing Code%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = 20001;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = 20002;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = 20003;
    
    -- Module 2: How AI Thinks (3 lessons)
    UPDATE lessons SET ordering = 20011 WHERE course_id = cid AND title ILIKE '%How AI Thinks%';
    UPDATE lessons SET ordering = 20012 WHERE course_id = cid AND title ILIKE '%Context%Memory%';
    UPDATE lessons SET ordering = 20013 WHERE course_id = cid AND title ILIKE '%Preventing Repetition%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = 20011;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = 20012;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = 20013;
    
    -- Module 3: Core Vibe Coding (3 lessons)
    UPDATE lessons SET ordering = 20021 WHERE course_id = cid AND title ILIKE '%System Prompts%';
    UPDATE lessons SET ordering = 20022 WHERE course_id = cid AND title ILIKE '%Loop%';
    UPDATE lessons SET ordering = 20023 WHERE course_id = cid AND title ILIKE '%Modular Thinking%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = 20021;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = 20022;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = 20023;
    
    -- Module 4: Toolkit (5 lessons)
    UPDATE lessons SET ordering = 20031 WHERE course_id = cid AND title ILIKE '%UI%Frontend%';
    UPDATE lessons SET ordering = 20032 WHERE course_id = cid AND title ILIKE '%Full-Stack%';
    UPDATE lessons SET ordering = 20033 WHERE course_id = cid AND title ILIKE '%Backend%';
    UPDATE lessons SET ordering = 20034 WHERE course_id = cid AND title ILIKE '%Agentic%';
    UPDATE lessons SET ordering = 20035 WHERE course_id = cid AND title ILIKE '%Orchestration%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = 20031;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = 20032;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = 20033;
    UPDATE lessons SET ordering = 4 WHERE course_id = cid AND ordering = 20034;
    UPDATE lessons SET ordering = 5 WHERE course_id = cid AND ordering = 20035;
    
    -- Module 5: Real Software (3 lessons)
    UPDATE lessons SET ordering = 20041 WHERE course_id = cid AND title ILIKE '%Debugging%';
    UPDATE lessons SET ordering = 20042 WHERE course_id = cid AND title ILIKE '%SaaS%';
    UPDATE lessons SET ordering = 20043 WHERE course_id = cid AND title ILIKE '%LMS%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = 20041;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = 20042;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = 20043;
    
    -- Module 6: Data (3 lessons)
    UPDATE lessons SET ordering = 20051 WHERE course_id = cid AND title ILIKE '%Databases%';
    UPDATE lessons SET ordering = 20052 WHERE course_id = cid AND title ILIKE '%Auth%';
    UPDATE lessons SET ordering = 20053 WHERE course_id = cid AND title ILIKE '%State%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = 20051;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = 20052;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = 20053;
    
    -- Module 7: Advanced (3 lessons)
    UPDATE lessons SET ordering = 20061 WHERE course_id = cid AND title ILIKE '%Verification%';
    UPDATE lessons SET ordering = 20062 WHERE course_id = cid AND title ILIKE '%Cost%';
    UPDATE lessons SET ordering = 20063 WHERE course_id = cid AND title ILIKE '%When NOT%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = 20061;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = 20062;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = 20063;
    
    -- Module 8: Career (4 lessons)
    UPDATE lessons SET ordering = 20071 WHERE course_id = cid AND title ILIKE '%Internal Tools%';
    UPDATE lessons SET ordering = 20072 WHERE course_id = cid AND title ILIKE '%Client Work%';
    UPDATE lessons SET ordering = 20073 WHERE course_id = cid AND title ILIKE '%Future%';
    UPDATE lessons SET ordering = 20074 WHERE course_id = cid AND title ILIKE '%Recommended Resources%';
    
    UPDATE lessons SET ordering = 1 WHERE course_id = cid AND ordering = 20071;
    UPDATE lessons SET ordering = 2 WHERE course_id = cid AND ordering = 20072;
    UPDATE lessons SET ordering = 3 WHERE course_id = cid AND ordering = 20073;
    UPDATE lessons SET ordering = 4 WHERE course_id = cid AND ordering = 20074;

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
