-- ============================================================================
-- UPDATE MODULE 4 VIDEOS: User Provided Curated Content
-- ============================================================================
-- Updates specific lessons in Module 4 with the corrected YouTube links.
-- Extracted direct YouTube URLs from provided Bing search links.
-- Course ID: 123e4567-e89b-12d3-a456-426614174001
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
BEGIN

    -- 1. Constitutional AI & Alignment
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=SQpmdt7HvHM'
    WHERE course_id = cid AND title ILIKE '%Constitutional AI%';

    -- 2. Production Deployment
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=GiBlq7d8mn0'
    WHERE course_id = cid AND title ILIKE '%Production Deployment%';

    -- 3. Recursive Prompts
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=JN1nOAUXhqY'
    WHERE course_id = cid AND title ILIKE '%Recursive Prompts%';

    -- 4. Industry Applications & Case Studies
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=fuu9xjq_y1Q'
    WHERE course_id = cid AND title ILIKE '%Industry Applications%';

    -- 5. Temperature and Creativity Control
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=2wHbkOwGSa0'
    WHERE course_id = cid AND title ILIKE '%Temperature and Creativity%';

    -- 6. Zero-Shot and Self-Consistency Techniques
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=sZIV7em3JA8'
    WHERE course_id = cid AND title ILIKE '%Zero-Shot%';

END $$;

-- VERIFICATION
SELECT title, video_url 
FROM lessons 
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
AND title IN (
    'Constitutional AI & Alignment', 
    'Production Deployment', 
    'Recursive Prompts', 
    'Industry Applications & Case Studies', 
    'Temperature and Creativity Control',
    'Zero-Shot and Self-Consistency Techniques'
);
