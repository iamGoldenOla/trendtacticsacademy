-- FINAL DATABASE SETUP
-- This script properly handles existing policies by dropping them first

-- 1. Drop existing policies if they exist (this is required since CREATE POLICY doesn't support IF NOT EXISTS)
DROP POLICY IF EXISTS "Users can view their own course access" ON student_course_access;
DROP POLICY IF EXISTS "Users can insert their own course access" ON student_course_access;
DROP POLICY IF EXISTS "Users can update their own course access" ON student_course_access;

-- 2. Create the student_course_access table (if it doesn't exist)
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

-- 3. Create indexes for performance (if they don't exist)
CREATE INDEX IF NOT EXISTS idx_student_course_access_user_id ON student_course_access(user_id);
CREATE INDEX IF NOT EXISTS idx_student_course_access_course_id ON student_course_access(course_id);

-- 4. Enable Row Level Security (if not already enabled)
ALTER TABLE student_course_access ENABLE ROW LEVEL SECURITY;

-- 5. Now create the policies (they were dropped above, so no conflicts)
CREATE POLICY "Users can view their own course access" ON student_course_access
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own course access" ON student_course_access
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own course access" ON student_course_access
  FOR UPDATE USING (auth.uid() = user_id);

-- 6. Create the function to get student courses (will replace if exists)
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

-- 7. Create trigger function to update timestamps (will replace if exists)
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 8. Create trigger to automatically update updated_at (will replace if exists)
CREATE OR REPLACE TRIGGER update_student_course_access_updated_at 
    BEFORE UPDATE ON student_course_access 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- 9. Grant permissions (these are safe to run multiple times)
GRANT ALL ON student_course_access TO authenticated;
GRANT ALL ON student_course_access TO anon;
GRANT EXECUTE ON FUNCTION get_student_courses(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION get_student_courses(UUID) TO anon;

-- 10. Final verification
SELECT 
    '✅ Database setup completed successfully' as status,
    COUNT(*) as total_records
FROM student_course_access;

-- 11. Show the policies that were created
SELECT 
    policyname,
    permissive,
    roles,
    cmd
FROM pg_policies
WHERE tablename = 'student_course_access';

-- 12. Confirm the function exists
SELECT 
    'get_student_courses function exists' as check,
    CASE 
        WHEN EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'get_student_courses') 
        THEN '✅ YES' 
        ELSE '❌ NO' 
    END as result;