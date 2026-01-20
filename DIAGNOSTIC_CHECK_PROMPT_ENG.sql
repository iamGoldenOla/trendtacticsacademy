-- ============================================================================
-- DIAGNOSTIC QUERY: Check Prompt Engineering Course Status
-- ============================================================================
-- Run this in Supabase SQL Editor to see what's in your database
-- ============================================================================

-- 1. Check if Prompt Engineering course exists
SELECT id, title, description 
FROM courses 
WHERE title ILIKE '%Prompt Engineering%';

-- 2. Check modules for Prompt Engineering
SELECT m.id, m.title, m.ordering, COUNT(l.id) as lesson_count
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id IN (SELECT id FROM courses WHERE title ILIKE '%Prompt Engineering%')
GROUP BY m.id, m.title, m.ordering
ORDER BY m.ordering;

-- 3. Check lessons for Prompt Engineering (first 5 only)
SELECT l.id, l.title, l.order_index, m.title as module_title,
       LENGTH(l.description) as content_length,
       CASE 
           WHEN l.description IS NULL THEN 'NO CONTENT'
           WHEN LENGTH(l.description) < 100 THEN 'PLACEHOLDER'
           WHEN LENGTH(l.description) > 1000 THEN 'FULL CONTENT'
           ELSE 'PARTIAL'
       END as content_status
FROM lessons l
JOIN modules m ON l.module_id = m.id
WHERE l.course_id IN (SELECT id FROM courses WHERE title ILIKE '%Prompt Engineering%')
ORDER BY l.order_index
LIMIT 5;

-- 4. Count total lessons by status
SELECT 
    CASE 
        WHEN description IS NULL THEN 'NO CONTENT'
        WHEN LENGTH(description) < 100 THEN 'PLACEHOLDER'
        WHEN LENGTH(description) > 1000 THEN 'FULL CONTENT'
        ELSE 'PARTIAL'
    END as status,
    COUNT(*) as count
FROM lessons
WHERE course_id IN (SELECT id FROM courses WHERE title ILIKE '%Prompt Engineering%')
GROUP BY status;

-- ============================================================================
-- EXPECTED RESULTS:
-- ============================================================================
-- Query 1: Should show 1 course (Prompt Engineering)
-- Query 2: Should show 4 modules (Foundations, Core Techniques, Advanced Workflows, Professional Mastery)
-- Query 3: Should show lessons with "FULL CONTENT" status (1000+ characters)
-- Query 4: Should show most/all lessons as "FULL CONTENT"
--
-- IF YOU SEE:
-- - Different module names → The SQL didn't match existing modules
-- - "PLACEHOLDER" or "NO CONTENT" → The SQL didn't update the lessons
-- - Wrong lesson count → Some SQL files didn't run
-- ============================================================================
