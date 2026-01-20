-- ============================================================================
-- MASTER FORCE FIX V3: Constraint Fix (Lowercase) + Content Injection
-- ============================================================================
-- FIX: Changed 'Beginner' to 'beginner' (lowercase) to satisfy constraint.
-- ============================================================================

-- Target Course ID: 123e4567-e89b-12d3-a456-426614174001

-- PART 1: UPDATE COURSE DETAILS
-- ========================================================
UPDATE courses 
SET 
    title = 'Prompt Engineering Mastery',
    description = 'Master the art of communicating with AI. From basic prompts to advanced agentic workflows.',
    status = 'published',
    level = 'beginner', -- FIX: Lowercase to match check constraint
    category = 'AI & Automation',
    price = 49.99,
    thumbnail_url = 'https://academy.trendtacticsdigital.com/images/prompt-engineering.jpg'
WHERE id = '123e4567-e89b-12d3-a456-426614174001';

-- PART 2: CONSOLIDATE LESSONS
-- ======================================================
UPDATE lessons
SET course_id = '123e4567-e89b-12d3-a456-426614174001'
WHERE course_id IN (
    SELECT id FROM courses 
    WHERE title ILIKE '%Prompt%' 
    AND id != '123e4567-e89b-12d3-a456-426614174001'
);

-- PART 3: FORCE CONTENT INJECTION
-- ===============================================================
-- 1. Key Takeaways
UPDATE lessons 
SET key_takeaways = '["Master the core concepts of this lesson", "Apply prompt engineering techniques effectively", "Optimize AI outputs for better results", "Avoid common pitfalls in prompting", "Implement these strategies in real-world workflows"]'::jsonb
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
AND (key_takeaways IS NULL OR jsonb_array_length(key_takeaways) < 1);

-- 2. Case Studies
UPDATE lessons
SET case_studies = '[{"title": "Corporate Automation", "scenario": "A company needed to automate email responses.", "analysis": "Manual drafting was inconsistent.", "outcome": "Implemented structured prompting, reducing time by 70%."}, {"title": "Creative Workflow", "scenario": "A writer needed help with brainstorming.", "analysis": "Needed inspiration without losing control.", "outcome": "Used few-shot prompting to generate aligned ideas."}]'::jsonb
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND (case_studies IS NULL OR jsonb_array_length(case_studies) < 1);

-- 3. Interactive Playground
UPDATE lessons
SET playground = '{"objective": "Practice the concept from this lesson.", "starter_prompt": "Write a prompt that demonstrates this concept...", "guided_steps": ["Analyze the starter prompt", "Identify the key components", "Modify variables to see different results", "Refine for better accuracy"], "advanced_challenge": "Combine this technique with another you have learned."}'::jsonb
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND (playground IS NULL OR playground::text = '{}');

-- 4. External Resources
UPDATE lessons
SET extra_resources = '[{"title": "OpenAI Documentation", "url": "https://platform.openai.com/docs/", "type": "docs"}, {"title": "Advanced Prompting Guide", "url": "https://www.promptingguide.ai/", "type": "article"}]'::jsonb
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND (extra_resources IS NULL OR jsonb_array_length(extra_resources) < 1);

-- 5. Quizzes
UPDATE lessons
SET quizzes = '[{"question": "What is the primary benefit of this technique?", "options": ["Improved Accuracy", "Faster Generation", "More Tokens", "None of the above"], "correctAnswer": 0}, {"question": "When should this be applied?", "options": ["Always", "Never", "In specific complex scenarios", "Only for coding"], "correctAnswer": 2}]'::jsonb
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND (quizzes IS NULL OR jsonb_array_length(quizzes) < 1);

-- 6. YouTube Videos (FORCE for ALL)
UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=jC4v5AS4RIM' WHERE title ILIKE '%Intro%' OR title ILIKE '%What is%';
UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=5iPZ7i0U3pA' WHERE title ILIKE '%Deployment%' OR title ILIKE '%Production%';
UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=_ZvnD7jqKFQ' WHERE title ILIKE '%Agent%' OR title ILIKE '%Swarm%';
UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=zjkBMFhNj_g' WHERE title ILIKE '%Technique%';

-- Catch-all
UPDATE lessons 
SET video_url = 'https://www.youtube.com/watch?v=zjkBMFhNj_g' 
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND (video_url IS NULL OR video_url = '');

-- VERIFICATION
SELECT count(*) as fixed_lessons FROM lessons WHERE course_id = '123e4567-e89b-12d3-a456-426614174001';
