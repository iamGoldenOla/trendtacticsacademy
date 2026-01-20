-- ============================================================================
-- UPDATE MODULE 6 VIDEOS: User Provided Curated Content
-- ============================================================================
-- Updates specific lessons in Module 6 with the corrected YouTube links.
-- Extracted direct YouTube URLs from provided Bing search links.
-- Course ID: 123e4567-e89b-12d3-a456-426614174001
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
BEGIN

    -- 1. Common Prompt Engineering Mistakes
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=MUsSVTUw9lA'
    WHERE course_id = cid AND title ILIKE '%Common Prompt Engineering Mistakes%';

    -- 2. Testing and Validating Prompts
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=df4IGEZ9hu8'
    WHERE course_id = cid AND title ILIKE '%Testing and Validating Prompts%';

    -- 3. Final Projects & Advanced Strategy
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=rI1FcpKi0Lc'
    WHERE course_id = cid AND title ILIKE '%Final Projects%';

END $$;

-- VERIFICATION
SELECT title, video_url 
FROM lessons 
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
AND module_id IN (SELECT id FROM modules WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' AND title ILIKE '%Module 6%');
