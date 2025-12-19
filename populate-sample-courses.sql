-- Populate sample courses for testing
-- This script creates sample courses with proper UUIDs that can be used for testing

-- Insert sample courses
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
    'Introduction to Web Development',
    'Learn the fundamentals of web development including HTML, CSS, and JavaScript',
    'Web Development',
    'Beginner',
    '4 weeks',
    0,
    true,
    NOW(),
    NOW()
),
(
    'b1ffcd00-ad1c-5fg9-cc7e-7cc0ce491b22',
    'Advanced React Development',
    'Master advanced React concepts including hooks, context, and performance optimization',
    'Web Development',
    'Intermediate',
    '6 weeks',
    49.99,
    true,
    NOW(),
    NOW()
),
(
    'c2ggde11-be2d-6gh0-dd8f-8dd1df502c33',
    'Mobile App Development with React Native',
    'Build cross-platform mobile applications using React Native',
    'Mobile Development',
    'Intermediate',
    '8 weeks',
    79.99,
    true,
    NOW(),
    NOW()
)
ON CONFLICT (id) DO NOTHING;

-- Insert sample modules for the courses
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
-- Modules for Introduction to Web Development
(
    'd3hhdf22-cf3e-7hi1-ee9g-9ee2eg613d44',
    'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11',
    'HTML Fundamentals',
    'Learn the basics of HTML structure and semantics',
    1,
    '1 week',
    NOW(),
    NOW()
),
(
    'e4iieg33-dg4f-8ij2-ff0h-0ff3fh724e55',
    'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11',
    'CSS Styling',
    'Master CSS styling techniques and responsive design',
    2,
    '1 week',
    NOW(),
    NOW()
),
(
    'f5jjfh44-eh5g-9jk3-gg1i-1gg4gi835f66',
    'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11',
    'JavaScript Basics',
    'Introduction to JavaScript programming',
    3,
    '2 weeks',
    NOW(),
    NOW()
)
ON CONFLICT (id) DO NOTHING;

-- Insert sample lessons for the modules
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
-- Lessons for HTML Fundamentals
(
    '06kkfi55-fi6h-0kl4-hh2j-2hh5hj946g77',
    'd3hhdf22-cf3e-7hi1-ee9g-9ee2eg613d44',
    'HTML Document Structure',
    'Learn about the basic structure of an HTML document including DOCTYPE, html, head, and body tags.',
    1,
    '1 hour',
    NOW(),
    NOW()
),
(
    '17llgj66-gj7i-1lm5-ii3k-3ii6ik057h88',
    'd3hhdf22-cf3e-7hi1-ee9g-9ee2eg613d44',
    'Common HTML Elements',
    'Explore commonly used HTML elements such as headings, paragraphs, lists, and links.',
    2,
    '1 hour',
    NOW(),
    NOW()
),
-- Lessons for CSS Styling
(
    '28mmhk77-hk8j-2mn6-jj4l-4jj7jl168i99',
    'e4iieg33-dg4f-8ij2-ff0h-0ff3fh724e55',
    'CSS Selectors',
    'Learn how to select and style HTML elements using various CSS selectors.',
    1,
    '1 hour',
    NOW(),
    NOW()
),
(
    '39nnil88-il9k-3no7-kk5m-5kk8km279j00',
    'e4iieg33-dg4f-8ij2-ff0h-0ff3fh724e55',
    'Responsive Design',
    'Understand how to create responsive designs that work on different screen sizes.',
    2,
    '2 hours',
    NOW(),
    NOW()
)
ON CONFLICT (id) DO NOTHING;

-- Create a function to generate AI courses (can be called by the backend)
CREATE OR REPLACE FUNCTION generate_ai_course(
    p_title TEXT,
    p_description TEXT,
    p_category TEXT DEFAULT 'General',
    p_level TEXT DEFAULT 'Beginner'
) RETURNS UUID AS $$
DECLARE
    new_course_id UUID;
BEGIN
    -- Generate a new UUID for the course
    new_course_id := gen_random_uuid();
    
    -- Insert the new course
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
    ) VALUES (
        new_course_id,
        p_title,
        p_description,
        p_category,
        p_level,
        '4 weeks',
        0,
        true,
        NOW(),
        NOW()
    );
    
    RETURN new_course_id;
END;
$$ LANGUAGE plpgsql;

-- Create a function to clear mock/sample data (for when AI generates real courses)
CREATE OR REPLACE FUNCTION clear_sample_data() RETURNS VOID AS $$
BEGIN
    -- Delete sample lessons
    DELETE FROM lessons 
    WHERE module_id IN (
        SELECT id FROM modules 
        WHERE course_id IN (
            SELECT id FROM courses 
            WHERE title ILIKE '%sample%' OR title ILIKE '%test%' OR title ILIKE '%demo%'
        )
    );
    
    -- Delete sample modules
    DELETE FROM modules 
    WHERE course_id IN (
        SELECT id FROM courses 
        WHERE title ILIKE '%sample%' OR title ILIKE '%test%' OR title ILIKE '%demo%'
    );
    
    -- Delete sample courses
    DELETE FROM courses 
    WHERE title ILIKE '%sample%' OR title ILIKE '%test%' OR title ILIKE '%demo%';
    
    -- Note: In a real implementation, you might want to be more selective about what gets deleted
END;
$$ LANGUAGE plpgsql;