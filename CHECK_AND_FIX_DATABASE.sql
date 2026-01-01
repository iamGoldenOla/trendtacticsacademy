-- CHECK AND FIX DATABASE SETUP
-- This script checks what exists and applies fixes only where needed

-- 1. Check if the student_course_access table exists
DO $$
DECLARE
    table_exists BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT FROM information_schema.tables 
        WHERE table_name = 'student_course_access'
    ) INTO table_exists;

    IF NOT table_exists THEN
        -- Create the table if it doesn't exist
        CREATE TABLE student_course_access (
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
        
        -- Create indexes for the new table
        CREATE INDEX idx_student_course_access_user_id ON student_course_access(user_id);
        CREATE INDEX idx_student_course_access_course_id ON student_course_access(course_id);
        
        -- Enable RLS for the new table
        ALTER TABLE student_course_access ENABLE ROW LEVEL SECURITY;
        
        RAISE NOTICE 'Created student_course_access table';
    ELSE
        RAISE NOTICE 'student_course_access table already exists';
    END IF;
END $$;

-- 2. Check and create/update policies
DO $$
DECLARE
    policy_exists BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT FROM pg_policies 
        WHERE tablename = 'student_course_access' 
        AND policyname = 'Users can view their own course access'
    ) INTO policy_exists;

    IF policy_exists THEN
        -- Drop and recreate the policy if it exists
        DROP POLICY IF EXISTS "Users can view their own course access" ON student_course_access;
    END IF;
    
    CREATE POLICY "Users can view their own course access" ON student_course_access
      FOR SELECT USING (auth.uid() = user_id);
    
    RAISE NOTICE 'Created/updated view policy';
END $$;

DO $$
DECLARE
    policy_exists BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT FROM pg_policies 
        WHERE tablename = 'student_course_access' 
        AND policyname = 'Users can insert their own course access'
    ) INTO policy_exists;

    IF policy_exists THEN
        -- Drop and recreate the policy if it exists
        DROP POLICY IF EXISTS "Users can insert their own course access" ON student_course_access;
    END IF;
    
    CREATE POLICY "Users can insert their own course access" ON student_course_access
      FOR INSERT WITH CHECK (auth.uid() = user_id);
    
    RAISE NOTICE 'Created/updated insert policy';
END $$;

DO $$
DECLARE
    policy_exists BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT FROM pg_policies 
        WHERE tablename = 'student_course_access' 
        AND policyname = 'Users can update their own course access'
    ) INTO policy_exists;

    IF policy_exists THEN
        -- Drop and recreate the policy if it exists
        DROP POLICY IF EXISTS "Users can update their own course access" ON student_course_access;
    END IF;
    
    CREATE POLICY "Users can update their own course access" ON student_course_access
      FOR UPDATE USING (auth.uid() = user_id);
    
    RAISE NOTICE 'Created/updated update policy';
END $$;

-- 3. Check and create/update the function
DO $$
DECLARE
    function_exists BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT FROM pg_proc 
        WHERE proname = 'get_student_courses'
    ) INTO function_exists;

    IF function_exists THEN
        -- Drop the function if it exists
        DROP FUNCTION IF EXISTS get_student_courses(UUID);
    END IF;
    
    -- Create the function
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
    
    RAISE NOTICE 'Created/updated get_student_courses function';
END $$;

-- 4. Grant permissions to the function
GRANT EXECUTE ON FUNCTION get_student_courses(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION get_student_courses(UUID) TO anon;

-- 5. Create trigger function if it doesn't exist
DO $$
DECLARE
    function_exists BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT FROM pg_proc 
        WHERE proname = 'update_updated_at_column'
    ) INTO function_exists;

    IF NOT function_exists THEN
        -- Create the trigger function
        CREATE OR REPLACE FUNCTION update_updated_at_column()
        RETURNS TRIGGER AS $$
        BEGIN
            NEW.updated_at = NOW();
            RETURN NEW;
        END;
        $$ language 'plpgsql';
        
        RAISE NOTICE 'Created update_updated_at_column function';
    ELSE
        RAISE NOTICE 'update_updated_at_column function already exists';
    END IF;
END $$;

-- 6. Create trigger if it doesn't exist, or update if it does
DO $$
DECLARE
    trigger_exists BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT FROM information_schema.triggers 
        WHERE trigger_name = 'update_student_course_access_updated_at'
        AND event_object_table = 'student_course_access'
    ) INTO trigger_exists;

    IF trigger_exists THEN
        -- Drop the trigger if it exists
        DROP TRIGGER IF EXISTS update_student_course_access_updated_at ON student_course_access;
    END IF;
    
    -- Create the trigger
    CREATE TRIGGER update_student_course_access_updated_at 
        BEFORE UPDATE ON student_course_access 
        FOR EACH ROW 
        EXECUTE FUNCTION update_updated_at_column();
    
    RAISE NOTICE 'Created/updated update_student_course_access_updated_at trigger';
END $$;

-- 7. Grant permissions to the table
GRANT ALL ON student_course_access TO authenticated;
GRANT ALL ON student_course_access TO anon;

-- 8. Final verification
SELECT 
    '✅ Database setup completed successfully' as status,
    COUNT(*) as total_records
FROM student_course_access;

-- 9. Show final state of policies
SELECT 
    'Policies' as section,
    policyname,
    cmd
FROM pg_policies
WHERE tablename = 'student_course_access';

-- 10. Show function exists
SELECT 
    'Function' as section,
    'get_student_courses' as name,
    CASE 
        WHEN EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'get_student_courses') 
        THEN '✅ EXISTS' 
        ELSE '❌ MISSING' 
    END as status;