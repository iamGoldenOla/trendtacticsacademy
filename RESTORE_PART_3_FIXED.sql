-- Vibe Coding Restoration Part 3: Career (FIXED - No Order Column)
-- Run this AFTER Part 2

DO $$
DECLARE
  v_course_id UUID;
  v_module_id UUID;
BEGIN
  SELECT id INTO v_course_id FROM courses WHERE slug = 'vibe-coding';

  -- Module 7: Advanced Vibe Coding
  INSERT INTO modules (course_id, title)
  VALUES (v_course_id, 'Module 7: Advanced Vibe Coding')
  ON CONFLICT (course_id, title) DO NOTHING
  RETURNING id INTO v_module_id;
  
  IF v_module_id IS NULL THEN
    SELECT id INTO v_module_id FROM modules WHERE course_id = v_course_id AND title = 'Module 7: Advanced Vibe Coding';
  END IF;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'Verification Prompts', '<h3><b>Checking the AI''s Work</b></h3><p>After generation, run a Verification Prompt:</p><ul><li>''List 3 ways this code could fail.''</li><li>''Explain this code to a 5 year old.''</li><li>''Audit for security vulnerabilities.''</li></ul><p>This forces the AI to switch from ''Creative Writer'' to ''Critical Critic''.</p>', 'https://www.youtube.com/embed/sFkS-XJb6jo', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'Cost, Performance & Sanity', '<h3><b>The API Bill</b></h3><p>Claude 3.7 Opus is expensive. Cursor Small is free.</p><ul><li><b>Drafting:</b> Use Smarter Models (Claude/GPT-4).</li><li><b>Refining/Typing:</b> Use Faster Models (Cursor Small).</li></ul><p><b>Sanity:</b> Don''t let the AI drive you into a ravine. If it struggles for 10 minutes, stop. Re-prompt. Reset.</p>', 'https://www.youtube.com/embed/yO7-wV7pPZQ', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'When NOT to Use AI', '<h3><b>The Danger Zone</b></h3><p>Do not use AI for:</p><ul><li><b>Production Secrets:</b> Never paste .env files.</li><li><b>Deeply Proprietary Algorithms:</b> Keep core IP local.</li><li><b>Pixel pushing adjustments:</b> Sometimes it''s faster to just change the CSS padding 2px yourself.</li></ul><p><b>Takeaway:</b> Keep your ''coding hands'' warm. Don''t atrophy completely.</p>', 'https://www.youtube.com/embed/Sal7cz3T40M', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

  -- Module 8: Applications & Career
  INSERT INTO modules (course_id, title)
  VALUES (v_course_id, 'Module 8: Applications & Career')
  ON CONFLICT (course_id, title) DO NOTHING
  RETURNING id INTO v_module_id;
  
  IF v_module_id IS NULL THEN
    SELECT id INTO v_module_id FROM modules WHERE course_id = v_course_id AND title = 'Module 8: Applications & Career';
  END IF;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'Internal Tools', '<h3><b>The Hidden Economy</b></h3><p>Every company needs internal dashboards, admin panels, and scripts. Vibe Coding makes these free to build. You can become the ''Toolsmith'' of your org.</p><h3><b>Value</b></h3><p>Saving the team 100 hours with a tool that took you 1 hour to vibe code is massive ROI.</p>', 'https://www.youtube.com/embed/6qg5iI_n8m0', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'Client Work', '<h3><b>Agencies are Dead. Long live Agencies.</b></h3><p>The billing model changes. Do not bill by hour. Bill by <b>Outcome</b>.<br>Old: ''I built the site in 40 hours @ $100/hr''.<br>New: ''I delivered the Launch Package in 2 days for $4000''.<br>Clients don''t care about AI; they care about speed and quality.</p>', 'https://www.youtube.com/embed/pU72h2Zbc5c', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'The Future of Software', '<h3><b>Software as a Commodity</b></h3><p>Code is now like oxygen—abundant. The value moves to <b>Data</b>, <b>User Experience</b>, and <b>Community</b>.</p><h3><b>Your Future</b></h3><p>You are not a coder. You are a:<br>1. <b>Product Engineer:</b> Building products.<br>2. <b>System Architect:</b> Designing flows.<br>3. <b>Taste-Maker:</b> Knowing what is ''Good''.</p><p><b>Final Vibe:</b> Embrace the exponential. Build cool things.</p>', 'https://www.youtube.com/embed/5EFd0n_n7bU', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

END $$;
