-- ============================================================================
-- UPDATE MODULE 1 VIDEOS: User Provided Curated Content
-- ============================================================================
-- Updates specific lessons in Module 1 with the corrected YouTube links.
-- Course ID: 123e4567-e89b-12d3-a456-426614174001
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
BEGIN

    -- 1. Understanding AI Models
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=pO5xyXv622Q'
    WHERE course_id = cid AND title ILIKE '%Understanding AI Models%';

    -- 2. What Prompt Engineering Really Is
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=uDIW34h8cmM'
    WHERE course_id = cid AND title ILIKE '%What Prompt Engineering Really Is%';

    -- 3. How AI Interprets Instructions
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=KcSXcpluDe4'
    WHERE course_id = cid AND title ILIKE '%How AI Interprets Instructions%';

    -- 4. Prompt Engineering vs Traditional Instructions
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=pRB9KgcWdd4'
    WHERE course_id = cid AND title ILIKE '%vs Traditional Instructions%';

    -- Note: "The Death of the Single Prompt" was missing a link in the provided list.
    -- Retaining existing placeholder/default for that specific lesson.

END $$;

-- VERIFICATION
SELECT title, video_url 
FROM lessons 
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
AND title IN (
    'Understanding AI Models', 
    'What Prompt Engineering Really Is', 
    'How AI Interprets Instructions', 
    'Prompt Engineering vs Traditional Instructions'
);
