-- ============================================================================
-- CONTENT COMPLETION: Add Missing Modules & Lessons (FIXED V2)
-- ============================================================================
-- FIX: Removed invalid UUID placeholders. Uses dynamic UUID generation.
-- Target Course ID: 123e4567-e89b-12d3-a456-426614174001
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
    m1_id UUID; m2_id UUID; m3_id UUID; m4_id UUID; m5_id UUID; m6_id UUID;
BEGIN
    -- 1. GET OR CREATE MODULES (Safe Upsert)
    -- ============================================================================
    
    -- Module 1
    SELECT id INTO m1_id FROM modules WHERE course_id = cid AND title LIKE 'Module 1%';
    IF m1_id IS NULL THEN 
        INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 1: Foundations & Behavior Architecture', 1) RETURNING id INTO m1_id; 
    END IF;

    -- Module 2
    SELECT id INTO m2_id FROM modules WHERE course_id = cid AND title LIKE 'Module 2%';
    IF m2_id IS NULL THEN 
        INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 2: Core Techniques & Orchestration', 2) RETURNING id INTO m2_id; 
    END IF;

    -- Module 3
    SELECT id INTO m3_id FROM modules WHERE course_id = cid AND title LIKE 'Module 3%';
    IF m3_id IS NULL THEN 
        INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 3: Advanced Workflows & Meta-Prompting', 3) RETURNING id INTO m3_id; 
    END IF;

    -- Module 4
    SELECT id INTO m4_id FROM modules WHERE course_id = cid AND title LIKE 'Module 4%';
    IF m4_id IS NULL THEN 
        INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 4: Professional Mastery & Ethics', 4) RETURNING id INTO m4_id; 
    END IF;

    -- Module 5
    SELECT id INTO m5_id FROM modules WHERE course_id = cid AND title LIKE 'Module 5%';
    IF m5_id IS NULL THEN 
        INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 5: Real-World Applications', 5) RETURNING id INTO m5_id; 
    END IF;

    -- Module 6
    SELECT id INTO m6_id FROM modules WHERE course_id = cid AND title LIKE 'Module 6%';
    IF m6_id IS NULL THEN 
        INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 6: Course Conclusion', 6) RETURNING id INTO m6_id; 
    END IF;


    -- 2. INSERT MISSING LESSONS
    -- ============================================================================
    
    -- Module 1
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m1_id AND title = 'The Death of the Single Prompt') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m1_id, cid, 'The Death of the Single Prompt', 1, 'https://www.youtube.com/watch?v=jC4v5AS4RIM');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m1_id AND title = 'Understanding AI Models') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m1_id, cid, 'Understanding AI Models', 2, 'https://www.youtube.com/watch?v=jC4v5AS4RIM');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m1_id AND title = 'What Prompt Engineering Really Is') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m1_id, cid, 'What Prompt Engineering Really Is', 3, 'https://www.youtube.com/watch?v=jC4v5AS4RIM');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m1_id AND title = 'How AI Interprets Instructions') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m1_id, cid, 'How AI Interprets Instructions', 4, 'https://www.youtube.com/watch?v=jC4v5AS4RIM');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m1_id AND title = 'Prompt Engineering vs Traditional Instructions') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m1_id, cid, 'Prompt Engineering vs Traditional Instructions', 5, 'https://www.youtube.com/watch?v=jC4v5AS4RIM');
    END IF;

    -- Module 2
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m2_id AND title = 'Context Management') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m2_id, cid, 'Context Management', 1, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m2_id AND title = 'Chain-of-Thought Prompting') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m2_id, cid, 'Chain-of-Thought Prompting', 2, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m2_id AND title = 'Few-Shot Learning') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m2_id, cid, 'Few-Shot Learning', 3, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m2_id AND title = 'Core Prompt Components') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m2_id, cid, 'Core Prompt Components', 4, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m2_id AND title = 'Context Layering') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m2_id, cid, 'Context Layering', 5, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m2_id AND title = 'Constraints & Guardrails') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m2_id, cid, 'Constraints & Guardrails', 6, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;

    -- Module 3
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m3_id AND title = 'Designing The Swarm') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m3_id, cid, 'Designing The Swarm', 1, 'https://www.youtube.com/watch?v=_ZvnD7jqKFQ');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m3_id AND title = 'Agent Control Planes') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m3_id, cid, 'Agent Control Planes', 2, 'https://www.youtube.com/watch?v=_ZvnD7jqKFQ');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m3_id AND title = 'Dynamic Prompting') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m3_id, cid, 'Dynamic Prompting', 3, 'https://www.youtube.com/watch?v=_ZvnD7jqKFQ');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m3_id AND title = 'Prompt Chaining') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m3_id, cid, 'Prompt Chaining', 4, 'https://www.youtube.com/watch?v=_ZvnD7jqKFQ');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m3_id AND title = 'Iterative Refinement and Prompt Chaining') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m3_id, cid, 'Iterative Refinement and Prompt Chaining', 5, 'https://www.youtube.com/watch?v=_ZvnD7jqKFQ');
    END IF;

    -- Module 4
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m4_id AND title = 'Constitutional AI & Alignment') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m4_id, cid, 'Constitutional AI & Alignment', 1, 'https://www.youtube.com/watch?v=5iPZ7i0U3pA');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m4_id AND title = 'Production Deployment') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m4_id, cid, 'Production Deployment', 2, 'https://www.youtube.com/watch?v=5iPZ7i0U3pA');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m4_id AND title = 'Recursive Prompts') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m4_id, cid, 'Recursive Prompts', 3, 'https://www.youtube.com/watch?v=5iPZ7i0U3pA');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m4_id AND title = 'Industry Applications & Case Studies') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m4_id, cid, 'Industry Applications & Case Studies', 4, 'https://www.youtube.com/watch?v=5iPZ7i0U3pA');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m4_id AND title = 'Temperature and Creativity Control') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m4_id, cid, 'Temperature and Creativity Control', 5, 'https://www.youtube.com/watch?v=5iPZ7i0U3pA');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m4_id AND title = 'Zero-Shot and Self-Consistency Techniques') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m4_id, cid, 'Zero-Shot and Self-Consistency Techniques', 6, 'https://www.youtube.com/watch?v=5iPZ7i0U3pA');
    END IF;

    -- Module 5
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m5_id AND title = 'Prompt Engineering for Content Creation') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m5_id, cid, 'Prompt Engineering for Content Creation', 1, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m5_id AND title = 'Prompt Engineering for Code Generation') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m5_id, cid, 'Prompt Engineering for Code Generation', 2, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m5_id AND title = 'Prompt Engineering for Data Analysis') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m5_id, cid, 'Prompt Engineering for Data Analysis', 3, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;

    -- Module 6
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m6_id AND title = 'Common Prompt Engineering Mistakes and How to Avoid Them') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m6_id, cid, 'Common Prompt Engineering Mistakes and How to Avoid Them', 1, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m6_id AND title = 'Testing and Validating Prompts') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m6_id, cid, 'Testing and Validating Prompts', 2, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m6_id AND title = 'Putting It All Together: Advanced Prompt Engineering Projects') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m6_id, cid, 'Putting It All Together: Advanced Prompt Engineering Projects', 3, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
END $$;


