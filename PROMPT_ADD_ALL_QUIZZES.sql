-- ==========================================
-- PROMPT ENGINEERING MASTERY - ADD ALL QUIZZES
-- Automated quiz generation for all 27 lessons
-- 5 questions per lesson = 135 total quizzes
-- ==========================================

-- Step 1: Ensure quizzes table exists (should already exist from Vibe Coding)
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

-- Step 2: Insert quizzes for ALL Prompt Engineering lessons
DO $$
DECLARE
    lesson_record RECORD;
BEGIN
    -- Loop through all Prompt Engineering lessons
    FOR lesson_record IN 
        SELECT l.id, l.title, m.title as module_title
        FROM lessons l
        JOIN modules m ON l.module_id = m.id
        JOIN courses c ON m.course_id = c.id
        WHERE c.title LIKE '%Prompt%Engineering%'
        ORDER BY m.ordering, l.ordering
    LOOP
        -- Insert 5 quiz questions for each lesson
        
        -- Question 1: Core concept understanding
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What is the main focus of "' || lesson_record.title || '"?',
            '["Understanding core prompt engineering concepts", "Memorizing AI model architectures", "Learning programming syntax", "Database management"]'::jsonb,
            'Understanding core prompt engineering concepts',
            'This lesson focuses on mastering fundamental prompt engineering principles and techniques.',
            1
        );
        
        -- Question 2: Practical application
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'How should you apply the techniques from "' || lesson_record.title || '"?',
            '["Practice with real AI models and iterate", "Only study theory without practice", "Memorize example prompts", "Avoid experimentation"]'::jsonb,
            'Practice with real AI models and iterate',
            'Hands-on practice and iteration are essential for mastering prompt engineering.',
            2
        );
        
        -- Question 3: Best practices
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What is a key best practice when working with the concepts in "' || lesson_record.title || '"?',
            '["Start with clear objectives and test systematically", "Use the longest prompts possible", "Avoid providing context", "Copy prompts without understanding"]'::jsonb,
            'Start with clear objectives and test systematically',
            'Clear goals and systematic testing lead to better prompt engineering results.',
            3
        );
        
        -- Question 4: Common mistakes
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What should you avoid when implementing concepts from "' || lesson_record.title || '"?',
            '["Being vague or ambiguous in prompts", "Providing clear instructions", "Testing different approaches", "Iterating based on results"]'::jsonb,
            'Being vague or ambiguous in prompts',
            'Clarity and specificity are crucial in effective prompt engineering.',
            4
        );
        
        -- Question 5: Advanced understanding
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What is the key to mastering the techniques in "' || lesson_record.title || '"?',
            '["Continuous practice and experimentation", "Reading documentation only", "Using the same prompt for everything", "Avoiding AI interaction"]'::jsonb,
            'Continuous practice and experimentation',
            'Mastery comes through consistent practice, experimentation, and learning from results.',
            5
        );
        
    END LOOP;
END $$;

-- Step 3: Verify all quizzes were created
SELECT 
    c.title as course,
    m.title as module,
    l.title as lesson,
    COUNT(q.id) as quiz_count
FROM courses c
JOIN modules m ON m.course_id = c.id
JOIN lessons l ON l.module_id = m.id
LEFT JOIN quizzes q ON q.lesson_id = l.id
WHERE c.title LIKE '%Prompt%Engineering%'
GROUP BY c.title, m.title, l.title, m.ordering, l.ordering
ORDER BY m.ordering, l.ordering;

-- Expected result: All lessons should show quiz_count = 5
