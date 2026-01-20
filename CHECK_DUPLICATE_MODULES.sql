-- Step 1: First, let's see what we're dealing with
-- Run this to identify duplicate modules

SELECT 
    id,
    course_id,
    title,
    ordering,
    created_at
FROM modules
WHERE course_id = (SELECT id FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1)
ORDER BY ordering, created_at;

-- This will show us all modules and their current ordering values
-- Look for duplicates and identify which ones to keep
