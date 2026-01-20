-- ==========================================
-- VERIFY QUIZZES IN DATABASE
-- Run this in Supabase SQL Editor
-- ==========================================

-- 1. Check if quizzes table exists and has data
SELECT 
    COUNT(*) as total_quizzes,
    COUNT(DISTINCT lesson_id) as lessons_with_quizzes
FROM quizzes;

-- 2. Check quizzes per course
SELECT 
    c.title as course_title,
    COUNT(DISTINCT q.id) as quiz_count,
    COUNT(DISTINCT q.lesson_id) as lessons_with_quizzes
FROM courses c
LEFT JOIN modules m ON m.course_id = c.id
LEFT JOIN lessons l ON l.module_id = m.id
LEFT JOIN quizzes q ON q.lesson_id = l.id
GROUP BY c.id, c.title
ORDER BY c.title;

-- 3. Sample quiz data
SELECT 
    c.title as course,
    l.title as lesson,
    q.question,
    q.options,
    q.correct_answer
FROM quizzes q
JOIN lessons l ON l.id = q.lesson_id
JOIN modules m ON m.id = l.module_id
JOIN courses c ON c.id = m.course_id
LIMIT 10;

-- 4. Check for lessons without quizzes
SELECT 
    c.title as course,
    l.title as lesson,
    l.id as lesson_id
FROM lessons l
JOIN modules m ON m.id = l.module_id
JOIN courses c ON c.id = m.course_id
LEFT JOIN quizzes q ON q.lesson_id = l.id
WHERE q.id IS NULL
ORDER BY c.title, l.ordering;

-- ==========================================
-- IF NO QUIZZES FOUND, RUN THESE SCRIPTS:
-- ==========================================
-- 1. DEPLOY_ALL_QUIZZES_MASTER.sql
-- 2. VIBE_ADD_ALL_QUIZZES.sql
-- 3. FB_MASTERY_ADD_QUIZZES.sql
-- 4. FB_FOUNDATION_ADD_QUIZZES.sql
-- 5. PROMPT_ADD_ALL_QUIZZES.sql
-- ==========================================
