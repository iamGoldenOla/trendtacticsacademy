-- Keep only the Vibe Coding course and remove all other courses
-- This will delete all courses except Vibe Coding (ID: a1b2c3d4-e5f6-7890-abcd-ef1234567890)

-- First, delete lessons for all courses except Vibe Coding
DELETE FROM lessons 
WHERE module_id IN (
    SELECT id FROM modules WHERE course_id != 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
);

-- Delete modules for all courses except Vibe Coding
DELETE FROM modules WHERE course_id != 'a1b2c3d4-e5f6-7890-abcd-ef1234567890';

-- Delete all courses except Vibe Coding
DELETE FROM courses WHERE id != 'a1b2c3d4-e5f6-7890-abcd-ef1234567890';

-- Verify that only Vibe Coding course remains
SELECT 
    id,
    title,
    (SELECT COUNT(*) FROM modules WHERE course_id = courses.id) as module_count,
    (SELECT COUNT(*) FROM lessons WHERE module_id IN (
        SELECT id FROM modules WHERE course_id = courses.id
    )) as lesson_count
FROM courses;