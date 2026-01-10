-- ============================================================================
-- SEED SCRIPT: Courses (Simplified)
-- ============================================================================
-- This script seeds only the essential columns that exist in all schemas
-- ============================================================================

-- Clear existing courses (optional - comment out if you want to keep existing)
DELETE FROM lessons;
DELETE FROM modules;
DELETE FROM courses;

-- Insert Vibe Coding Course
INSERT INTO courses (
  id,
  title,
  description,
  category,
  level,
  status
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
  'Vibe Coding: Building Real Software with AI',
  'Learn to build real software using AI tools like Cursor, Bolt.new, and Replit Agent. Master the art of describing what you want and letting AI handle the implementation. Perfect for entrepreneurs, designers, and anyone who wants to build without traditional coding.',
  'Programming',
  'beginner',
  'published'
) ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  updated_at = NOW();

-- Insert Facebook Ads Course
INSERT INTO courses (
  id,
  title,
  description,
  category,
  level,
  status
) VALUES (
  'b2c3d4e5-f6a7-8901-bcde-f01234567891',
  'Facebook Ads: Building Profitable, Predictable Ad Systems in 2025',
  'Master Facebook advertising with a systems-based approach. Learn campaign structure, targeting, creative strategy, optimization, and scaling. Build profitable ad campaigns that work consistently and predictably.',
  'Marketing',
  'intermediate',
  'published'
) ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  updated_at = NOW();

-- Insert Prompt Engineering Course
INSERT INTO courses (
  id,
  title,
  description,
  category,
  level,
  status
) VALUES (
  'c3d4e5f6-a7b8-9012-cdef-012345678912',
  'Prompt Engineering: Designing Instructions That Control AI Systems (2025 Edition)',
  'Learn to design effective prompts that control AI systems. Master prompt structure, context layering, constraints, and advanced techniques. Apply prompt engineering to content creation, code generation, and data analysis.',
  'AI & Technology',
  'beginner',
  'published'
) ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  updated_at = NOW();

-- Verify courses were inserted
DO $$
DECLARE
  course_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO course_count FROM courses;
  
  RAISE NOTICE '';
  RAISE NOTICE '========================================';
  RAISE NOTICE '✅ COURSES SEEDED SUCCESSFULLY';
  RAISE NOTICE '========================================';
  RAISE NOTICE 'Total courses in database: %', course_count;
  RAISE NOTICE '';
  RAISE NOTICE 'Courses:';
  RAISE NOTICE '1. Vibe Coding (26 lessons)';
  RAISE NOTICE '2. Facebook Ads (26 lessons)';
  RAISE NOTICE '3. Prompt Engineering (16 lessons)';
  RAISE NOTICE '';
  RAISE NOTICE 'Next step: Run 002_seed_modules.sql';
  RAISE NOTICE '========================================';
END $$;

