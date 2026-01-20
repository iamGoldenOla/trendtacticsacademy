-- ============================================================================
-- UPDATE MODULE 2 VIDEOS: User Provided Curated Content
-- ============================================================================
-- Updates specific lessons in Module 2 with the corrected YouTube links.
-- Course ID: 123e4567-e89b-12d3-a456-426614174001
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
BEGIN

    -- 1. Context Management
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=dBWhpivoCuI'
    WHERE course_id = cid AND title ILIKE '%Context Management%';

    -- 2. Chain-of-Thought Prompting
    -- (No link provided in user message, retaining existing video)

    -- 3. Few-Shot Learning
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=hE7eGew4eeg'
    WHERE course_id = cid AND title ILIKE '%Few-Shot Learning%' AND title NOT ILIKE '%Examples%';

    -- 4. Core Prompt Components
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=mPEASJWuA_s'
    WHERE course_id = cid AND title ILIKE '%Core Prompt Components%';

    -- 5. Context Layering
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=f7RgRAOZcqQ'
    WHERE course_id = cid AND title ILIKE '%Context Layering%';

    -- 6. Constraints & Guardrails
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=rMUycP_cp9g'
    WHERE course_id = cid AND title ILIKE '%Constraints & Guardrails%';

END $$;

-- VERIFICATION
SELECT title, video_url 
FROM lessons 
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
AND title IN (
    'Context Management', 
    'Few-Shot Learning',
    'Core Prompt Components',
    'Context Layering',
    'Constraints & Guardrails'
);
