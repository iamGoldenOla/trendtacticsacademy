-- Fix Vibe Coding Title and Ensure All Courses are Published

-- 1. Update Vibe Coding Title
UPDATE courses
SET title = 'Vibe Coding'
WHERE title ILIKE '%Vibe Coding%';

-- 2. Ensure Facebook Ads Foundation is Published
UPDATE courses
SET status = 'published'
WHERE id = 'a1b2c3d4-e5f6-7890-1234-567890abcdef';

-- 3. Verify All Courses
SELECT id, title, status FROM courses;
