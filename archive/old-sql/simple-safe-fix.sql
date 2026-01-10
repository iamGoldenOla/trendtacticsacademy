-- Simple safe fix that won't violate constraints

-- Add missing columns to courses table (without specifying values that might violate constraints)
ALTER TABLE courses ADD COLUMN IF NOT EXISTS instructor_id UUID;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS category TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS objectives JSONB;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS prerequisites JSONB;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS price DECIMAL(10,2) DEFAULT 0;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS thumbnail_url TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS published_at TIMESTAMP WITH TIME ZONE;

-- Keep duration as TEXT to match existing schema
-- No changes to duration column to avoid constraint violations

-- Fix modules table
ALTER TABLE modules ADD COLUMN IF NOT EXISTS ordering INTEGER;
ALTER TABLE modules ADD COLUMN IF NOT EXISTS duration TEXT;  -- Match existing pattern

-- Fix lessons table
ALTER TABLE lessons ADD COLUMN IF NOT EXISTS resources JSONB;
ALTER TABLE lessons ADD COLUMN IF NOT EXISTS ordering INTEGER;  -- Additional ordering column

-- Create assessments table (required but missing)
CREATE TABLE IF NOT EXISTS assessments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  module_id UUID REFERENCES modules(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  type TEXT,
  questions JSONB,
  passing_score INTEGER DEFAULT 70,
  attempts_allowed INTEGER DEFAULT 3,
  time_limit INTEGER,
  ordering INTEGER,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_courses_category ON courses(category) WHERE category IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_courses_is_published ON courses(is_published) WHERE is_published IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_modules_course ON modules(course_id) WHERE course_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_modules_ordering ON modules(ordering) WHERE ordering IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_lessons_module ON lessons(module_id) WHERE module_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_lessons_ordering ON lessons(ordering) WHERE ordering IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_lessons_order_index ON lessons(order_index) WHERE order_index IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_assessments_module ON assessments(module_id) WHERE module_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_assessments_ordering ON assessments(ordering) WHERE ordering IS NOT NULL;

-- Insert minimal sample data without specifying constrained fields
INSERT INTO courses (title, description, is_published) VALUES
  ('Introduction to Web Development', 'Learn the fundamentals of web development', true)
ON CONFLICT DO NOTHING;

INSERT INTO courses (title, description, is_published) VALUES
  ('Mobile App Development with React Native', 'Build cross-platform mobile apps', true)
ON CONFLICT DO NOTHING;