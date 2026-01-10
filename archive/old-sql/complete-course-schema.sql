-- Complete Course Schema for Trendtactics Academy
-- This script creates all necessary tables with proper relationships and constraints

-- Enable UUID extension if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create courses table with all required columns
CREATE TABLE IF NOT EXISTS courses (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  instructor_id UUID REFERENCES auth.users(id),
  category TEXT,
  level TEXT,
  duration TEXT,
  objectives JSONB,
  prerequisites JSONB,
  status TEXT DEFAULT 'draft',
  price DECIMAL(10,2) DEFAULT 0,
  thumbnail_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  published_at TIMESTAMPTZ
);

-- Add missing columns to courses table if they don't exist
DO $$ 
BEGIN
  -- Add status column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name='courses' AND column_name='status'
  ) THEN
    ALTER TABLE courses ADD COLUMN status TEXT DEFAULT 'draft';
  END IF;
  
  -- Add instructor_id column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name='courses' AND column_name='instructor_id'
  ) THEN
    ALTER TABLE courses ADD COLUMN instructor_id UUID REFERENCES auth.users(id);
  END IF;
  
  -- Add category column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name='courses' AND column_name='category'
  ) THEN
    ALTER TABLE courses ADD COLUMN category TEXT;
  END IF;
  
  -- Add level column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name='courses' AND column_name='level'
  ) THEN
    ALTER TABLE courses ADD COLUMN level TEXT;
  END IF;
  
  -- Add duration column (TEXT type, not integer)
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name='courses' AND column_name='duration'
  ) THEN
    ALTER TABLE courses ADD COLUMN duration TEXT;
  END IF;
  
  -- Add objectives column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name='courses' AND column_name='objectives'
  ) THEN
    ALTER TABLE courses ADD COLUMN objectives JSONB;
  END IF;
  
  -- Add prerequisites column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name='courses' AND column_name='prerequisites'
  ) THEN
    ALTER TABLE courses ADD COLUMN prerequisites JSONB;
  END IF;
  
  -- Add price column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name='courses' AND column_name='price'
  ) THEN
    ALTER TABLE courses ADD COLUMN price DECIMAL(10,2) DEFAULT 0;
  END IF;
  
  -- Add thumbnail_url column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name='courses' AND column_name='thumbnail_url'
  ) THEN
    ALTER TABLE courses ADD COLUMN thumbnail_url TEXT;
  END IF;
  
  -- Add published_at column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name='courses' AND column_name='published_at'
  ) THEN
    ALTER TABLE courses ADD COLUMN published_at TIMESTAMPTZ;
  END IF;
EXCEPTION WHEN duplicate_column THEN
  -- Column already exists, do nothing
END $$;

