-- ============================================================================
-- UPDATE MODULE 5 VIDEOS: User Provided Curated Content
-- ============================================================================
-- Updates specific lessons in Module 5 with the corrected YouTube links.
-- Extracted direct YouTube URLs from provided Bing search links.
-- Course ID: 123e4567-e89b-12d3-a456-426614174001
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
BEGIN

    -- 1. Prompt Engineering for Content Creation
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=jKZhJE8xdDE'
    WHERE course_id = cid AND title ILIKE '%Content Creation%';

    -- 2. Prompt Engineering for Code Generation
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=HVId6kYKKgQ'
    WHERE course_id = cid AND title ILIKE '%Code Generation%';

    -- 3. Prompt Engineering for Data Analysis
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=uuprB1LpT8Y'
    WHERE course_id = cid AND title ILIKE '%Data Analysis%';

END $$;

-- VERIFICATION
SELECT title, video_url 
FROM lessons 
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
AND title IN (
    'Prompt Engineering for Content Creation', 
    'Prompt Engineering for Code Generation', 
    'Prompt Engineering for Data Analysis'
);
