-- ============================================================================
-- UPDATE VIBE CODING MODULE 2 VIDEOS
-- ============================================================================
-- Updates lessons in Module 2 of "Vibe Coding" with user-provided YouTube links.
-- Dynamically finds the Vibe Coding course ID to ensure accuracy.
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

    -- Lesson: How AI Thinks (and Why It Breaks)
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=006V3t__xkc'
    WHERE course_id = cid AND title ILIKE '%How AI Thinks%';

    -- Lesson: Context, Memory, and Constraints
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=-uW5-TaVXu4'
    WHERE course_id = cid AND title ILIKE '%Context, Memory, and Constraints%';

    -- Lesson: Preventing Repetition & Duplicate Content
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=VQ0CW1fS2Og'
    WHERE course_id = cid AND title ILIKE '%Preventing Repetition%';

END $$;

-- VERIFICATION
SELECT c.title as Course, l.title as Lesson, l.video_url
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%'
AND l.module_id IN (SELECT id FROM modules WHERE course_id = c.id AND title ILIKE '%Module 2%');
