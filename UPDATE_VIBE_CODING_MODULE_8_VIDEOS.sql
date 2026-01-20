-- ============================================================================
-- UPDATE VIBE CODING MODULE 8 VIDEOS
-- ============================================================================
-- Updates lessons in Module 8 of "Vibe Coding" with user-provided YouTube links.
-- Extracted direct YouTube URLs from provided Bing search links.
-- Dynamically finds the Vibe Coding course ID.
-- ============================================================================

DO $$
DECLARE
    cid UUID;
BEGIN
    -- 1. Find the Vibe Coding Course ID
    SELECT id INTO cid FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1;

    -- Safety Check
    IF cid IS NULL THEN
        RAISE EXCEPTION 'Vibe Coding Course Not Found';
    END IF;

    -- 2. Update Lesson Videos
    -- ========================================

    -- Lesson: Internal Tools
    -- Selected "How to Build Internal Tools with Low-Code" (9UhexJn7ZRA)
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=9UhexJn7ZRA'
    WHERE course_id = cid AND title ILIKE '%Internal Tools%';

    -- Lesson: Client Work
    -- Selected "7 Truths About Client Work" (X4SU_f8Z2P0)
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=X4SU_f8Z2P0'
    WHERE course_id = cid AND title ILIKE '%Client Work%';

    -- Lesson: The Future of Software
    -- Selected "The Future of Software Development (2025 & Beyond)" (KATAoOtxSqQ)
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=KATAoOtxSqQ'
    WHERE course_id = cid AND title ILIKE '%Future of Software%';

END $$;

-- VERIFICATION
SELECT c.title as Course, l.title as Lesson, l.video_url
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%'
AND l.module_id IN (SELECT id FROM modules WHERE course_id = c.id AND title ILIKE '%Module 8%');
