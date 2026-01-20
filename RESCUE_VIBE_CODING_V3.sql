-- ============================================================================
-- RESCUE VIBE CODING V3 (Aggressive Module Clearing)
-- ============================================================================
-- 1. Finds the Vibe Coding Course and its Modules.
-- 2. "Explodes" the ordering of ALL lessons in these modules (regardless of course_id).
--    This fixes the constraint error where a lesson might occupy a slot but have a wrong course_id.
-- 3. Proceeds to link and update videos cleanly.
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
        RAISE EXCEPTION 'CRITICAL: Vibe Coding Course NOT found.';
    END IF;

    RAISE NOTICE 'Rescue V3 running for Course ID: %', cid;

    -- 2. Get Module IDs (Assuming they exist, else we'd have bigger schema issues)
    SELECT id INTO m1_id FROM modules WHERE course_id = cid AND (title ILIKE '%Foundations%' OR ordering = 1) LIMIT 1;
    SELECT id INTO m2_id FROM modules WHERE course_id = cid AND (title ILIKE '%AI%Builds%' OR ordering = 2) LIMIT 1;
    SELECT id INTO m3_id FROM modules WHERE course_id = cid AND (title ILIKE '%Core Workflow%' OR ordering = 3) LIMIT 1;
    SELECT id INTO m4_id FROM modules WHERE course_id = cid AND (title ILIKE '%Toolkit%' OR ordering = 4) LIMIT 1;
    SELECT id INTO m5_id FROM modules WHERE course_id = cid AND (title ILIKE '%Real Software%' OR ordering = 5) LIMIT 1;
    SELECT id INTO m6_id FROM modules WHERE course_id = cid AND (title ILIKE '%Data%' OR ordering = 6) LIMIT 1;
    SELECT id INTO m7_id FROM modules WHERE course_id = cid AND (title ILIKE '%Advanced%' OR ordering = 7) LIMIT 1;
    SELECT id INTO m8_id FROM modules WHERE course_id = cid AND (title ILIKE '%Career%' OR ordering = 8) LIMIT 1;

    -- ========================================================================
    -- STEP 0: THE NUCLEAR OPTION (Clear by Module ID)
    -- ========================================================================
    -- We target the MODULES directly. If a lesson is in Module 4, it moves.
    -- We don't care if it thinks it belongs to Course XYZ.
    UPDATE lessons 
    SET ordering = ordering + 5000 
    WHERE module_id IN (m1_id, m2_id, m3_id, m4_id, m5_id, m6_id, m7_id, m8_id);

    -- Safety: Ensure all these lessons actually belong to our course
    UPDATE lessons 
    SET course_id = cid 
    WHERE module_id IN (m1_id, m2_id, m3_id, m4_id, m5_id, m6_id, m7_id, m8_id);


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

    UPDATE lessons SET course_id = cid, module_id = m8_id, ordering = 4
    WHERE title ILIKE '%Recommended Resources%';

END $$;

-- VERIFICATION
SELECT 
    l.title, 
    l.module_id, 
    l.ordering,     
    CASE WHEN l.video_url IS NOT NULL THEN '✅ VIDEO' ELSE '❌ NO VIDEO' END as vid_status,
    CASE WHEN l.ordering < 100 THEN '✅ ACTIVE' ELSE '⚠️ PARKED' END as status
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%'
ORDER BY l.module_id, l.ordering ASC;
