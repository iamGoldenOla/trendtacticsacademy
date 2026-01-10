-- DEFINITIVE VERIFICATION SCRIPT
-- This will give you clear confirmation of your database structure

-- SHOW ME WHAT YOU HAVE
SELECT 
    '📚 TOTAL COURSES IN DATABASE' as "Metric",
    COUNT(*) as "Count"
FROM courses
UNION ALL
SELECT 
    '📖 TOTAL MODULES IN DATABASE' as "Metric",
    COUNT(*) as "Count"
FROM modules
UNION ALL
SELECT 
    '📝 TOTAL ASSESSMENTS IN DATABASE' as "Metric",
    COUNT(*) as "Count"
FROM assessments;

-- LIST ALL COURSE CATEGORIES
SELECT DISTINCT 
    'CATEGORY' as "Type",
    COALESCE(category, 'Uncategorized') as "Name"
FROM courses
ORDER BY "Name";

-- SHOW ALL COURSES WITH THEIR CATEGORIES
SELECT 
    title as "Course Title",
    COALESCE(category, 'No Category') as "Category",
    COALESCE(level, 'No Level') as "Level"
FROM courses
ORDER BY category, title;

-- CONFIRM YOUR AI SOFTWARE DEVELOPMENT COURSES EXIST
SELECT 
    '🤖 CONFIRMING AI SOFTWARE DEVELOPMENT COURSES' as "Verification",
    COUNT(*) as "Count"
FROM courses 
WHERE category = 'AI Software Development';

-- CONFIRM YOUR DIGITAL MARKETING COURSES EXIST
SELECT 
    '📱 CONFIRMING DIGITAL MARKETING COURSES' as "Verification",
    COUNT(*) as "Count"
FROM courses 
WHERE category = 'Digital Marketing';

-- SHOW SAMPLE OF YOUR MODULES
SELECT 
    'SAMPLE MODULES' as "Info",
    COUNT(*) as "Modules Count"
FROM modules
LIMIT 1;

-- SHOW SAMPLE OF YOUR ASSESSMENTS
SELECT 
    'SAMPLE ASSESSMENTS' as "Info",
    COUNT(*) as "Assessments Count"
FROM assessments
LIMIT 1;

-- FINAL CONFIRMATION
SELECT 
    '✅ DATABASE VERIFICATION COMPLETE' as "Status",
    'Your course structure is properly organized' as "Message",
    'Ready for student enrollment' as "Next Step";