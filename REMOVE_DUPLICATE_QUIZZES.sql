-- ==========================================
-- SAFELY REMOVE DUPLICATE QUIZZES
-- This version groups by lesson_id AND question
-- to avoid removing quizzes from different courses
-- ==========================================

-- 1. First, let's see duplicates PER LESSON (not across courses)
SELECT 
    c.title as course,
    l.title as lesson,
    q.question,
    COUNT(*) as duplicate_count
FROM quizzes q
JOIN lessons l ON l.id = q.lesson_id
JOIN modules m ON m.id = l.module_id
JOIN courses c ON c.id = m.course_id
GROUP BY c.title, l.title, q.lesson_id, q.question
HAVING COUNT(*) > 1
ORDER BY c.title, l.title, duplicate_count DESC;

-- 2. SAFE duplicate removal - only removes duplicates WITHIN the same lesson
DELETE FROM quizzes
WHERE id NOT IN (
    SELECT MIN(id)
    FROM quizzes
    GROUP BY lesson_id, question
    -- This ensures we only remove duplicates for the SAME lesson
);

-- 3. Verify no duplicates remain WITHIN each lesson
SELECT 
    c.title as course,
    l.title as lesson,
    q.question,
    COUNT(*) as count
FROM quizzes q
JOIN lessons l ON l.id = q.lesson_id
JOIN modules m ON m.id = l.module_id
JOIN courses c ON c.id = m.course_id
GROUP BY c.title, l.title, q.lesson_id, q.question
HAVING COUNT(*) > 1;
-- Should return 0 rows

-- 4. Verify all courses still have their quizzes
SELECT 
    c.title as course,
    COUNT(DISTINCT l.id) as total_lessons,
    COUNT(DISTINCT q.lesson_id) as lessons_with_quizzes,
    COUNT(q.id) as total_quiz_questions
FROM courses c
LEFT JOIN modules m ON m.course_id = c.id
LEFT JOIN lessons l ON l.module_id = m.id
LEFT JOIN quizzes q ON q.lesson_id = l.id
WHERE c.title IN (
    'Facebook Ads Foundation',
    'Facebook Ads Mastery', 
    'Vibe Coding 3.0',
    'Prompt Engineering Mastery'
)
GROUP BY c.id, c.title
ORDER BY c.title;

-- ==========================================
-- EXPECTED RESULTS (approximate):
-- Facebook Ads Foundation: ~50-100 questions
-- Facebook Ads Mastery: ~50-100 questions
-- Vibe Coding 3.0: ~130-150 questions
-- Prompt Engineering Mastery: ~135-150 questions
-- ==========================================

SELECT '✅ Safe duplicate removal complete!' as status;
