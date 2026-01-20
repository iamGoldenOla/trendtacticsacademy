-- Run this first to see what level values are allowed and the table structure

-- 1. Check the constraint definition
SELECT 
    conname as constraint_name,
    pg_get_constraintdef(oid) as constraint_definition
FROM pg_constraint 
WHERE conname = 'courses_level_check';

-- 2. See existing courses and their levels
SELECT id, title, level, category FROM courses LIMIT 5;

-- 3. Check table structure
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'courses'
ORDER BY ordinal_position;
