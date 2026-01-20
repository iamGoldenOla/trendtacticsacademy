-- ADD QUIZZES TO EXISTING MODULE 8 LESSONS 2-3
-- Lessons already exist, just need to add quizzes

DO $$
DECLARE
    foundation_id UUID;
    mod8_id UUID;
    lesson2_id UUID;
    lesson3_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod8_id FROM modules WHERE course_id = foundation_id AND ordering = 8;
    
    -- Get existing lesson IDs
    SELECT id INTO lesson2_id FROM lessons WHERE module_id = mod8_id AND ordering = 2;
    SELECT id INTO lesson3_id FROM lessons WHERE module_id = mod8_id AND ordering = 3;
    
    RAISE NOTICE 'Adding quizzes to existing Module 8 lessons...';
    
    -- Delete any existing quizzes for these lessons (in case of duplicates)
    DELETE FROM quiz_questions WHERE lesson_id IN (lesson2_id, lesson3_id);
    
    -- ADD QUIZZES FOR LESSON 2: Reading Reports
    IF lesson2_id IS NOT NULL THEN
        INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
        (lesson2_id, 'What should you customize columns to show?', 
         '["Metrics aligned with your campaign objectives", "All available metrics", "Only spend and impressions", "Random metrics"]'::jsonb,
         0, 'Customize columns to show metrics relevant to your specific objectives'),
        
        (lesson2_id, 'What do breakdowns reveal?', 
         '["Performance patterns across dimensions like age, placement, device", "Only total performance", "Campaign names", "Ad creative"]'::jsonb,
         0, 'Breakdowns segment performance by dimensions to reveal patterns and opportunities'),
        
        (lesson2_id, 'What does high CTR with low conversion rate indicate?', 
         '["Creative attracts attention but landing page or offer fails to convert", "Everything is perfect", "Creative is bad", "Targeting is wrong"]'::jsonb,
         0, 'High CTR shows good creative, low conversion rate indicates post-click issues'),
        
        (lesson2_id, 'When does ad fatigue typically set in?', 
         '["When frequency exceeds 3-4 impressions per person", "After 1 impression", "After 10 impressions", "Never"]'::jsonb,
         0, 'Frequency above 3-4 typically indicates audiences are seeing ads too often'),
        
        (lesson2_id, 'Why require sufficient sample size before making decisions?', 
         '["Small samples produce unreliable results", "Facebook requires it", "It costs less", "It is easier"]'::jsonb,
         0, 'Sufficient sample size (50-100 conversions) ensures reliable, actionable insights');
        
        RAISE NOTICE 'Added 5 quizzes to Lesson 2: Reading Reports';
    END IF;
    
    -- ADD QUIZZES FOR LESSON 3: Key Metrics
    IF lesson3_id IS NOT NULL THEN
        INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
        (lesson3_id, 'What is CPM?', 
         '["Cost per 1,000 impressions", "Cost per million", "Cost per month", "Cost per metric"]'::jsonb,
         0, 'CPM measures the cost to show your ad 1,000 times'),
        
        (lesson3_id, 'What does ROAS measure?', 
         '["Return on ad spend - revenue generated per dollar spent", "Reach of ad set", "Rate of ad success", "Return on all sales"]'::jsonb,
         0, 'ROAS shows how much revenue you generate for each dollar spent on ads'),
        
        (lesson3_id, 'What does low CTR indicate?', 
         '["Creative or targeting problems", "Good performance", "High conversion rate", "Low costs"]'::jsonb,
         0, 'Low CTR suggests your ad is not resonating with your audience'),
        
        (lesson3_id, 'How are CPC, CPM, and CTR related?', 
         '["CPC = CPM / (CTR × 10)", "No relationship", "CPC = CPM × CTR", "CPC = CPM + CTR"]'::jsonb,
         0, 'CPC depends on both CPM (auction cost) and CTR (ad relevance)'),
        
        (lesson3_id, 'What does conversion rate measure?', 
         '["Percentage of clicks that convert", "Total conversions", "Cost per conversion", "Click-through rate"]'::jsonb,
         0, 'Conversion rate shows how well your landing page converts traffic into results');
        
        RAISE NOTICE 'Added 5 quizzes to Lesson 3: Key Metrics';
    END IF;
    
    RAISE NOTICE '======================';
    RAISE NOTICE 'MODULE 8 QUIZZES COMPLETE!';
    RAISE NOTICE 'All 3 Module 8 lessons now have 5 quizzes each';
    RAISE NOTICE '======================';
    
END $$;
