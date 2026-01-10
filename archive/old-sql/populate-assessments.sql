-- Populate assessments table with sample data

-- First, let's check if we have modules to link assessments to
SELECT id, title, course_id FROM modules LIMIT 5;

-- If no modules exist, let's create some sample modules first
DO $$ 
DECLARE
    course_record RECORD;
    module_id UUID;
BEGIN
    -- Loop through existing courses to create modules
    FOR course_record IN SELECT id, title FROM courses LOOP
        -- Create Module 1
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 'Introduction to ' || course_record.title, 
         'Basic concepts and fundamentals', 1, '1 week')
        ON CONFLICT DO NOTHING;
        
        -- Create Module 2
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 'Core Concepts of ' || course_record.title, 
         'Essential skills and techniques', 2, '2 weeks')
        ON CONFLICT DO NOTHING;
        
        -- Create Module 3
        INSERT INTO modules (course_id, title, description, ordering, duration) VALUES
        (course_record.id, 'Advanced ' || course_record.title, 
         'Advanced topics and mastery', 3, '1 week')
        ON CONFLICT DO NOTHING;
    END LOOP;
    
    RAISE NOTICE 'Created sample modules for all courses';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Could not create modules: %', SQLERRM;
END $$;

-- Now populate assessments for each module
DO $$ 
DECLARE
    module_record RECORD;
BEGIN
    -- Loop through existing modules to create assessments
    FOR module_record IN SELECT id, title, course_id FROM modules LOOP
        -- Create a quiz assessment
        INSERT INTO assessments (module_id, title, type, questions, passing_score, attempts_allowed, time_limit, ordering) VALUES
        (module_record.id, 
         module_record.title || ' Quiz', 
         'quiz',
         '[{"question": "What is the main concept covered in this module?", "options": ["Option A", "Option B", "Option C", "Option D"], "correct": 1},
           {"question": "Which technique is most important?", "options": ["Technique 1", "Technique 2", "Technique 3", "Technique 4"], "correct": 2}]'::jsonb,
         70, 3, 30, 1)
        ON CONFLICT DO NOTHING;
        
        -- Create an assignment assessment
        INSERT INTO assessments (module_id, title, type, questions, passing_score, attempts_allowed, time_limit, ordering) VALUES
        (module_record.id, 
         module_record.title || ' Assignment', 
         'assignment',
         '[{"task": "Complete the practical exercise described in the module", "requirements": ["Requirement 1", "Requirement 2", "Requirement 3"]}]'::jsonb,
         80, 2, 120, 2)
        ON CONFLICT DO NOTHING;
    END LOOP;
    
    RAISE NOTICE 'Created assessments for all modules';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Could not create assessments: %', SQLERRM;
END $$;

-- Verify the assessments were created
SELECT COUNT(*) as total_assessments FROM assessments;

-- Show sample assessments
SELECT a.title, a.type, m.title as module_title, c.title as course_title
FROM assessments a
JOIN modules m ON a.module_id = m.id
JOIN courses c ON m.course_id = c.id
LIMIT 10;