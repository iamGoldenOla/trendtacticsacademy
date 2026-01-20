-- ==========================================
-- COMPLETE VIBE CODING QUIZ SYSTEM
-- Automated quiz generation for all 28 lessons
-- 5 questions per lesson = 140 total quizzes
-- ==========================================

-- Step 1: Create quizzes table if it doesn't exist
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

-- Step 2: Insert generic but relevant quizzes for ALL Vibe Coding lessons
-- This uses a DO block to iterate through all lessons

DO $$
DECLARE
    lesson_record RECORD;
BEGIN
    -- Loop through all Vibe Coding lessons
    FOR lesson_record IN 
        SELECT l.id, l.title, m.title as module_title
        FROM lessons l
        JOIN modules m ON l.module_id = m.id
        JOIN courses c ON m.course_id = c.id
        WHERE c.title LIKE '%Vibe Coding%'
        ORDER BY m.ordering, l.ordering
    LOOP
        -- Insert 5 quiz questions for each lesson
        
        -- Question 1: Understanding core concept
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What is the main focus of this lesson: ' || lesson_record.title || '?',
            '["Understanding the core concept", "Memorizing syntax", "Installing software", "Debugging only"]'::jsonb,
            'Understanding the core concept',
            'This lesson focuses on understanding the fundamental concepts presented.',
            1
        );
        
        -- Question 2: Practical application
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'How should you apply the concepts from ' || lesson_record.title || '?',
            '["In real-world projects", "Only in theory", "Never apply them", "Only in tests"]'::jsonb,
            'In real-world projects',
            'The best way to learn is by applying concepts to actual projects.',
            2
        );
        
        -- Question 3: Best practices
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What is a best practice when working with the topics in ' || lesson_record.title || '?',
            '["Start with clear goals and iterate", "Rush to completion", "Skip planning", "Avoid testing"]'::jsonb,
            'Start with clear goals and iterate',
            'Clear goals and iterative development lead to better outcomes.',
            3
        );
        
        -- Question 4: Common mistakes
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What should you avoid when implementing concepts from ' || lesson_record.title || '?',
            '["Skipping the fundamentals", "Taking time to understand", "Asking questions", "Testing your work"]'::jsonb,
            'Skipping the fundamentals',
            'Understanding fundamentals is crucial before moving to advanced topics.',
            4
        );
        
        -- Question 5: Key takeaway
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What is the key takeaway from ' || lesson_record.title || '?',
            '["Master the concepts through practice", "Memorize everything", "Skip to next lesson", "Theory is enough"]'::jsonb,
            'Master the concepts through practice',
            'Practical application and hands-on practice solidify learning.',
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
WHERE c.title LIKE '%Vibe Coding%'
GROUP BY c.title, m.title, l.title, m.ordering, l.ordering
ORDER BY m.ordering, l.ordering;

-- Expected result: All lessons should show quiz_count = 5

-- ==========================================
-- INSTRUCTIONS
-- ==========================================
-- 1. Run this entire script in Supabase SQL Editor
-- 2. It will automatically create 5 quizzes for each lesson
-- 3. Verify using the SELECT query at the end
-- 4. All 28 lessons should have 5 quizzes each (140 total)
-- ==========================================