-- 3. FINAL FORCE CONTENT (Run again to catch the newly inserted lessons)
-- ============================================================================
-- Key Takeaways
UPDATE lessons 
SET key_takeaways = '["Master the core concepts of this lesson", "Apply prompt engineering techniques effectively", "Optimize AI outputs for better results", "Avoid common pitfalls in prompting", "Implement these strategies in real-world workflows"]'::jsonb
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
AND (key_takeaways IS NULL OR jsonb_array_length(key_takeaways) < 1);

-- Case Studies
UPDATE lessons
SET case_studies = '[{"title": "Corporate Automation", "scenario": "A company needed to automate email responses.", "analysis": "Manual drafting was inconsistent.", "outcome": "Implemented structured prompting, reducing time by 70%."}, {"title": "Creative Workflow", "scenario": "A writer needed help with brainstorming.", "analysis": "Needed inspiration without losing control.", "outcome": "Used few-shot prompting to generate aligned ideas."}]'::jsonb
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND (case_studies IS NULL OR jsonb_array_length(case_studies) < 1);

-- Interactive Playground
UPDATE lessons
SET playground = '{"objective": "Practice the concept from this lesson.", "starter_prompt": "Write a prompt that demonstrates this concept...", "guided_steps": ["Analyze the starter prompt", "Identify the key components", "Modify variables to see different results", "Refine for better accuracy"], "advanced_challenge": "Combine this technique with another you have learned."}'::jsonb
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND (playground IS NULL OR playground::text = '{}');

-- External Resources
UPDATE lessons
SET extra_resources = '[{"title": "OpenAI Documentation", "url": "https://platform.openai.com/docs/", "type": "docs"}, {"title": "Advanced Prompting Guide", "url": "https://www.promptingguide.ai/", "type": "article"}]'::jsonb
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND (extra_resources IS NULL OR jsonb_array_length(extra_resources) < 1);

-- Quizzes
UPDATE lessons
SET quizzes = '[{"question": "What is the primary benefit of this technique?", "options": ["Improved Accuracy", "Faster Generation", "More Tokens", "None of the above"], "correctAnswer": 0}, {"question": "When should this be applied?", "options": ["Always", "Never", "In specific complex scenarios", "Only for coding"], "correctAnswer": 2}]'::jsonb
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND (quizzes IS NULL OR jsonb_array_length(quizzes) < 1);

-- VERIFICATION
SELECT 
    m.title as Module,
    l.title as Lesson,
    CASE WHEN l.video_url IS NOT NULL THEN '✅ Video' ELSE '❌ NO VIDEO' END as Status
FROM lessons l
JOIN modules m ON l.module_id = m.id
WHERE l.course_id = '123e4567-e89b-12d3-a456-426614174001'
ORDER BY m.ordering, l.ordering;
