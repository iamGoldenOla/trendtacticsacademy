-- ==========================================
-- FACEBOOK ADS MASTERY - ADD ALL QUIZZES
-- Automated quiz generation for all 27 lessons
-- 5 questions per lesson = 135 total quizzes
-- ==========================================

-- Ensure quizzes table exists
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

-- Insert quizzes for ALL Facebook Ads Mastery lessons
DO $$
DECLARE
    lesson_record RECORD;
BEGIN
    -- Loop through all Facebook Ads Mastery lessons
    FOR lesson_record IN 
        SELECT l.id, l.title, m.title as module_title
        FROM lessons l
        JOIN modules m ON l.module_id = m.id
        JOIN courses c ON m.course_id = c.id
        WHERE c.title LIKE '%Facebook%Ads%Mastery%'
        ORDER BY m.ordering, l.ordering
    LOOP
        -- Insert 5 quiz questions for each lesson
        
        -- Question 1: Advanced concept
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What advanced concept is covered in "' || lesson_record.title || '"?',
            '["Mastery-level Facebook Ads strategies", "Basic social media posting", "General marketing theory", "Website design fundamentals"]'::jsonb,
            'Mastery-level Facebook Ads strategies',
            'This lesson focuses on advanced, professional-level Facebook advertising techniques.',
            1
        );
        
        -- Question 2: Strategic application
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'How should you apply the advanced techniques from "' || lesson_record.title || '"?',
            '["Implement strategically with data-driven decisions", "Apply randomly without testing", "Ignore performance metrics", "Use only basic approaches"]'::jsonb,
            'Implement strategically with data-driven decisions',
            'Advanced techniques require strategic implementation and continuous data analysis.',
            2
        );
        
        -- Question 3: Professional best practices
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What is a professional best practice for "' || lesson_record.title || '"?',
            '["Systematic testing and optimization at scale", "Set campaigns and never review", "Maximize budget without strategy", "Ignore industry benchmarks"]'::jsonb,
            'Systematic testing and optimization at scale',
            'Professional advertisers use systematic approaches to test, measure, and optimize continuously.',
            3
        );
        
        -- Question 4: Advanced pitfalls
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What advanced mistake should you avoid with "' || lesson_record.title || '"?',
            '["Over-optimizing without sufficient data", "Testing multiple variables", "Monitoring key metrics", "Following proven frameworks"]'::jsonb,
            'Over-optimizing without sufficient data',
            'Advanced advertisers know to wait for statistical significance before making optimization decisions.',
            4
        );
        
        -- Question 5: Mastery-level insight
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What separates mastery-level execution of "' || lesson_record.title || '"?',
            '["Strategic thinking combined with tactical excellence", "Following basic tutorials only", "Avoiding advanced features", "Ignoring business objectives"]'::jsonb,
            'Strategic thinking combined with tactical excellence',
            'Mastery requires both high-level strategic thinking and flawless tactical execution.',
            5
        );
        
    END LOOP;
END $$;

-- Verify quizzes were created
SELECT 
    c.title as course,
    m.title as module,
    l.title as lesson,
    COUNT(q.id) as quiz_count
FROM courses c
JOIN modules m ON m.course_id = c.id
JOIN lessons l ON l.module_id = m.id
LEFT JOIN quizzes q ON q.lesson_id = l.id
WHERE c.title LIKE '%Facebook%Ads%Mastery%'
GROUP BY c.title, m.title, l.title, m.ordering, l.ordering
ORDER BY m.ordering, l.ordering;
