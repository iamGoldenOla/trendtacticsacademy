-- Course Organization Structure for Trendtactics Academy
-- Organizing courses by main categories and subcategories

-- First, let's update existing courses with proper categorization
UPDATE courses 
SET 
    category = 'Software Development',
    level = 'beginner'
WHERE title LIKE '%Web Development%' OR title LIKE '%App Development%';

UPDATE courses 
SET 
    category = 'Digital Marketing',
    level = 'beginner'
WHERE title LIKE '%Digital Marketing%' OR title LIKE '%Marketing%';

-- Insert the complete course structure reflecting your offerings

-- Main Category: Software Development
INSERT INTO courses (title, description, category, level, duration, is_published) VALUES
  ('Full Stack Web Development Masterclass', 
   'Comprehensive course covering HTML, CSS, JavaScript, React, Node.js, and database integration. Build real-world web applications from scratch.',
   'Software Development', 'beginner', '8 weeks', true)
ON CONFLICT DO NOTHING;

INSERT INTO courses (title, description, category, level, duration, is_published) VALUES
  ('Mobile App Development with React Native', 
   'Build cross-platform mobile applications for iOS and Android using React Native. Learn mobile UI/UX design and deployment.',
   'Software Development', 'intermediate', '10 weeks', true)
ON CONFLICT DO NOTHING;

-- Sub-category under Software Development: AI Development (future expansion)
INSERT INTO courses (title, description, category, level, duration, is_published) VALUES
  ('AI Software Development Fundamentals', 
   'Introduction to artificial intelligence concepts and implementation. Covers machine learning basics, neural networks, and AI integration in applications.',
   'Software Development', 'advanced', '12 weeks', false)
ON CONFLICT DO NOTHING;

-- Main Category: Digital Marketing
INSERT INTO courses (title, description, category, level, duration, is_published) VALUES
  ('Complete Digital Marketing Strategy', 
   'Master all aspects of digital marketing including SEO, PPC, analytics, and campaign management. Build comprehensive marketing strategies.',
   'Digital Marketing', 'beginner', '6 weeks', true)
ON CONFLICT DO NOTHING;

-- Sub-categories under Digital Marketing
INSERT INTO courses (title, description, category, level, duration, is_published) VALUES
  ('Advanced Email Marketing Automation', 
   'Create automated email campaigns, segmentation strategies, and conversion optimization. Learn advanced tools and analytics.',
   'Digital Marketing', 'intermediate', '4 weeks', true)
ON CONFLICT DO NOTHING;

INSERT INTO courses (title, description, category, level, duration, is_published) VALUES
  ('Social Media Marketing Mastery', 
   'Master social media platforms including Instagram, LinkedIn, Twitter, and TikTok. Learn content strategy and community management.',
   'Digital Marketing', 'beginner', '5 weeks', true)
ON CONFLICT DO NOTHING;

INSERT INTO courses (title, description, category, level, duration, is_published) VALUES
  ('Content Creation for Digital Marketing', 
   'Develop compelling content for all digital channels. Learn copywriting, video production, and graphic design for marketing.',
   'Digital Marketing', 'beginner', '6 weeks', true)
ON CONFLICT DO NOTHING;

INSERT INTO courses (title, description, category, level, duration, is_published) VALUES
  ('Facebook Ads & Meta Advertising', 
   'Master Facebook and Instagram advertising. Learn ad creation, targeting, budgeting, and campaign optimization.',
   'Digital Marketing', 'intermediate', '4 weeks', true)
ON CONFLICT DO NOTHING;

-- Create modules structure for the main courses
DO $$ 
DECLARE
    course_record RECORD;
    module_id UUID;
