-- Test what level values are allowed by trying to insert a minimal course
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
    'Test Course',
    'Test description',
    'Test Category',
    'beginner',
    '1 week',
    0,
    true
)
RETURNING id, level;

-- Clean up the test course
DELETE FROM courses WHERE title = 'Test Course';

-- Try with uppercase
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
    'Test Course',
    'Test description',
    'Test Category',
    'Beginner',
    '1 week',
    0,
    true
)
RETURNING id, level;

-- Clean up the test course
DELETE FROM courses WHERE title = 'Test Course';