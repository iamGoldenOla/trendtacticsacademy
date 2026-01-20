-- ============================================================================
-- UPDATE VIBE CODING MODULE 4 VIDEOS
-- ============================================================================
-- Updates lessons in Module 4 of "Vibe Coding" with user-provided YouTube links.
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

    -- Lesson: UI / Frontend AI
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=X406gPfof1E'
    WHERE course_id = cid AND title ILIKE '%UI / Frontend AI%';

    -- Lesson: Full-Stack & Auto Builders
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=PWDDHgW3vog'
    WHERE course_id = cid AND title ILIKE '%Full-Stack & Auto Builders%';

    -- Lesson: Backend, Logic & Data
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=1oTuMPIwHmk'
    WHERE course_id = cid AND title ILIKE '%Backend, Logic & Data%';

    -- Lesson: Agentic IDEs (Command Centers)
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=OxG7df254cw'
    WHERE course_id = cid AND title ILIKE '%Agentic IDEs%';

    -- Lesson: AI Agents & Orchestration
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=X3XJeTApVMM'
    WHERE course_id = cid AND title ILIKE '%AI Agents & Orchestration%';

END $$;

-- VERIFICATION
SELECT c.title as Course, l.title as Lesson, l.video_url
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%'
AND l.module_id IN (SELECT id FROM modules WHERE course_id = c.id AND title ILIKE '%Module 4%');
