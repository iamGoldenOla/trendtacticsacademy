-- Add featured column to courses table
-- This script adds the featured column that was missing from the courses table

-- Add the featured column to the courses table
ALTER TABLE courses ADD COLUMN IF NOT EXISTS featured BOOLEAN DEFAULT FALSE;

-- Update the column to allow NULL values if needed (optional)
-- ALTER TABLE courses ALTER COLUMN featured DROP NOT NULL;

-- Verify the column was added
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'courses' 
AND column_name = 'featured';

-- Now you can run the insert-vibe-coding-course.sql script