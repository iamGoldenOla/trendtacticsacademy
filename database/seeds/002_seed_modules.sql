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
('vc-mod-01', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 1: Vibe Coding Foundations', 'Learn the fundamentals of Vibe Coding and why it represents the future of software development', 1, NOW(), NOW()),
('vc-mod-02', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 2: The Vibe Coding Ecosystem', 'Explore the tools and workflows that make Vibe Coding possible', 2, NOW(), NOW()),
('vc-mod-03', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 3: Full-Stack AI Builders', 'Master full-stack AI tools like Bolt.new, Lovable, Replit Agent, and V0', 3, NOW(), NOW()),
('vc-mod-04', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 4: AI-First IDEs', 'Learn to use AI-powered IDEs like Cursor, Windsurf, and Qoder', 4, NOW(), NOW()),
('vc-mod-05', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 5: Agentic Coding Tools', 'Explore autonomous coding agents like Devin, OpenHands, and Claude Computer Use', 5, NOW(), NOW()),
('vc-mod-06', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 6: Real-World Workflows', 'Apply Vibe Coding to real production environments and SaaS products', 6, NOW(), NOW()),
('vc-mod-07', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 7: Prompting for Software', 'Master prompt engineering specifically for code generation', 7, NOW(), NOW()),
('vc-mod-08', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 8: The Future of Vibe Coding', 'Explore emerging tools and career opportunities in AI-first development', 8, NOW(), NOW()),
('vc-mod-09', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 9: Testing and Debugging with AI', 'Learn AI-powered testing and debugging strategies', 9, NOW(), NOW()),
('vc-mod-10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 10: Version Control and Collaboration', 'Master Git, GitHub, and collaborative workflows in the AI era', 10, NOW(), NOW()),
('vc-mod-11', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 11: Building Real Projects', 'Build three complete projects from scratch using Vibe Coding', 11, NOW(), NOW()),
('vc-mod-12', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 12: Advanced Vibe Coding Techniques', 'Master advanced techniques like API integration and performance optimization', 12, NOW(), NOW()),
('vc-mod-13', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Module 13: Course Conclusion', 'Review your journey and explore next steps in your Vibe Coding career', 13, NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  ordering = EXCLUDED.ordering,
  updated_at = NOW();

-- ============================================================================
-- FACEBOOK ADS MODULES (13 modules)
-- ============================================================================

INSERT INTO modules (id, course_id, title, description, ordering, created_at, updated_at) VALUES
('fb-mod-01', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 1: Facebook Ads Foundations', 'Understand how Facebook Ads work under the hood and the ecosystem structure', 1, NOW(), NOW()),
('fb-mod-02', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 2: Campaign Structure and Strategy', 'Master campaign structure, objectives, and strategic planning', 2, NOW(), NOW()),
('fb-mod-03', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 3: Audience Targeting', 'Learn targeting options, custom audiences, and lookalike audiences', 3, NOW(), NOW()),
('fb-mod-04', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 4: Creative Strategy', 'Master ad creative best practices and format selection', 4, NOW(), NOW()),
('fb-mod-05', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 5: Budgeting and Bidding', 'Understand budget strategies and bidding optimization', 5, NOW(), NOW()),
('fb-mod-06', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 6: The Facebook Pixel', 'Install, configure, and optimize the Facebook Pixel', 6, NOW(), NOW()),
('fb-mod-07', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 7: Campaign Optimization', 'Learn to read metrics and optimize campaigns for better performance', 7, NOW(), NOW()),
('fb-mod-08', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 8: Scaling Campaigns', 'Master horizontal and vertical scaling strategies', 8, NOW(), NOW()),
('fb-mod-09', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 9: Retargeting and Remarketing', 'Build effective retargeting funnels and dynamic product ads', 9, NOW(), NOW()),
('fb-mod-10', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 10: Advanced Targeting', 'Master interest stacking, layered targeting, and exclusion strategies', 10, NOW(), NOW()),
('fb-mod-11', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 11: Troubleshooting and Problem-Solving', 'Solve common problems and handle ad disapprovals', 11, NOW(), NOW()),
('fb-mod-12', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 12: Advanced Strategies', 'Master multi-product campaigns and seasonal planning', 12, NOW(), NOW()),
('fb-mod-13', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Module 13: AI and Automation', 'Leverage Facebook AI and integrate external AI tools', 13, NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  ordering = EXCLUDED.ordering,
  updated_at = NOW();

-- ============================================================================
-- PROMPT ENGINEERING MODULES (6 modules)
-- ============================================================================

INSERT INTO modules (id, course_id, title, description, ordering, created_at, updated_at) VALUES
('pe-mod-01', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 1: Prompt Engineering Foundations', 'Learn what prompt engineering is and how AI interprets instructions', 1, NOW(), NOW()),
('pe-mod-02', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 2: Prompt Structure & Control', 'Master core prompt components, context layering, and constraints', 2, NOW(), NOW()),
('pe-mod-03', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 3: Intermediate Prompt Techniques', 'Learn few-shot learning, iterative refinement, and prompt chaining', 3, NOW(), NOW()),
('pe-mod-04', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 4: Advanced Prompt Techniques', 'Master temperature control, zero-shot, and self-consistency techniques', 4, NOW(), NOW()),
('pe-mod-05', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 5: Specialized Applications', 'Apply prompt engineering to content, code, and data analysis', 5, NOW(), NOW()),
('pe-mod-06', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Module 6: Troubleshooting and Best Practices', 'Avoid common mistakes, test prompts, and build advanced projects', 6, NOW(), NOW())
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
  RAISE NOTICE '- Vibe Coding: % modules', vc_modules;
  RAISE NOTICE '- Facebook Ads: % modules', fb_modules;
  RAISE NOTICE '- Prompt Engineering: % modules', pe_modules;
  RAISE NOTICE '';
  RAISE NOTICE 'Next step: Run 003_seed_lessons.sql';
  RAISE NOTICE '========================================';
END $$;

