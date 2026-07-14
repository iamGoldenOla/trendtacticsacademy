-- ============================================================================
-- 🚀 COMPLETE DATABASE SCHEMA REBUILD & CONSTRAINT RECOVERY
-- ============================================================================
-- Run this entire script in your Supabase SQL Editor.
-- It will safely recreate the missing courses, modules, and lessons tables,
-- restore all cascaded foreign key constraints, and seed courses/modules.
-- ============================================================================

-- 1. DROP CASCADE (Clean start for core tables)
DROP TABLE IF EXISTS public.lessons CASCADE;
DROP TABLE IF EXISTS public.modules CASCADE;
DROP TABLE IF EXISTS public.courses CASCADE;

-- 2. CREATE COURSES TABLE
CREATE TABLE public.courses (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  title TEXT NOT NULL,
  description TEXT,
  thumbnail TEXT,
  price NUMERIC DEFAULT 0.00,
  duration TEXT,
  level TEXT CHECK (level IN ('beginner', 'intermediate', 'advanced')) DEFAULT 'beginner',
  category TEXT,
  rating NUMERIC DEFAULT 0,
  topics TEXT[],
  slug TEXT UNIQUE,
  status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'published', 'archived'))
);

-- 3. CREATE MODULES TABLE
CREATE TABLE public.modules (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  course_id UUID REFERENCES public.courses(id) ON DELETE CASCADE NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  order_index INTEGER NOT NULL
);

-- 4. CREATE LESSONS TABLE
CREATE TABLE public.lessons (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  module_id UUID REFERENCES public.modules(id) ON DELETE CASCADE NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  content TEXT,
  video_url TEXT,
  order_index INTEGER NOT NULL,
  is_preview BOOLEAN DEFAULT FALSE,
  resources JSONB DEFAULT '[]'::jsonb
);

-- 5. RE-ESTABLISH DROPPED FOREIGN KEY CONSTRAINTS
-- enrollments table
ALTER TABLE public.enrollments DROP CONSTRAINT IF EXISTS enrollments_course_id_fkey;
ALTER TABLE public.enrollments ADD CONSTRAINT enrollments_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;

ALTER TABLE public.enrollments DROP CONSTRAINT IF EXISTS enrollments_user_id_fkey;
ALTER TABLE public.enrollments ADD CONSTRAINT enrollments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

-- lesson_progress table
ALTER TABLE public.lesson_progress DROP CONSTRAINT IF EXISTS lesson_progress_lesson_id_fkey;
ALTER TABLE public.lesson_progress ADD CONSTRAINT lesson_progress_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;

ALTER TABLE public.lesson_progress DROP CONSTRAINT IF EXISTS lesson_progress_user_id_fkey;
ALTER TABLE public.lesson_progress ADD CONSTRAINT lesson_progress_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

-- user_course_progress table
ALTER TABLE public.user_course_progress DROP CONSTRAINT IF EXISTS user_course_progress_course_id_fkey;
ALTER TABLE public.user_course_progress ADD CONSTRAINT user_course_progress_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;

ALTER TABLE public.user_course_progress DROP CONSTRAINT IF EXISTS user_course_progress_user_id_fkey;
ALTER TABLE public.user_course_progress ADD CONSTRAINT user_course_progress_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

-- quiz_questions table
ALTER TABLE public.quiz_questions DROP CONSTRAINT IF EXISTS quiz_questions_lesson_id_fkey;
ALTER TABLE public.quiz_questions ADD CONSTRAINT quiz_questions_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;

-- quiz_attempts table
ALTER TABLE public.quiz_attempts DROP CONSTRAINT IF EXISTS quiz_attempts_lesson_id_fkey;
ALTER TABLE public.quiz_attempts ADD CONSTRAINT quiz_attempts_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;

ALTER TABLE public.quiz_attempts DROP CONSTRAINT IF EXISTS quiz_attempts_user_id_fkey;
ALTER TABLE public.quiz_attempts ADD CONSTRAINT quiz_attempts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

-- certificates table
ALTER TABLE public.certificates DROP CONSTRAINT IF EXISTS certificates_course_id_fkey;
ALTER TABLE public.certificates ADD CONSTRAINT certificates_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;

ALTER TABLE public.certificates DROP CONSTRAINT IF EXISTS certificates_enrollment_id_fkey;
ALTER TABLE public.certificates ADD CONSTRAINT certificates_enrollment_id_fkey FOREIGN KEY (enrollment_id) REFERENCES public.enrollments(id) ON DELETE CASCADE;

ALTER TABLE public.certificates DROP CONSTRAINT IF EXISTS certificates_user_id_fkey;
ALTER TABLE public.certificates ADD CONSTRAINT certificates_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

-- 6. ENABLE ROW LEVEL SECURITY
ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.modules ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lessons ENABLE ROW LEVEL SECURITY;

-- 7. RECREATE READ POLICIES
DROP POLICY IF EXISTS "Everyone can view courses" ON public.courses;
CREATE POLICY "Everyone can view courses" ON public.courses FOR SELECT USING (true);

