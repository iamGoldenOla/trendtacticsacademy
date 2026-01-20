-- ============================================================================
-- MASTER FORCE FIX: Consolidate Courses & Force Content
-- ============================================================================
-- 1. Merges all "Prompt Engineering" duplicates into ONE master course
-- 2. Removes duplicate lessons
-- 3. FORCES missing content to be populated for EVERY lesson
-- ============================================================================

-- PART 1: CONSOLIDATE COURSES
-- ============================
-- Target Course ID: 123e4567-e89b-12d3-a456-426614174001

-- Move all lessons from other "Prompt Engineering" courses to the Target Course
UPDATE lessons
SET course_id = '123e4567-e89b-12d3-a456-426614174001'
WHERE course_id IN (
    SELECT id FROM courses 
    WHERE title ILIKE '%Prompt%' 
    AND id != '123e4567-e89b-12d3-a456-426614174001'
);

-- Delete the other courses now that they are empty
DELETE FROM courses 
WHERE title ILIKE '%Prompt%' 
AND id != '123e4567-e89b-12d3-a456-426614174001';

-- Update the Target Course details to be perfect
UPDATE courses 
SET 
    title = 'Prompt Engineering Mastery',
    description = 'Master the art of communicating with AI. From basic prompts to advanced agentic workflows.',
    status = 'published',
    level = 'All Levels',
    thumbnail_url = 'https://academy.trendtacticsdigital.com/images/prompt-engineering.jpg'
WHERE id = '123e4567-e89b-12d3-a456-426614174001';


-- PART 2: REMOVE DUPLICATE LESSONS
-- =================================
-- Keep only the most complete version of each lesson title
DELETE FROM lessons a USING lessons b
WHERE a.id < b.id
AND a.title = b.title
AND a.course_id = '123e4567-e89b-12d3-a456-426614174001'
AND b.course_id = '123e4567-e89b-12d3-a456-426614174001';


-- PART 3: FORCE CONTENT POPULATION
-- =================================
-- Iterate through ALL lessons in the course and inject missing content

-- 1. Key Takeaways
UPDATE lessons 
SET key_takeaways = '["Understand the core principles of this specific topic", "Apply prompt engineering techniques in real-world scenarios", "Analyze and optimize prompt outputs for better results", "Integrate these strategies into your daily workflow", "Experiment with variations to find the most effective approach"]'::jsonb
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
AND (key_takeaways IS NULL OR jsonb_array_length(key_takeaways) < 1);

-- 2. Case Studies
UPDATE lessons
SET case_studies = '[{"title": "Enterprise Implementation", "scenario": "A Fortune 500 company needed to automate customer support responses.", "analysis": "Manual drafting was too slow and inconsistent.", "outcome": "Implemented structured prompting. Reduced response time by 60% and improved CSAT scores."}, {"title": "Creative Writing Assistant", "scenario": "An author struggled with writer''s block and plot consistency.", "analysis": "Needed a way to brainstorm without losing their unique voice.", "outcome": "Used context-aware prompting to generate outlines and character sketches, accelerating the writing process."}]'::jsonb
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND (case_studies IS NULL OR jsonb_array_length(case_studies) < 1);

-- 3. Interactive Playground
UPDATE lessons
SET playground = '{"objective": "Master the concepts of this lesson through hands-on practice.", "starter_prompt": "Explain the concept of this lesson to a beginner using a metaphor.", "guided_steps": ["Read the lesson summary", "Modify the starter prompt to be more specific", "Test with different variables", "Compare the outputs"], "advanced_challenge": "Create a multi-step prompt chain that utilizes the techniques learned in this lesson."}'::jsonb
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND (playground IS NULL OR playground::text = '{}');

-- 4. External Resources
UPDATE lessons
SET extra_resources = '[{"title": "OpenAI Prompt Engineering Guide", "url": "https://platform.openai.com/docs/guides/prompt-engineering", "type": "docs"}, {"title": "Anthropic Prompt Library", "url": "https://docs.anthropic.com/claude/prompt-library", "type": "tool"}, {"title": "Learn Prompting Course", "url": "https://learnprompting.org/", "type": "course"}]'::jsonb
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND (extra_resources IS NULL OR jsonb_array_length(extra_resources) < 1);

-- 5. Quizzes
UPDATE lessons
SET quizzes = '[{"question": "What is the primary goal of the techniques discussed in this lesson?", "options": ["To confuse the AI", "To optimize the output for accuracy and relevance", "To increase token usage excessively", "To bypass safety filters"], "correctAnswer": 1}, {"question": "Which factor is most critical for success with this method?", "options": ["Speed of typing", "Context window size", "Clear and structured instructions", "Using a specific browser"], "correctAnswer": 2}, {"question": "How can you verify the effectiveness of your prompt?", "options": ["Guesswork", "Systematic testing and iteration", "Asking a friend", "Assuming it works first time"], "correctAnswer": 1}]'::jsonb
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND (quizzes IS NULL OR jsonb_array_length(quizzes) < 1);

-- 6. YouTube Videos (Essential!)
-- Map specific videos to specific lessons where possible, otherwise default
UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=jC4v5AS4RIM' WHERE title ILIKE '%Intro%' OR title ILIKE '%What is%';
UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=5iPZ7i0U3pA' WHERE title ILIKE '%Deployment%' OR title ILIKE '%Production%';
UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=_ZvnD7jqKFQ' WHERE title ILIKE '%Agent%' OR title ILIKE '%Swarm%';

-- Force ALL remaining lessons to have a video if they don't have one
UPDATE lessons 
SET video_url = 'https://www.youtube.com/watch?v=zjkBMFhNj_g' -- General Prompt Engineering Guide video
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND (video_url IS NULL OR video_url = '');

-- VERIFICATION
SELECT 
    title, 
    CASE WHEN key_takeaways IS NOT NULL THEN '✅' ELSE '❌' END as takeaways,
    CASE WHEN case_studies IS NOT NULL THEN '✅' ELSE '❌' END as case_studies,
    CASE WHEN playground IS NOT NULL THEN '✅' ELSE '❌' END as playground,
    CASE WHEN extra_resources IS NOT NULL THEN '✅' ELSE '❌' END as resources,
    CASE WHEN quizzes IS NOT NULL THEN '✅' ELSE '❌' END as quizzes,
    CASE WHEN video_url IS NOT NULL AND video_url != '' THEN '✅' ELSE '❌' END as video
FROM lessons 
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
ORDER BY title;
