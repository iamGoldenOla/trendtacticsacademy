-- Verification script to confirm all fixes are working

-- Check that all required tables exist
SELECT table_name FROM information_schema.tables 
WHERE table_name IN ('courses', 'modules', 'lessons', 'assessments')
ORDER BY table_name;

-- Check structure of courses table
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'courses' 
ORDER BY ordinal_position;

-- Check structure of modules table
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'modules' 
ORDER BY ordinal_position;

-- Check structure of lessons table
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'lessons' 
ORDER BY ordinal_position;

-- Check structure of assessments table
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'assessments' 
ORDER BY ordinal_position;

-- Check sample data
SELECT 'courses' as table_name, COUNT(*) as row_count FROM courses
UNION ALL
SELECT 'modules' as table_name, COUNT(*) as row_count FROM modules
UNION ALL
SELECT 'lessons' as table_name, COUNT(*) as row_count FROM lessons
UNION ALL
SELECT 'assessments' as table_name, COUNT(*) as row_count FROM assessments;

-- Check that constraints are respected
SELECT DISTINCT lesson_type FROM lessons WHERE lesson_type IS NOT NULL;

-- Check that courses have proper level values
SELECT DISTINCT level FROM courses WHERE level IS NOT NULL;

-- Check that courses have is_published flag
SELECT title, is_published FROM courses LIMIT 5;