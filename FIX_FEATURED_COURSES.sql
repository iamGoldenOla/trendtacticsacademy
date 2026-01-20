-- Fix Featured Courses and Remove Duplicates
-- This SQL script will:
-- 1. Delete duplicate Facebook Ads Foundation course (keep the newer one with is_featured = true)
-- 2. Set all remaining courses as featured and published

-- Step 1: Check current state
SELECT 
    id,
    title,
    is_featured,
    is_published,
    created_at,
    (SELECT COUNT(*) FROM modules WHERE modules.course_id = courses.id) as module_count
FROM courses
ORDER BY created_at DESC;

-- Step 2: Identify and delete the duplicate Facebook Ads Foundation
-- We need to delete lessons first, then modules, then the course (due to foreign key constraints)

-- 2a. Find the duplicate course ID (the one with is_featured = false)
DO $$
DECLARE
    duplicate_course_id UUID;
BEGIN
    -- Get the ID of the duplicate course (is_featured = false)
    SELECT id INTO duplicate_course_id
    FROM courses
    WHERE title = 'Facebook Ads Foundation'
    AND is_featured = false
    LIMIT 1;
    
    IF duplicate_course_id IS NOT NULL THEN
        RAISE NOTICE 'Found duplicate course ID: %', duplicate_course_id;
        
        -- Delete lessons first
        DELETE FROM lessons
        WHERE module_id IN (
            SELECT id FROM modules WHERE course_id = duplicate_course_id
        );
        RAISE NOTICE 'Deleted lessons for duplicate course';
        
        -- Delete modules
        DELETE FROM modules
        WHERE course_id = duplicate_course_id;
        RAISE NOTICE 'Deleted modules for duplicate course';
        
        -- Delete the course
        DELETE FROM courses
        WHERE id = duplicate_course_id;
        RAISE NOTICE 'Deleted duplicate course';
    ELSE
        RAISE NOTICE 'No duplicate Facebook Ads Foundation course found';
    END IF;
END $$;

-- Step 3: Set all remaining courses as featured and published
UPDATE courses
SET 
    is_featured = true,
    is_published = true
WHERE is_published = true OR is_featured = true OR title IN ('Vibe Coding', 'Facebook Ads Mastery', 'Prompt Engineering Mastery', 'Facebook Ads Foundation');

-- Step 4: Verify the fix
SELECT 
    id,
    title,
    is_featured,
    is_published,
    (SELECT COUNT(*) FROM modules WHERE modules.course_id = courses.id) as module_count
FROM courses
ORDER BY created_at DESC;

-- Expected result: 4 courses, all with is_featured = true and is_published = true
-- 1. Facebook Ads Foundation (with 10 modules)
-- 2. Prompt Engineering Mastery
-- 3. Facebook Ads Mastery
-- 4. Vibe Coding
