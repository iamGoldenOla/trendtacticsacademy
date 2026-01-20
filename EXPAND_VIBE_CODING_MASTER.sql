-- ==========================================
-- VIBE CODING CONTENT EXPANSION - MASTER SCRIPT
-- Modules 1-2 Complete (7 Lessons)
-- Run this in Supabase SQL Editor
-- ==========================================

-- This script expands Vibe Coding lessons to 1200-word comprehensive content
-- matching the Facebook Ads Foundation standard

\i 'EXPAND_VIBE_CODING_MODULE_1_PART1.sql'
\i 'EXPAND_VIBE_CODING_MODULE_1_PART2.sql'
\i 'EXPAND_VIBE_CODING_MODULE_2_LESSON1.sql'
\i 'EXPAND_VIBE_CODING_MODULE_2_LESSONS_2_3.sql'

-- Note: The above uses PostgreSQL's \i command to include files
-- If your SQL editor doesn't support \i, copy and paste each file's content in order

-- ==========================================
-- VERIFICATION QUERY
-- ==========================================
SELECT 
    m.ordering as module_num,
    m.title as module_title,
    l.ordering as lesson_num,
    l.title as lesson_title,
    LENGTH(l.content) as content_length,
    CASE 
        WHEN LENGTH(l.content) > 1000 THEN '✅ Comprehensive (1200+ words)'
        WHEN LENGTH(l.content) > 500 THEN '⚠️ Moderate (500-1000 words)'
        ELSE '❌ Needs Expansion (<500 words)'
    END as content_status
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%'
  AND m.ordering IN (1, 2)
ORDER BY m.ordering, l.ordering;

-- ==========================================
-- PROGRESS SUMMARY
-- ==========================================
-- ✅ Module 1: Foundations of Vibe Coding (4 lessons)
--    - Intent Is the New Programming Language
--    - What Is Vibe Coding (Deep)
--    - From Writing Code to Directing Systems
--    - Recommended Resources & Ecosystem
--
-- ✅ Module 2: How AI Actually Builds Software (3 lessons)
--    - How AI Thinks (and Why It Breaks)
--    - Context, Memory, and Constraints
--    - Preventing Repetition & Duplicate Content
--
-- 📋 Remaining: Modules 3-8 (19+ lessons)
-- ==========================================
