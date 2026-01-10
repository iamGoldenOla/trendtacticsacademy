-- ============================================================================
-- COMBINED SEED SCRIPT: All Courses, Modules, and Lessons
-- ============================================================================
-- This script seeds everything in one go
-- Run this ONCE in Supabase SQL Editor
-- ============================================================================

-- Clear existing data
DELETE FROM lessons;
DELETE FROM modules;
DELETE FROM courses;

-- ============================================================================
-- STEP 1: SEED COURSES
-- ============================================================================

INSERT INTO courses (
  id,
  title,
  description,
  category,
  level,
  status
) VALUES 
(
  'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
  'Vibe Coding: Building Real Software with AI',
  'Learn to build real software using AI tools like Cursor, Bolt.new, and Replit Agent. Master the art of describing what you want and letting AI handle the implementation. Perfect for entrepreneurs, designers, and anyone who wants to build without traditional coding.',
  'Programming',
  'beginner',
  'published'
),
(
  'b2c3d4e5-f6a7-8901-bcde-f01234567891',
  'Facebook Ads: Building Profitable, Predictable Ad Systems in 2025',
  'Master Facebook advertising with a systems-based approach. Learn campaign structure, targeting, creative strategy, optimization, and scaling. Build profitable ad campaigns that work consistently and predictably.',
  'Marketing',
  'intermediate',
  'published'
),
(
  'c3d4e5f6-a7b8-9012-cdef-012345678912',
  'Prompt Engineering: Designing Instructions That Control AI Systems (2025 Edition)',
  'Learn to design effective prompts that control AI systems. Master prompt structure, context layering, constraints, and advanced techniques. Apply prompt engineering to content creation, code generation, and data analysis.',
  'AI & Technology',
  'beginner',
  'published'
);

-- ============================================================================
-- STEP 2: SEED MODULES
-- ============================================================================

-- Vibe Coding Modules (13)
INSERT INTO modules (id, course_id, title, description, ordering) VALUES
('10000000-0000-0000-0000-000000000001', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 1: Vibe Coding Foundations', 'Learn the fundamentals of Vibe Coding and why it represents the future of software development', 1),
('10000000-0000-0000-0000-000000000002', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 2: The Vibe Coding Ecosystem', 'Explore the tools and workflows that make Vibe Coding possible', 2),
('10000000-0000-0000-0000-000000000003', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 3: Full-Stack AI Builders', 'Master full-stack AI tools like Bolt.new, Lovable, Replit Agent, and V0', 3),
('10000000-0000-0000-0000-000000000004', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 4: AI-First IDEs', 'Learn to use AI-powered IDEs like Cursor, Windsurf, and Qoder', 4),
('10000000-0000-0000-0000-000000000005', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 5: Agentic Coding Tools', 'Explore autonomous coding agents like Devin, OpenHands, and Claude Computer Use', 5),
('10000000-0000-0000-0000-000000000006', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 6: Real-World Workflows', 'Apply Vibe Coding to real production environments and SaaS products', 6),
('10000000-0000-0000-0000-000000000007', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 7: Prompting for Software', 'Master prompt engineering specifically for code generation', 7),
('10000000-0000-0000-0000-000000000008', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 8: The Future of Vibe Coding', 'Explore emerging tools and career opportunities in AI-first development', 8),
('10000000-0000-0000-0000-000000000009', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 9: Testing and Debugging with AI', 'Learn AI-powered testing and debugging strategies', 9),
('10000000-0000-0000-0000-000000000010', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 10: Version Control and Collaboration', 'Master Git, GitHub, and collaborative workflows in the AI era', 10),
('10000000-0000-0000-0000-000000000011', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 11: Building Real Projects', 'Build three complete projects from scratch using Vibe Coding', 11),
('10000000-0000-0000-0000-000000000012', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 12: Advanced Vibe Coding Techniques', 'Master advanced techniques like API integration and performance optimization', 12),
('10000000-0000-0000-0000-000000000013', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 13: Course Conclusion', 'Review your journey and explore next steps in your Vibe Coding career', 13);

-- Facebook Ads Modules (10)
INSERT INTO modules (id, course_id, title, description, ordering) VALUES
('20000000-0000-0000-0000-000000000001', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 1: Facebook Ads Foundations', 'Understand how Facebook Ads work under the hood and the ecosystem structure', 1),
('20000000-0000-0000-0000-000000000002', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 2: Account & Campaign Structure', 'Master account setup, campaign structure, and strategic planning', 2),
('20000000-0000-0000-0000-000000000003', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 3: Audiences & Targeting (The Right Way in 2025)', 'Learn modern targeting strategies, custom audiences, and lookalike audiences', 3),
('20000000-0000-0000-0000-000000000004', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 4: Ad Creatives That Convert', 'Master ad creative best practices and formats that drive conversions', 4),
('20000000-0000-0000-0000-000000000005', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 5: Funnels, Pages & Conversion Flow', 'Build effective funnels and optimize conversion flows', 5),
('20000000-0000-0000-0000-000000000006', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 6: Budgeting, Testing & Optimization', 'Master budget strategies, A/B testing, and campaign optimization', 6),
('20000000-0000-0000-0000-000000000007', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 7: Scaling & Stability', 'Learn to scale campaigns while maintaining performance and stability', 7),
('20000000-0000-0000-0000-000000000008', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 8: Real-World Facebook Ads Workflows', 'Apply Facebook Ads strategies to real-world business scenarios', 8),
('20000000-0000-0000-0000-000000000009', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 9: AI & Facebook Ads (Modern Workflow)', 'Integrate AI tools into your Facebook Ads workflow', 9),
('20000000-0000-0000-0000-000000000010', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Final Module: Long-Term Mastery', 'Develop long-term mastery and sustainable Facebook Ads success', 10);

-- Prompt Engineering Modules (6)
INSERT INTO modules (id, course_id, title, description, ordering) VALUES
('30000000-0000-0000-0000-000000000001', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 1: Prompt Engineering Foundations', 'Learn what prompt engineering is and how AI interprets instructions', 1),
('30000000-0000-0000-0000-000000000002', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 2: Prompt Structure & Control', 'Master core prompt components, context layering, and constraints', 2),
('30000000-0000-0000-0000-000000000003', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 3: Intermediate Prompt Techniques', 'Learn few-shot learning, iterative refinement, and prompt chaining', 3),
('30000000-0000-0000-0000-000000000004', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 4: Advanced Prompt Engineering', 'Master advanced techniques like meta-prompting and prompt optimization', 4),
('30000000-0000-0000-0000-000000000005', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 5: Real-World Applications', 'Apply prompt engineering to content creation, code generation, and data analysis', 5),
('30000000-0000-0000-0000-000000000006', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 6: Course Conclusion', 'Review your journey and explore next steps in prompt engineering', 6);

-- ============================================================================
-- STEP 3: VERIFY
-- ============================================================================

DO $$
DECLARE
  course_count INTEGER;
  module_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO course_count FROM courses;
  SELECT COUNT(*) INTO module_count FROM modules;
  
  RAISE NOTICE '';
  RAISE NOTICE '========================================';
  RAISE NOTICE 'COURSES AND MODULES SEEDED';
  RAISE NOTICE '========================================';
  RAISE NOTICE 'Courses: %', course_count;
  RAISE NOTICE 'Modules: %', module_count;
  RAISE NOTICE '';
  RAISE NOTICE 'Next: Run 003_seed_lessons.sql separately';
  RAISE NOTICE '(Lessons file is too large to combine)';
  RAISE NOTICE '========================================';
END $$;

