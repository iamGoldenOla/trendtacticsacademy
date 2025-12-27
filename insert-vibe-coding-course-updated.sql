-- Insert the Vibe Coding course with featured status using category field
-- This script creates the Vibe Coding course that should appear on the homepage
-- Uses category = 'featured' since the featured column might not exist yet

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
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',  -- Unique UUID for Vibe Coding course
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
    'f0f69f5b-3g4c-5d0b-9b4e-2f6g7b8c9d0e',
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
    'Understanding Vibe Coding',
    'Learn the foundational concepts of Vibe Coding and why it exists',
    1,
    '1 week',
    NOW(),
    NOW()
),
(
    'g1g70g6c-4h5d-6e1c-0c5f-3g7h8c9d0e1f',
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
    'Thinking Before Coding',
    'Develop the skill of expressing ideas clearly before implementation',
    2,
    '1 week',
    NOW(),
    NOW()
),
(
    'h2h81h7d-5i6e-7f2d-1d6g-4h8i9d0e1f2g',
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
    'Working with AI as a Creative Partner',
    'Learn how to collaborate effectively with AI tools',
    3,
    '1 week',
    NOW(),
    NOW()
),
(
    'i3i92i8e-6j7f-8g3e-2e7h-5i9j0e1f2g3h',
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
    'Vibe Coding in Real Life',
    'See how Vibe Coding works in practical scenarios',
    4,
    '1 week',
    NOW(),
    NOW()
),
(
    'j4j03j9f-7k8g-9h4f-3f8i-6j0k1f2g3h4i',
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
    'k5k14k0g-8l9h-0i5g-4g9j-7k1l2g3h4i5j',
    'f0f69f5b-3g4c-5d0b-9b4e-2f6g7b8c9d0e',
    'What is Vibe Coding?',
    'Introduction to the concept of Vibe Coding and how it differs from traditional coding approaches.',
    1,
    '30 minutes',
    NOW(),
    NOW()
),
(
    'l6l25l1h-9m0i-1j6h-5h0k-8l2m3h4i5j6k',
    'f0f69f5b-3g4c-5d0b-9b4e-2f6g7b8c9d0e',
    'Why Vibe Coding Exists',
    'Understanding the problems with traditional coding education and how Vibe Coding solves them.',
    2,
    '45 minutes',
    NOW(),
    NOW()
),
(
    'm7m36m2i-0n1j-2k7i-6i1l-9m3n4i5j6k7l',
    'f0f69f5b-3g4c-5d0b-9b4e-2f6g7b8c9d0e',
    'Core Principles',
    'Learn the fundamental principles that guide Vibe Coding methodology.',
    3,
    '1 hour',
    NOW(),
    NOW()
),
-- Lessons for Thinking Before Coding module
(
    'n8n47n3j-1o2k-3l8j-7j2m-0n4o5j6k7l8m',
    'g1g70g6c-4h5d-6e1c-0c5f-3g7h8c9d0e1f',
    'Idea Formation',
    'Learn how to form clear and actionable ideas before starting to code.',
    1,
    '45 minutes',
    NOW(),
    NOW()
),
(
    'o9o58o4k-2p3l-4m9k-8k3n-1o5p6k7l8m9n',
    'g1g70g6c-4h5d-6e1c-0c5f-3g7h8c9d0e1f',
    'Expressing Ideas Clearly',
    'Techniques for expressing your ideas in ways that are easy to implement.',
    2,
    '1 hour',
    NOW(),
    NOW()
),
(
    'p0p69p5l-3q4m-5n0l-9l4o-2p6q7l8m9n0o',
    'g1g70g6c-4h5d-6e1c-0c5f-3g7h8c9d0e1f',
    'Planning Your Approach',
    'How to plan your approach before diving into implementation.',
    3,
    '1 hour',
    NOW(),
    NOW()
),
-- Lessons for Working with AI as a Creative Partner module
(
    'q1q70q6m-4r5n-6o1m-0m5p-3q7r8m9n0o1p',
    'h2h81h7d-5i6e-7f2d-1d6g-4h8i9d0e1f2g',
    'Introduction to AI Tools',
    'Overview of AI tools available for coding and how to use them effectively.',
    1,
    '1 hour',
    NOW(),
    NOW()
),
(
    'r2r81r7n-5s6o-7p2n-1n6q-4r8s9n0o1p2q',
    'h2h81h7d-5i6e-7f2d-1d6g-4h8i9d0e1f2g',
    'Collaboration Strategies',
    'Best practices for collaborating with AI tools in your coding workflow.',
    2,
    '1 hour',
    NOW(),
    NOW()
),
(
    's3s92s8o-6t7p-8q3o-2o7r-5s9t0o1p2q3r',
    'h2h81h7d-5i6e-7f2d-1d6g-4h8i9d0e1f2g',
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