-- FIX EXISTING DATABASE SETUP
-- Use this script when you get "already exists" errors to properly handle existing objects

-- 1. First, drop existing policies if they exist (to avoid conflicts)
DROP POLICY IF EXISTS "Users can view their own course access" ON student_course_access;
DROP POLICY IF EXISTS "Users can insert their own course access" ON student_course_access;
DROP POLICY IF EXISTS "Users can update their own course access" ON student_course_access;

-- 2. Drop existing function if it exists
DROP FUNCTION IF EXISTS get_student_courses(UUID);

-- 3. Drop existing trigger if it exists
DROP TRIGGER IF EXISTS update_student_course_access_updated_at ON student_course_access;

-- 4. Create the policies again (now that old ones are removed)
CREATE POLICY "Users can view their own course access" ON student_course_access
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own course access" ON student_course_access
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own course access" ON student_course_access
  FOR UPDATE USING (auth.uid() = user_id);

-- 5. Create the function again
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

-- 6. Grant permissions to the function
GRANT EXECUTE ON FUNCTION get_student_courses(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION get_student_courses(UUID) TO anon;

-- 7. Create trigger to automatically update updated_at
CREATE OR REPLACE TRIGGER update_student_course_access_updated_at 
    BEFORE UPDATE ON student_course_access 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- 8. Verify everything is set up correctly
SELECT 
    '✅ Database setup fixes applied successfully' as status;

-- 9. Verify the policies exist
SELECT 
    policyname,
    permissive,
    roles,
    cmd,
    qual
FROM pg_policies
WHERE tablename = 'student_course_access';

-- 10. Verify the function exists
SELECT 
    'get_student_courses function exists' as check,
    CASE 
        WHEN EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'get_student_courses') 
        THEN '✅ YES' 
        ELSE '❌ NO' 
    END as result;