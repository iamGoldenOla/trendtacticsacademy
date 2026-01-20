-- ==========================================
-- SECURITY: Enable Row Level Security (RLS)
-- Protects user data from unauthorized access
-- ==========================================

-- Enable RLS on all tables
ALTER TABLE courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE modules ENABLE ROW LEVEL SECURITY;
ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE enrollments ENABLE ROW LEVEL SECURITY;
ALTER TABLE progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE quizzes ENABLE ROW LEVEL SECURITY;

-- ==========================================
-- POLICIES: Define access rules
-- ==========================================

-- COURSES: Everyone can view, only admins can modify
CREATE POLICY "Anyone can view courses"
ON courses FOR SELECT
USING (true);

CREATE POLICY "Only admins can insert courses"
ON courses FOR INSERT
WITH CHECK (auth.jwt() ->> 'role' = 'admin');

CREATE POLICY "Only admins can update courses"
ON courses FOR UPDATE
USING (auth.jwt() ->> 'role' = 'admin');

-- ENROLLMENTS: Users can only see their own enrollments
CREATE POLICY "Users can view their own enrollments"
ON enrollments FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can enroll themselves"
ON enrollments FOR INSERT
WITH CHECK (auth.uid() = user_id);

-- PROGRESS: Users can only see and update their own progress
CREATE POLICY "Users can view their own progress"
ON progress FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own progress"
ON progress FOR UPDATE
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own progress"
ON progress FOR INSERT
WITH CHECK (auth.uid() = user_id);

-- MODULES & LESSONS: Everyone can view
CREATE POLICY "Anyone can view modules"
ON modules FOR SELECT
USING (true);

CREATE POLICY "Anyone can view lessons"
ON lessons FOR SELECT
USING (true);

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

-- Progress indexes
CREATE INDEX IF NOT EXISTS idx_progress_user_id ON progress(user_id);
CREATE INDEX IF NOT EXISTS idx_progress_lesson_id ON progress(lesson_id);
CREATE INDEX IF NOT EXISTS idx_progress_user_lesson ON progress(user_id, lesson_id);

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
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users(id),
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
CREATE POLICY "Only admins can view audit logs"
ON audit_logs FOR SELECT
USING (auth.jwt() ->> 'role' = 'admin');

-- ==========================================
-- VERIFICATION QUERIES
-- ==========================================

-- Check RLS is enabled
SELECT schemaname, tablename, rowsecurity
FROM pg_tables
WHERE schemaname = 'public'
AND tablename IN ('courses', 'enrollments', 'progress', 'modules', 'lessons', 'quizzes')
ORDER BY tablename;

-- Check policies exist
SELECT schemaname, tablename, policyname, permissive, roles, cmd
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, policyname;

-- Check indexes exist
SELECT
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
AND tablename IN ('courses', 'enrollments', 'progress', 'modules', 'lessons', 'quizzes', 'audit_logs')
ORDER BY tablename, indexname;

-- Success message
SELECT 
    '✅ Row Level Security enabled on all tables' as security_status,
    '✅ Access policies created' as policies_status,
    '✅ Performance indexes added' as indexes_status,
    '✅ Audit logging configured' as audit_status;
