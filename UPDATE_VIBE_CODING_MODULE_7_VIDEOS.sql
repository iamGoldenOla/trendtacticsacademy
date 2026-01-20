-- ============================================================================
-- UPDATE VIBE CODING MODULE 7 VIDEOS
-- ============================================================================
-- Updates lessons in Module 7 of "Vibe Coding" with user-provided YouTube links.
-- Filtering for the most relevant AI-specific links from the provided list.
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

    -- Lesson: Verification Prompts
    -- Selected "Prompt Injection & Verification Explained" (QfGZkQ4X4mU)
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=QfGZkQ4X4mU'
    WHERE course_id = cid AND title ILIKE '%Verification Prompts%';

    -- Lesson: Cost, Performance & Sanity
    -- Selected "AI Cost Optimization & Performance Tuning" (PWDDHgW3vog)
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=PWDDHgW3vog'
    WHERE course_id = cid AND title ILIKE '%Cost%Performance%';

    -- Lesson: When NOT to Use AI
    -- Selected "When NOT to Use AI Agents" (UcYl9HKT1Mg)
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=UcYl9HKT1Mg'
    WHERE course_id = cid AND title ILIKE '%When NOT to Use AI%';

END $$;

-- VERIFICATION
SELECT c.title as Course, l.title as Lesson, l.video_url
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%'
AND l.module_id IN (SELECT id FROM modules WHERE course_id = c.id AND title ILIKE '%Module 7%');
