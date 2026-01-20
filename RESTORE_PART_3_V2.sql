-- Vibe Coding Restoration Part 3: Career (V2 - Simple Inserts)
-- Run this AFTER Part 2

DO $$
DECLARE
  v_course_id UUID;
  v_module_id UUID;
BEGIN
  SELECT id INTO v_course_id FROM courses WHERE slug = 'vibe-coding';

  -- Module 7: Advanced Vibe Coding
  SELECT id INTO v_module_id FROM modules WHERE course_id = v_course_id AND title = 'Module 7: Advanced Vibe Coding';
  IF v_module_id IS NULL THEN
    INSERT INTO modules (course_id, title) VALUES (v_course_id, 'Module 7: Advanced Vibe Coding') RETURNING id INTO v_module_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'Verification Prompts') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'Verification Prompts', '<h3><b>Checking the AI''s Work</b></h3><p>Run Verification Prompts after generation.</p>', 'https://www.youtube.com/embed/sFkS-XJb6jo', 10);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'Cost, Performance & Sanity') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'Cost, Performance & Sanity', '<h3><b>The API Bill</b></h3><p>Balance cost and intelligence. Know when to reset.</p>', 'https://www.youtube.com/embed/yO7-wV7pPZQ', 10);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'When NOT to Use AI') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'When NOT to Use AI', '<h3><b>The Danger Zone</b></h3><p>Never paste secrets. Keep core IP local.</p>', 'https://www.youtube.com/embed/Sal7cz3T40M', 10);
  END IF;

  -- Module 8: Applications & Career
  SELECT id INTO v_module_id FROM modules WHERE course_id = v_course_id AND title = 'Module 8: Applications & Career';
  IF v_module_id IS NULL THEN
    INSERT INTO modules (course_id, title) VALUES (v_course_id, 'Module 8: Applications & Career') RETURNING id INTO v_module_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'Internal Tools') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'Internal Tools', '<h3><b>The Hidden Economy</b></h3><p>Become the Toolsmith of your org.</p>', 'https://www.youtube.com/embed/6qg5iI_n8m0', 10);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'Client Work') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'Client Work', '<h3><b>Value-Based Pricing</b></h3><p>Bill by outcome, not by hour.</p>', 'https://www.youtube.com/embed/pU72h2Zbc5c', 10);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'The Future of Software') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'The Future of Software', '<h3><b>Software as a Commodity</b></h3><p>Code is abundant. Taste is scarce. Be a Product Engineer.</p>', 'https://www.youtube.com/embed/5EFd0n_n7bU', 10);
  END IF;

END $$;
