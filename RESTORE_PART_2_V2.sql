-- Vibe Coding Restoration Part 2: Toolkit (V2 - Simple Inserts)
-- Run this AFTER Part 1

DO $$
DECLARE
  v_course_id UUID;
  v_module_id UUID;
BEGIN
  SELECT id INTO v_course_id FROM courses WHERE slug = 'vibe-coding';

  -- Module 4: The Vibe Toolkit (45+ Tools)
  SELECT id INTO v_module_id FROM modules WHERE course_id = v_course_id AND title = 'Module 4: The Vibe Toolkit (45+ Tools)';
  IF v_module_id IS NULL THEN
    INSERT INTO modules (course_id, title) VALUES (v_course_id, 'Module 4: The Vibe Toolkit (45+ Tools)') RETURNING id INTO v_module_id;
  END IF;

  -- Lessons for Module 4
  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'Agentic IDEs (Command Centers)') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'Agentic IDEs (Command Centers)', '<h3><b>The New Workbench</b></h3><p>We review the top Agentic IDEs: Cursor, Windsurf, Aider, and more.</p>', 'https://www.youtube.com/embed/uGgCqV7G8_0', 10);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'UI / Frontend AI') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'UI / Frontend AI', '<h3><b>Pixel Perfect instantly</b></h3><p>Tools: v0.dev, Bolt.new, Lovable, Screenshot-to-Code.</p>', 'https://www.youtube.com/embed/sFkS-XJb6jo', 10);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'Full-Stack & Auto Builders') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'Full-Stack & Auto Builders', '<h3><b>One Prompt, One App</b></h3><p>Tools: Replit Agent, Create.xyz, Databutton, Softr, Glide.</p>', 'https://www.youtube.com/embed/yO7-wV7pPZQ', 10);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'Backend, Logic & Data') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'Backend, Logic & Data', '<h3><b>The Backbone</b></h3><p>Tools: Supabase, Xano, BuildShip, Prisma.</p>', 'https://www.youtube.com/embed/1PHk_g8gWbU', 10);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'AI Agents & Orchestration') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'AI Agents & Orchestration', '<h3><b>The Autonomy Layer</b></h3><p>Tools: Antigravity, Devin, LangGraph, CrewAI.</p>', 'https://www.youtube.com/embed/Sal7cz3T40M', 10);
  END IF;

  -- Module 5: Building Real Software
  SELECT id INTO v_module_id FROM modules WHERE course_id = v_course_id AND title = 'Module 5: Building Real Software';
  IF v_module_id IS NULL THEN
    INSERT INTO modules (course_id, title) VALUES (v_course_id, 'Module 5: Building Real Software') RETURNING id INTO v_module_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'Building a SaaS with AI') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'Building a SaaS with AI', '<h3><b>The Playbook</b></h3><p>Auth, DB, Payments, Dashboard - all with AI assistance.</p>', 'https://www.youtube.com/embed/6qg5iI_n8m0', 10);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'Building an LMS (Your Case Study)') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'Building an LMS (Your Case Study)', '<h3><b>Meta-Learning</b></h3><p>You are using an LMS built by Vibe Coding.</p>', 'https://www.youtube.com/embed/pU72h2Zbc5c', 10);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'Debugging AI Systems') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'Debugging AI Systems', '<h3><b>When it breaks</b></h3><p>Logs, Root Cause Analysis, Self-Healing systems.</p>', 'https://www.youtube.com/embed/5EFd0n_n7bU', 10);
  END IF;

  -- Module 6: Data, State & Auth
  SELECT id INTO v_module_id FROM modules WHERE course_id = v_course_id AND title = 'Module 6: Data, State & Auth';
  IF v_module_id IS NULL THEN
    INSERT INTO modules (course_id, title) VALUES (v_course_id, 'Module 6: Data, State & Auth') RETURNING id INTO v_module_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'Databases Without Fear') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'Databases Without Fear', '<h3><b>SQL is English</b></h3><p>With AI, SQL is just natural language.</p>', 'https://www.youtube.com/embed/FdbBgZp33W0', 10);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'Authentication & Roles') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'Authentication & Roles', '<h3><b>RLS (Row Level Security)</b></h3><p>Supabase uses RLS. This is critical.</p>', 'https://www.youtube.com/embed/1PHk_g8gWbU', 10);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM lessons WHERE module_id = v_module_id AND title = 'State, Caching & Persistence') THEN
    INSERT INTO lessons (module_id, title, content, video_url, duration)
    VALUES (v_module_id, 'State, Caching & Persistence', '<h3><b>The Memory of the App</b></h3><p>Local State, Global State, Server State, Browser Cache.</p>', 'https://www.youtube.com/embed/uGgCqV7G8_0', 10);
  END IF;

END $$;
