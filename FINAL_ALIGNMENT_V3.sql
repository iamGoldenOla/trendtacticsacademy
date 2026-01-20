-- ============================================================================
-- FINAL CURRICULUM ALIGNMENT V3: The "Nuclear" Ordering Fix
-- ============================================================================
-- FIX: Clears ordering by MODULE ID to ensure slots are 100% free.
-- This prevents the "Key (module_id, ordering) already exists" error.
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
    m1_id UUID; m2_id UUID; m3_id UUID; m4_id UUID; m5_id UUID; m6_id UUID;
BEGIN
    -- 1. GET OR CREATE CORRECT MODULES
    -- ========================================
    INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 1: Foundations & Behavior Architecture', 1) ON CONFLICT DO NOTHING;
    SELECT id INTO m1_id FROM modules WHERE course_id = cid AND title = 'Module 1: Foundations & Behavior Architecture';

    INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 2: Core Techniques & Orchestration', 2) ON CONFLICT DO NOTHING;
    SELECT id INTO m2_id FROM modules WHERE course_id = cid AND title = 'Module 2: Core Techniques & Orchestration';

    INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 3: Advanced Workflows & Meta-Prompting', 3) ON CONFLICT DO NOTHING;
    SELECT id INTO m3_id FROM modules WHERE course_id = cid AND title = 'Module 3: Advanced Workflows & Meta-Prompting';

    INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 4: Professional Mastery & Ethics', 4) ON CONFLICT DO NOTHING;
    SELECT id INTO m4_id FROM modules WHERE course_id = cid AND title = 'Module 4: Professional Mastery & Ethics';

    INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 5: Real-World Applications', 5) ON CONFLICT DO NOTHING;
    SELECT id INTO m5_id FROM modules WHERE course_id = cid AND title = 'Module 5: Real-World Applications';

    INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 6: Course Conclusion', 6) ON CONFLICT DO NOTHING;
    SELECT id INTO m6_id FROM modules WHERE course_id = cid AND title = 'Module 6: Course Conclusion';


    -- 2. RESET ORDERING (THE FIX)
    -- ========================================
    -- We update by MODULE_ID to clear the slots 1, 2, 3... in these specific modules.
    -- Using a random offsets to safely move them out of the way.
    UPDATE lessons 
    SET ordering = 5000 + floor(random() * 1000)::int
    WHERE module_id IN (m1_id, m2_id, m3_id, m4_id, m5_id, m6_id);
    
    -- Also reset any other lessons in this course just in case
    UPDATE lessons SET ordering = 6000 + floor(random() * 1000)::int WHERE course_id = cid;


    -- 3. ALIGN LESSONS (Strict Assignment)
    -- ========================================

    -- Module 1
    UPDATE lessons SET module_id = m1_id, ordering = 1 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Death of the Single Prompt%' LIMIT 1);
    UPDATE lessons SET module_id = m1_id, ordering = 2 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Understanding AI Models%' LIMIT 1);
    UPDATE lessons SET module_id = m1_id, ordering = 3 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%What Prompt Engineering Really Is%' LIMIT 1);
    UPDATE lessons SET module_id = m1_id, ordering = 4 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%How AI Interprets Instructions%' LIMIT 1);
    UPDATE lessons SET module_id = m1_id, ordering = 5 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%vs Traditional Instructions%' LIMIT 1);

    -- Module 2
    UPDATE lessons SET module_id = m2_id, ordering = 1 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Context Management%' LIMIT 1);
    UPDATE lessons SET module_id = m2_id, ordering = 2 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Chain-of-Thought%' LIMIT 1);
    UPDATE lessons SET module_id = m2_id, ordering = 3 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Few-Shot Learning%' AND title NOT ILIKE '%Examples%' LIMIT 1);
    UPDATE lessons SET module_id = m2_id, ordering = 4 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Core Prompt Components%' LIMIT 1);
    UPDATE lessons SET module_id = m2_id, ordering = 5 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Context Layering%' LIMIT 1);
    UPDATE lessons SET module_id = m2_id, ordering = 6 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Constraints & Guardrails%' LIMIT 1);

    -- Module 3
    UPDATE lessons SET module_id = m3_id, ordering = 1 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Designing The Swarm%' LIMIT 1);
    UPDATE lessons SET module_id = m3_id, ordering = 2 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Agent Control Planes%' LIMIT 1);
    UPDATE lessons SET module_id = m3_id, ordering = 3 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Dynamic Prompting%' LIMIT 1);
    UPDATE lessons SET module_id = m3_id, ordering = 4 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Prompt Chaining%' AND title NOT ILIKE '%Iterative%' LIMIT 1);
    UPDATE lessons SET module_id = m3_id, ordering = 5 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Few-Shot Learning and Examples%' LIMIT 1);
    UPDATE lessons SET module_id = m3_id, ordering = 6 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Iterative Refinement%' LIMIT 1);

    -- Module 4
    UPDATE lessons SET module_id = m4_id, ordering = 1 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Constitutional AI%' LIMIT 1);
    UPDATE lessons SET module_id = m4_id, ordering = 2 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Production Deployment%' LIMIT 1);
    UPDATE lessons SET module_id = m4_id, ordering = 3 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Recursive Prompts%' LIMIT 1);
    UPDATE lessons SET module_id = m4_id, ordering = 4 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Industry Applications%' LIMIT 1);
    UPDATE lessons SET module_id = m4_id, ordering = 5 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Temperature and Creativity%' LIMIT 1);
    UPDATE lessons SET module_id = m4_id, ordering = 6 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Zero-Shot and Self-Consistency%' LIMIT 1);

    -- Module 5
    UPDATE lessons SET module_id = m5_id, ordering = 1 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Content Creation%' LIMIT 1);
    UPDATE lessons SET module_id = m5_id, ordering = 2 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Code Generation%' LIMIT 1);
    UPDATE lessons SET module_id = m5_id, ordering = 3 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Data Analysis%' LIMIT 1);

    -- Module 6
    UPDATE lessons SET module_id = m6_id, ordering = 1 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Common Prompt Engineering Mistakes%' LIMIT 1);
    UPDATE lessons SET module_id = m6_id, ordering = 2 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Testing and Validating%' LIMIT 1);
    UPDATE lessons SET module_id = m6_id, ordering = 3 WHERE id = (SELECT id FROM lessons WHERE course_id = cid AND title ILIKE '%Putting It All Together%' LIMIT 1);


    -- 4. CLEANUP DUPLICATES
    -- ========================================
    -- Delete anything in these modules that has order > 1000 (meaning it wasn't one of the lessons we just arranged).
    DELETE FROM lessons WHERE module_id IN (m1_id, m2_id, m3_id, m4_id, m5_id, m6_id) AND ordering > 1000;
    
    -- Cleanup "Facebook Ads" or other bad modules
    DELETE FROM modules WHERE course_id = cid AND id NOT IN (m1_id, m2_id, m3_id, m4_id, m5_id, m6_id);


    -- 5. CONTENT INJECTION (AI TRIGGER)
    -- ========================================
    -- [A] Key Takeaways
    UPDATE lessons SET key_takeaways = '["Master the core concepts of this lesson", "Apply prompt engineering techniques effectively", "Optimize AI outputs for better results", "Avoid common pitfalls in prompting", "Implement these strategies in real-world workflows"]'::jsonb
    WHERE course_id = cid AND (key_takeaways IS NULL OR jsonb_array_length(key_takeaways) < 1);

    -- [B] Case Studies
    UPDATE lessons SET case_studies = '[{"title": "Corporate Automation", "scenario": "A company needed to automate email responses.", "analysis": "Manual drafting was inconsistent.", "outcome": "Implemented structured prompting, reducing time by 70%."}, {"title": "Creative Workflow", "scenario": "A writer needed help with brainstorming.", "analysis": "Needed inspiration without losing control.", "outcome": "Used few-shot prompting to generate aligned ideas."}]'::jsonb
    WHERE course_id = cid AND (case_studies IS NULL OR jsonb_array_length(case_studies) < 1);

    -- [C] Interactive Playground
    UPDATE lessons SET playground = '{"objective": "Practice the concept from this lesson.", "starter_prompt": "Write a prompt that demonstrates this concept...", "guided_steps": ["Analyze the starter prompt", "Identify the key components", "Modify variables to see different results", "Refine for better accuracy"], "advanced_challenge": "Combine this technique with another you have learned."}'::jsonb
    WHERE course_id = cid AND (playground IS NULL OR playground::text = '{}');

    -- [D] External Resources
    UPDATE lessons SET extra_resources = '[{"title": "OpenAI Documentation", "url": "https://platform.openai.com/docs/", "type": "docs"}, {"title": "Advanced Prompting Guide", "url": "https://www.promptingguide.ai/", "type": "article"}]'::jsonb
    WHERE course_id = cid AND (extra_resources IS NULL OR jsonb_array_length(extra_resources) < 1);

    -- [E] Quizzes
    UPDATE lessons SET quizzes = '[{"question": "What is the primary benefit of this technique?", "options": ["Improved Accuracy", "Faster Generation", "More Tokens", "None of the above"], "correctAnswer": 0}, {"question": "When should this be applied?", "options": ["Always", "Never", "In specific complex scenarios", "Only for coding"], "correctAnswer": 2}]'::jsonb
    WHERE course_id = cid AND (quizzes IS NULL OR jsonb_array_length(quizzes) < 1);

    -- [F] YouTube Videos
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=jC4v5AS4RIM' WHERE title ILIKE '%Intro%' OR title ILIKE '%What is%' AND course_id = cid;
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=5iPZ7i0U3pA' WHERE title ILIKE '%Deployment%' OR title ILIKE '%Production%' AND course_id = cid;
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=_ZvnD7jqKFQ' WHERE title ILIKE '%Agent%' OR title ILIKE '%Swarm%' AND course_id = cid;
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=zjkBMFhNj_g' WHERE title ILIKE '%Technique%' AND course_id = cid;
    
    -- Fallback for ALL
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=zjkBMFhNj_g' 
    WHERE course_id = cid AND (video_url IS NULL OR video_url = '');

END $$;

-- VERIFICATION
SELECT m.title as Module, l.title as Lesson, l.ordering, 
       CASE WHEN l.video_url IS NOT NULL THEN '✅ Video' ELSE '❌ NO VIDEO' END as Vid,
       CASE WHEN l.playground IS NOT NULL THEN '✅ Play' ELSE '❌ NO PLAY' END as Play
FROM lessons l
JOIN modules m ON l.module_id = m.id
WHERE l.course_id = '123e4567-e89b-12d3-a456-426614174001'
ORDER BY m.ordering, l.ordering;
