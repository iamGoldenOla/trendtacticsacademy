-- Check what tables actually exist in the database
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' ORDER BY table_name;

-- Check the structure of courses table
SELECT column_name, data_type, is_nullable FROM information_schema.columns 
WHERE table_name = 'courses' ORDER BY ordinal_position;

-- Check the structure of modules table
SELECT column_name, data_type, is_nullable FROM information_schema.columns 
WHERE table_name = 'modules' ORDER BY ordinal_position;

-- Check the structure of lessons table
SELECT column_name, data_type, is_nullable FROM information_schema.columns 
WHERE table_name = 'lessons' ORDER BY ordinal_position;