-- Check what courses actually exist in the database
SELECT id, title, description, is_published, created_at
FROM courses
ORDER BY created_at DESC;

-- Check the data types of the courses table
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'courses' 
ORDER BY ordinal_position;