-- Check what the level constraint allows
SELECT pg_get_constraintdef(oid) as constraint_definition
FROM pg_constraint 
WHERE conname = 'courses_level_check';

-- Check the current structure of the courses table
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'courses' 
ORDER BY ordinal_position;