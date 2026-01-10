-- Simple, safe schema creation script
-- This script will work regardless of existing table state

-- Drop existing tables if they exist (be careful with this in production!)
-- DROP TABLE IF EXISTS user_progress, enrollments, assessments, lessons, modules, courses CASCADE;

-- Create courses table
CREATE TABLE IF NOT EXISTS courses (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  instructor_id UUID,
  category TEXT,
  level TEXT,
  duration TEXT,  -- TEXT, not INTEGER
  objectives JSONB,
  prerequisites JSONB,
  status TEXT DEFAULT 'draft',
  price DECIMAL(10,2) DEFAULT 0,
  thumbnail_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  published_at TIMESTAMP WITH TIME ZONE
);

-- Create modules table
CREATE TABLE IF NOT EXISTS modules (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  ordering INTEGER,  -- INTEGER for ordering
  duration TEXT,     -- TEXT, not INTEGER
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create lessons table
CREATE TABLE IF NOT EXISTS lessons (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  module_id UUID REFERENCES modules(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  content TEXT,
  ordering INTEGER,  -- INTEGER for ordering
  duration TEXT,     -- TEXT, not INTEGER
  video_url TEXT,
  resources JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create assessments table
CREATE TABLE IF NOT EXISTS assessments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  module_id UUID REFERENCES modules(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  type TEXT, -- 'quiz', 'assignment', 'exam'
  questions JSONB,
  passing_score INTEGER DEFAULT 70,
  attempts_allowed INTEGER DEFAULT 3,
  time_limit INTEGER, -- in minutes (INTEGER)
  ordering INTEGER,   -- INTEGER for ordering
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_courses_status ON courses(status);
CREATE INDEX IF NOT EXISTS idx_courses_category ON courses(category);
CREATE INDEX IF NOT EXISTS idx_modules_course ON modules(course_id);
CREATE INDEX IF NOT EXISTS idx_modules_ordering ON modules(ordering);
CREATE INDEX IF NOT EXISTS idx_lessons_module ON lessons(module_id);
CREATE INDEX IF NOT EXISTS idx_lessons_ordering ON lessons(ordering);
CREATE INDEX IF NOT EXISTS idx_assessments_module ON assessments(module_id);
CREATE INDEX IF NOT EXISTS idx_assessments_ordering ON assessments(ordering);

-- Insert sample data (safe with ON CONFLICT DO NOTHING)
INSERT INTO courses (id, title, description, category, level, duration, status) VALUES
  ('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Introduction to Web Development', 'Learn the fundamentals of web development', 'Web Development', 'Beginner', '4 weeks', 'published')
ON CONFLICT (id) DO NOTHING;

INSERT INTO courses (id, title, description, category, level, duration, status) VALUES
  ('b2c3d4e5-f678-90ab-cdef-1234567890ab', 'Mobile App Development with React Native', 'Build cross-platform mobile apps', 'App Development', 'Intermediate', '6 weeks', 'published')
ON CONFLICT (id) DO NOTHING;

INSERT INTO courses (id, title, description, category, level, duration, status) VALUES
  ('c3d4e5f6-7890-abcd-ef12-34567890abcd', 'Digital Marketing Mastery', 'Master digital marketing strategies', 'Digital Marketing', 'Beginner', '5 weeks', 'draft')
ON CONFLICT (id) DO NOTHING;