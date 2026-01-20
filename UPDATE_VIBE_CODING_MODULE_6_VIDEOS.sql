-- ============================================================================
-- UPDATE VIBE CODING MODULE 6 VIDEOS
-- ============================================================================
-- Updates lessons in Module 6 of "Vibe Coding" with user-provided YouTube links.
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

    -- Lesson: Databases Without Fear
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=cBs_6DyovXc'
    WHERE course_id = cid AND title ILIKE '%Databases Without Fear%';

    -- Lesson: Authentication & Roles
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=-IqMxPU3vbU'
    WHERE course_id = cid AND title ILIKE '%Authentication & Roles%';

    -- Lesson: State, Caching & Persistence
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=I2jV0HPUyHM'
    WHERE course_id = cid AND title ILIKE '%State, Caching & Persistence%';

END $$;

-- VERIFICATION
SELECT c.title as Course, l.title as Lesson, l.video_url
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%'
AND l.module_id IN (SELECT id FROM modules WHERE course_id = c.id AND title ILIKE '%Module 6%');
