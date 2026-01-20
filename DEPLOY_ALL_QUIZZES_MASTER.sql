-- ==========================================
-- QUIZ VERIFICATION SCRIPT
-- Run this AFTER deploying individual quiz files
-- ==========================================

-- This script verifies all quizzes have been deployed correctly
-- Run the individual SQL files first, then run this to verify

-- ==========================================
-- VERIFICATION: CHECK ALL QUIZZES
-- ==========================================

SELECT 
    c.title as course,
    COUNT(DISTINCT m.id) as modules,
    COUNT(DISTINCT l.id) as lessons,
    COUNT(q.id) as total_quizzes,
    ROUND(COUNT(q.id)::numeric / NULLIF(COUNT(DISTINCT l.id), 0), 1) as avg_quizzes_per_lesson
FROM courses c
LEFT JOIN modules m ON m.course_id = c.id
LEFT JOIN lessons l ON l.module_id = m.id
LEFT JOIN quizzes q ON q.lesson_id = l.id
WHERE c.title IN (
    'Vibe Coding 3.0',
    'Prompt Engineering Mastery',
    'Facebook Ads Foundation',
    'Facebook Ads Mastery'
)
GROUP BY c.title
ORDER BY c.title;

-- Expected Results:
-- Vibe Coding 3.0: ~140 quizzes (28 lessons × 5)
-- Prompt Engineering Mastery: ~135 quizzes (27 lessons × 5)
-- Facebook Ads Foundation: varies by lesson count × 5
-- Facebook Ads Mastery: ~135 quizzes (27 lessons × 5)

-- ==========================================
-- DETAILED BREAKDOWN BY COURSE
-- ==========================================

-- Check each course individually
DO $$
BEGIN
    RAISE NOTICE '========================================';
    RAISE NOTICE 'QUIZ DEPLOYMENT VERIFICATION';
    RAISE NOTICE '========================================';
END $$;
