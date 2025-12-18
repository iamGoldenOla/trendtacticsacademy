-- Check the structure of the lessons table
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'lessons' 
ORDER BY ordinal_position;

-- Check if there are any RLS policies on the lessons table
SELECT * FROM pg_policy WHERE polrelid = 'lessons'::regclass;

-- Check if RLS is enabled on the lessons table
SELECT relname, relrowsecurity, relforcerowsecurity 
FROM pg_class 
WHERE relname = 'lessons';