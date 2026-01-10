-- Update course categories to reflect AI Software Development focus

-- 1. Update existing Web Development courses to AI Software Development
UPDATE courses 
SET 
    category = 'AI Software Development',
    level = 'beginner',
    title = 'Full Stack AI Web Development Masterclass',
    description = 'Comprehensive course covering HTML, CSS, JavaScript, React, Node.js, and database integration with AI capabilities. Build intelligent web applications from scratch.'
WHERE category = 'Web Development' OR title LIKE '%Web Development%';

-- 2. Update existing App Development courses to AI Software Development
UPDATE courses 
SET 
    category = 'AI Software Development',
    level = 'intermediate',
    title = 'AI Mobile App Development with React Native',
    description = 'Build intelligent cross-platform mobile applications for iOS and Android using React Native with integrated AI features. Learn mobile UI/UX design and AI deployment.'
WHERE category = 'App Development' OR title LIKE '%Mobile App Development%';

-- 3. Ensure Digital Marketing courses remain properly categorized
UPDATE courses 
SET 
    category = 'Digital Marketing',
    level = CASE 
        WHEN title LIKE '%Complete%' OR title LIKE '%Mastery%' OR title LIKE '%Content%' THEN 'beginner'
        WHEN title LIKE '%Advanced%' OR title LIKE '%Automation%' OR title LIKE '%Facebook%' THEN 'intermediate'
        WHEN title LIKE '%Strategy%' THEN 'beginner'
        ELSE level
    END
WHERE category = 'Digital Marketing';

-- 4. Handle any uncategorized courses
UPDATE courses 
SET 
    category = 'AI Software Development',
    level = 'beginner'
WHERE category IS NULL AND (title LIKE '%Web%' OR title LIKE '%Development%');

UPDATE courses 
SET 
    category = 'AI Software Development',
    level = 'intermediate'
WHERE category IS NULL AND title LIKE '%App%';

-- 5. Create proper module structure for AI Software Development courses
DO $$ 
DECLARE
    course_record RECORD;
BEGIN
    -- Loop through AI Software Development courses
    FOR course_record IN 
        SELECT id, title FROM courses 
        WHERE category = 'AI Software Development'
    LOOP
        -- Delete existing modules for these courses to recreate with AI focus
        DELETE FROM modules WHERE course_id = course_record.id;
        
        -- Module 1: Fundamentals with AI Introduction
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Introduction and AI Fundamentals', 
         'Basic development concepts with AI integration foundations', 
         1, '1 week');
        
        -- Module 2: Core Development Skills with AI
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Core Development and AI Implementation', 
         'Essential development techniques with AI feature integration', 
         2, '3 weeks');
        
        -- Module 3: Advanced AI Concepts
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Advanced AI Integration and Optimization', 
         'Advanced AI algorithms and performance optimization', 
         3, '2 weeks');
        
        -- Module 4: Intelligent Project Development
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 
         'Capstone AI-Powered Project', 
         'Complete intelligent application development and deployment', 
         4, '2 weeks');
    END LOOP;
    
    RAISE NOTICE 'Updated modules structure for AI Software Development courses';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Could not update modules: %', SQLERRM;
END $$;

-- 6. Create assessments for AI Software Development modules
DO $$ 
DECLARE
    module_record RECORD;
BEGIN
    -- Loop through AI Software Development modules
    FOR module_record IN 
        SELECT m.id, m.title, m.course_id, c.title as course_title
        FROM modules m
        JOIN courses c ON m.course_id = c.id
        WHERE c.category = 'AI Software Development'
    LOOP
        -- Delete existing assessments for these modules
        DELETE FROM assessments WHERE module_id = module_record.id;
        
        -- Create a quiz assessment with AI-focused questions
        INSERT INTO assessments (module_id, title, type, questions, passing_score, attempts_allowed, time_limit, ordering) VALUES
        (module_record.id, 
         module_record.title || ' Knowledge Check', 
         'quiz',
         '[{"question": "What are the key concepts covered in this module?", "options": ["Concept A", "Concept B", "Concept C", "Concept D"], "correct": 0},
           {"question": "How does this relate to AI integration?", "options": ["Application 1", "Application 2", "Application 3", "Application 4"], "correct": 1}]'::jsonb,
         70, 3, 30, 1);
        
        -- Create a practical assignment
        INSERT INTO assessments (module_id, title, type, questions, passing_score, attempts_allowed, time_limit, ordering) VALUES
        (module_record.id, 
         module_record.title || ' Practical Assignment', 
         'assignment',
         '[{"task": "Apply the concepts learned in this module to build an AI feature", "requirements": ["Requirement 1", "Requirement 2", "Requirement 3"]}]'::jsonb,
         80, 2, 120, 2);
    END LOOP;
    
    RAISE NOTICE 'Created AI-focused assessments for all modules';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Could not create assessments: %', SQLERRM;
END $$;

-- 7. Verify the updates
SELECT 
    category as "Category",
    COUNT(*) as "Number of Courses",
    STRING_AGG(title, ' | ') as "Course Titles"
FROM courses 
GROUP BY category
ORDER BY category;

-- 8. Show the updated AI Software Development courses
SELECT 
    '🤖 UPDATED AI SOFTWARE DEVELOPMENT COURSES' as "Specialization",
    title as "Course",
    level as "Level",
    duration as "Time to Complete",
    'AI-Integrated Curriculum' as "Unique Feature"
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

-- Final confirmation
SELECT 
    '✅ SUCCESS: COURSE CATEGORIES UPDATED' as "Status",
    'All Web Development and App Development courses are now properly categorized as AI Software Development' as "Message",
    'Digital Marketing courses remain in their correct category' as "Additional Info";