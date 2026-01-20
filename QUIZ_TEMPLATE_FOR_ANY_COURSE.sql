-- ==========================================
-- QUIZ TEMPLATE FOR ANY COURSE
-- Replace [COURSE_NAME] with actual course title
-- This generates 5 quizzes per lesson automatically
-- ==========================================

-- Step 1: Ensure quizzes table exists
CREATE TABLE IF NOT EXISTS quizzes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lesson_id UUID REFERENCES lessons(id) ON DELETE CASCADE,
    question TEXT NOT NULL,
    options JSONB NOT NULL,
    correct_answer TEXT NOT NULL,
    explanation TEXT,
    ordering INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_quizzes_lesson_id ON quizzes(lesson_id);

-- Step 2: Insert quizzes for ALL lessons in the course
DO $$
DECLARE
    lesson_record RECORD;
    course_name TEXT := 'YOUR_COURSE_NAME_HERE'; -- ⭐ CHANGE THIS
BEGIN
    -- Loop through all lessons in the specified course
    FOR lesson_record IN 
        SELECT l.id, l.title, m.title as module_title
        FROM lessons l
        JOIN modules m ON l.module_id = m.id
        JOIN courses c ON m.course_id = c.id
        WHERE c.title LIKE '%' || course_name || '%'
        ORDER BY m.ordering, l.ordering
    LOOP
        -- Insert 5 quiz questions for each lesson
        
        -- Question 1: Core concept understanding
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What is the main focus of "' || lesson_record.title || '"?',
            '["Understanding core concepts", "Memorizing definitions", "Skipping fundamentals", "Ignoring best practices"]'::jsonb,
            'Understanding core concepts',
            'This lesson focuses on mastering fundamental concepts and principles.',
            1
        );
        
        -- Question 2: Practical application
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'How should you apply the techniques from "' || lesson_record.title || '"?',
            '["Practice with real examples and iterate", "Only study theory", "Skip hands-on practice", "Avoid experimentation"]'::jsonb,
            'Practice with real examples and iterate',
            'Hands-on practice and iteration are essential for mastering these concepts.',
            2
        );
        
        -- Question 3: Best practices
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What is a key best practice when working with "' || lesson_record.title || '"?',
            '["Start with clear objectives and test systematically", "Rush without planning", "Ignore documentation", "Skip validation"]'::jsonb,
            'Start with clear objectives and test systematically',
            'Clear goals and systematic testing lead to better results.',
            3
        );
        
        -- Question 4: Common mistakes
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What should you avoid when implementing concepts from "' || lesson_record.title || '"?',
            '["Being unclear or inconsistent", "Following best practices", "Testing thoroughly", "Learning from mistakes"]'::jsonb,
            'Being unclear or inconsistent',
            'Clarity and consistency are crucial for successful implementation.',
            4
        );
        
        -- Question 5: Advanced understanding
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What is the key to mastering the techniques in "' || lesson_record.title || '"?',
            '["Continuous practice and learning", "One-time study only", "Avoiding challenges", "Ignoring feedback"]'::jsonb,
            'Continuous practice and learning',
            'Mastery comes through consistent practice, experimentation, and learning from results.',
            5
        );
        
    END LOOP;
    
    RAISE NOTICE 'Successfully added quizzes for course: %', course_name;
END $$;

-- Step 3: Verify quizzes were created
SELECT 
    c.title as course,
    m.title as module,
    l.title as lesson,
    COUNT(q.id) as quiz_count
FROM courses c
JOIN modules m ON m.course_id = c.id
JOIN lessons l ON l.module_id = m.id
LEFT JOIN quizzes q ON q.lesson_id = l.id
WHERE c.title LIKE '%YOUR_COURSE_NAME_HERE%' -- ⭐ CHANGE THIS
GROUP BY c.title, m.title, l.title, m.ordering, l.ordering
ORDER BY m.ordering, l.ordering;

-- Expected result: All lessons should show quiz_count = 5
