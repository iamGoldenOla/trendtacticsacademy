-- ============================================================================
-- SEED SCRIPT: Modules
-- ============================================================================
-- This script seeds the modules table for all 3 courses
-- Run this AFTER 001_seed_courses.sql
-- ============================================================================

-- ============================================================================
-- VIBE CODING MODULES (13 modules)
-- ============================================================================

INSERT INTO modules (id, course_id, title, description, ordering, created_at, updated_at) VALUES
('10000000-0000-0000-0000-000000000001', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 1: Vibe Coding Foundations', 'Learn the fundamentals of Vibe Coding and why it represents the future of software development', 1, NOW(), NOW()),
('10000000-0000-0000-0000-000000000002', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 2: The Vibe Coding Ecosystem', 'Explore the tools and workflows that make Vibe Coding possible', 2, NOW(), NOW()),
('10000000-0000-0000-0000-000000000003', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 3: Full-Stack AI Builders', 'Master full-stack AI tools like Bolt.new, Lovable, Replit Agent, and V0', 3, NOW(), NOW()),
('10000000-0000-0000-0000-000000000004', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 4: AI-First IDEs', 'Learn to use AI-powered IDEs like Cursor, Windsurf, and Qoder', 4, NOW(), NOW()),
('10000000-0000-0000-0000-000000000005', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 5: Agentic Coding Tools', 'Explore autonomous coding agents like Devin, OpenHands, and Claude Computer Use', 5, NOW(), NOW()),
('10000000-0000-0000-0000-000000000006', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 6: Real-World Workflows', 'Apply Vibe Coding to real production environments and SaaS products', 6, NOW(), NOW()),
('10000000-0000-0000-0000-000000000007', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 7: Prompting for Software', 'Master prompt engineering specifically for code generation', 7, NOW(), NOW()),
('10000000-0000-0000-0000-000000000008', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 8: The Future of Vibe Coding', 'Explore emerging tools and career opportunities in AI-first development', 8, NOW(), NOW()),
('10000000-0000-0000-0000-000000000009', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 9: Testing and Debugging with AI', 'Learn AI-powered testing and debugging strategies', 9, NOW(), NOW()),
('10000000-0000-0000-0000-000000000010', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 10: Version Control and Collaboration', 'Master Git, GitHub, and collaborative workflows in the AI era', 10, NOW(), NOW()),
('10000000-0000-0000-0000-000000000011', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 11: Building Real Projects', 'Build three complete projects from scratch using Vibe Coding', 11, NOW(), NOW()),
('10000000-0000-0000-0000-000000000012', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 12: Advanced Vibe Coding Techniques', 'Master advanced techniques like API integration and performance optimization', 12, NOW(), NOW()),
('10000000-0000-0000-0000-000000000013', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 13: Course Conclusion', 'Review your journey and explore next steps in your Vibe Coding career', 13, NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  ordering = EXCLUDED.ordering,
  updated_at = NOW();

-- ============================================================================
-- FACEBOOK ADS MODULES (10 modules)
-- ============================================================================

INSERT INTO modules (id, course_id, title, description, ordering, created_at, updated_at) VALUES
('20000000-0000-0000-0000-000000000001', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 1: Facebook Ads Foundations', 'Understand how Facebook Ads work under the hood and the ecosystem structure', 1, NOW(), NOW()),
('20000000-0000-0000-0000-000000000002', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 2: Account & Campaign Structure', 'Master account setup, campaign structure, and strategic planning', 2, NOW(), NOW()),
('20000000-0000-0000-0000-000000000003', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 3: Audiences & Targeting (The Right Way in 2025)', 'Learn modern targeting strategies, custom audiences, and lookalike audiences', 3, NOW(), NOW()),
('20000000-0000-0000-0000-000000000004', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 4: Ad Creatives That Convert', 'Master ad creative best practices and formats that drive conversions', 4, NOW(), NOW()),
('20000000-0000-0000-0000-000000000005', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 5: Funnels, Pages & Conversion Flow', 'Build effective funnels and optimize conversion flows', 5, NOW(), NOW()),
('20000000-0000-0000-0000-000000000006', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 6: Budgeting, Testing & Optimization', 'Master budget strategies, A/B testing, and campaign optimization', 6, NOW(), NOW()),
('20000000-0000-0000-0000-000000000007', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 7: Scaling & Stability', 'Learn to scale campaigns while maintaining performance and stability', 7, NOW(), NOW()),
('20000000-0000-0000-0000-000000000008', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 8: Real-World Facebook Ads Workflows', 'Apply Facebook Ads strategies to real-world business scenarios', 8, NOW(), NOW()),
('20000000-0000-0000-0000-000000000009', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 9: AI & Facebook Ads (Modern Workflow)', 'Integrate AI tools into your Facebook Ads workflow', 9, NOW(), NOW()),
('20000000-0000-0000-0000-000000000010', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Final Module: Long-Term Mastery', 'Develop long-term mastery and sustainable Facebook Ads success', 10, NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  ordering = EXCLUDED.ordering,
  updated_at = NOW();

-- ============================================================================
-- PROMPT ENGINEERING MODULES (6 modules)
-- ============================================================================

INSERT INTO modules (id, course_id, title, description, ordering, created_at, updated_at) VALUES
('30000000-0000-0000-0000-000000000001', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 1: Prompt Engineering Foundations', 'Learn what prompt engineering is and how AI interprets instructions', 1, NOW(), NOW()),
('30000000-0000-0000-0000-000000000002', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 2: Prompt Structure & Control', 'Master core prompt components, context layering, and constraints', 2, NOW(), NOW()),
('30000000-0000-0000-0000-000000000003', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 3: Intermediate Prompt Techniques', 'Learn few-shot learning, iterative refinement, and prompt chaining', 3, NOW(), NOW()),
('30000000-0000-0000-0000-000000000004', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 4: Advanced Prompt Techniques', 'Master temperature control, zero-shot, and self-consistency techniques', 4, NOW(), NOW()),
('30000000-0000-0000-0000-000000000005', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 5: Specialized Applications', 'Apply prompt engineering to content, code, and data analysis', 5, NOW(), NOW()),
('30000000-0000-0000-0000-000000000006', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 6: Troubleshooting and Best Practices', 'Avoid common mistakes, test prompts, and build advanced projects', 6, NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  ordering = EXCLUDED.ordering,
  updated_at = NOW();

-- Verify modules were inserted
DO $$
DECLARE
  module_count INTEGER;
  vc_modules INTEGER;
  fb_modules INTEGER;
  pe_modules INTEGER;
BEGIN
  SELECT COUNT(*) INTO module_count FROM modules;
  SELECT COUNT(*) INTO vc_modules FROM modules WHERE course_id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890';
  SELECT COUNT(*) INTO fb_modules FROM modules WHERE course_id = 'b2c3d4e5-f6a7-8901-bcde-f01234567891';
  SELECT COUNT(*) INTO pe_modules FROM modules WHERE course_id = 'c3d4e5f6-a7b8-9012-cdef-012345678912';
  
  RAISE NOTICE '';
  RAISE NOTICE '========================================';
  RAISE NOTICE '✅ MODULES SEEDED SUCCESSFULLY';
  RAISE NOTICE '========================================';
  RAISE NOTICE 'Total modules in database: %', module_count;
  RAISE NOTICE '';
  RAISE NOTICE 'Breakdown:';
  RAISE NOTICE '- Vibe Coding: % modules (expected: 13)', vc_modules;
  RAISE NOTICE '- Facebook Ads: % modules (expected: 10)', fb_modules;
  RAISE NOTICE '- Prompt Engineering: % modules (expected: 6)', pe_modules;
  RAISE NOTICE '';
  RAISE NOTICE 'Next step: Run 003_seed_lessons.sql';
  RAISE NOTICE '========================================';
END $$;

