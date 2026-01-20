-- Vibe Coding Restoration Part 1: Foundations
-- Run this AFTER Part 0 (if applicable)

DO $$
DECLARE
  v_course_id UUID;
  v_module_id UUID;
BEGIN

  -- Ensure Course Exists (Only in Part 1)
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
  SELECT id INTO v_course_id FROM courses WHERE slug = 'vibe-coding';

  -- Module: Module 1: Foundations of Vibe Coding
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

  -- Module: Module 2: How AI Actually Builds Software
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

  -- Module: Module 3: The Core Vibe Coding Workflow
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

END $$;
