-- Insert the Vibe Coding course with featured status
-- This script creates the Vibe Coding course that should appear on the homepage

-- 1. Insert the main Vibe Coding course
INSERT INTO courses (
    id,
    title,
    description,
    category,
    level,
    duration,
    price,
    is_published,
    created_at,
    updated_at,
    featured
) VALUES 
(
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',  -- Valid UUID
    'Vibe Coding',
    'Learn to create digital products by focusing on ideas, intention, creativity, and guidance — often with the help of AI — instead of memorizing code syntax or complex technical rules.',
    'Creative Coding',  -- Adjusted category to match description better
    'beginner',
    6, -- Duration in weeks (integer)
    0,
    true,
    NOW(),
    NOW(),
    true
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    category = EXCLUDED.category,
    level = EXCLUDED.level,
    duration = EXCLUDED.duration,
    price = EXCLUDED.price,
    is_published = EXCLUDED.is_published,
    updated_at = EXCLUDED.updated_at,
    featured = EXCLUDED.featured;

-- 2. Insert modules for Vibe Coding course
-- We use static valid UUIDs here to ensure we can reference them in lessons
INSERT INTO modules (
    id,
    course_id,
    title,
    description,
    ordering,
    duration,
    created_at,
    updated_at
) VALUES 
(
    'a1a11111-1a1a-1a1a-1a1a-1a1a1a1a1a1a',
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
    'Understanding Vibe Coding',
    'Learn the foundational concepts of Vibe Coding and why it exists',
    1,
    1, -- 1 week
    NOW(),
    NOW()
),
(
    'b2b22222-2b2b-2b2b-2b2b-2b2b2b2b2b2b',
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
    'Thinking Before Coding',
    'Develop the skill of expressing ideas clearly before implementation',
    2,
    1, -- 1 week
    NOW(),
    NOW()
),
(
    'c3c33333-3c3c-3c3c-3c3c-3c3c3c3c3c3c',
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
    'Working with AI as a Creative Partner',
    'Learn how to collaborate effectively with AI tools',
    3,
    1, -- 1 week
    NOW(),
    NOW()
),
(
    'd4d44444-4d4d-4d4d-4d4d-4d4d4d4d4d4d',
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
    'Vibe Coding in Real Life',
    'See how Vibe Coding works in practical scenarios',
    4,
    1, -- 1 week
    NOW(),
    NOW()
),
(
    'e5e55555-5e5e-5e5e-5e5e-5e5e5e5e5e5e',
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
    'Exploring and Building with Confidence',
    'Use safe environments to experiment and build complete projects',
    5,
    2, -- 2 weeks
    NOW(),
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    ordering = EXCLUDED.ordering,
    duration = EXCLUDED.duration,
    updated_at = EXCLUDED.updated_at;

-- 3. Insert lessons (Placeholder structure, content will be populated by Generation Task)
-- Using valid UUIDs starting with 1000... for easy identification

INSERT INTO lessons (
    id,
    module_id,
    title,
    ordering,
    duration,
    created_at,
    updated_at
) VALUES 
-- Module 1: Understanding Vibe Coding
(
    '10000000-0000-0000-0000-000000000001',
    'a1a11111-1a1a-1a1a-1a1a-1a1a1a1a1a1a',
    'What Is Vibe Coding?',
    1,
    30, -- minutes
    NOW(),
    NOW()
),
(
    '10000000-0000-0000-0000-000000000002',
    'a1a11111-1a1a-1a1a-1a1a-1a1a1a1a1a1a',
    'Why Vibe Coding Exists',
    2,
    45,
    NOW(),
    NOW()
),
(
    '10000000-0000-0000-0000-000000000003',
    'a1a11111-1a1a-1a1a-1a1a-1a1a1a1a1a1a',
    'How Vibe Coding Is Different from Traditional Coding',
    3,
    60,
    NOW(),
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    module_id = EXCLUDED.module_id,
    ordering = EXCLUDED.ordering,
    duration = EXCLUDED.duration,
    updated_at = EXCLUDED.updated_at;