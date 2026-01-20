-- ---------------------------------------------------------
-- SUPABASE NUKE COMMAND: VIBE CODING 3.0
-- ---------------------------------------------------------
-- PURPOSE: 
-- This script completely wipes all Modules and Lessons for the "Vibe Coding" course.
-- Use this if you see duplicate lessons, old content mixed with new, or ordering glitches.
-- After running this, reload course.html to trigger the fresh 26-lesson installation.
-- ---------------------------------------------------------

-- 1. Delete all Lessons for Vibe Coding (found by title match to be safe)
DELETE FROM lessons 
WHERE course_id IN (
    SELECT id FROM courses WHERE title ILIKE '%Vibe Coding%' OR title ILIKE '%Agentic%'
);

-- 2. Delete all Modules for Vibe Coding
DELETE FROM modules 
WHERE course_id IN (
    SELECT id FROM courses WHERE title ILIKE '%Vibe Coding%' OR title ILIKE '%Agentic%'
);

-- 3. (Optional) Reset any user progress for this course if needed
-- DELETE FROM user_progress
-- WHERE lesson_id IN (
--     SELECT id FROM lessons WHERE course_id IN (SELECT id FROM courses WHERE title ILIKE '%Vibe Coding%')
-- );

-- ---------------------------------------------------------
-- VERIFICATION
-- ---------------------------------------------------------
-- Run this after deletion to confirm 0 rows remain:
SELECT count(*) as remaining_lessons FROM lessons 
WHERE course_id IN (SELECT id FROM courses WHERE title ILIKE '%Vibe Coding%');
