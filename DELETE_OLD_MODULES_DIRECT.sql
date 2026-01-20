-- ============================================================================
-- FINAL FIX: Delete Specific Old Modules by ID
-- ============================================================================
-- Directly delete the 4 old modules that are causing duplicates
-- ============================================================================

-- First, delete the lessons in those old modules
DELETE FROM lessons WHERE module_id IN (
    'b9b2104b-770d-4bba-bc41-2a009564fe9a',  -- Old Module 1
    '5abb668a-79d0-461d-b759-635541c5ab8f',  -- Old Module 2
    'b1bc51a6-8352-404c-8322-3914cc115f74',  -- Old Module 3
    '2ac3ab9a-e1a9-4bad-94af-333efe3bf328'   -- Old Module 4
);

-- Then delete the old modules themselves
DELETE FROM modules WHERE id IN (
    'b9b2104b-770d-4bba-bc41-2a009564fe9a',  -- Prompt Engineering to Behavior Architecture
    '5abb668a-79d0-461d-b759-635541c5ab8f',  -- Multi-Agent Orchestration
    'b1bc51a6-8352-404c-8322-3914cc115f74',  -- Meta-Prompting & Self-Optimization
    '2ac3ab9a-e1a9-4bad-94af-333efe3bf328'   -- AI Ethics & Governance 2026
);

-- Verify the cleanup
SELECT m.id, m.title, m.ordering, COUNT(l.id) as lesson_count
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id IN (SELECT id FROM courses WHERE title ILIKE '%Prompt Engineering%')
GROUP BY m.id, m.title, m.ordering
ORDER BY m.ordering;
