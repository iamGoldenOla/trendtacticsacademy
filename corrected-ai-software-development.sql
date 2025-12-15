-- Corrected Course Structure - AI Software Development Focus
-- Reflecting that Full Stack Web and Mobile App Development are AI-focused

-- Update existing courses to proper AI Software Development category
UPDATE courses 
SET 
    category = 'AI Software Development',
    level = 'beginner'
WHERE title LIKE '%Web Development%';

UPDATE courses 
SET 
    category = 'AI Software Development',
    level = 'intermediate'
WHERE title LIKE '%Mobile App Development%';

-- Insert the corrected course structure reflecting your AI Software Development expertise

-- Main Category: AI Software Development
INSERT INTO courses (title, description, category, level, duration, is_published) VALUES
  ('Full Stack AI Web Development Masterclass', 
   'Comprehensive course covering HTML, CSS, JavaScript, React, Node.js, and database integration with AI capabilities. Build intelligent web applications from scratch.',
   'AI Software Development', 'beginner', '8 weeks', true)
ON CONFLICT DO NOTHING;

INSERT INTO courses (title, description, category, level, duration, is_published) VALUES
  ('AI Mobile App Development with React Native', 
   'Build intelligent cross-platform mobile applications for iOS and Android using React Native with integrated AI features. Learn mobile UI/UX design and AI deployment.',
   'AI Software Development', 'intermediate', '10 weeks', true)
ON CONFLICT DO NOTHING;

-- Digital Marketing courses remain the same
INSERT INTO courses (title, description, category, level, duration, is_published) VALUES
  ('Complete Digital Marketing Strategy', 
   'Master all aspects of digital marketing including SEO, PPC, analytics, and campaign management. Build comprehensive marketing strategies.',
   'Digital Marketing', 'beginner', '6 weeks', true)
ON CONFLICT DO NOTHING;

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

-- Create modules structure for the AI Software Development courses
DO $$ 
DECLARE
    course_record RECORD;
    module_id UUID;
BEGIN
    -- Loop through AI Software Development courses
    FOR course_record IN 
        SELECT id, title FROM courses 
        WHERE category = 'AI Software Development' AND is_published = true
    LOOP
        -- Module 1: Fundamentals with AI Introduction
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Introduction and AI Fundamentals', 
         'Basic web/mobile concepts with AI integration foundations', 
         1, '1 week')
        ON CONFLICT DO NOTHING;
        
        -- Module 2: Core Development Skills
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Core Development and AI Implementation', 
         'Essential development techniques with AI feature integration', 
         2, '3 weeks')
        ON CONFLICT DO NOTHING;
        
        -- Module 3: Advanced AI Concepts
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Advanced AI Integration and Optimization', 
         'Advanced AI algorithms and performance optimization', 
         3, '2 weeks')
        ON CONFLICT DO NOTHING;
        
        -- Module 4: Intelligent Project Development
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Capstone AI-Powered Project', 
         'Complete intelligent application development and deployment', 
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
    
    RAISE NOTICE 'Created structured modules for all published courses with AI focus';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Could not create modules: %', SQLERRM;
END $$;

-- Create assessments for all modules with AI-focused questions
DO $$ 
DECLARE
    module_record RECORD;
BEGIN
    -- Loop through existing modules to create assessments
    FOR module_record IN 
        SELECT id, title, course_id FROM modules 
        WHERE id NOT IN (SELECT DISTINCT module_id FROM assessments WHERE module_id IS NOT NULL)
    LOOP
        -- Create a quiz assessment with AI-focused questions where applicable
        INSERT INTO assessments (module_id, title, type, questions, passing_score, attempts_allowed, time_limit, ordering) VALUES
        (module_record.id, 
         module_record.title || ' Knowledge Check', 
         'quiz',
         '[{"question": "What are the key concepts covered in this module?", "options": ["Concept A", "Concept B", "Concept C", "Concept D"], "correct": 0},
           {"question": "How does this relate to AI integration?", "options": ["Application 1", "Application 2", "Application 3", "Application 4"], "correct": 1}]'::jsonb,
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
    
    RAISE NOTICE 'Created assessments for all modules with AI focus';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Could not create assessments: %', SQLERRM;
END $$;

-- Verify the corrected organization structure
SELECT 
    category as "Main Category",
    COUNT(*) as "Number of Courses",
    STRING_AGG(title, ' | ') as "Course Titles"
FROM courses 
WHERE is_published = true
GROUP BY category
ORDER BY category;

-- Show the corrected course catalog
SELECT 
    title as "Course Title",
    category as "Category",
    level as "Level",
    duration as "Duration",
    CASE WHEN is_published THEN 'Available' ELSE 'Coming Soon' END as "Status"
FROM courses 
ORDER BY category, is_published DESC, level, title;

-- Highlight your AI Software Development expertise
SELECT 
    '🌟 YOUR AI SOFTWARE DEVELOPMENT EXPERTISE' as "Specialization",
    title as "Course",
    level as "Level",
    duration as "Time to Complete",
    '🤖 AI-Integrated Curriculum' as "Unique Feature"
FROM courses 
WHERE category = 'AI Software Development'
ORDER BY 
    CASE level 
        WHEN 'beginner' THEN 1
        WHEN 'intermediate' THEN 2
        WHEN 'advanced' THEN 3
        ELSE 4
    END,
    title;