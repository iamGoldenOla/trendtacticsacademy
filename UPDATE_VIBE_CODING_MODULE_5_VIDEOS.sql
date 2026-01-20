-- ============================================================================
-- UPDATE VIBE CODING MODULE 5 VIDEOS
-- ============================================================================
-- Updates lessons in Module 5 of "Vibe Coding" with user-provided YouTube links.
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

    -- Lesson: Debugging AI Systems
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=IS5dAkFSo_Y'
    WHERE course_id = cid AND title ILIKE '%Debugging AI Systems%';

    -- Lesson: Building a SaaS with AI
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=SmQ9UyyQ2lo'
    WHERE course_id = cid AND title ILIKE '%Building a SaaS%';

    -- Lesson: Building an LMS (Your Case Study)
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=Oo8xo7991nA'
    WHERE course_id = cid AND title ILIKE '%Building an LMS%';

END $$;

-- VERIFICATION
SELECT c.title as Course, l.title as Lesson, l.video_url
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%'
AND l.module_id IN (SELECT id FROM modules WHERE course_id = c.id AND title ILIKE '%Module 5%');
