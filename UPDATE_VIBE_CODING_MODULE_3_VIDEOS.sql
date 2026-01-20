-- ============================================================================
-- UPDATE VIBE CODING MODULE 3 VIDEOS
-- ============================================================================
-- Updates lessons in Module 3 of "Vibe Coding" with user-provided YouTube links.
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

    -- Lesson: System Prompts vs User Prompts
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=rYdIojvUj-Q'
    WHERE course_id = cid AND title ILIKE '%System Prompts vs User Prompts%';

    -- Lesson: The Vibe Coding Loop
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=QfGZkQ4X4mU'
    WHERE course_id = cid AND title ILIKE '%The Vibe Coding Loop%';

    -- Lesson: Modular Thinking
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=Q4_YjmzzD3U'
    WHERE course_id = cid AND title ILIKE '%Modular Thinking%';

END $$;

-- VERIFICATION
SELECT c.title as Course, l.title as Lesson, l.video_url
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%'
AND l.module_id IN (SELECT id FROM modules WHERE course_id = c.id AND title ILIKE '%Module 3%');
