-- ============================================================================
-- DIAGNOSE VIBE CODING STATE
-- ============================================================================
-- Checks for duplicate courses and lists all lessons associated with 'Vibe Coding'.
-- This will help identifying why the previous UPDATE script missed the lessons.
-- ============================================================================

DO $$ 
DECLARE
    info_text TEXT := '';
BEGIN
    RAISE NOTICE '--- CHECKING COURSES ---';
END $$;

-- 1. List all courses with 'Vibe' in the title
SELECT id, title, level, created_at 
FROM courses 
WHERE title ILIKE '%Vibe%';

-- 2. List all lessons attached to ANY 'Vibe' course
--    and show their current Video URL.
SELECT 
    c.title as course_title,
    c.id as course_id,
    l.id as lesson_id,
    l.title as lesson_title,
    l.module_id,
    l.video_url
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Vibe%'
ORDER BY c.title, l.ordering;

-- 3. Check if there are lessons with Vibe titles but NO Course connection (Orphaned? Unlikely strict FK)
--    or attached to a different course?
SELECT id, course_id, title, video_url 
FROM lessons 
WHERE title ILIKE '%Intent Is the New Programming%';
