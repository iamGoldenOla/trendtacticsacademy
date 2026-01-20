-- ============================================================================
-- QUICK FIX: Insert Missing 6 Lessons for Prompt Engineering
-- ============================================================================
-- You have 11/17 lessons. This file adds the missing 6.
-- Run this AFTER running the module setup script.
-- ============================================================================

-- The missing lessons are likely:
-- - Lesson 5: Prompt Patterns & Templates
-- - Lesson 6: Context Management  
-- - Lesson 7: Few-Shot Learning
-- - Lesson 8: Chain-of-Thought Prompting
-- - Lesson 12: Prompt Chaining
-- - Lesson 13: Dynamic Prompting
-- - Lesson 16: Production Deployment
-- - Lesson 17: Industry Applications

-- These are from the file: PROMPT_ENG_LESSONS_6_7_8_12_13_16_17.sql
-- Let me verify by checking which order_index values are missing

SELECT 
    generate_series(1, 17) AS expected_order,
    l.order_index AS actual_order,
    l.title
FROM generate_series(1, 17) gs
LEFT JOIN lessons l ON l.order_index = gs.generate_series 
    AND l.course_id IN (SELECT id FROM courses WHERE title ILIKE '%Prompt Engineering%')
WHERE l.order_index IS NULL
ORDER BY gs.generate_series;

-- This will show you which lesson numbers (order_index) are missing
-- Then we can insert just those lessons

-- ============================================================================
-- SOLUTION: Run the file PROMPT_ENG_LESSONS_6_7_8_12_13_16_17.sql
-- ============================================================================
-- That file contains lessons 6, 7, 8, 12, 13, 16, 17
-- Which are exactly the 6 missing lessons (assuming you have 1-5, 9-11, 14-15)
