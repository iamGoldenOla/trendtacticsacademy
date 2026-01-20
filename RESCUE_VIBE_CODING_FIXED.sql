-- ============================================================================
-- RESCUE VIBE CODING V2 (Collision Fix)
-- ============================================================================
-- 1. Clears ordering conflicts by moving ALL lessons to a safe range (1000+).
-- 2. Connects orphaned lessons to the Vibe Coding course.
-- 3. Assigns correct Modules and Ordering constraints.
-- 4. Updates Video URLs from the Master Backup.
-- ============================================================================

DO $$
DECLARE
    cid UUID;
    m1_id UUID; m2_id UUID; m3_id UUID; m4_id UUID;
    m5_id UUID; m6_id UUID; m7_id UUID; m8_id UUID;
BEGIN
    -- 1. Find the Vibe Coding Course
    SELECT id INTO cid FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1;
    
    IF cid IS NULL THEN
        RAISE EXCEPTION 'CRITICAL: Vibe Coding Course NOT found. Please create it first.';
    END IF;

    RAISE NOTICE 'Rescuing lessons for Course ID: %', cid;

    -- 2. Get Module IDs
    SELECT id INTO m1_id FROM modules WHERE course_id = cid AND (title ILIKE '%Foundations%' OR ordering = 1) LIMIT 1;
    SELECT id INTO m2_id FROM modules WHERE course_id = cid AND (title ILIKE '%AI%Builds%' OR ordering = 2) LIMIT 1;
    SELECT id INTO m3_id FROM modules WHERE course_id = cid AND (title ILIKE '%Core Workflow%' OR ordering = 3) LIMIT 1;
    SELECT id INTO m4_id FROM modules WHERE course_id = cid AND (title ILIKE '%Toolkit%' OR ordering = 4) LIMIT 1;
    SELECT id INTO m5_id FROM modules WHERE course_id = cid AND (title ILIKE '%Real Software%' OR ordering = 5) LIMIT 1;
    SELECT id INTO m6_id FROM modules WHERE course_id = cid AND (title ILIKE '%Data%' OR ordering = 6) LIMIT 1;
    SELECT id INTO m7_id FROM modules WHERE course_id = cid AND (title ILIKE '%Advanced%' OR ordering = 7) LIMIT 1;
    SELECT id INTO m8_id FROM modules WHERE course_id = cid AND (title ILIKE '%Career%' OR ordering = 8) LIMIT 1;

    -- ========================================================================
    -- STEP 0: THE RESET (Prevents "Duplicate Key" Errors)
    -- ========================================================================
    -- Move ALL lessons in this course to a high ordering number temporarily.
    -- This clears spots 1, 2, 3... for the incoming updates.
    UPDATE lessons 
    SET ordering = ordering + 2000 
    WHERE course_id = cid OR course_id IS NULL; -- Covering orphans too just in case

    -- ========================================================================
    -- STEP 1: RESCUE & UPDATE
    -- ========================================================================
    
    -- MODULE 1
    UPDATE lessons SET course_id = cid, module_id = m1_id, ordering = 1, video_url = 'https://www.youtube.com/watch?v=_xc7ikBW3Yo' 
    WHERE title ILIKE '%Intent Is the New Programming%';
    
    UPDATE lessons SET course_id = cid, module_id = m1_id, ordering = 2, video_url = 'https://www.youtube.com/watch?v=lpQugp7AXEU' 
    WHERE title ILIKE '%What Is Vibe Coding%';
    
    UPDATE lessons SET course_id = cid, module_id = m1_id, ordering = 3, video_url = 'https://www.youtube.com/watch?v=qaZC3XSAeR8' 
    WHERE title ILIKE '%From Writing Code%';

    -- MODULE 2
    UPDATE lessons SET course_id = cid, module_id = m2_id, ordering = 1, video_url = 'https://www.youtube.com/watch?v=006V3t__xkc' 
    WHERE title ILIKE '%How AI Thinks%';
    
    UPDATE lessons SET course_id = cid, module_id = m2_id, ordering = 2, video_url = 'https://www.youtube.com/watch?v=-uW5-TaVXu4' 
    WHERE title ILIKE '%Context, Memory%';
    
    UPDATE lessons SET course_id = cid, module_id = m2_id, ordering = 3, video_url = 'https://www.youtube.com/watch?v=VQ0CW1fS2Og' 
    WHERE title ILIKE '%Preventing Repetition%';

    -- MODULE 3
    UPDATE lessons SET course_id = cid, module_id = m3_id, ordering = 1, video_url = 'https://www.youtube.com/watch?v=rYdIojvUj-Q' 
    WHERE title ILIKE '%System Prompts vs User Prompts%';
    
    UPDATE lessons SET course_id = cid, module_id = m3_id, ordering = 2, video_url = 'https://www.youtube.com/watch?v=QfGZkQ4X4mU' 
    WHERE title ILIKE '%The Vibe Coding Loop%';
    
    UPDATE lessons SET course_id = cid, module_id = m3_id, ordering = 3, video_url = 'https://www.youtube.com/watch?v=Q4_YjmzzD3U' 
    WHERE title ILIKE '%Modular Thinking%';

    -- MODULE 4
    UPDATE lessons SET course_id = cid, module_id = m4_id, ordering = 1, video_url = 'https://www.youtube.com/watch?v=X406gPfof1E' 
    WHERE title ILIKE '%UI / Frontend AI%';
    
    UPDATE lessons SET course_id = cid, module_id = m4_id, ordering = 2, video_url = 'https://www.youtube.com/watch?v=PWDDHgW3vog' 
    WHERE title ILIKE '%Full-Stack & Auto Builders%';
    
    UPDATE lessons SET course_id = cid, module_id = m4_id, ordering = 3, video_url = 'https://www.youtube.com/watch?v=1oTuMPIwHmk' 
    WHERE title ILIKE '%Backend, Logic & Data%';
    
    UPDATE lessons SET course_id = cid, module_id = m4_id, ordering = 4, video_url = 'https://www.youtube.com/watch?v=OxG7df254cw' 
    WHERE title ILIKE '%Agentic IDEs%';
    
    UPDATE lessons SET course_id = cid, module_id = m4_id, ordering = 5, video_url = 'https://www.youtube.com/watch?v=X3XJeTApVMM' 
    WHERE title ILIKE '%AI Agents & Orchestration%';

    -- MODULE 5
    UPDATE lessons SET course_id = cid, module_id = m5_id, ordering = 1, video_url = 'https://www.youtube.com/watch?v=IS5dAkFSo_Y' 
    WHERE title ILIKE '%Debugging AI Systems%';
    
    UPDATE lessons SET course_id = cid, module_id = m5_id, ordering = 2, video_url = 'https://www.youtube.com/watch?v=SmQ9UyyQ2lo' 
    WHERE title ILIKE '%Building a SaaS%';
    
    UPDATE lessons SET course_id = cid, module_id = m5_id, ordering = 3, video_url = 'https://www.youtube.com/watch?v=Oo8xo7991nA' 
    WHERE title ILIKE '%Building an LMS%';

    -- MODULE 6
    UPDATE lessons SET course_id = cid, module_id = m6_id, ordering = 1, video_url = 'https://www.youtube.com/watch?v=cBs_6DyovXc' 
    WHERE title ILIKE '%Databases Without Fear%';
    
    UPDATE lessons SET course_id = cid, module_id = m6_id, ordering = 2, video_url = 'https://www.youtube.com/watch?v=-IqMxPU3vbU' 
    WHERE title ILIKE '%Authentication & Roles%';
    
    UPDATE lessons SET course_id = cid, module_id = m6_id, ordering = 3, video_url = 'https://www.youtube.com/watch?v=I2jV0HPUyHM' 
    WHERE title ILIKE '%State, Caching%';

    -- MODULE 7
    UPDATE lessons SET course_id = cid, module_id = m7_id, ordering = 1, video_url = 'https://www.youtube.com/watch?v=QfGZkQ4X4mU' 
    WHERE title ILIKE '%Verification Prompts%';
    
    UPDATE lessons SET course_id = cid, module_id = m7_id, ordering = 2, video_url = 'https://www.youtube.com/watch?v=PWDDHgW3vog' 
    WHERE title ILIKE '%Cost%Performance%';
    
    UPDATE lessons SET course_id = cid, module_id = m7_id, ordering = 3, video_url = 'https://www.youtube.com/watch?v=UcYl9HKT1Mg' 
    WHERE title ILIKE '%When NOT to Use AI%';

    -- MODULE 8
    UPDATE lessons SET course_id = cid, module_id = m8_id, ordering = 1, video_url = 'https://www.youtube.com/watch?v=9UhexJn7ZRA' 
    WHERE title ILIKE '%Internal Tools%';
    
    UPDATE lessons SET course_id = cid, module_id = m8_id, ordering = 2, video_url = 'https://www.youtube.com/watch?v=X4SU_f8Z2P0' 
    WHERE title ILIKE '%Client Work%';
    
    UPDATE lessons SET course_id = cid, module_id = m8_id, ordering = 3, video_url = 'https://www.youtube.com/watch?v=KATAoOtxSqQ' 
    WHERE title ILIKE '%Future of Software%';

    UPDATE lessons SET course_id = cid, module_id = m8_id, ordering = 4, video_url = 'https://www.youtube.com/watch?v=lpQugp7AXEU' 
    WHERE title ILIKE '%Recommended Resources%';

    -- ========================================================================
    -- STEP 2: CLEANUP (Opt)
    -- ========================================================================
    -- Any lessons still in the 2000+ range are likely duplicates or old junk.
    -- We'll leave them for safekeeping but they won't appear in the first few slots.

END $$;

-- VERIFICATION
SELECT 
    l.title, 
    l.module_id, 
    l.ordering, 
    l.video_url,
    CASE WHEN l.ordering < 100 THEN '✅ ACTIVE' ELSE '⚠️ PARKED/DUPLICATE' END as status
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%'
ORDER BY l.ordering ASC;
