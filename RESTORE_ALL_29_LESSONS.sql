-- ============================================================================
-- RESTORE ALL 29 LESSONS (Safe Insert)
-- ============================================================================
-- Goal: Bring the lesson count from 13 back to ~29.
-- Strategy: Check for the missing 16 lessons. If missing, INSERT them.
-- does NOT delete or reorder existing lessons (safety first).
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
    m1_id UUID; m2_id UUID; m3_id UUID; m4_id UUID; m5_id UUID; m6_id UUID;
BEGIN
    -- 1. ENSURE MODULES EXIST (Especially 5 & 6)
    -- ========================================
    -- We select existing IDs or Insert if missing.
    
    -- M1-M4 (Should exist, but safe check)
    SELECT id INTO m1_id FROM modules WHERE course_id = cid AND title LIKE 'Module 1%';
    SELECT id INTO m2_id FROM modules WHERE course_id = cid AND title LIKE 'Module 2%';
    SELECT id INTO m3_id FROM modules WHERE course_id = cid AND title LIKE 'Module 3%';
    SELECT id INTO m4_id FROM modules WHERE course_id = cid AND title LIKE 'Module 4%';

    -- M5 & M6 (Likely missing)
    SELECT id INTO m5_id FROM modules WHERE course_id = cid AND title LIKE 'Module 5%';
    IF m5_id IS NULL THEN 
        INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 5: Real-World Applications', 5) RETURNING id INTO m5_id; 
    END IF;

    SELECT id INTO m6_id FROM modules WHERE course_id = cid AND title LIKE 'Module 6%';
    IF m6_id IS NULL THEN 
        INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 6: Course Conclusion', 6) RETURNING id INTO m6_id; 
    END IF;


    -- 2. INSERT MISSING LESSONS
    -- ========================================
    -- We use a high ordering number (10+) to append them to the end of the module
    -- so we don't conflict with existing ordering 1, 2, 3...

    -- Module 1 Missing:
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m1_id AND title ILIKE '%What Prompt Engineering Really Is%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m1_id, cid, 'What Prompt Engineering Really Is', 10, 'https://www.youtube.com/watch?v=jC4v5AS4RIM');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m1_id AND title ILIKE '%How AI Interprets Instructions%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m1_id, cid, 'How AI Interprets Instructions', 11, 'https://www.youtube.com/watch?v=jC4v5AS4RIM');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m1_id AND title ILIKE '%vs Traditional Instructions%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m1_id, cid, 'Prompt Engineering vs Traditional Instructions', 12, 'https://www.youtube.com/watch?v=jC4v5AS4RIM');
    END IF;

    -- Module 2 Missing:
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m2_id AND title ILIKE '%Core Prompt Components%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m2_id, cid, 'Core Prompt Components', 10, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m2_id AND title ILIKE '%Context Layering%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m2_id, cid, 'Context Layering', 11, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m2_id AND title ILIKE '%Constraints & Guardrails%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m2_id, cid, 'Constraints & Guardrails', 12, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;

    -- Module 3 Missing:
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m3_id AND title ILIKE '%Iterative Refinement%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m3_id, cid, 'Iterative Refinement and Prompt Chaining', 10, 'https://www.youtube.com/watch?v=_ZvnD7jqKFQ');
    END IF;
    -- "Few-Shot Learning and Examples" if distinct from M2's "Few-Shot Learning"
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m3_id AND title ILIKE '%Few-Shot Learning and Examples%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m3_id, cid, 'Few-Shot Learning and Examples', 11, 'https://www.youtube.com/watch?v=_ZvnD7jqKFQ');
    END IF;

    -- Module 4 Missing:
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m4_id AND title ILIKE '%Temperature%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m4_id, cid, 'Temperature and Creativity Control', 10, 'https://www.youtube.com/watch?v=5iPZ7i0U3pA');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m4_id AND title ILIKE '%Zero-Shot%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m4_id, cid, 'Zero-Shot and Self-Consistency Techniques', 11, 'https://www.youtube.com/watch?v=5iPZ7i0U3pA');
    END IF;

    -- Module 5 (All Missing):
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m5_id AND title ILIKE '%Content Creation%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m5_id, cid, 'Prompt Engineering for Content Creation', 1, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m5_id AND title ILIKE '%Code Generation%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m5_id, cid, 'Prompt Engineering for Code Generation', 2, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m5_id AND title ILIKE '%Data Analysis%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m5_id, cid, 'Prompt Engineering for Data Analysis', 3, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;

    -- Module 6 (All Missing):
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m6_id AND title ILIKE '%Mistakes%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m6_id, cid, 'Common Prompt Engineering Mistakes', 1, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m6_id AND title ILIKE '%Validating%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m6_id, cid, 'Testing and Validating Prompts', 2, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m6_id AND title ILIKE '%Projects%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m6_id, cid, 'Final Projects & Advanced Strategy', 3, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;


    -- 3. FILL CONTENT (For the NEW lessons)
    -- ========================================
    UPDATE lessons SET 
       key_takeaways = COALESCE(key_takeaways, '["Master the core concepts", "Apply techniques effectively", "Optimize outputs", "Avoid pitfalls", "Real-world application"]'::jsonb),
       playground = COALESCE(playground, '{"objective": "Practice this concept", "starter_prompt": "Write a prompt...", "guided_steps": ["Analyze", "Modify", "Test"], "advanced_challenge": "Combine techniques"}'::jsonb),
       quizzes = COALESCE(quizzes, '[{"question": "What is the main goal?", "options": ["Accuracy", "Speed", "Complexity", "None"], "correctAnswer": 0}]'::jsonb),
       extra_resources = COALESCE(extra_resources, '[{"title": "Documentation", "url": "https://platform.openai.com/docs/", "type": "docs"}]'::jsonb),
       case_studies = COALESCE(case_studies, '[{"title": "Application", "scenario": "Applying this technique.", "outcome": "Success."}]'::jsonb),
       video_url = COALESCE(NULLIF(video_url, ''), 'https://www.youtube.com/watch?v=zjkBMFhNj_g')
    WHERE course_id = cid;

END $$;

-- VERIFICATION
SELECT count(*) as total_lessons FROM lessons WHERE course_id = '123e4567-e89b-12d3-a456-426614174001';
