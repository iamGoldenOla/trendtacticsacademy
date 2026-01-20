-- ============================================================================
-- FIX ALL VIBE CODING VIDEOS (Grand Unification Fix)
-- ============================================================================
-- Forces a video update for EVERY lesson in the Vibe Coding course.
-- Uses the single, definitive link from the Master Backup.
-- Includes verification output to prove rows were updated.
-- ============================================================================

DO $$
DECLARE
    cid UUID;
    updated_count INT;
BEGIN
    -- 1. Find Vibe Coding Course
    SELECT id INTO cid FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1;
    
    IF cid IS NULL THEN
        RAISE EXCEPTION 'CRITICAL: Vibe Coding Course NOT found in database.';
    END IF;

    RAISE NOTICE 'Updating videos for Course ID: %', cid;

    -- ========================================================================
    -- MODULE 1: Foundations
    -- ========================================================================
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=_xc7ikBW3Yo' 
    WHERE course_id = cid AND title ILIKE '%Intent Is the New Programming%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=lpQugp7AXEU' 
    WHERE course_id = cid AND title ILIKE '%What Is Vibe Coding%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=qaZC3XSAeR8' 
    WHERE course_id = cid AND title ILIKE '%From Writing Code%';

    -- ========================================================================
    -- MODULE 2: AI Software Construction
    -- ========================================================================
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=006V3t__xkc' 
    WHERE course_id = cid AND title ILIKE '%How AI Thinks%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=-uW5-TaVXu4' 
    WHERE course_id = cid AND title ILIKE '%Context, Memory%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=VQ0CW1fS2Og' 
    WHERE course_id = cid AND title ILIKE '%Preventing Repetition%';

    -- ========================================================================
    -- MODULE 3: Core Workflow
    -- ========================================================================
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=rYdIojvUj-Q' 
    WHERE course_id = cid AND title ILIKE '%System Prompts vs User Prompts%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=QfGZkQ4X4mU' 
    WHERE course_id = cid AND title ILIKE '%The Vibe Coding Loop%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=Q4_YjmzzD3U' 
    WHERE course_id = cid AND title ILIKE '%Modular Thinking%';

    -- ========================================================================
    -- MODULE 4: The Toolkit
    -- ========================================================================
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=X406gPfof1E' 
    WHERE course_id = cid AND title ILIKE '%UI / Frontend AI%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=PWDDHgW3vog' 
    WHERE course_id = cid AND title ILIKE '%Full-Stack & Auto Builders%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=1oTuMPIwHmk' 
    WHERE course_id = cid AND title ILIKE '%Backend, Logic & Data%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=OxG7df254cw' 
    WHERE course_id = cid AND title ILIKE '%Agentic IDEs%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=X3XJeTApVMM' 
    WHERE course_id = cid AND title ILIKE '%AI Agents & Orchestration%';

    -- ========================================================================
    -- MODULE 5: Building Software
    -- ========================================================================
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=IS5dAkFSo_Y' 
    WHERE course_id = cid AND title ILIKE '%Debugging AI Systems%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=SmQ9UyyQ2lo' 
    WHERE course_id = cid AND title ILIKE '%Building a SaaS%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=Oo8xo7991nA' 
    WHERE course_id = cid AND title ILIKE '%Building an LMS%';

    -- ========================================================================
    -- MODULE 6: Data & Auth
    -- ========================================================================
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=cBs_6DyovXc' 
    WHERE course_id = cid AND title ILIKE '%Databases Without Fear%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=-IqMxPU3vbU' 
    WHERE course_id = cid AND title ILIKE '%Authentication & Roles%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=I2jV0HPUyHM' 
    WHERE course_id = cid AND title ILIKE '%State, Caching%';

    -- ========================================================================
    -- MODULE 7: Advanced
    -- ========================================================================
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=QfGZkQ4X4mU' 
    WHERE course_id = cid AND title ILIKE '%Verification Prompts%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=PWDDHgW3vog' 
    WHERE course_id = cid AND title ILIKE '%Cost%Performance%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=UcYl9HKT1Mg' 
    WHERE course_id = cid AND title ILIKE '%When NOT to Use AI%';

    -- ========================================================================
    -- MODULE 8: Career
    -- ========================================================================
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=9UhexJn7ZRA' 
    WHERE course_id = cid AND title ILIKE '%Internal Tools%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=X4SU_f8Z2P0' 
    WHERE course_id = cid AND title ILIKE '%Client Work%';

    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=KATAoOtxSqQ' 
    WHERE course_id = cid AND title ILIKE '%Future of Software%';

END $$;

-- VERIFICATION: Show me what we have now
SELECT 
    l.title as lesson_title,
    CASE WHEN l.video_url IS NOT NULL THEN '✅ Has Video' ELSE '❌ MISSING' END as status,
    l.video_url
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%'
ORDER BY l.ordering ASC;
