-- Insert the Vibe Coding course with featured status using category field
-- This script creates the Vibe Coding course that should appear on the homepage
-- Uses category = 'featured' since the featured column might not exist yet
-- All UUIDs are now in correct format (0-9, a-f only)

-- Insert the main Vibe Coding course
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
    updated_at
) VALUES 
(
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',  -- Valid UUID for Vibe Coding course
    'Vibe Coding',
    'Learn to create digital products by focusing on ideas, intention, creativity, and guidance — often with the help of AI — instead of memorizing code syntax or complex technical rules.',
    'featured',  -- Set category as 'featured' to make it appear on homepage
    'beginner',
    '6 weeks',
    0,
    true,
    NOW(),
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    category = EXCLUDED.category,
    level = EXCLUDED.level,
    duration = EXCLUDED.duration,
    price = EXCLUDED.price,
    is_published = EXCLUDED.is_published,
    updated_at = EXCLUDED.updated_at;

-- Insert modules for Vibe Coding course
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
    'a0f69f5b-3f4c-5d0b-9b4e-2f6f7b8c9d0e',  -- Valid UUID
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
    'Understanding Vibe Coding',
    'Learn the foundational concepts of Vibe Coding and why it exists',
    1,
    '1 week',
    NOW(),
    NOW()
),
(
    'b1f70f6c-4f5d-6e1c-0c5f-3f7f8c9d0e1f',  -- Valid UUID
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
    'Thinking Before Coding',
    'Develop the skill of expressing ideas clearly before implementation',
    2,
    '1 week',
    NOW(),
    NOW()
),
(
    'c2f81f7d-5f6e-7f2d-1d6f-4f8f9d0e1f2f',  -- Valid UUID
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
    'Working with AI as a Creative Partner',
    'Learn how to collaborate effectively with AI tools',
    3,
    '1 week',
    NOW(),
    NOW()
),
(
    'd3f92f8e-6f7f-8f3e-2e7f-5f9f0e1f2f3f',  -- Valid UUID
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
    'Vibe Coding in Real Life',
    'See how Vibe Coding works in practical scenarios',
    4,
    '1 week',
    NOW(),
    NOW()
),
(
    'e4f03f9f-7f8f-9f4f-3f8f-6f0f1f2f3f4f',  -- Valid UUID
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
    'Exploring and Building with Confidence',
    'Use safe environments to experiment and build complete projects',
    5,
    '2 weeks',
    NOW(),
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    ordering = EXCLUDED.ordering,
    duration = EXCLUDED.duration,
    updated_at = EXCLUDED.updated_at;

-- Insert lessons for the modules
INSERT INTO lessons (
    id,
    module_id,
    title,
    content,
    ordering,
    duration,
    created_at,
    updated_at
) VALUES 
-- Lessons for Understanding Vibe Coding module
(
    'f5f14f0a-8f9f-0f5a-4a9f-7f1f2a3f4f5f',  -- Valid UUID
    'a0f69f5b-3f4c-5d0b-9b4e-2f6f7b8c9d0e',
    'What is Vibe Coding?',
    'Introduction to the concept of Vibe Coding and how it differs from traditional coding approaches.',
    1,
    '30 minutes',
    NOW(),
    NOW()
),
(
    'a6f25f1b-9f0f-1f6b-5b0f-8f2f3b4f5f6f',  -- Valid UUID
    'a0f69f5b-3f4c-5d0b-9b4e-2f6f7b8c9d0e',
    'Why Vibe Coding Exists',
    'Understanding the problems with traditional coding education and how Vibe Coding solves them.',
    2,
    '45 minutes',
    NOW(),
    NOW()
),
(
    'b7f36f2c-0f1f-2f7c-6c1f-9f3f4c5f6f7f',  -- Valid UUID
    'a0f69f5b-3f4c-5d0b-9b4e-2f6f7b8c9d0e',
    'Core Principles',
    'Learn the fundamental principles that guide Vibe Coding methodology.',
    3,
    '1 hour',
    NOW(),
    NOW()
),
-- Lessons for Thinking Before Coding module
(
    'c8f47f3d-1f2f-3f8d-7d2f-0f4f5d6f7f8f',  -- Valid UUID
    'b1f70f6c-4f5d-6e1c-0c5f-3f7f8c9d0e1f',
    'Idea Formation',
    'Learn how to form clear and actionable ideas before starting to code.',
    1,
    '45 minutes',
    NOW(),
    NOW()
),
(
    'd9f58f4e-2f3f-4f9e-8e3f-1f5f6e7f8f9f',  -- Valid UUID
    'b1f70f6c-4f5d-6e1c-0c5f-3f7f8c9d0e1f',
    'Expressing Ideas Clearly',
    'Techniques for expressing your ideas in ways that are easy to implement.',
    2,
    '1 hour',
    NOW(),
    NOW()
),
(
    'e0f69f5f-3f4f-5f0f-9f4f-2f6f7f8f9f0f',  -- Valid UUID
    'b1f70f6c-4f5d-6e1c-0c5f-3f7f8c9d0e1f',
    'Planning Your Approach',
    'How to plan your approach before diving into implementation.',
    3,
    '1 hour',
    NOW(),
    NOW()
),
-- Lessons for Working with AI as a Creative Partner module
(
    'f1f70f6a-4f5f-6f1a-0a5f-3f7f8a9f0f1f',  -- Valid UUID
    'c2f81f7d-5f6e-7f2d-1d6f-4f8f9d0e1f2f',
    'Introduction to AI Tools',
    'Overview of AI tools available for coding and how to use them effectively.',
    1,
    '1 hour',
    NOW(),
    NOW()
),
(
    'a2f81f7b-5f6f-7f2b-1b6f-4f8f9b0f1f2f',  -- Valid UUID
    'c2f81f7d-5f6e-7f2d-1d6f-4f8f9d0e1f2f',
    'Collaboration Strategies',
    'Best practices for collaborating with AI tools in your coding workflow.',
    2,
    '1 hour',
    NOW(),
    NOW()
),
(
    'b3f92f8c-6f7f-8f3c-2c7f-5f9f0c1f2f3f',  -- Valid UUID
    'c2f81f7d-5f6e-7f2d-1d6f-4f8f9d0e1f2f',
    'Reviewing AI Suggestions',
    'How to review and validate AI-generated code before using it.',
    3,
    '1.5 hours',
    NOW(),
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    content = EXCLUDED.content,
    ordering = EXCLUDED.ordering,
    duration = EXCLUDED.duration,
    updated_at = EXCLUDED.updated_at;