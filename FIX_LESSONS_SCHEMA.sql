-- FIX_LESSONS_SCHEMA.sql
-- Adds missing columns required by the new frontend generator
-- Execute this to stop the "Could not find column" errors

-- 1. Add quiz_questions (JSONB for structural data)
ALTER TABLE lessons 
ADD COLUMN IF NOT EXISTS quiz_questions JSONB;

-- 2. Add resources (JSONB for list of links)
ALTER TABLE lessons 
ADD COLUMN IF NOT EXISTS resources JSONB;

-- 3. Add summary (Text for quick takeaways)
ALTER TABLE lessons 
ADD COLUMN IF NOT EXISTS summary TEXT;

-- 4. Add playground (JSONB for Simulator/Vibe Coding integration)
ALTER TABLE lessons 
ADD COLUMN IF NOT EXISTS playground JSONB;

-- 5. Helper index for faster lookups (optional but good practice)
CREATE INDEX IF NOT EXISTS idx_lessons_course_ordering ON lessons(course_id, ordering);

-- 6. Grant permissions (just in case)
GRANT ALL ON lessons TO authenticated;
GRANT ALL ON lessons TO service_role;