BEGIN
    -- Loop through Software Development courses
    FOR course_record IN 
        SELECT id, title FROM courses 
        WHERE category = 'Software Development' AND is_published = true
    LOOP
        -- Module 1: Fundamentals
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Introduction and Fundamentals', 
         'Basic concepts, setup, and foundational knowledge', 
         1, '1 week')
        ON CONFLICT DO NOTHING;
        
        -- Module 2: Core Skills
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Core Development Skills', 
         'Essential techniques and best practices', 
         2, '3 weeks')
        ON CONFLICT DO NOTHING;
        
        -- Module 3: Advanced Concepts
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Advanced Topics and Optimization', 
         'Advanced skills and performance optimization', 
         3, '2 weeks')
        ON CONFLICT DO NOTHING;
        
        -- Module 4: Project Development
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Capstone Project', 
         'Complete project development and deployment', 
         4, '2 weeks')
        ON CONFLICT DO NOTHING;
    END LOOP;
    
    -- Loop through Digital Marketing courses
    FOR course_record IN 
        SELECT id, title FROM courses 
        WHERE category = 'Digital Marketing' AND is_published = true
    LOOP
        -- Module 1: Foundation
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Marketing Fundamentals', 
         'Basic concepts and market analysis', 
         1, '1 week')
        ON CONFLICT DO NOTHING;
        
        -- Module 2: Strategy Development
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Strategy and Planning', 
         'Campaign planning and audience targeting', 
         2, '2 weeks')
        ON CONFLICT DO NOTHING;
        
        -- Module 3: Implementation
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Execution and Tools', 
         'Using marketing tools and platforms', 
         3, '2 weeks')
        ON CONFLICT DO NOTHING;
        
        -- Module 4: Analytics and Optimization
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Performance Analysis', 
         'Measuring success and optimization techniques', 
         4, '1 week')
        ON CONFLICT DO NOTHING;
    END LOOP;
    
    RAISE NOTICE 'Created structured modules for all published courses';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Could not create modules: %', SQLERRM;
END $$;

-- Create assessments for all modules
DO $$ 
DECLARE
    module_record RECORD;
BEGIN
    -- Loop through existing modules to create assessments
    FOR module_record IN 
        SELECT id, title, course_id FROM modules 
        WHERE id NOT IN (SELECT DISTINCT module_id FROM assessments WHERE module_id IS NOT NULL)
    LOOP
        -- Create a quiz assessment
        INSERT INTO assessments (module_id, title, type, questions, passing_score, attempts_allowed, time_limit, ordering) VALUES
        (module_record.id, 
         module_record.title || ' Knowledge Check', 
         'quiz',
         '[{"question": "What are the key concepts covered in this module?", "options": ["Concept A", "Concept B", "Concept C", "Concept D"], "correct": 0},
           {"question": "Which technique is most important for practical application?", "options": ["Technique 1", "Technique 2", "Technique 3", "Technique 4"], "correct": 1}]'::jsonb,
         70, 3, 30, 1)
        ON CONFLICT DO NOTHING;
        
        -- Create a practical assignment
        INSERT INTO assessments (module_id, title, type, questions, passing_score, attempts_allowed, time_limit, ordering) VALUES
        (module_record.id, 
         module_record.title || ' Practical Assignment', 
         'assignment',
         '[{"task": "Apply the concepts learned in this module to a real-world scenario", "requirements": ["Requirement 1", "Requirement 2", "Requirement 3"]}]'::jsonb,
         80, 2, 120, 2)
        ON CONFLICT DO NOTHING;
    END LOOP;
    
    RAISE NOTICE 'Created assessments for all modules';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Could not create assessments: %', SQLERRM;
END $$;

-- Verify the organization structure
SELECT 
    category as "Main Category",
    COUNT(*) as "Number of Courses",
    STRING_AGG(title, ' | ') as "Course Titles"
FROM courses 
WHERE is_published = true
GROUP BY category
ORDER BY category;

-- Show the complete course catalog
SELECT 
    title as "Course Title",
    category as "Category",
    level as "Level",
    duration as "Duration",
    CASE WHEN is_published THEN 'Available' ELSE 'Coming Soon' END as "Status"
FROM courses 
ORDER BY category, is_published DESC, title;