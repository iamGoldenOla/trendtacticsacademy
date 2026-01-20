-- Update the course title to the correct "Vibe Coding 3.0"
UPDATE courses
SET title = 'Vibe Coding 3.0'
WHERE title = 'Vibe Coding';

-- Verify the update
SELECT id, title, slug FROM courses WHERE title LIKE 'Vibe Coding%';
