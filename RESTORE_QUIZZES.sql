-- RESTORE QUIZZES FOR LESSON 1
-- The quizzes were accidentally deleted, this restores them

DO $$
DECLARE
    foundation_id UUID;
    mod1_id UUID;
    lesson1_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod1_id FROM modules WHERE course_id = foundation_id AND ordering = 1;
    SELECT id INTO lesson1_id FROM lessons WHERE module_id = mod1_id AND ordering = 1;
    
    RAISE NOTICE 'Restoring 5 quiz questions for Lesson 1...';
    
    -- Delete any existing quizzes first
    DELETE FROM quiz_questions WHERE lesson_id = lesson1_id;
    
    -- Insert 5 quiz questions
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson1_id, 
     'What are the three hierarchical levels in Meta Ads Manager campaign structure?',
     '["Campaigns, Ad Sets, Ads", "Campaigns, Budgets, Creatives", "Objectives, Audiences, Placements", "Accounts, Campaigns, Ads"]'::jsonb,
     0,
     'The three-tier structure consists of Campaigns (objectives), Ad Sets (targeting and budget), and Ads (creative)'),
    
    (lesson1_id,
     'Which metric shows the percentage of people who clicked your ad after seeing it?',
     '["Click-Through Rate (CTR)", "Cost Per Click (CPC)", "Cost Per Mille (CPM)", "Return on Ad Spend (ROAS)"]'::jsonb,
     0,
     'CTR is calculated as (Clicks ÷ Impressions) × 100 and indicates ad engagement'),
    
    (lesson1_id,
     'At which level do you define your target audience in Meta Ads Manager?',
     '["Ad Set Level", "Campaign Level", "Ad Level", "Account Level"]'::jsonb,
     0,
     'Audience targeting, budget, and schedule are all defined at the Ad Set level'),
    
    (lesson1_id,
     'What does ROAS measure in advertising performance?',
     '["Revenue generated per dollar spent on ads", "Total ad impressions", "Click-through rate", "Cost per thousand impressions"]'::jsonb,
     0,
     'ROAS (Return on Ad Spend) = Revenue ÷ Ad Spend, showing profitability'),
    
    (lesson1_id,
     'Why is the three-tier campaign structure important for advertisers?',
     '["It provides granular control while maintaining organizational clarity", "It is required by Facebook", "It reduces advertising costs", "It automatically optimizes campaigns"]'::jsonb,
     0,
     'The structure separates objectives, targeting, and creative for better organization and testing');
    
    RAISE NOTICE '5 quiz questions restored successfully!';
    
END $$;

-- Verify
SELECT 
    'Lesson 1 Quiz Status' as status,
    COUNT(*) as quiz_count
FROM quiz_questions q
JOIN lessons l ON q.lesson_id = l.id
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation' AND m.ordering = 1 AND l.ordering = 1;

-- Show all quizzes
SELECT 
    ROW_NUMBER() OVER (ORDER BY q.id) as quiz_number,
    LEFT(question, 60) as question_preview,
    correct_answer
FROM quiz_questions q
JOIN lessons l ON q.lesson_id = l.id
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation' AND m.ordering = 1 AND l.ordering = 1;
