-- ==========================================
-- 🚀 TRENDTACTICS ACADEMY - COURSE DATA V3
-- ==========================================
-- This script safely inserts 3 courses with FIXED UUIDs to prevent duplicates.
-- It includes FULL content (Modules/Lessons) for Vibe Coding.

-- 0. SCHEMA MIGRATION: Ensure thumbnail column exists
ALTER TABLE courses ADD COLUMN IF NOT EXISTS thumbnail TEXT;

-- 1. VIBE CODING (Full Course)
INSERT INTO courses (
  id,
  title,
  description,
  category,
  level,
  duration,
  price,
  thumbnail,
  is_published,
  created_at,
  updated_at
) VALUES (
  'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d', -- FIXED UUID
  'Vibe Coding',
  'Learn to create digital products by focusing on ideas, intention, creativity, and guidance — often with the help of AI — instead of memorizing code syntax.',
  'Creative Coding',
  'beginner',
  '4 weeks',
  0,
  'https://images.unsplash.com/photo-1542831371-29b0f74f9713?auto=format&fit=crop&q=80&w=1000',
  true,
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, description = EXCLUDED.description, thumbnail = EXCLUDED.thumbnail;

-- 2. PROMPT ENGINEERING
INSERT INTO courses (
  id,
  title,
  description,
  category,
  level,
  duration,
  price,
  thumbnail,
  is_published,
  created_at,
  updated_at
) VALUES (
  '123e4567-e89b-12d3-a456-426614174001', -- FIXED UUID
  'Prompt Engineering',
  'Master the art of crafting effective prompts for LLMs. Unlock the full potential of AI models for content, code, and more.',
  'AI Skills',
  'intermediate',
  '6 weeks',
  0,
  'https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&q=80&w=1000',
  true,
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, description = EXCLUDED.description, thumbnail = EXCLUDED.thumbnail;

-- 3. FACEBOOK ADS
INSERT INTO courses (
  id,
  title,
  description,
  category,
  level,
  duration,
  price,
  thumbnail,
  is_published,
  created_at,
  updated_at
) VALUES (
  '0987fcde-4321-0987-6543-210987654321', -- FIXED UUID (Valid format)
  'Facebook Ads Mastery',
  'Learn how to run profitable Facebook ad campaigns from scratch. Target the right audience and scale your business.',
  'Marketing',
  'advanced',
  '5 weeks',
  0,
  'https://images.unsplash.com/photo-1563986768609-322da13575f3?auto=format&fit=crop&q=80&w=1000',
  true,
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, description = EXCLUDED.description, thumbnail = EXCLUDED.thumbnail;


-- ==========================================
-- 📚 MODULES & LESSONS (For Vibe Coding)
-- ==========================================

-- Modules
INSERT INTO modules (id, course_id, title, description, ordering, duration, created_at, updated_at) VALUES 
('a1a11111-1a1a-1a1a-1a1a-1a1a1a1a1a1a', 'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d', 'Understanding Vibe Coding', 'Foundational concepts', 1, 1, NOW(), NOW()),
('b2b22222-2b2b-2b2b-2b2b-2b2b2b2b2b2b', 'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d', 'Thinking Before Coding', 'Expressing ideas clearly', 2, 1, NOW(), NOW()),
('c3c33333-3c3c-3c3c-3c3c-3c3c3c3c3c3c', 'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d', 'AI as a Creative Partner', 'Collaborating with AI', 3, 1, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- Lessons (Module 1)
INSERT INTO lessons (id, module_id, title, content, ordering, duration, created_at, updated_at) VALUES 
('10000000-0000-0000-0000-000000000001', 'a1a11111-1a1a-1a1a-1a1a-1a1a1a1a1a1a', 'What Is Vibe Coding?', 'Intro to Vibe Coding...', 1, 30, NOW(), NOW()),
('10000000-0000-0000-0000-000000000002', 'a1a11111-1a1a-1a1a-1a1a-1a1a1a1a1a1a', 'Why Vibe Coding Exists', 'Solving ed problems...', 2, 45, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- Lessons (Module 2)
INSERT INTO lessons (id, module_id, title, content, ordering, duration, created_at, updated_at) VALUES 
('20000000-0000-0000-0000-000000000001', 'b2b22222-2b2b-2b2b-2b2b-2b2b2b2b2b2b', 'Idea Formation', 'Forming clear ideas...', 1, 45, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

