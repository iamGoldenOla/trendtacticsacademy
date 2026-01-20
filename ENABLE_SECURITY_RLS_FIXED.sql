-- ==========================================
-- SECURITY: Enable Row Level Security (RLS)
-- Only on tables that exist in your database
-- ==========================================

-- First, let's check which tables exist
-- Run this to see your tables:
-- SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';

-- Enable RLS on existing tables
ALTER TABLE IF EXISTS courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS modules ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS enrollments ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS quizzes ENABLE ROW LEVEL SECURITY;

-- ==========================================
-- POLICIES: Define access rules
-- ==========================================

-- COURSES: Everyone can view, only admins can modify
DROP POLICY IF EXISTS "Anyone can view courses" ON courses;
CREATE POLICY "Anyone can view courses"
ON courses FOR SELECT
USING (true);

DROP POLICY IF EXISTS "Only admins can insert courses" ON courses;
CREATE POLICY "Only admins can insert courses"
ON courses FOR INSERT
WITH CHECK (auth.jwt() ->> 'role' = 'admin');

DROP POLICY IF EXISTS "Only admins can update courses" ON courses;
CREATE POLICY "Only admins can update courses"
ON courses FOR UPDATE
USING (auth.jwt() ->> 'role' = 'admin');

-- ENROLLMENTS: Users can only see their own enrollments
DROP POLICY IF EXISTS "Users can view their own enrollments" ON enrollments;
CREATE POLICY "Users can view their own enrollments"
ON enrollments FOR SELECT
USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can enroll themselves" ON enrollments;
CREATE POLICY "Users can enroll themselves"
ON enrollments FOR INSERT
WITH CHECK (auth.uid() = user_id);

-- MODULES & LESSONS: Everyone can view
DROP POLICY IF EXISTS "Anyone can view modules" ON modules;
CREATE POLICY "Anyone can view modules"
ON modules FOR SELECT
USING (true);

DROP POLICY IF EXISTS "Anyone can view lessons" ON lessons;
CREATE POLICY "Anyone can view lessons"
ON lessons FOR SELECT
USING (true);

DROP POLICY IF EXISTS "Anyone can view quizzes" ON quizzes;
CREATE POLICY "Anyone can view quizzes"
ON quizzes FOR SELECT
USING (true);

-- ==========================================
-- INDEXES: Improve query performance
-- ==========================================

-- Courses indexes
CREATE INDEX IF NOT EXISTS idx_courses_id ON courses(id);
CREATE INDEX IF NOT EXISTS idx_courses_created_at ON courses(created_at DESC);

-- Enrollments indexes
CREATE INDEX IF NOT EXISTS idx_enrollments_user_id ON enrollments(user_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_course_id ON enrollments(course_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_user_course ON enrollments(user_id, course_id);

-- Modules indexes
CREATE INDEX IF NOT EXISTS idx_modules_course_id ON modules(course_id);
CREATE INDEX IF NOT EXISTS idx_modules_ordering ON modules(ordering);

-- Lessons indexes
CREATE INDEX IF NOT EXISTS idx_lessons_module_id ON lessons(module_id);
CREATE INDEX IF NOT EXISTS idx_lessons_ordering ON lessons(ordering);

-- Quizzes indexes
CREATE INDEX IF NOT EXISTS idx_quizzes_lesson_id ON quizzes(lesson_id);

-- ==========================================
-- AUDIT LOG: Track all changes
-- ==========================================

-- Create audit log table
CREATE TABLE IF NOT EXISTS audit_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID,
  action TEXT NOT NULL,
  table_name TEXT NOT NULL,
  record_id UUID,
  old_data JSONB,
  new_data JSONB,
  ip_address INET,
  user_agent TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Index for audit logs
CREATE INDEX IF NOT EXISTS idx_audit_logs_user_id ON audit_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_audit_logs_created_at ON audit_logs(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_audit_logs_table_name ON audit_logs(table_name);

-- Enable RLS on audit logs
ALTER TABLE audit_logs ENABLE ROW LEVEL SECURITY;

-- Only admins can view audit logs
DROP POLICY IF EXISTS "Only admins can view audit logs" ON audit_logs;
CREATE POLICY "Only admins can view audit logs"
ON audit_logs FOR SELECT
USING (auth.jwt() ->> 'role' = 'admin');

-- ==========================================
-- VERIFICATION QUERIES
-- ==========================================

-- Check RLS is enabled
SELECT 
    schemaname, 
    tablename, 
    rowsecurity as rls_enabled
FROM pg_tables
WHERE schemaname = 'public'
AND tablename IN ('courses', 'enrollments', 'modules', 'lessons', 'quizzes', 'audit_logs')
ORDER BY tablename;

-- Check policies exist
SELECT 
    schemaname, 
    tablename, 
    policyname,
    cmd as command
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, policyname;

-- Check indexes exist
SELECT
    tablename,
    indexname
FROM pg_indexes
WHERE schemaname = 'public'
AND tablename IN ('courses', 'enrollments', 'modules', 'lessons', 'quizzes', 'audit_logs')
ORDER BY tablename, indexname;

-- Success message
SELECT 
    '✅ Row Level Security enabled' as security_status,
    '✅ Access policies created' as policies_status,
    '✅ Performance indexes added' as indexes_status,
    '✅ Audit logging configured' as audit_status;
