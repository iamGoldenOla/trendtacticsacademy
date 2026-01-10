-- Check current database state and prepare for update

-- 1. Show current course categories
SELECT 
    title as "Current Title",
    category as "Current Category",
    CASE 
        WHEN category IN ('Web Development', 'App Development') THEN 'Needs Update to AI Software Development'
        WHEN category = 'Digital Marketing' THEN 'Correct Category'
        WHEN category IS NULL THEN 'Missing Category'
        ELSE 'Other'
    END as "Action Required"
FROM courses 
ORDER BY category, title;

-- 2. Count courses by current category
SELECT 
    COALESCE(category, 'Uncategorized') as "Category",
    COUNT(*) as "Number of Courses"
FROM courses 
GROUP BY category
ORDER BY "Number of Courses" DESC;

-- 3. Identify courses that need to be updated to AI Software Development
SELECT 
    title as "Course Title",
    category as "Current Category",
    'Will be updated to AI Software Development' as "Planned Action"
FROM courses 
WHERE category IN ('Web Development', 'App Development') OR category IS NULL;

-- 4. Show digital marketing courses (these are correctly categorized)
SELECT 
    title as "Course Title",
    category as "Current Category",
    'Correctly categorized' as "Status"
FROM courses 
WHERE category = 'Digital Marketing';

-- 5. Prepare update statements for courses that need to be moved to AI Software Development
SELECT 
    'UPDATE courses SET category = ''AI Software Development'', level = ''' || 
    CASE 
        WHEN title LIKE '%Web%' THEN 'beginner'
        WHEN title LIKE '%App%' THEN 'intermediate'
        ELSE 'beginner'
    END || ''' WHERE title = ''' || title || ''';' as "Update Statement"
FROM courses 
WHERE category IN ('Web Development', 'App Development') OR category IS NULL;

-- Summary of what needs to be done
SELECT 
    '📋 UPDATE PLAN' as "Task",
    '1. Update Web Development and App Development courses to AI Software Development category' as "Action",
    '2. Set appropriate difficulty levels (beginner for web, intermediate for mobile)' as "Detail"
UNION ALL
SELECT 
    '📋 UPDATE PLAN' as "Task",
    '3. Keep Digital Marketing courses in their current category' as "Action",
    '4. Ensure all courses have proper categorization' as "Detail";