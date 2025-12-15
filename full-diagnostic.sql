-- Full diagnostic script to understand existing table structure
-- This will show all tables and their columns

-- Show all tables
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
ORDER BY table_name;

-- Show structure of all tables
SELECT 
    table_name,
    column_name, 
    data_type, 
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_schema = 'public' 
ORDER BY table_name, ordinal_position;

-- Check if there are any existing records in courses table
SELECT COUNT(*) as course_count FROM courses;

-- Check if there are any existing records in lessons table
SELECT COUNT(*) as lesson_count FROM lessons;

-- Check if there are any existing records in modules table
SELECT COUNT(*) as module_count FROM modules;

-- Check if there are any existing records in assessments table
SELECT COUNT(*) as assessment_count FROM assessments;