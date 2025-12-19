-- Test inserting a single course with corrected values
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
    'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11',
    'Test Course',
    'Test description',
    'Test Category',
    'beginner',
    '1 week',
    0,
    true,
    NOW(),
    NOW()
)
ON CONFLICT (id) DO NOTHING
RETURNING id, title, level;

-- Clean up
DELETE FROM courses WHERE id = 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11';