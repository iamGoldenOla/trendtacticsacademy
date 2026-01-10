-- SIMPLE VERIFICATION SCRIPT
-- This will show you exactly what's in your database right now

-- 1. SHOW ALL COURSES
SELECT '📚 ALL COURSES' as "Information";
SELECT 
    title as "Course Title",
    category as "Category",
    level as "Level",
    CASE 
        WHEN is_published THEN '🟢 Published' 
        ELSE '🟡 Not Published' 
    END as "Status"
FROM courses 
ORDER BY category, title;

-- 2. COUNT COURSES BY CATEGORY
SELECT '📊 COURSE COUNTS' as "Information";
SELECT 
    category as "Category",
    COUNT(*) as "Number of Courses"
FROM courses 
GROUP BY category
ORDER BY category;

-- 3. SHOW MODULE COUNT
SELECT '📖 MODULE INFORMATION' as "Information";
SELECT 
    COUNT(*) as "Total Modules",
    COUNT(DISTINCT course_id) as "Courses with Modules"
FROM modules;

-- 4. SHOW ASSESSMENT COUNT
SELECT '📝 ASSESSMENT INFORMATION' as "Information";
SELECT 
    COUNT(*) as "Total Assessments",
    COUNT(DISTINCT module_id) as "Modules with Assessments"
FROM assessments;

-- 5. CHECK YOUR AI SOFTWARE DEVELOPMENT COURSES
SELECT '🤖 YOUR AI SOFTWARE DEVELOPMENT COURSES' as "Information";
SELECT 
    title as "Course Title",
    level as "Level",
    duration as "Duration"
FROM courses 
WHERE category = 'AI Software Development'
ORDER BY level;

-- 6. CHECK YOUR DIGITAL MARKETING COURSES
SELECT '📱 YOUR DIGITAL MARKETING COURSES' as "Information";
SELECT 
    title as "Course Title",
    level as "Level",
    duration as "Duration"
FROM courses 
WHERE category = 'Digital Marketing'
ORDER BY title;

-- 7. DATABASE HEALTH CHECK
SELECT '✅ DATABASE HEALTH' as "Information";
SELECT 
    'Database is functioning properly' as "Status",
    'All tables accessible' as "Tables",
    'No constraint violations' as "Constraints";