-- Create course_outlines table
CREATE TABLE IF NOT EXISTS course_outlines (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
  content TEXT,
  version INTEGER DEFAULT 1,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create modules table
CREATE TABLE IF NOT EXISTS modules (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  ordering INTEGER,
  duration TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add ordering column to modules if it doesn't exist (fixing the "order" keyword issue)
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name='modules' AND column_name='ordering'
  ) THEN
    ALTER TABLE modules ADD COLUMN ordering INTEGER;
  END IF;
EXCEPTION WHEN duplicate_column THEN
  -- Column already exists, do nothing
END $$;

-- Create lessons table
CREATE TABLE IF NOT EXISTS lessons (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  module_id UUID REFERENCES modules(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  content TEXT,
  ordering INTEGER,
  duration TEXT,
  video_url TEXT,
  resources JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add ordering column to lessons if it doesn't exist
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name='lessons' AND column_name='ordering'
  ) THEN
    ALTER TABLE lessons ADD COLUMN ordering INTEGER;
  END IF;
EXCEPTION WHEN duplicate_column THEN
  -- Column already exists, do nothing
END $$;

-- Create assessments table
CREATE TABLE IF NOT EXISTS assessments (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  module_id UUID REFERENCES modules(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  type TEXT, -- 'quiz', 'assignment', 'exam'
  questions JSONB,
  passing_score INTEGER DEFAULT 70,
  attempts_allowed INTEGER DEFAULT 3,
  time_limit INTEGER, -- in minutes
  ordering INTEGER,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add ordering column to assessments if it doesn't exist
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name='assessments' AND column_name='ordering'
  ) THEN
    ALTER TABLE assessments ADD COLUMN ordering INTEGER;
  END IF;
EXCEPTION WHEN duplicate_column THEN
  -- Column already exists, do nothing
END $$;

-- Create enrollments table
CREATE TABLE IF NOT EXISTS enrollments (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
  enrolled_at TIMESTAMPTZ DEFAULT NOW(),
  progress INTEGER DEFAULT 0,
  completed_at TIMESTAMPTZ,
  UNIQUE(user_id, course_id)
);

-- Create user_progress table
CREATE TABLE IF NOT EXISTS user_progress (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  lesson_id UUID REFERENCES lessons(id) ON DELETE CASCADE,
  completed BOOLEAN DEFAULT FALSE,
  score DECIMAL(5,2),
  completed_at TIMESTAMPTZ,
  UNIQUE(user_id, lesson_id)
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_courses_status ON courses(status);
CREATE INDEX IF NOT EXISTS idx_courses_category ON courses(category);
CREATE INDEX IF NOT EXISTS idx_courses_instructor ON courses(instructor_id);
CREATE INDEX IF NOT EXISTS idx_courses_created_at ON courses(created_at);
CREATE INDEX IF NOT EXISTS idx_modules_course ON modules(course_id);
CREATE INDEX IF NOT EXISTS idx_modules_ordering ON modules(ordering);
CREATE INDEX IF NOT EXISTS idx_lessons_module ON lessons(module_id);
CREATE INDEX IF NOT EXISTS idx_lessons_ordering ON lessons(ordering);
CREATE INDEX IF NOT EXISTS idx_assessments_module ON assessments(module_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_user ON enrollments(user_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_course ON enrollments(course_id);
CREATE INDEX IF NOT EXISTS idx_user_progress_user ON user_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_user_progress_lesson ON user_progress(lesson_id);

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = NOW();
   RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers to automatically update updated_at columns
DROP TRIGGER IF EXISTS update_courses_updated_at ON courses;
CREATE TRIGGER update_courses_updated_at 
BEFORE UPDATE ON courses 
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_modules_updated_at ON modules;
CREATE TRIGGER update_modules_updated_at 
BEFORE UPDATE ON modules 
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_lessons_updated_at ON lessons;
CREATE TRIGGER update_lessons_updated_at 
BEFORE UPDATE ON lessons 
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_assessments_updated_at ON assessments;
CREATE TRIGGER update_assessments_updated_at 
BEFORE UPDATE ON assessments 
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_course_outlines_updated_at ON course_outlines;
CREATE TRIGGER update_course_outlines_updated_at 
BEFORE UPDATE ON course_outlines 
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Insert sample data for testing (duration is TEXT, not integer)
INSERT INTO courses (title, description, category, level, duration, status)
VALUES 
  ('Introduction to Web Development', 'Learn the fundamentals of web development', 'Web Development', 'Beginner', '4 weeks', 'published'),
  ('Mobile App Development with React Native', 'Build cross-platform mobile apps', 'App Development', 'Intermediate', '6 weeks', 'published'),
  ('Digital Marketing Mastery', 'Master digital marketing strategies', 'Digital Marketing', 'Beginner', '5 weeks', 'draft')
ON CONFLICT DO NOTHING;

-- Sample RLS policies (adjust as needed for your security requirements)
ALTER TABLE courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE modules ENABLE ROW LEVEL SECURITY;
ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE assessments ENABLE ROW LEVEL SECURITY;
ALTER TABLE enrollments ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_progress ENABLE ROW LEVEL SECURITY;

-- Grant necessary permissions (adjust as needed)
GRANT ALL ON courses TO authenticated;
GRANT ALL ON modules TO authenticated;
GRANT ALL ON lessons TO authenticated;
GRANT ALL ON assessments TO authenticated;
GRANT ALL ON enrollments TO authenticated;
GRANT ALL ON user_progress TO authenticated;
GRANT ALL ON course_outlines TO authenticated;