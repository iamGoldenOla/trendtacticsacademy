-- ============================================================================
-- ENHANCE PROFESSIONAL LESSONS - Add Missing Content
-- ============================================================================
-- This adds objectives, playground, quizzes, resources, and case studies
-- to the professional lessons that are currently missing them
-- ============================================================================

-- First, let's identify which lessons need enhancement
SELECT 
    l.id,
    l.title,
    CASE WHEN l.key_takeaways IS NULL THEN '❌' ELSE '✅' END as has_objectives,
    CASE WHEN l.playground IS NULL THEN '❌' ELSE '✅' END as has_playground,
    CASE WHEN l.quizzes IS NULL THEN '❌' ELSE '✅' END as has_quizzes,
    CASE WHEN l.extra_resources IS NULL THEN '❌' ELSE '✅' END as has_resources,
    CASE WHEN l.case_studies IS NULL THEN '❌' ELSE '✅' END as has_cases
FROM lessons l
WHERE l.course_id = '123e4567-e89b-12d3-a456-426614174001'
AND l.title IN (
    'The Death of the Single Prompt',
    'Designing The Swarm',
    'Agent Control Planes',
    'Recursive Prompts',
    'Constitutional AI & Alignment'
)
ORDER BY l.title;
