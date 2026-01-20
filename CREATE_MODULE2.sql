-- FACEBOOK ADS FOUNDATION - MODULE 2: AUDIENCE & TARGETING MASTERY
-- 5 comprehensive lessons with case studies and quizzes

DO $$
DECLARE
    foundation_id UUID;
    mod2_id UUID;
    lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    
    -- Create Module 2
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (
        foundation_id,
        'Audience & Targeting Mastery',
        'Master advanced audience targeting strategies to reach your ideal customers',
        2
    )
    RETURNING id INTO mod2_id;
    
    RAISE NOTICE 'Module 2 created: %', mod2_id;
    RAISE NOTICE 'Creating 5 lessons for Module 2...';
    
    -- This file will be split into multiple parts due to size
    -- Part 1: Lessons 1-2
    
    RAISE NOTICE 'Module 2 structure created. Lessons will be added in separate files.';
    
END $$;

-- Verify module created
SELECT 
    m.ordering,
    m.title,
    m.description
FROM modules m
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation'
ORDER BY m.ordering;
