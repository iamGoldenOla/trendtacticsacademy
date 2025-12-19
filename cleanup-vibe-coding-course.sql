-- Cleanup script to remove existing Vibe Coding course data
-- This will remove any existing data that might be causing duplicate key errors

-- Delete lessons first (due to foreign key constraints)
DELETE FROM lessons 
WHERE module_id IN (
    SELECT id FROM modules WHERE course_id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
);

-- Delete modules
DELETE FROM modules WHERE course_id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890';

-- Delete the course
DELETE FROM courses WHERE id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890';

-- Reset the auto-increment sequences if needed (for PostgreSQL)
-- SELECT setval('courses_id_seq', (SELECT MAX(id) FROM courses));
-- SELECT setval('modules_id_seq', (SELECT MAX(id) FROM modules));
-- SELECT setval('lessons_id_seq', (SELECT MAX(id) FROM lessons));