-- CHECK WHAT THE FRONTEND IS EXPECTING
-- This will help us understand the mismatch between frontend and database

-- 1. Check if there are any courses in the AI Software Development category
SELECT 
    'Checking for AI Software Development courses' as "Query",
    COUNT(*) as "Count"
FROM courses 
WHERE category = 'AI Software Development';

-- 2. Check what categories actually exist in the database
SELECT 
    'Actual categories in database' as "Info",
    category as "Category",
    COUNT(*) as "Course Count"
FROM courses 
GROUP BY category
ORDER BY "Course Count" DESC;

-- 3. Check if there are published courses
SELECT 
    'Published vs Draft courses' as "Info",
    CASE 
        WHEN is_published THEN 'Published' 
        ELSE 'Draft' 
    END as "Status",
    COUNT(*) as "Count"
FROM courses 
GROUP BY is_published;

-- 4. Check course levels to ensure they match constraints
SELECT 
    'Course levels validation' as "Info",
    level as "Level",
    COUNT(*) as "Count"
FROM courses 
WHERE level IS NOT NULL
GROUP BY level
ORDER BY "Level";

-- 5. Show all courses with their publication status
SELECT 
    title as "Course Title",
    category as "Category",
    level as "Level",
    CASE 
        WHEN is_published THEN 'Published' 
        ELSE 'Draft' 
    END as "Publication Status"
FROM courses 
ORDER BY category, title;

-- 6. Check for duplicate course titles
SELECT 
    title as "Course Title",
    COUNT(*) as "Occurrences"
FROM courses 
GROUP BY title
HAVING COUNT(*) > 1
ORDER BY "Occurrences" DESC;

-- Summary of findings
SELECT 
    '🔍 FRONTEND INVESTIGATION SUMMARY' as "Finding",
    'Frontend likely expects AI Software Development category' as "Issue",
    'Database has Web Development and App Development categories' as "Root Cause"
UNION ALL
SELECT 
    '🔍 FRONTEND INVESTIGATION SUMMARY' as "Finding",
    'Need to consolidate categories or update frontend expectations' as "Solution",
    'Ensure courses are published (is_published = true)' as "Additional Check";