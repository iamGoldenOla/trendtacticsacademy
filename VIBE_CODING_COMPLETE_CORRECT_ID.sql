-- VIBE CODING COMPLETE RESTORE - CORRECT ID
-- This script uses the exact course ID that your URL expects
-- Run this in Supabase SQL Editor

-- Step 1: Clean up any old Vibe Coding data
DELETE FROM lessons WHERE module_id IN (
    SELECT id FROM modules WHERE course_id IN (
        SELECT id FROM courses WHERE slug = 'vibe-coding' OR title ILIKE '%Vibe Coding%'
    )
);
DELETE FROM modules WHERE course_id IN (
    SELECT id FROM courses WHERE slug = 'vibe-coding' OR title ILIKE '%Vibe Coding%'
);
DELETE FROM courses WHERE slug = 'vibe-coding' OR title ILIKE '%Vibe Coding%';

-- Step 2: Insert course with the EXACT ID from your URL
INSERT INTO courses (id, title, slug, description, category, level, price, is_published, status)
VALUES (
    'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d',
    'Vibe Coding 3.0',
    'vibe-coding',
    'Master the art of AI-assisted programming. From Zero to One with Cursor, Replit, and V0.',
    'AI Development',
    NULL,
    '49.99',
    true,
    'published'
);

-- Step 3: Insert all modules and lessons
DO $$
DECLARE
    v_course_id UUID := 'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d';
    v_module_id UUID;
