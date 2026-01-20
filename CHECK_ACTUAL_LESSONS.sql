-- ============================================================================
-- CHECK: Which lessons are missing content?
-- ============================================================================

SELECT 
    l.title,
    CASE WHEN l.key_takeaways IS NULL THEN '❌ Missing' ELSE '✅ Has' END as objectives,
    CASE WHEN l.case_studies IS NULL THEN '❌ Missing' ELSE '✅ Has' END as cases,
    CASE WHEN l.playground IS NULL THEN '❌ Missing' ELSE '✅ Has' END as playground,
    CASE WHEN l.quizzes IS NULL THEN '❌ Missing' ELSE '✅ Has' END as quizzes,
    CASE WHEN l.extra_resources IS NULL THEN '❌ Missing' ELSE '✅ Has' END as resources,
    m.title as module
FROM lessons l
JOIN modules m ON l.module_id = m.id
WHERE l.course_id = '123e4567-e89b-12d3-a456-426614174001'
ORDER BY m.ordering, l.order_index;
