-- RUN DATABASE FIXES FOR COURSE ACCESS SYSTEM
-- Run this script in the Supabase SQL Editor to create all necessary tables for course access

-- 1. First, make sure the UUID extension is enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Create the student_course_access table if it doesn't exist
CREATE TABLE IF NOT EXISTS student_course_access (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
  purchase_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  access_status TEXT DEFAULT 'active' CHECK (access_status IN ('active', 'expired', 'cancelled')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  -- Ensure a user can't have duplicate access to the same course
  UNIQUE(user_id, course_id)
);

-- 3. Enable RLS for security
ALTER TABLE student_course_access ENABLE ROW LEVEL SECURITY;

-- 4. Create policies for RLS
CREATE POLICY "Users can view their own course access" ON student_course_access
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own course access" ON student_course_access
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own course access" ON student_course_access
  FOR UPDATE USING (auth.uid() = user_id);

-- 5. Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_student_course_access_user_id ON student_course_access(user_id);
CREATE INDEX IF NOT EXISTS idx_student_course_access_course_id ON student_course_access(course_id);

-- 6. Create function to update updated_at timestamp if it doesn't exist
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 7. Create trigger to automatically update updated_at if it doesn't exist
DO $$ 
BEGIN
    -- Drop the trigger if it exists to avoid conflicts
    DROP TRIGGER IF EXISTS update_student_course_access_updated_at ON student_course_access;
    
    -- Create the trigger
    CREATE TRIGGER update_student_course_access_updated_at 
        BEFORE UPDATE ON student_course_access 
        FOR EACH ROW 
        EXECUTE FUNCTION update_updated_at_column();
EXCEPTION
    WHEN duplicate_object THEN
        -- Trigger already exists, do nothing
        NULL;
END $$;

-- 8. Grant permissions
GRANT ALL ON student_course_access TO authenticated;
GRANT ALL ON student_course_access TO anon;

-- 9. Create the function to get student courses if it doesn't exist
CREATE OR REPLACE FUNCTION get_student_courses(p_user_id UUID)
RETURNS TABLE(
    course_id UUID,
    course_title TEXT,
    course_description TEXT,
    course_level TEXT,
    course_category TEXT,
    course_image_url TEXT,
    enrollment_date TIMESTAMP WITH TIME ZONE,
    access_status TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.id as course_id,
        c.title as course_title,
        c.description as course_description,
        c.level as course_level,
        c.category as course_category,
        c.thumbnail_url as course_image_url,
        sca.purchase_date as enrollment_date,
        sca.access_status
    FROM courses c
    INNER JOIN student_course_access sca ON c.id = sca.course_id
    WHERE sca.user_id = p_user_id
      AND sca.access_status = 'active'
    ORDER BY c.created_at;
END;
$$;

-- 10. Grant permissions to the function
GRANT EXECUTE ON FUNCTION get_student_courses(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION get_student_courses(UUID) TO anon;

-- 11. Verify the table exists and show its structure
SELECT 
    '✅ student_course_access table created successfully' as status,
    COUNT(*) as row_count
FROM student_course_access;

-- 12. Show the table columns
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'student_course_access'
ORDER BY ordinal_position;

-- 13. Show RLS policies
SELECT 
    policyname,
    permissive,
    roles,
    cmd,
    qual
FROM pg_policies
WHERE tablename = 'student_course_access';