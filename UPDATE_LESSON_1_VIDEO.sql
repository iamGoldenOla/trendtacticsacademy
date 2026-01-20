-- ============================================================================
-- UPDATE LESSON 1 VIDEO: User Specific Request
-- ============================================================================
-- Updates "The Death of the Single Prompt" with the provided YouTube link.
-- Link: https://youtu.be/57wgHyz6dMk
-- Course ID: 123e4567-e89b-12d3-a456-426614174001
-- ============================================================================

UPDATE lessons 
SET video_url = 'https://youtu.be/57wgHyz6dMk'
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
AND title ILIKE '%Death of the Single Prompt%';

-- VERIFICATION
SELECT title, video_url 
FROM lessons 
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
AND title ILIKE '%Death of the Single Prompt%';
