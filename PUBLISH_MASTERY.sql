-- Publish Facebook Ads Mastery
UPDATE courses
SET status = 'published'
WHERE id = '0987fcde-4321-0987-6543-210987654321';

-- Verify
SELECT title, status FROM courses WHERE title ILIKE '%Facebook%';
