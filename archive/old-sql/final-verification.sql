-- Final comprehensive verification of the complete schema

-- Check all tables exist and have data
SELECT 'courses' as table_name, COUNT(*) as row_count FROM courses
UNION ALL
SELECT 'modules' as table_name, COUNT(*) as row_count FROM modules
UNION ALL
SELECT 'lessons' as table_name, COUNT(*) as row_count FROM lessons
UNION ALL
SELECT 'assessments' as table_name, COUNT(*) as row_count FROM assessments
ORDER BY table_name;

-- Verify courses structure and data
SELECT 
    title,
    category,
    level,
    duration,
    is_published,
    COALESCE(instructor_id::text, 'Not assigned') as instructor_status
FROM courses 
LIMIT 10;

-- Verify modules are linked to courses
SELECT 
    c.title as course_title,
    m.title as module_title,
    m.ordering,
    m.duration
FROM modules m
JOIN courses c ON m.course_id = c.id
ORDER BY c.title, m.ordering
LIMIT 15;

-- Verify assessments are linked to modules
SELECT 
    c.title as course_title,
    m.title as module_title,
    a.title as assessment_title,
    a.type,
    a.passing_score,
    a.attempts_allowed
FROM assessments a
JOIN modules m ON a.module_id = m.id
JOIN courses c ON m.course_id = c.id
ORDER BY c.title, m.ordering, a.ordering
LIMIT 15;

-- Check constraint compliance
SELECT 'lesson_type constraint' as check_type, 
       STRING_AGG(DISTINCT lesson_type, ', ') as values_found
FROM lessons 
WHERE lesson_type IS NOT NULL
UNION ALL
SELECT 'course level constraint' as check_type,
       STRING_AGG(DISTINCT level, ', ') as values_found
FROM courses
WHERE level IS NOT NULL;

-- Verify all required columns exist
SELECT 
    table_name,
    COUNT(*) as column_count
FROM information_schema.columns 
WHERE table_name IN ('courses', 'modules', 'lessons', 'assessments')
AND table_schema = 'public'
GROUP BY table_name
ORDER BY table_name;

-- Check for proper indexing
SELECT 
    tablename,
    indexname,
    indexdef
FROM pg_indexes 
WHERE tablename IN ('courses', 'modules', 'lessons', 'assessments')
AND schemaname = 'public'
ORDER BY tablename, indexname;

-- Final status check
SELECT 
    'Database Schema Status' as check_item,
    CASE 
        WHEN (SELECT COUNT(*) FROM courses) > 0 THEN '✓ Courses table populated'
        ELSE '✗ Courses table empty'
    END as status
UNION ALL
SELECT 
    'Database Schema Status' as check_item,
    CASE 
        WHEN (SELECT COUNT(*) FROM modules) > 0 THEN '✓ Modules table populated'
        ELSE '⚠ Modules table empty (will be populated as courses are developed)'
    END as status
UNION ALL
SELECT 
    'Database Schema Status' as check_item,
    CASE 
        WHEN (SELECT COUNT(*) FROM lessons) > 0 THEN '✓ Lessons table populated'
        ELSE '⚠ Lessons table empty (will be populated as courses are developed)'
    END as status
UNION ALL
SELECT 
    'Database Schema Status' as check_item,
    CASE 
        WHEN (SELECT COUNT(*) FROM assessments) > 0 THEN '✓ Assessments table populated'
        ELSE '⚠ Assessments table empty (will be populated as courses are developed)'
    END as status;