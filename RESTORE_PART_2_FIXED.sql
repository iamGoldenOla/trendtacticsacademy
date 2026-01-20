-- Vibe Coding Restoration Part 2: Toolkit (FIXED - No Order Column)
-- Run this AFTER Part 1

DO $$
DECLARE
  v_course_id UUID;
  v_module_id UUID;
BEGIN
  SELECT id INTO v_course_id FROM courses WHERE slug = 'vibe-coding';

  -- Module 4: The Vibe Toolkit (45+ Tools)
  INSERT INTO modules (course_id, title)
  VALUES (v_course_id, 'Module 4: The Vibe Toolkit (45+ Tools)')
  ON CONFLICT (course_id, title) DO NOTHING
  RETURNING id INTO v_module_id;
  
  -- If module already exists, get its ID
  IF v_module_id IS NULL THEN
    SELECT id INTO v_module_id FROM modules WHERE course_id = v_course_id AND title = 'Module 4: The Vibe Toolkit (45+ Tools)';
  END IF;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'Agentic IDEs (Command Centers)', '<h3><b>The New Workbench</b></h3><p>We review the top Agentic IDEs:</p><ul><li><b>Cursor:</b> The current King. Best UX, ''Composer'' feature.</li><li><b>Windsurf:</b> Context-aware, deep codebase understanding.</li><li><b>Trae / PearAI / Void:</b> Open-source alternatives.</li><li><b>Aider:</b> CLI-based, extremely powerful for power users.</li></ul><h3><b>When to use what?</b></h3><p>Use <b>Cursor</b> for daily driving. Use <b>Aider</b> for massive refactors via terminal.</p>', 'https://www.youtube.com/embed/uGgCqV7G8_0', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'UI / Frontend AI', '<h3><b>Pixel Perfect instantly</b></h3><p>Frontend is solved. Tools:</p><ul><li><b>v0.dev:</b> Vercel''s generative UI. Copy-paste React code.</li><li><b>Bolt.new:</b> Full stack browser environments.</li><li><b>Lovable:</b> ''GPT-4 for Figma''.</li><li><b>Screenshot-to-Code:</b> Literal magic.</li></ul><h3><b>Workflow</b></h3><p>Take a screenshot of a site you like -> Screenshot-to-Code -> Paste into v0.dev -> Refine -> Paste into Cursor.</p>', 'https://www.youtube.com/embed/sFkS-XJb6jo', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'Full-Stack & Auto Builders', '<h3><b>One Prompt, One App</b></h3><p>Tools that build the whole package:</p><ul><li><b>Replit Agent:</b> Builds valid, deployable apps in the browser.</li><li><b>Create.xyz:</b> Component driven generation.</li><li><b>Databutton:</b> AI-native app builder with Python backend.</li><li><b>Softr / Glide:</b> No-code on top of data.</li></ul><h3><b>Use Case</b></h3><p>Use these for internal tools, MVPs, and prototypes. Use Code (Cursor) for scale.</p>', 'https://www.youtube.com/embed/yO7-wV7pPZQ', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'Backend, Logic & Data', '<h3><b>The Backbone</b></h3><p>Modules for data:</p><ul><li><b>Supabase:</b> The Postgres standard. Auth, Realtime, Vector.</li><li><b>Xano:</b> Nocode API builder.</li><li><b>BuildShip:</b> Visual backend logic.</li><li><b>Prisma:</b> Typesafe ORM (essential for Vibe Coding).</li></ul><h3><b>Recommendation</b></h3><p>Stick to <b>Supabase + Prisma</b>. It provides the strongest types for the AI to understand.</p>', 'https://www.youtube.com/embed/1PHk_g8gWbU', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'AI Agents & Orchestration', '<h3><b>The Autonomy Layer</b></h3><p>Agents that run loops:</p><ul><li><b>Antigravity:</b> (Self-Referential) This system!</li><li><b>Devin:</b> The first AI software engineer.</li><li><b>LangGraph:</b> Building stateful agent workflows.</li><li><b>CrewAI:</b> Teams of agents.</li></ul><h3><b>Future</b></h3><p>You will manage a ''Crew'' of agents (QA, Dev, DevOps) rather than writing code yourself.</p>', 'https://www.youtube.com/embed/Sal7cz3T40M', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

  -- Module 5: Building Real Software
  INSERT INTO modules (course_id, title)
  VALUES (v_course_id, 'Module 5: Building Real Software')
  ON CONFLICT (course_id, title) DO NOTHING
  RETURNING id INTO v_module_id;
  
  IF v_module_id IS NULL THEN
    SELECT id INTO v_module_id FROM modules WHERE course_id = v_course_id AND title = 'Module 5: Building Real Software';
  END IF;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'Building a SaaS with AI', '<h3><b>The Playbook</b></h3><p>1. <b>Auth:</b> Clerk or Supabase Auth.<br>2. <b>DB:</b> Supabase.<br>3. <b>Payments:</b> Stripe (Ask AI to ''Generate Stripe Checkout Session code'').<br>4. <b>Dashboard:</b> v0.dev for UI.</p><h3><b>Integrations</b></h3><p>AI is great at reading documentation. Paste the Stripe API docs into Cursor and say ''Implement this''. It works 99% of the time.</p>', 'https://www.youtube.com/embed/6qg5iI_n8m0', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'Building an LMS (Your Case Study)', '<h3><b>Meta-Learning</b></h3><p>You are using an LMS built by Vibe Coding. How does it work?</p><ul><li><b>Courses Table:</b> Holds metadata.</li><li><b>Modules/Lessons:</b> Linked via Foreign Keys.</li><li><b>Auto-Generation:</b> The ''Antigravity'' engine checks for missing content and fills it.</li><li><b>Resume Logic:</b> ''Last Lesson'' ID stored in User Profile.</li></ul>', 'https://www.youtube.com/embed/pU72h2Zbc5c', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'Debugging AI Systems', '<h3><b>When it breaks</b></h3><p>AI writes bugs. Debugging them requires:</p><ul><li><b>Logs:</b> ''Console.log is your friend''.</li><li><b>Root Cause Analysis:</b> Paste the error into the AI. ''Explain this error and fix it''.</li><li><b>System Failures:</b> If the AI Loops, check constraints.</li></ul><h3><b>Self-Healing</b></h3><p>Auto-feed the error back to the AI. ''If error, run fix_agent(error)''.</p>', 'https://www.youtube.com/embed/5EFd0n_n7bU', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

  -- Module 6: Data, State & Auth
  INSERT INTO modules (course_id, title)
  VALUES (v_course_id, 'Module 6: Data, State & Auth')
  ON CONFLICT (course_id, title) DO NOTHING
  RETURNING id INTO v_module_id;
  
  IF v_module_id IS NULL THEN
    SELECT id INTO v_module_id FROM modules WHERE course_id = v_course_id AND title = 'Module 6: Data, State & Auth';
  END IF;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'Databases Without Fear', '<h3><b>SQL is English</b></h3><p>With AI, SQL is just natural language.<br>Prompt: ''Select all users who haven''t logged in for 30 days.'' -> SELECT * FROM users WHERE last_login < NOW() - INTERVAL ''30 days''.</p><h3><b>Migration</b></h3><p>Never write migrations manually. Ask Supabase AI: ''Add a phone_number column to users table''. You don''t need to be a DBA. You need to know Data Models.</p>', 'https://www.youtube.com/embed/FdbBgZp33W0', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'Authentication & Roles', '<h3><b>RLS (Row Level Security)</b></h3><p>Supabase uses RLS. This is critical.</p><ul><li><b>Rule:</b> auth.uid() = user_id.</li><li><b>Meaning:</b> Only I can see my data.</li></ul><p>AI often forgets RLS. <b>Always prompt:</b> ''Ensure RLS policies are enabled and correct.''</p><h3><b>Roles</b></h3><p>Admin, Student, Instructor. Store these in public.users table so RLS can read them.</p>', 'https://www.youtube.com/embed/1PHk_g8gWbU', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

  INSERT INTO lessons (module_id, title, content, video_url, duration)
  VALUES (v_module_id, 'State, Caching & Persistence', '<h3><b>The Memory of the App</b></h3><p>Apps need to remember.</p><ul><li><b>Local State:</b> React useState (Ephemeral).</li><li><b>Global State:</b> Redux/Zustand (Session).</li><li><b>Server State:</b> Database (Permanent).</li><li><b>Browser Cache:</b> LocalStorage (Semi-Permanent).</li></ul><p><b>Vibe Lesson:</b> AI loves useState. Remind it to use LocalStorage or Supabase if you want data to survive a reload.</p>', 'https://www.youtube.com/embed/uGgCqV7G8_0', 10)
  ON CONFLICT (module_id, title) DO UPDATE SET content = EXCLUDED.content, video_url = EXCLUDED.video_url;

END $$;
