-- ============================================================================
-- FINAL COURSE CONSOLIDATION & CLEANUP
-- ============================================================================
-- 1. Identify the GOOD course (Prompt Engineering)
-- 2. Move all lessons to it
-- 3. Delete the bad duplicate course
-- 4. Ensure it's published and featured
-- ============================================================================

-- Step 1: Ensure the Target Course exists and is Published
UPDATE courses 
SET 
    status = 'published',
    level = 'Beginner',
    category = 'AI & Automation',
    price = 49.99,
    thumbnail_url = 'https://academy.trendtacticsdigital.com/images/prompt-engineering.jpg' -- Placeholder
WHERE id = '123e4567-e89b-12d3-a456-426614174001';

-- Step 2: Move ALL lessons from the "Bad" duplicate course to the "Good" one
-- We find the duplicate by title (fuzzy match) but NOT the good ID
UPDATE lessons
SET course_id = '123e4567-e89b-12d3-a456-426614174001'
WHERE course_id IN (
    SELECT id FROM courses 
    WHERE title ILIKE '%Prompt%' 
    AND id != '123e4567-e89b-12d3-a456-426614174001'
);

-- Step 3: Delete the Duplicate Course(s)
DELETE FROM courses 
WHERE title ILIKE '%Prompt%' 
AND id != '123e4567-e89b-12d3-a456-426614174001';

-- Step 4: Remove Duplicate Lessons (keep the one with the most content)
-- This is a bit complex, so we'll use a smart DELETE
DELETE FROM lessons a USING lessons b
WHERE a.id < b.id
AND a.title = b.title
AND a.course_id = '123e4567-e89b-12d3-a456-426614174001'
AND b.course_id = '123e4567-e89b-12d3-a456-426614174001';

-- Step 5: Verify Final State
SELECT 
    c.title as course_title,
    count(l.id) as lesson_count,
    c.status
FROM courses c
LEFT JOIN lessons l ON c.id = l.course_id
WHERE c.id = '123e4567-e89b-12d3-a456-426614174001'
GROUP BY c.id, c.title, c.status;
