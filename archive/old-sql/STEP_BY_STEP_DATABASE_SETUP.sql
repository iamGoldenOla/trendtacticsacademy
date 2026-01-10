-- STEP 1: Create the student_course_access table
-- Run this query first and wait for it to complete before proceeding
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

-- STEP 2: Create indexes for performance (run after STEP 1 completes)
CREATE INDEX IF NOT EXISTS idx_student_course_access_user_id ON student_course_access(user_id);
CREATE INDEX IF NOT EXISTS idx_student_course_access_course_id ON student_course_access(course_id);

-- STEP 3: Enable Row Level Security (run after STEP 1 completes)
ALTER TABLE student_course_access ENABLE ROW LEVEL SECURITY;

-- STEP 4: Create Row Level Security policies (run after STEP 3 completes)
CREATE POLICY "Users can view their own course access" ON student_course_access
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own course access" ON student_course_access
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own course access" ON student_course_access
  FOR UPDATE USING (auth.uid() = user_id);

-- STEP 5: Grant permissions (run after all above steps complete)
GRANT ALL ON student_course_access TO authenticated;
GRANT ALL ON student_course_access TO anon;

-- STEP 6: Create the function to get student courses (run after STEP 1 completes)
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

-- STEP 7: Grant permissions to the function (run after STEP 6 completes)
GRANT EXECUTE ON FUNCTION get_student_courses(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION get_student_courses(UUID) TO anon;

-- STEP 8: Create trigger function to update timestamps (run after STEP 1 completes)
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- STEP 9: Create trigger to automatically update updated_at (run after STEP 8 completes)
CREATE TRIGGER update_student_course_access_updated_at 
    BEFORE UPDATE ON student_course_access 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();