BEGIN
    -- MODULE 1: Foundations
    INSERT INTO modules (course_id, title) VALUES (v_course_id, 'Module 1: Foundations of Vibe Coding') RETURNING id INTO v_module_id;
    INSERT INTO lessons (module_id, title, content, video_url, duration) VALUES
        (v_module_id, 'What Is Vibe Coding (Deep)', '<h3>The Shift from Syntax to Intent</h3><p>Vibe Coding is the practice of turning human intent into executable systems using AI.</p>', 'https://www.youtube.com/embed/yO7-wV7pPZQ', 10),
        (v_module_id, 'From Writing Code to Directing Systems', '<h3>The Soloist vs. The Conductor</h3><p>Modern developers must think in systems, not single files.</p>', 'https://www.youtube.com/embed/Sal7cz3T40M', 10),
        (v_module_id, 'Intent Is the New Programming Language', '<h3>Language as Logic</h3><p>In 2026, English is the highest-level programming language.</p>', 'https://www.youtube.com/embed/sFkS-XJb6jo', 10);

    -- MODULE 2: How AI Builds Software
    INSERT INTO modules (course_id, title) VALUES (v_course_id, 'Module 2: How AI Actually Builds Software') RETURNING id INTO v_module_id;
    INSERT INTO lessons (module_id, title, content, video_url, duration) VALUES
        (v_module_id, 'How AI Thinks (and Why It Breaks)', '<h3>Prediction, Not Reason</h3><p>LLMs predict the next token based on probability.</p>', 'https://www.youtube.com/embed/uGgCqV7G8_0', 10),
        (v_module_id, 'Context, Memory, and Constraints', '<h3>The Finite Resource</h3><p>Even with 1M token windows, precise attention degrades over size.</p>', 'https://www.youtube.com/embed/FdbBgZp33W0', 10),
        (v_module_id, 'Preventing Repetition & Duplicate Content', '<h3>The Loop Problem</h3><p>AI agents often get stuck in loops. Build exits.</p>', 'https://www.youtube.com/embed/1PHk_g8gWbU', 10);

    -- MODULE 3: Core Workflow
    INSERT INTO modules (course_id, title) VALUES (v_course_id, 'Module 3: The Core Vibe Coding Workflow') RETURNING id INTO v_module_id;
    INSERT INTO lessons (module_id, title, content, video_url, duration) VALUES
        (v_module_id, 'The Vibe Coding Loop', '<h3>The Circle of Life</h3><p>Define Intent -> Scope -> Structure -> Generate -> Verify -> Ship -> Iterate.</p>', 'https://www.youtube.com/embed/5EFd0n_n7bU', 10),
        (v_module_id, 'System Prompts vs User Prompts', '<h3>The God Mode</h3><p>System prompts are the constitution of your AI agent.</p>', 'https://www.youtube.com/embed/6qg5iI_n8m0', 10),
        (v_module_id, 'Modular Thinking', '<h3>Everything is a Lego Block</h3><p>Build modules, not monoliths.</p>', 'https://www.youtube.com/embed/pU72h2Zbc5c', 10);

    -- MODULE 4: The Vibe Toolkit
    INSERT INTO modules (course_id, title) VALUES (v_course_id, 'Module 4: The Vibe Toolkit (45+ Tools)') RETURNING id INTO v_module_id;
    INSERT INTO lessons (module_id, title, content, video_url, duration) VALUES
        (v_module_id, 'Agentic IDEs (Command Centers)', '<h3>The New Workbench</h3><p>Cursor, Windsurf, Aider, and more.</p>', 'https://www.youtube.com/embed/uGgCqV7G8_0', 10),
        (v_module_id, 'UI / Frontend AI', '<h3>Pixel Perfect Instantly</h3><p>v0.dev, Bolt.new, Lovable, Screenshot-to-Code.</p>', 'https://www.youtube.com/embed/sFkS-XJb6jo', 10),
        (v_module_id, 'Full-Stack & Auto Builders', '<h3>One Prompt, One App</h3><p>Replit Agent, Create.xyz, Databutton.</p>', 'https://www.youtube.com/embed/yO7-wV7pPZQ', 10),
        (v_module_id, 'Backend, Logic & Data', '<h3>The Backbone</h3><p>Supabase, Xano, BuildShip, Prisma.</p>', 'https://www.youtube.com/embed/1PHk_g8gWbU', 10),
        (v_module_id, 'AI Agents & Orchestration', '<h3>The Autonomy Layer</h3><p>Antigravity, Devin, LangGraph, CrewAI.</p>', 'https://www.youtube.com/embed/Sal7cz3T40M', 10);

    -- MODULE 5: Building Real Software
    INSERT INTO modules (course_id, title) VALUES (v_course_id, 'Module 5: Building Real Software') RETURNING id INTO v_module_id;
    INSERT INTO lessons (module_id, title, content, video_url, duration) VALUES
        (v_module_id, 'Building a SaaS with AI', '<h3>The Playbook</h3><p>Auth, DB, Payments, Dashboard - all with AI.</p>', 'https://www.youtube.com/embed/6qg5iI_n8m0', 10),
        (v_module_id, 'Building an LMS (Your Case Study)', '<h3>Meta-Learning</h3><p>You are using an LMS built by Vibe Coding.</p>', 'https://www.youtube.com/embed/pU72h2Zbc5c', 10),
        (v_module_id, 'Debugging AI Systems', '<h3>When it breaks</h3><p>Logs, Root Cause Analysis, Self-Healing.</p>', 'https://www.youtube.com/embed/5EFd0n_n7bU', 10);

    -- MODULE 6: Data, State & Auth
    INSERT INTO modules (course_id, title) VALUES (v_course_id, 'Module 6: Data, State & Auth') RETURNING id INTO v_module_id;
    INSERT INTO lessons (module_id, title, content, video_url, duration) VALUES
        (v_module_id, 'Databases Without Fear', '<h3>SQL is English</h3><p>With AI, SQL is just natural language.</p>', 'https://www.youtube.com/embed/FdbBgZp33W0', 10),
        (v_module_id, 'Authentication & Roles', '<h3>RLS (Row Level Security)</h3><p>Supabase uses RLS. This is critical.</p>', 'https://www.youtube.com/embed/1PHk_g8gWbU', 10),
        (v_module_id, 'State, Caching & Persistence', '<h3>The Memory of the App</h3><p>Local State, Global State, Server State.</p>', 'https://www.youtube.com/embed/uGgCqV7G8_0', 10);

    -- MODULE 7: Advanced Vibe Coding
    INSERT INTO modules (course_id, title) VALUES (v_course_id, 'Module 7: Advanced Vibe Coding') RETURNING id INTO v_module_id;
    INSERT INTO lessons (module_id, title, content, video_url, duration) VALUES
        (v_module_id, 'Verification Prompts', '<h3>Checking AI Work</h3><p>Run Verification Prompts after generation.</p>', 'https://www.youtube.com/embed/sFkS-XJb6jo', 10),
        (v_module_id, 'Cost, Performance & Sanity', '<h3>The API Bill</h3><p>Balance cost and intelligence.</p>', 'https://www.youtube.com/embed/yO7-wV7pPZQ', 10),
        (v_module_id, 'When NOT to Use AI', '<h3>The Danger Zone</h3><p>Never paste secrets. Keep core IP local.</p>', 'https://www.youtube.com/embed/Sal7cz3T40M', 10);

    -- MODULE 8: Applications & Career
    INSERT INTO modules (course_id, title) VALUES (v_course_id, 'Module 8: Applications & Career') RETURNING id INTO v_module_id;
    INSERT INTO lessons (module_id, title, content, video_url, duration) VALUES
        (v_module_id, 'Internal Tools', '<h3>The Hidden Economy</h3><p>Become the Toolsmith of your org.</p>', 'https://www.youtube.com/embed/6qg5iI_n8m0', 10),
        (v_module_id, 'Client Work', '<h3>Value-Based Pricing</h3><p>Bill by outcome, not by hour.</p>', 'https://www.youtube.com/embed/pU72h2Zbc5c', 10),
        (v_module_id, 'The Future of Software', '<h3>Software as a Commodity</h3><p>Code is abundant. Taste is scarce.</p>', 'https://www.youtube.com/embed/5EFd0n_n7bU', 10);

END $$;

-- Step 4: Verify
SELECT 
    c.title as course,
    COUNT(DISTINCT m.id) as modules,
    COUNT(l.id) as lessons
FROM courses c
LEFT JOIN modules m ON m.course_id = c.id
LEFT JOIN lessons l ON l.module_id = m.id
WHERE c.id = 'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d'
GROUP BY c.title;
