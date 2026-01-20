
-- Restore Vibe Coding Course Content
-- Generated automatically from vibe-coding-3.0.json

-- 1. Ensure Course Exists
INSERT INTO courses (id, title, description, image_url, slug, price, level, category)
VALUES (
  '550e8400-e29b-41d4-a716-446655440000',
  'Vibe Coding',
  'Master the art of AI-assisted programming. From Zero to One with Cursor, Replit, and V0.',
  '/images/vibe-coding-thumb.jpg',
  'vibe-coding',
  49.99,
  'All Levels',
  'AI Development'
)
ON CONFLICT (slug) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description;

-- 2. Variables for IDs
DO $$
DECLARE
  v_course_id UUID;
  v_module_id UUID;
BEGIN
  -- Get Course ID
  SELECT id INTO v_course_id FROM courses WHERE slug = 'vibe-coding';

  -- 3. Delete existing content for this course to prevent duplicates?
  -- ideally we shouldn't if we want to preserve student progress, but if the structure changed, we might have to.
  -- For now, let's assume we are purely adding/updating based on title or clearing old stuff first if NUKE was run.
  -- The user likely ran NUKE, so we are fresh.
  
  -- But just in case, let's just insert modules and lessons.
  

  -- Module 1: Module 1: Foundations of Vibe Coding
  INSERT INTO modules (course_id, title, "order")
  VALUES (v_course_id, 'Module 1: Foundations of Vibe Coding', 1)
  ON CONFLICT (course_id, title) DO UPDATE SET "order" = 1
  RETURNING id INTO v_module_id;

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'What Is Vibe Coding (Deep)', '<h3><b>The Shift from Syntax to Intent</b></h3><p>Vibe Coding is the practice of turning human intent into executable systems using AI. Unlike traditional coding—where syntax is king—Vibe Coding treats clarity, structure, and judgment as the core skills.</p><h3><b>Why Syntax-First Learning Collapses</b></h3><p>In the past, 80% of lines written were boilerplate. In 2026, AI handles this instantly. Learning syntax first is like learning to spell every word in the dictionary before writing an essay. It is slow and outdated.</p><h3><b>Orchestration Beats Implementation</b></h3><p>The new developer is a Conductor. You don''t play every instrument; you ensure they play <i>together</i>. Your job is to define the ''Vibe'' (the architecture, user experience, and constraints) and let the AI agents handle the ''Notes'' (functions, variable names, style).</p><h3><b>Cost Curve of Software</b></h3><p>AI reduces the cost of producing code to near-zero. This means the <i>volume</i> of code will explode. The bottleneck shifts from ''Writing'' to ''Reviewing'' and ''Integrating''.</p><h3><b>Key Takeaways</b></h3><ul><li><b>Intent > Syntax:</b> If you can describe it, you can build it.</li><li><b>Reviewer Mindset:</b> You are now Editor-in-Chief.</li><li><b>Speed:</b> Experimentation is now free.</li></ul><h3><b>Tools Referenced</b></h3><p>Using: ChatGPT, Claude 3.7, Gemini 2.0, Cursor, Antigravity.</p>', 'https://www.youtube.com/embed/yO7-wV7pPZQ', 1, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'From Writing Code to Directing Systems', '<h3><b>The Soloist vs. The Conductor</b></h3><p>A Soloist focuses on one line at a time. A Conductor listens to the whole symphony. Modern developers must think in systems.</p><h3><b>Why File-by-File is Obsolete</b></h3><p>Thinking about a single file ignores the side effects on the rest of the app. AI agents like Composer allow you to edit 20 files at once. You must visualize the <i>graph</i> of your application, not just the current file.</p><h3><b>System Thinking</b></h3><p>Ask: ''If I change the User Schema, what breaks?'' <br>The AI might miss this. You must not. You provide the ''Global Context'' that the AI lacks.</p><h3><b>Key Takeaways</b></h3><ul><li>Decisions > Keystrokes.</li><li>You are responsible for the <i>architecture</i>.</li><li>AI is a powerful engine, but it needs a steering wheel.</li></ul><h3><b>Tools Referenced</b></h3><p>Using: Cursor (Composer), Windsurf, Aider, Continue.dev, Zed.</p>', 'https://www.youtube.com/embed/Sal7cz3T40M', 2, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Intent Is the New Programming Language', '<h3><b>Language as Logic</b></h3><p>In 2026, English (or any natural language) <i>is</i> the highest-level programming language. The compiler is the LLM.</p><h3><b>Vague vs. Constrained Prompts</b></h3><p><b>Bad:</b> ''Make a landing page.'' (Ambiguous, Leads to hallucinations)<br><b>Good:</b> ''Create a Next.js landing page with a black H1 using Inter font, a sticky navbar, and a contact form that emails me.'' (Constrained, Specific)</p><h3><b>Translating Business to Technical</b></h3><p>Your skill is translating ''We need more sales'' (Business) into ''Add a popup modal with a 10% discount code on exit intent'' (Technical).</p><h3><b>Key Takeaways</b></h3><ul><li>Ambiguity = Bugs.</li><li>Specific Constraints = Correct Code.</li><li>Prompting is just specifying requirements clearly.</li></ul><h3><b>Exercise</b></h3><p>Rewrite a vague prompt (''Fix the bug'') into a structured one with 3 constraints.</p>', 'https://www.youtube.com/embed/sFkS-XJb6jo', 3, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  -- Module 2: Module 2: How AI Actually Builds Software
  INSERT INTO modules (course_id, title, "order")
  VALUES (v_course_id, 'Module 2: How AI Actually Builds Software', 2)
  ON CONFLICT (course_id, title) DO UPDATE SET "order" = 2
  RETURNING id INTO v_module_id;

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'How AI Thinks (and Why It Breaks)', '<h3><b>Prediction, Not Reason</b></h3><p>LLMs do not ''think''. They predict the next token based on probability. If you ask for a library that <i>should</i> exist but doesn''t, it might invent one (Hallucination).</p><h3><b>Why AI Repeats Itself</b></h3><p>AI loves patterns. If your codebase has 5 bad files, it will make the 6th file bad too. It mimics your existing style—good or bad.</p><h3><b>Context Windows</b></h3><p>The ''Context Window'' is the AI''s short-term memory. If you feed it too much trash (logs, lockfiles), it forgets your instructions. Keep the context clean.</p><h3><b>Key Takeaways</b></h3><ul><li>AI is a pattern matcher, not a logician.</li><li>It requires ''Guardrails'' to stay on track.</li><li>Trust but verify.</li></ul><h3><b>Tools Referenced</b></h3><p>OpenAI, Anthropic, Google AI Studio.</p>', 'https://www.youtube.com/embed/uGgCqV7G8_0', 1, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Context, Memory, and Constraints', '<h3><b>The Finite Resource</b></h3><p>Even with 1M token windows, precise attention degrades over size. You cannot dump your entire hard drive into the prompt.</p><h3><b>Memory Systems</b></h3><p><b>RAG (Retrieval Augmented Generation):</b> Fetching only the relevant docs for the current query.<br><b>Vector Databases:</b> Storing code meaning mathematically to find related files.</p><h3><b>Why Projects Decay</b></h3><p>As a project grows, ''Context Drift'' happens. The AI loses the original architectural vision. You must remind it of the ''Rules'' (via .cursorrules) constantly.</p><h3><b>Tools Referenced</b></h3><p>LangChain, LlamaIndex, Pinecone, Supabase Vector.</p>', 'https://www.youtube.com/embed/FdbBgZp33W0', 2, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Preventing Repetition & Duplicate Content', '<h3><b>The Loop Problem</b></h3><p>AI agents often get stuck in loops (like your LMS did!). They try to ''fix'' a problem, fail, and try the exact same fix again.</p><h3><b>The Solution: Persistence & Hashing</b></h3><p><b>State:</b> You must save the state (''Lesson 1 Installed'').<br><b>Hashing:</b> Check content uniqueness. If the new content is 99% similar to the old, discard it.</p><h3><b>LMS Case Study</b></h3><p>This course itself uses a ''Circuit Breaker''. If generation fails or loops, we switch to a ''Direct DB'' fetch or a ''Hardcoded Fallback'' to guarantee continuity. We never block the user.</p><h3><b>Key Takeaways</b></h3><ul><li>Always assume the agent will loop. Build exits.</li><li>Persist state immediately.</li><li>Check regular DB before asking AI.</li></ul>', 'https://www.youtube.com/embed/1PHk_g8gWbU', 3, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  -- Module 3: Module 3: The Core Vibe Coding Workflow
  INSERT INTO modules (course_id, title, "order")
  VALUES (v_course_id, 'Module 3: The Core Vibe Coding Workflow', 3)
  ON CONFLICT (course_id, title) DO UPDATE SET "order" = 3
  RETURNING id INTO v_module_id;

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'The Vibe Coding Loop', '<h3><b>The Circle of Life</b></h3><p>The workflow is circular, not linear:</p><ol><li><b>Define Intent:</b> What do we want?</li><li><b>Define Scope:</b> How big is it?</li><li><b>Structure:</b> What files do we need?</li><li><b>Generate:</b> Let AI write v1.</li><li><b>Verify:</b> Does it run?</li><li><b>Persist/Ship:</b> Save it.</li><li><b>Iterate:</b> Improve v1 to v2.</li></ol><p><b>Stop Rule:</b> Iterate once, then ship. Don''t polish forever.</p><h3><b>Tools Referenced</b></h3><p>Antigravity, Cursor, Notion AI, Obsidian.</p>', 'https://www.youtube.com/embed/5EFd0n_n7bU', 1, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'System Prompts vs User Prompts', '<h3><b>The God Mode</b></h3><p><b>User Prompt:</b> ''Write a function.'' (Ephemeral, one-time)<br><b>System Prompt:</b> ''You are a Senior Typescript Engineer. Always use Arrow Functions.'' (Persistent, Global)</p><h3><b>Enforcing Rules</b></h3><p>System prompts are the ''constitution'' of your AI agent. They define the personality, the constraints, and the mandatory behaviors. If you want consistent code, tune the System Prompt, not the User Prompt.</p><h3><b>Key Takeaways</b></h3><ul><li>System Prompts = Governance.</li><li>User Prompts = Commands.</li><li>Make the AI self-check via System Instructions.</li></ul>', 'https://www.youtube.com/embed/6qg5iI_n8m0', 2, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Modular Thinking (Courses, Apps, Systems)', '<h3><b>Everything is a Lego Block</b></h3><p>Don''t build a ''Monolith''. Build modules. <br>In this LMS: Course -> Module -> Lesson -> Quiz.<br>In App Dev: Auth -> Database -> API -> Frontend.</p><h3><b>Why Modular?</b></h3><p>1. <b>Easier Debugging:</b> If Auth breaks, the API is still fine.<br>2. <b>AI Context:</b> AI can handle small modules perfectly. It chokes on huge monoliths.</p><h3><b>Key Takeaways</b></h3><ul><li>Small scopes = High success.</li><li>Decompose big problems into tiny modules.</li><li>This mirrors the LMS schema design.</li></ul>', 'https://www.youtube.com/embed/pU72h2Zbc5c', 3, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  -- Module 4: Module 4: The Vibe Toolkit (45+ Tools)
  INSERT INTO modules (course_id, title, "order")
  VALUES (v_course_id, 'Module 4: The Vibe Toolkit (45+ Tools)', 4)
  ON CONFLICT (course_id, title) DO UPDATE SET "order" = 4
  RETURNING id INTO v_module_id;

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Agentic IDEs (Command Centers)', '<h3><b>The New Workbench</b></h3><p>We review the top Agentic IDEs:</p><ul><li><b>Cursor:</b> The current King. Best UX, ''Composer'' feature.</li><li><b>Windsurf:</b> Context-aware, deep codebase understanding.</li><li><b>Trae / PearAI / Void:</b> Open-source alternatives.</li><li><b>Aider:</b> CLI-based, extremely powerful for power users.</li></ul><h3><b>When to use what?</b></h3><p>Use <b>Cursor</b> for daily driving. Use <b>Aider</b> for massive refactors via terminal.</p>', 'https://www.youtube.com/embed/uGgCqV7G8_0', 1, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'UI / Frontend AI', '<h3><b>Pixel Perfect instanly</b></h3><p>Frontend is solved. Tools:</p><ul><li><b>v0.dev:</b> Vercel''s generative UI. Copy-paste React code.</li><li><b>Bolt.new:</b> Full stack browser environments.</li><li><b>Lovable:</b> ''GPT-4 for Figma''.</li><li><b>Screenshot-to-Code:</b> Literal magic.</li></ul><h3><b>Workflow</b></h3><p>Take a screenshot of a site you like -> Screenshot-to-Code -> Paste into v0.dev -> Refine -> Paste into Cursor.</p>', 'https://www.youtube.com/embed/sFkS-XJb6jo', 2, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Full-Stack & Auto Builders', '<h3><b>One Prompt, One App</b></h3><p>Tools that build the whole package:</p><ul><li><b>Replit Agent:</b> Builds valid, deployable apps in the browser.</li><li><b>Create.xyz:</b> Component driven generation.</li><li><b>Databutton:</b> AI-native app builder with Python backend.</li><li><b>Softr / Glide:</b> No-code on top of data.</li></ul><h3><b>Use Case</b></h3><p>Use these for internal tools, MVPs, and prototypes. Use Code (Cursor) for scale.</p>', 'https://www.youtube.com/embed/yO7-wV7pPZQ', 3, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Backend, Logic & Data', '<h3><b>The Backbone</b></h3><p>Modules for data:</p><ul><li><b>Supabase:</b> The Postgres standard. Auth, Realtime, Vector.</li><li><b>Xano:</b> Nocode API builder.</li><li><b>BuildShip:</b> Visual backend logic.</li><li><b>Prisma:</b> Typesafe ORM (essential for Vibe Coding).</li></ul><h3><b>Recommendation</b></h3><p>Stick to <b>Supabase + Prisma</b>. It provides the strongest types for the AI to understand.</p>', 'https://www.youtube.com/embed/1PHk_g8gWbU', 4, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'AI Agents & Orchestration', '<h3><b>The Autonomy Layer</b></h3><p>Agents that run loops:</p><ul><li><b>Antigravity:</b> (Self-Referential) This system!</li><li><b>Devin:</b> The first AI software engineer.</li><li><b>LangGraph:</b> Building stateful agent workflows.</li><li><b>CrewAI:</b> Teams of agents.</li></ul><h3><b>Future</b></h3><p>You will manage a ''Crew'' of agents (QA, Dev, DevOps) rather than writing code yourself.</p>', 'https://www.youtube.com/embed/Sal7cz3T40M', 5, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  -- Module 5: Module 5: Building Real Software
  INSERT INTO modules (course_id, title, "order")
  VALUES (v_course_id, 'Module 5: Building Real Software', 5)
  ON CONFLICT (course_id, title) DO UPDATE SET "order" = 5
  RETURNING id INTO v_module_id;

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Building a SaaS with AI', '<h3><b>The Playbook</b></h3><p>1. <b>Auth:</b> Clerk or Supabase Auth.<br>2. <b>DB:</b> Supabase.<br>3. <b>Payments:</b> Stripe (Ask AI to ''Generate Stripe Checkout Session code'').<br>4. <b>Dashboard:</b> v0.dev for UI.</p><h3><b>Integrations</b></h3><p>AI is great at reading documentation. Paste the Stripe API docs into Cursor and say ''Implement this''. It works 99% of the time.</p>', 'https://www.youtube.com/embed/6qg5iI_n8m0', 1, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Building an LMS (Your Case Study)', '<h3><b>Meta-Learning</b></h3><p>You are using an LMS built by Vibe Coding. How does it work?</p><ul><li><b>Courses Table:</b> Holds metadata.</li><li><b>Modules/Lessons:</b> Linked via Foreign Keys.</li><li><b>Auto-Generation:</b> The ''Antigravity'' engine checks for missing content and fills it.</li><li><b>Resume Logic:</b> ''Last Lesson'' ID stored in User Profile.</li></ul><h3><b>Exercise</b></h3><p>Ask Cursor: ''Design a SQL schema for a Learning Management System with progress tracking.''</p>', 'https://www.youtube.com/embed/pU72h2Zbc5c', 2, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Debugging AI Systems', '<h3><b>When it breaks</b></h3><p>AI writes bugs. Debugging them requires:</p><ul><li><b>Logs:</b> ''Console.log is your friend''.</li><li><b>Root Cause Analysis:</b> Paste the error into the AI. ''Explain this error and fix it''.</li><li><b>System Failures:</b> If the AI Loops, check constraints.</li></ul><h3><b>Self-Healing</b></h3><p>Auto-feed the error back to the AI. ''If error, run fix_agent(error)''.</p>', 'https://www.youtube.com/embed/5EFd0n_n7bU', 3, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  -- Module 6: Module 6: Data, State & Auth
  INSERT INTO modules (course_id, title, "order")
  VALUES (v_course_id, 'Module 6: Data, State & Auth', 6)
  ON CONFLICT (course_id, title) DO UPDATE SET "order" = 6
  RETURNING id INTO v_module_id;

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Databases Without Fear', '<h3><b>SQL is English</b></h3><p>With AI, SQL is just natural language. <br>Prompt: ''Select all users who haven''t logged in for 30 days.'' -> `SELECT * FROM users WHERE last_login < NOW() - INTERVAL ''30 days''`.</p><h3><b>Migration</b></h3><p>Never write migrations manually. Ask Supabase AI: ''Add a phone_number column to users table''.</p><p><b>Takeaway:</b> You don''t need to be a DBA. You need to know Data Models.</p>', 'https://www.youtube.com/embed/FdbBgZp33W0', 1, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Authentication & Roles', '<h3><b>RLS (Row Level Security)</b></h3><p>Supabase uses RLS. This is critical.</p><ul><li><b>Rule:</b> `auth.uid() = user_id`.</li><li><b>Meaning:</b> Only I can see my data.</li></ul><p>AI often forgets RLS. <b>Always prompt:</b> ''Ensure RLS policies are enabled and correct.''</p><h3><b>Roles</b></h3><p>Admin, Student, Instructor. Store these in `public.users` table so RLS can read them.</p>', 'https://www.youtube.com/embed/1PHk_g8gWbU', 2, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'State, Caching & Persistence', '<h3><b>The Memory of the App</b></h3><p>Apps need to remember.</p><ul><li><b>Local State:</b> React `useState` (Ephemeral).</li><li><b>Global State:</b> Redux/Zustand (Session).</li><li><b>Server State:</b> Database (Permanent).</li><li><b>Browser Cache:</b> LocalStorage (Semi-Permanent).</li></ul><p><b>Vibe Lesson:</b> AI loves `useState`. Remind it to use `LocalStorage` or `Supabase` if you want data to survive a reload.</p>', 'https://www.youtube.com/embed/uGgCqV7G8_0', 3, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  -- Module 7: Module 7: Advanced Vibe Coding
  INSERT INTO modules (course_id, title, "order")
  VALUES (v_course_id, 'Module 7: Advanced Vibe Coding', 7)
  ON CONFLICT (course_id, title) DO UPDATE SET "order" = 7
  RETURNING id INTO v_module_id;

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Verification Prompts', '<h3><b>Checking the AI''s Work</b></h3><p>After generation, run a Verification Prompt:</p><ul><li>''List 3 ways this code could fail.''</li><li>''Explain this code to a 5 year old.''</li><li>''Audit for security vulnerabilities.''</li></ul><p>This forces the AI to switch from ''Creative Writer'' to ''Critical Critic''.</p>', 'https://www.youtube.com/embed/sFkS-XJb6jo', 1, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Cost, Performance & Sanity', '<h3><b>The API Bill</b></h3><p>Claude 3.7 Opus is expensive. Cursor Small is free.</p><ul><li><b>Drafting:</b> Use Smarter Models (Claude/GPT-4).</li><li><b>Refining/Typing:</b> Use Faster Models (Cursor Small).</li></ul><p><b>Sanity:</b> Don''t let the AI drive you into a ravine. If it struggles for 10 minutes, stop. Re-prompt. Reset.</p>', 'https://www.youtube.com/embed/yO7-wV7pPZQ', 2, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'When NOT to Use AI', '<h3><b>The Danger Zone</b></h3><p>Do not use AI for:</p><ul><li><b>Production Secrets:</b> Never paste .env files.</li><li><b>Deeply Proprietary Algorithms:</b> Keep core IP local.</li><li><b>Pixel pushing adjustments:</b> Sometimes it''s faster to just change the CSS padding 2px yourself.</li></ul><p><b>Takeaway:</b> Keep your ''coding hands'' warm. Don''t atrophy completely.</p>', 'https://www.youtube.com/embed/Sal7cz3T40M', 3, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  -- Module 8: Module 8: Applications & Career
  INSERT INTO modules (course_id, title, "order")
  VALUES (v_course_id, 'Module 8: Applications & Career', 8)
  ON CONFLICT (course_id, title) DO UPDATE SET "order" = 8
  RETURNING id INTO v_module_id;

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Internal Tools', '<h3><b>The Hidden Economy</b></h3><p>Every company needs internal dashboards, admin panels, and scripts. Vibe Coding makes these free to build. You can become the ''Toolsmith'' of your org.</p><h3><b>Value</b></h3><p>Saving the team 100 hours with a tool that took you 1 hour to vibe code is massive ROI.</p>', 'https://www.youtube.com/embed/6qg5iI_n8m0', 1, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'Client Work', '<h3><b>Agencies are Dead. Long live Agencies.</b></h3><p>The billing model changes. Do not bill by hour. Bill by <b>Outcome</b>. <br>Old: ''I built the site in 40 hours @ $100/hr''.<br>New: ''I delivered the Launch Package in 2 days for $4000''.<br>Clients don''t care about AI; they care about speed and quality.</p>', 'https://www.youtube.com/embed/pU72h2Zbc5c', 2, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

  INSERT INTO lessons (module_id, title, content, video_url, "order", duration)
  VALUES (v_module_id, 'The Future of Software', '<h3><b>Software as a Commodity</b></h3><p>Code is now like oxygen—abundant. The value moves to <b>Data</b>, <b>User Experience</b>, and <b>Community</b>.</p><h3><b>Your Future</b></h3><p>You are not a coder. You are a: <br>1. <b>Product Engineer:</b> Building products.<br>2. <b>System Architect:</b> Designing flows.<br>3. <b>Taste-Maker:</b> Knowing what is ''Good''.</p><p><b>Final Vibe:</b> Embrace the exponential. Build cool shit.</p>', 'https://www.youtube.com/embed/5EFd0n_n7bU', 3, 10)
  ON CONFLICT (module_id, title) DO UPDATE SET
    content = EXCLUDED.content,
    video_url = EXCLUDED.video_url,
    "order" = EXCLUDED."order";

END $$;
