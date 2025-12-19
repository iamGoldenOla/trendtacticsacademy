-- Find out what level values are currently in the database
SELECT DISTINCT level FROM courses WHERE level IS NOT NULL;

-- Try to insert a course with different level values to see what works
-- First, let's try lowercase values
INSERT INTO courses (
    title,
    description,
    category,
    level,
    duration,
    price,
    is_published
) VALUES 
(
    'Test Course - beginner',
    'Test description',
    'Test Category',
    'beginner',
    '1 week',
    0,
    true
)
ON CONFLICT DO NOTHING
RETURNING id, level;

-- Try intermediate
INSERT INTO courses (
    title,
    description,
    category,
    level,
    duration,
    price,
    is_published
) VALUES 
(
    'Test Course - intermediate',
    'Test description',
    'Test Category',
    'intermediate',
    '1 week',
    0,
    true
)
ON CONFLICT DO NOTHING
RETURNING id, level;

-- Try advanced
INSERT INTO courses (
    title,
    description,
    category,
    level,
    duration,
    price,
    is_published
) VALUES 
(
    'Test Course - advanced',
    'Test description',
    'Test Category',
    'advanced',
    '1 week',
    0,
    true
)
ON CONFLICT DO NOTHING
RETURNING id, level;

-- Clean up test courses
DELETE FROM courses WHERE title LIKE 'Test Course%';