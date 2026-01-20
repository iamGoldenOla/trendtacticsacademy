-- ==========================================
-- FACEBOOK ADS FOUNDATION - ADD ALL QUIZZES
-- Automated quiz generation for all lessons
-- 5 questions per lesson
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

-- Insert quizzes for ALL Facebook Ads Foundation lessons
DO $$
DECLARE
    lesson_record RECORD;
BEGIN
    -- Loop through all Facebook Ads Foundation lessons
    FOR lesson_record IN 
        SELECT l.id, l.title, m.title as module_title
        FROM lessons l
        JOIN modules m ON l.module_id = m.id
        JOIN courses c ON m.course_id = c.id
        WHERE c.title LIKE '%Facebook%Ads%Foundation%'
        ORDER BY m.ordering, l.ordering
    LOOP
        -- Insert 5 quiz questions for each lesson
        
        -- Question 1: Core concept
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What is the main focus of "' || lesson_record.title || '"?',
            '["Understanding Facebook Ads fundamentals", "Advanced coding techniques", "Email marketing only", "SEO optimization"]'::jsonb,
            'Understanding Facebook Ads fundamentals',
            'This lesson focuses on core Facebook advertising concepts and best practices.',
            1
        );
        
        -- Question 2: Practical application
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'How should you apply the concepts from "' || lesson_record.title || '"?',
            '["Practice in Ads Manager with real campaigns", "Only read theory", "Skip testing", "Ignore metrics"]'::jsonb,
            'Practice in Ads Manager with real campaigns',
            'Hands-on practice with actual campaigns is essential for mastering Facebook Ads.',
            2
        );
        
        -- Question 3: Best practices
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What is a key best practice for "' || lesson_record.title || '"?',
            '["Test systematically and measure results", "Set and forget campaigns", "Ignore audience targeting", "Use maximum budget immediately"]'::jsonb,
            'Test systematically and measure results',
            'Systematic testing and data-driven optimization are fundamental to Facebook Ads success.',
            3
        );
        
        -- Question 4: Common mistakes
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What should you avoid when implementing "' || lesson_record.title || '"?',
            '["Poor targeting and unclear objectives", "Testing different audiences", "Monitoring performance", "Following best practices"]'::jsonb,
            'Poor targeting and unclear objectives',
            'Clear objectives and proper targeting are essential for campaign success.',
            4
        );
        
        -- Question 5: Key takeaway
        INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering)
        VALUES (
            lesson_record.id,
            'What is the key to success with "' || lesson_record.title || '"?',
            '["Continuous learning and optimization", "One-time setup only", "Ignoring analytics", "Random experimentation"]'::jsonb,
            'Continuous learning and optimization',
            'Facebook Ads success requires ongoing learning, testing, and optimization based on data.',
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
WHERE c.title LIKE '%Facebook%Ads%Foundation%'
GROUP BY c.title, m.title, l.title, m.ordering, l.ordering
ORDER BY m.ordering, l.ordering;
