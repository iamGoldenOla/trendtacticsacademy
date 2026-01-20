-- ============================================================================
-- UPDATE VIBE CODING MODULE 1 VIDEOS
-- ============================================================================
-- Updates lessons in Module 1 of "Vibe Coding" with user-provided YouTube links.
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

    -- Lesson: Intent Is the New Programming Language
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=_xc7ikBW3Yo'
    WHERE course_id = cid AND title ILIKE '%Intent Is the New Programming Language%';

    -- Lesson: What Is Vibe Coding (Deep)
    -- User specifically highlighted this video at the end of the request
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=lpQugp7AXEU'
    WHERE course_id = cid AND title ILIKE '%What Is Vibe Coding%';

    -- Lesson: From Writing Code to Directing Systems
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=qaZC3XSAeR8'
    WHERE course_id = cid AND title ILIKE '%From Writing Code to Directing Systems%';

END $$;

-- VERIFICATION
SELECT c.title as Course, l.title as Lesson, l.video_url
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%'
AND l.module_id IN (SELECT id FROM modules WHERE course_id = c.id AND ordering = 1);
