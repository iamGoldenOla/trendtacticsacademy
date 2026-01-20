-- ============================================================================
-- UPDATE MODULE 3 VIDEOS: User Provided Curated Content
-- ============================================================================
-- Updates specific lessons in Module 3 with the corrected YouTube links.
-- Extracted direct YouTube URLs from provided Bing search links.
-- Course ID: 123e4567-e89b-12d3-a456-426614174001
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
BEGIN

    -- 1. Designing The Swarm
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=E6iJx4ePQCc'
    WHERE course_id = cid AND title ILIKE '%Designing The Swarm%';

    -- 2. Agent Control Planes
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=ZVKJVwQNQJQ'
    WHERE course_id = cid AND title ILIKE '%Agent Control Planes%';

    -- 3. Dynamic Prompting
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=kijFMdTpu7Q'
    WHERE course_id = cid AND title ILIKE '%Dynamic Prompting%';

    -- 4. Prompt Chaining
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=sNo3_bBGRng'
    WHERE course_id = cid AND title = 'Prompt Chaining';

    -- 5. Iterative Refinement and Prompt Chaining
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=jJklCOOsiHI'
    WHERE course_id = cid AND title ILIKE '%Iterative Refinement%';

    -- 6. Few-Shot Learning and Examples
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=SCZLhnbJ2bc'
    WHERE course_id = cid AND title ILIKE '%Few-Shot Learning and Examples%';

END $$;

-- VERIFICATION
SELECT title, video_url 
FROM lessons 
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
AND title IN (
    'Designing The Swarm', 
    'Agent Control Planes', 
    'Dynamic Prompting', 
    'Prompt Chaining', 
    'Iterative Refinement and Prompt Chaining',
    'Few-Shot Learning and Examples'
);
