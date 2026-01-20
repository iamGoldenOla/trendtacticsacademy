-- ============================================================================
-- FINAL CURRICULUM ALIGNMENT V4: The Polish
-- ============================================================================
-- 1. Fixes Match Failures: Catches "What is Prompt Engineering?" etc.
-- 2. Nukes "Facebook Ads": Explicitly deletes this pollution.
-- 3. Inserts Missing Modules 5 & 6 (start from scratch for them).
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
    m1_id UUID; m2_id UUID; m3_id UUID; m4_id UUID; m5_id UUID; m6_id UUID;
BEGIN
    -- 1. ENSURE MODULES (Standard Procedure)
    SELECT id INTO m1_id FROM modules WHERE course_id = cid AND title LIKE 'Module 1%';
    SELECT id INTO m2_id FROM modules WHERE course_id = cid AND title LIKE 'Module 2%';
    SELECT id INTO m3_id FROM modules WHERE course_id = cid AND title LIKE 'Module 3%';
    SELECT id INTO m4_id FROM modules WHERE course_id = cid AND title LIKE 'Module 4%';
    SELECT id INTO m5_id FROM modules WHERE course_id = cid AND title LIKE 'Module 5%';
    SELECT id INTO m6_id FROM modules WHERE course_id = cid AND title LIKE 'Module 6%';

    -- If 5/6 are missing, create them
    IF m5_id IS NULL THEN INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 5: Real-World Applications', 5) RETURNING id INTO m5_id; END IF;
    IF m6_id IS NULL THEN INSERT INTO modules (course_id, title, ordering) VALUES (cid, 'Module 6: Course Conclusion', 6) RETURNING id INTO m6_id; END IF;


    -- 2. SMART MAPPING (Fixing the Title Mismatches)
    -- ========================================

    -- M1: Matches "What is Prompt Engineering?" and "Prompt Anatomy"
    UPDATE lessons SET module_id = m1_id, ordering = 3 WHERE course_id = cid AND title ILIKE '%What is Prompt Engineering%';
    UPDATE lessons SET module_id = m1_id, ordering = 4 WHERE course_id = cid AND (title ILIKE '%Prompt Anatomy%' OR title ILIKE '%Structure%');
    UPDATE lessons SET module_id = m1_id, ordering = 5 WHERE course_id = cid AND title ILIKE '%First Prompt%';

    -- Ensure M5 lessons exist (INSERT if missing)
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m5_id AND title ILIKE '%Content Creation%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m5_id, cid, 'Prompt Engineering for Content Creation', 1, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m5_id AND title ILIKE '%Code Generation%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m5_id, cid, 'Prompt Engineering for Code Generation', 2, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m5_id AND title ILIKE '%Data Analysis%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m5_id, cid, 'Prompt Engineering for Data Analysis', 3, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;

    -- Ensure M6 lessons exist
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m6_id AND title ILIKE '%Mistakes%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m6_id, cid, 'Common Prompt Engineering Mistakes', 1, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m6_id AND title ILIKE '%Validating%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m6_id, cid, 'Testing and Validating Prompts', 2, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = m6_id AND title ILIKE '%Projects%') THEN
        INSERT INTO lessons (module_id, course_id, title, ordering, video_url) VALUES (m6_id, cid, 'Final Projects & Advanced Strategy', 3, 'https://www.youtube.com/watch?v=zjkBMFhNj_g');
    END IF;


    -- 3. NUKE FACEBOOK ADS & DUPLICATES
    -- ========================================
    -- Verify we have moved everything valuable. Now destroy the container.
    DELETE FROM modules WHERE course_id = cid AND title ILIKE '%Facebook%';
    
    -- Cleanup any lessons that are NOW orphaned or still parked at 6000+ (Duplicates)
    DELETE FROM lessons WHERE course_id = cid AND ordering > 5000;


    -- 4. RE-INJECT CONTENT (Just to be safe for the new inserts)
    -- ========================================
    UPDATE lessons SET 
       key_takeaways = COALESCE(key_takeaways, '["Master the core concepts", "Apply techniques effectively", "Optimize outputs", "Avoid pitfalls", "Real-world application"]'::jsonb),
       playground = COALESCE(playground, '{"objective": "Practice this concept", "starter_prompt": "Write a prompt...", "guided_steps": ["Analyze", "Modify", "Test"], "advanced_challenge": "Combine techniques"}'::jsonb),
       quizzes = COALESCE(quizzes, '[{"question": "What is the main goal?", "options": ["Accuracy", "Speed", "Complexity", "None"], "correctAnswer": 0}]'::jsonb),
       extra_resources = COALESCE(extra_resources, '[{"title": "Documentation", "url": "https://platform.openai.com/docs/", "type": "docs"}]'::jsonb),
       video_url = COALESCE(NULLIF(video_url, ''), 'https://www.youtube.com/watch?v=zjkBMFhNj_g')
    WHERE course_id = cid;

END $$;

-- VERIFICATION
SELECT m.title as Module, l.title as Lesson, l.ordering
FROM lessons l
JOIN modules m ON l.module_id = m.id
WHERE l.course_id = '123e4567-e89b-12d3-a456-426614174001'
ORDER BY m.ordering, l.ordering;
