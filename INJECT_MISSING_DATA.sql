-- ============================================================================
-- INJECT MISSING DATA ONLY (No Reordering / No Deletion)
-- ============================================================================
-- This script fixes the "Missing Keys" issue.
-- It populates: Quizzes, Case Studies, Playground, Videos, Resources, Takeaways.
-- It does NOT touch ordering or modules, avoiding all errors.
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
BEGIN

    -- 1. KEY TAKEAWAYS
    -- ============================================================================
    UPDATE lessons 
    SET key_takeaways = '["Master the core concepts of this lesson", "Apply prompt engineering techniques effectively", "Optimize AI outputs for better results", "Avoid common pitfalls in prompting", "Implement these strategies in real-world workflows"]'::jsonb
    WHERE course_id = cid 
    AND (key_takeaways IS NULL OR jsonb_array_length(key_takeaways) < 1);

    -- 2. CASE STUDIES
    -- ============================================================================
    UPDATE lessons
    SET case_studies = '[{"title": "Corporate Automation", "scenario": "A company needed to automate email responses.", "analysis": "Manual drafting was inconsistent.", "outcome": "Implemented structured prompting, reducing time by 70%."}, {"title": "Creative Workflow", "scenario": "A writer needed help with brainstorming.", "analysis": "Needed inspiration without losing control.", "outcome": "Used few-shot prompting to generate aligned ideas."}]'::jsonb
    WHERE course_id = cid 
    AND (case_studies IS NULL OR jsonb_array_length(case_studies) < 1);

    -- 3. INTERACTIVE PLAYGROUND
    -- ============================================================================
    UPDATE lessons
    SET playground = '{"objective": "Practice the concept from this lesson.", "starter_prompt": "Write a prompt that demonstrates this concept...", "guided_steps": ["Analyze the starter prompt", "Identify the key components", "Modify variables to see different results", "Refine for better accuracy"], "advanced_challenge": "Combine this technique with another you have learned."}'::jsonb
    WHERE course_id = cid 
    AND (playground IS NULL OR playground::text = '{}');

    -- 4. EXTERNAL RESOURCES
    -- ============================================================================
    UPDATE lessons
    SET extra_resources = '[{"title": "OpenAI Documentation", "url": "https://platform.openai.com/docs/", "type": "docs"}, {"title": "Advanced Prompting Guide", "url": "https://www.promptingguide.ai/", "type": "article"}]'::jsonb
    WHERE course_id = cid 
    AND (extra_resources IS NULL OR jsonb_array_length(extra_resources) < 1);

    -- 5. QUIZZES
    -- ============================================================================
    UPDATE lessons
    SET quizzes = '[{"question": "What is the primary benefit of this technique?", "options": ["Improved Accuracy", "Faster Generation", "More Tokens", "None of the above"], "correctAnswer": 0}, {"question": "When should this be applied?", "options": ["Always", "Never", "In specific complex scenarios", "Only for coding"], "correctAnswer": 2}]'::jsonb
    WHERE course_id = cid 
    AND (quizzes IS NULL OR jsonb_array_length(quizzes) < 1);

    -- 6. YOUTUBE VIDEOS (Smart Mapping + Fallback)
    -- ============================================================================
    -- Specific mappings for lessons that need specific videos
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=jC4v5AS4RIM' WHERE course_id = cid AND (title ILIKE '%Intro%' OR title ILIKE '%What is%' OR title ILIKE '%Foundations%');
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=5iPZ7i0U3pA' WHERE course_id = cid AND (title ILIKE '%Deployment%' OR title ILIKE '%Production%' OR title ILIKE '%Ethics%');
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=_ZvnD7jqKFQ' WHERE course_id = cid AND (title ILIKE '%Agent%' OR title ILIKE '%Swarm%' OR title ILIKE '%Workflow%');
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=zjkBMFhNj_g' WHERE course_id = cid AND (title ILIKE '%Technique%' OR title ILIKE '%Prompt%');

    -- Fallback for ANY lesson in this course that still has no video
    UPDATE lessons 
    SET video_url = 'https://www.youtube.com/watch?v=zjkBMFhNj_g'
    WHERE course_id = cid 
    AND (video_url IS NULL OR video_url = '');

    
    -- 7. CLEANUP "Facebook Ads" References (Optional, but safe)
    -- ============================================================================
    -- If a lesson is in the "Facebook Ads" module but belongs to Prompt Eng, we leave it for now as requested.
    -- But we ensure it has content.

END $$;

-- VERIFICATION
SELECT 
    title,
    CASE WHEN video_url IS NOT NULL THEN '✅ Video' ELSE '❌' END as Video,
    CASE WHEN quizzes IS NOT NULL THEN '✅ Quiz' ELSE '❌' END as Quiz,
    CASE WHEN playground IS NOT NULL THEN '✅ Play' ELSE '❌' END as Play,
    CASE WHEN case_studies IS NOT NULL THEN '✅ Case' ELSE '❌' END as Case
FROM lessons
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001';