DROP POLICY IF EXISTS "Everyone can view modules" ON public.modules;
CREATE POLICY "Everyone can view modules" ON public.modules FOR SELECT USING (true);

DROP POLICY IF EXISTS "Everyone can view lessons" ON public.lessons;
CREATE POLICY "Everyone can view lessons" ON public.lessons FOR SELECT USING (true);

-- 8. SEED COURSES
INSERT INTO public.courses (
  id,
  title,
  description,
  category,
  level,
  price,
  slug,
  status
) VALUES 
(
  'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
  'Vibe Coding: Building Real Software with AI',
  'Learn to build real software using AI tools like Cursor, Bolt.new, and Replit Agent. Master the art of describing what you want and letting AI handle the implementation.',
  'Programming',
  'beginner',
  10.00,
  'vibe-coding',
  'published'
),
(
  'b2c3d4e5-f6a7-8901-bcde-f01234567891',
  'Facebook Ads: Building Profitable, Predictable Ad Systems in 2025',
  'Master Facebook advertising with a systems-based approach. Learn campaign structure, targeting, creative strategy, optimization, and scaling.',
  'Marketing',
  'intermediate',
  8.00,
  'facebook-ads',
  'published'
),
(
  'c3d4e5f6-a7b8-9012-cdef-012345678912',
  'Prompt Engineering: Designing Instructions That Control AI Systems (2025 Edition)',
  'Learn to design effective prompts that control AI systems. Master prompt structure, context layering, constraints, and advanced techniques.',
  'AI & Technology',
  'beginner',
  10.00,
  'prompt-engineering',
  'published'
);

-- 9. SEED MODULES
INSERT INTO public.modules (id, course_id, title, description, order_index) VALUES
('10000000-0000-0000-0000-000000000001', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 1: Vibe Coding Foundations', 'Learn the fundamentals of Vibe Coding and why it represents the future of software development', 1),
('10000000-0000-0000-0000-000000000002', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 2: The Vibe Coding Ecosystem', 'Explore the tools and workflows that make Vibe Coding possible', 2),
('10000000-0000-0000-0000-000000000003', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 3: Full-Stack AI Builders', 'Master full-stack AI tools like Bolt.new, Lovable, Replit Agent, and V0', 3),
('10000000-0000-0000-0000-000000000004', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 4: AI-First IDEs', 'Learn to use AI-powered IDEs like Cursor, Windsurf, and Qoder', 4),
('10000000-0000-0000-0000-000000000005', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 5: Agentic Coding Tools', 'Explore autonomous coding agents like Devin, OpenHands, and Claude Computer Use', 5),
('10000000-0000-0000-0000-000000000006', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 6: Real-World Workflows', 'Apply Vibe Coding to real production environments and SaaS products', 6),
('10000000-0000-0000-0000-000000000007', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 7: Prompting for Software', 'Master prompt engineering specifically for code generation', 7),
('10000000-0000-0000-0000-000000000008', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 8: Collaboration with AI', 'Learn how to pair-program effectively with AI assistants', 8),
('10000000-0000-0000-0000-000000000009', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 9: Debugging AI Code', 'Master the skills needed to find and fix errors in AI-generated codebases', 9),
('10000000-0000-0000-0000-000000000010', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 10: Scaling AI Projects', 'Learn how to maintain and scale projects built using Vibe Coding', 10),
('10000000-0000-0000-0000-000000000011', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 11: Non-Technical Builders', 'Empower non-technical creators to build production-grade software', 11),
('10000000-0000-0000-0000-000000000012', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 12: The Future of Programming', 'Understand where software development is heading and how to stay ahead', 12),
('10000000-0000-0000-0000-000000000013', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 13: Capstone Project', 'Build and deploy a complete web application from scratch using Vibe Coding', 13),

-- Facebook Ads Modules (3)
('20000000-0000-0000-0000-000000000001', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 1: Campaigns and Structure', 'Master campaign objectives, ad set settings, and budget distribution models', 1),
('20000000-0000-0000-0000-000000000002', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 2: Targeting and Audiences', 'Learn custom audiences, lookalikes, and broad targeting strategies', 2),
('20000000-0000-0000-0000-000000000003', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 3: Creative and Ad Design', 'Master hook writing, video angles, and high-converting static creatives', 3),

-- Prompt Engineering Modules (3)
('30000000-0000-0000-0000-000000000001', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 1: Prompt Foundations', 'Learn zero-shot, few-shot, and chain-of-thought prompting fundamentals', 1),
('30000000-0000-0000-0000-000000000002', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 2: Advanced Instruction Design', 'Master system prompts, constraints, XML tags, and output formatting schemas', 2),
('30000000-0000-0000-0000-000000000003', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 3: AI Tool Orchestration', 'Learn how to prompt models for function calling, API usage, and agents', 3);

-- 10. REFRESH SCHEMA CACHE
NOTIFY pgrst, 'reload config';
