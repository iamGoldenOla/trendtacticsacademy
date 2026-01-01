-- Create table to track course access for students
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

-- Enable RLS for security
ALTER TABLE student_course_access ENABLE ROW LEVEL SECURITY;

-- Create policies for RLS
CREATE POLICY "Users can view their own course access" ON student_course_access
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own course access" ON student_course_access
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own course access" ON student_course_access
  FOR UPDATE USING (auth.uid() = user_id);

-- Create indexes for performance
CREATE INDEX idx_student_course_access_user_id ON student_course_access(user_id);
CREATE INDEX idx_student_course_access_course_id ON student_course_access(course_id);

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_student_course_access_updated_at 
    BEFORE UPDATE ON student_course_access 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();