
-- UNIVERSAL CONTENT UPGRADE - PART 1
-- Vibe Coding Modules 1-4 (Lessons 1-14)
-- Applying Gold Standard Template

-- ============================================================
-- MODULE 1: Foundations of Vibe Coding
-- ============================================================

-- Lesson 1: Intent Is the New Programming Language
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Shift Your Thinking:</b> Understand why "what you want" matters more than "how to write it".</li>
    <li><b>Historical Context:</b> See how programming has evolved from binary to assembly to high-level, and now to Intent.</li>
    <li><b>The Future of Work:</b> Learn why "Prompt Engineering" is just a transitional skill.</li>
</ul>

<h3>📘 The Evolution of Code</h3>
<p>Programming has always been about abstraction. We moved from punching cards (0s and 1s) to Assembly, then to C, then to Python. Each step masked the complexity of the machine. <b>Intent-based programming</b> is the final layer of abstraction. You simply state your intent, and the AI handles the syntax.</p>
<blockquote>"The hottest new programming language is English." - Andrej Karpathy</blockquote>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. The Abstraction Ladder</h4>
    <p>Every decade, we move one rung up the ladder. We stop managing memory, then we stop managing types. Now, we are stopping the management of <i>syntax</i> itself. The focus is purely on logic and architecture.</p>
</div>
<div class="concept-block">
    <h4>2. Deterministic vs. Probabilistic</h4>
    <p>Old code was deterministic: logic always equaled result. AI code is probabilistic: it makes a "best guess" at your intent. This requires a new skill: <b>Verification</b>. You must read code effectively to confirm it matches your intent.</p>
</div>

<h3>📉 Case Study: The Calculator App</h3>
<p><b>The Old Way:</b> A developer writes 200 lines of HTML/CSS/JS. They debug specific typos in event listeners.</p>
<p><b>The Vibe Way:</b> You prompt: "Create a retro-style calculator with a history tape and neon color scheme." The AI generates 200 lines instantly. You notice the "equals" button is too small. You prompt: "Make the equals button span two columns." The AI refactors the CSS grid.</p>
<p><b>The Outcome:</b> The app is built in 3 minutes instead of 3 hours. The developer spent 0 minutes writing syntax and 3 minutes accepting/rejecting design choices.</p>

<h3>📝 Summary</h3>
<p>Intent is the new syntax. Your ability to clearly articulate a problem is now your most valuable asset. We are moving away from being "writers" of code to being "editors" and "architects" of systems.</p>
' WHERE title = 'Intent Is the New Programming Language';

-- Lesson 2: What Is Vibe Coding (Deep) -> Already updated, but ensuring consistency
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Understand the Shift:</b> Move from manual syntax writing to AI orchestration.</li>
    <li><b>Master the "Conductor" Mindset:</b> Learn how to lead the AI rather than correcting its spelling.</li>
    <li><b>Define Vibe Coding:</b> Grasp the official definition coined by Andrej Karpathy.</li>
</ul>

<h3>📘 What is Vibe Coding?</h3>
<p>Vibe Coding is not just "using AI to write code." It is a fundamental paradigm shift in software development where the human developer''s role evolves from a bricklayer to an architect. Instead of typing every character of syntax, you focus on the <b>intent</b>, <b>design</b>, and <b>"vibe"</b> of the application, while AI agents handle the implementation details.</p>
<blockquote>"I fully give in to the vibes, embrace exponentials, and forget that the code even exists." - Andrej Karpathy</blockquote>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Intent Over Syntax</h4>
    <p>In traditional coding, 90% of your brain power is spent on syntax (semi-colons, brackets, memory management). In Vibe Coding, you shift that energy to <b>Intent</b>: describing <i>what</i> you want the software to do. If you can describe it precisely, the AI can build it.</p>
</div>

<div class="concept-block">
    <h4>2. The Conductor Mindset</h4>
    <p>Think of an orchestra. The conductor doesn''t play the violin; they direct the musicians. Similarly, you don''t write the loops; you direct the LLMs. Your job is to ensure the output matches your vision, intervening only when the "music" sounds off.</p>
</div>

<h3>📉 Case Study: The 48-Hour SaaS</h3>
<p><b>The Challenge:</b> Marcus, a marketing professional with zero coding experience, identified a need for a niche customer feedback tool but couldn''t afford a dev team.</p>
<p><b>The Vibe Coding Approach:</b> Instead of learning React from scratch, Marcus used Cursor and Claude 3.5. He focused entirely on the user journey ("The user clicks here, and sees this...") rather than the code structure.</p>
<p><b>The Outcome:</b> Marcus launched a fully functional SaaS MVP in 48 hours. He wrote less than 50 lines of code manually, yet orchestrated over 5,000 lines of production-ready code.</p>

<h3>📝 Summary</h3>
<p>Vibe Coding represents the future of software creation. It is the transition from writing instructions for a machine to collaborating with an intelligent agent. By mastering this mindset, you unlock the ability to build software at the speed of thought, limited only by your imagination and not your typing speed.</p>
' WHERE title = 'What Is Vibe Coding (Deep)' OR title = 'What Is Vibe Coding?';

-- Lesson 3: From Writing Code to Directing Systems
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>The Director''s Chair:</b> Learn to treat the IDE as a command center, not a text editor.</li>
    <li><b>System Thinking:</b> Stop looking at lines; start looking at modules and data flow.</li>
    <li><b>The Feedback Loop:</b> Master the art of rapid iteration with AI.</li>
</ul>

<h3>📘 Directing vs. Writing</h3>
<p>When you write code, you are buried in the weeds. When you <b>direct systems</b>, you stand back and look at the whole picture. Vibe Coding tools (like Cursor, Windsurf) are not text editors; they are command centers where you issue orders to intelligent agents.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. High-Level Architecture</h4>
    <p>You must define the "shape" of the software. What database are we using? How do users log in? The AI is great at filling in the walls, but you must pour the foundation.</p>
</div>
<div class="concept-block">
    <h4>2. Managing Context</h4>
    <p>A director ensures every actor knows their motivation. A Vibe Coder ensures the AI knows the project context. This means managing your `.cursorrules`, documentation, and file context effectively.</p>
</div>

<h3>🛠️ Practical Application</h3>
<p>How to direct instead of write:</p>
<ol>
    <li><b>Don''t type the function:</b> Type a comment describing what the function should do. Hit "Tab".</li>
    <li><b>Don''t search StackOverflow:</b> Ask the chat "How do I center a div using Tailwind?" and hit "Apply".</li>
    <li><b>Don''t fix typos:</b> Highlight the code and press Ctrl+K: "Fix this error".</li>
</ol>

<h3>📝 Summary</h3>
<p>You are no longer a typist. You are a Technical Director. Your output is measured in features shipped, not lines of code written. Embrace the tools that allow you to operate at this higher level.</p>
' WHERE title = 'From Writing Code to Directing Systems';


-- ============================================================
-- MODULE 2: How AI Actually Builds Software
-- ============================================================

-- Lesson 4: How AI Thinks (and Why It Breaks)
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Demystify the Magic:</b> Understand that LLMs are just next-token predictors.</li>
    <li><b>Identify Weaknesses:</b> effective hallucination detection.</li>
    <li><b>Token Probabilities:</b> Why AI is sometimes "creative" when you want it to be "exact".</li>
</ul>

<h3>📘 Predictors, Not Thinkers</h3>
<p>Large Language Models (LLMs) do not "think" like humans. They predict the next word in a sequence based on probability. If you say "The sky is", the AI predicts "blue" (90%) or "gray" (10%). It does not <i>know</i> what a sky is. Understanding this limitation is key to controlling it.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Stochastic Parrots</h4>
    <p>The AI is repeating patterns it has seen in its training data. If your request matches a common pattern (e.g., "Create a Todo List"), it will answer perfectly. If your request is novel or weird, it might hallucinate because it has no pattern to rely on.</p>
</div>
<div class="concept-block">
    <h4>2. Hallucination</h4>
    <p>When the AI doesn''t know the answer, it guesses. In code, this leads to importing libraries that don''t exist. Always verify imports and API calls.</p>
</div>

<h3>📉 Case Study: The "Fake" Library</h3>
<p><b>The Challenge:</b> A developer asked AI to "use the Stripe V4 library for Python".</p>
<p><b>The Failure:</b> Stripe V4 didn''t exist yet. But the AI "hallucinated" it, creating perfect-looking code that crashed instantly because the library couldn''t be imported.</p>
<p><b>The Fix:</b> The developer learned to verify: "Does this library actually exist?" and provided the AI with the <i>actual</i> documentation to ground its response.</p>

<h3>📝 Summary</h3>
<p>AI is a probability machine. It excels at common tasks but struggles with edge cases. Treat it like a brilliant but overconfident junior developer: trust, but verify everything.</p>
' WHERE title = 'How AI Thinks (and Why It Breaks)';


-- Lesson 5: Context, Memory, and Constraints
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>The Window Limit:</b> Understand token limits and why AI forgets things.</li>
    <li><b>RAG (Retrieval-Augmented Generation):</b> How to extend memory.</li>
    <li><b>Constraint Prompting:</b> Getting better results by limiting choices.</li>
</ul>

<h3>📘 The Context Window</h3>
<p>The "Context Window" is the AI''s short-term memory. It''s like a whiteboard. Once the whiteboard is full, you have to erase something to write more. If you dump your entire codebase into the chat, you might fill the window, causing the AI to "forget" the instructions you gave it at the start.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Managing Tokens</h4>
    <p>Don''t paste unrelated files. Only provide the files relevant to the current task. This keeps the "signal-to-noise" ratio high.</p>
</div>
<div class="concept-block">
    <h4>2. Constraints are Power</h4>
    <p>Paradoxically, telling the AI what <i>not</i> to do is often more powerful than telling it what to do. "Do not use jQuery" is a constraint that saves you from cleanup later.</p>
</div>

<h3>🛠️ Practical Application</h3>
<p>How to maximize context:</p>
<ol>
    <li><b>Use `@` mentions:</b> In Cursor, type `@file` to include only specific files.</li>
    <li><b>Summarize:</b> Before starting a new big task, ask the AI to "Summarize our progress so far" to refresh its memory.</li>
    <li><b>Start Fresh:</b> If the AI starts getting confused, start a new chat. A fresh context window is often the best debugger.</li>
</ol>

<h3>📝 Summary</h3>
<p>Memory is finite. Be an efficient manager of the AI''s attention. Feed it high-quality context, set strict constraints, and clear the slate when things get messy.</p>
' WHERE title = 'Context, Memory, and Constraints';

-- Lesson 6: Preventing Repetition & Duplicate Content
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>DRY (Don''t Repeat Yourself):</b> Enforcing standard coding practices with AI.</li>
    <li><b>The "Lazy" AI Problem:</b> Why AI loves to duplicate code blocks.</li>
    <li><b>Refactoring Workflows:</b> How to use AI to clean up its own mess.</li>
</ul>

<h3>📘 The Repetition Trap</h3>
<p>AI models are trained on internet code, and internet code is full of copy-pasting. As a result, AI loves to repeat styles, functions, and logic. If you aren''t careful, you will end up with 5 versions of the same button component.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. The "Refactor" Prompt</h4>
    <p>Never accept the first draft if it looks repetitive. Immediately prompt: "Refactor this to be a reusable component." The AI is great at refactoring, but it usually needs to be told to do so.</p>
</div>
<div class="concept-block">
    <h4>2. Centralizing Logic</h4>
    <p>Force the AI to create utility files (e.g., `utils.js` or `constants.ts`). Explicitly tell it: "Put all color hex codes in a theme file, do not hardcode them."</p>
</div>

<h3>📉 Case Study: The CSS Blob</h3>
<p><b>The Issue:</b> A student built a landing page where every section had its own valid CSS. The file was 4000 lines long and impossible to maintain.</p>
<p><b>The Fix:</b> They ran a prompt: "Analyze this CSS. Identify repeated patterns. Create a variable system and refactor the code to use it."</p>
<p><b>The Outcome:</b> The snippet shrank to 800 lines. The site looked identical but was now maintainable.</p>

<h3>📝 Summary</h3>
<p>AI defaults to "write new code." You must guide it to "reuse existing code." Establish a modular pattern early, or you will drown in a sea of duplicate syntax.</p>
' WHERE title = 'Preventing Repetition & Duplicate Content';

-- ============================================================
-- MODULE 3: The Core Vibe Coding Workflow
-- ============================================================

-- Lesson 7: System Prompts vs User Prompts
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>The God Mode:</b> Understanding the power of System Prompts.</li>
    <li><b>Setting the Stage:</b> How to define the AI''s personality and rules globally.</li>
    <li><b>Cursor Rules:</b> Practical application of system prompts in your IDE.</li>
</ul>

<h3>📘 What is a System Prompt?</h3>
<p>A User Prompt is "Write a function." A <b>System Prompt</b> is "You are a Senior Python Engineer who handles errors gracefully." The System Prompt sets the rules of engagement for the entire conversation. It is invisible to the user but controls the AI''s behavior.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Role Definition</h4>
    <p>Always assign a role. "Act as a security expert" makes the AI look for vulnerabilities. "Act as a junior dev" makes it write simple, verifiable code.</p>
</div>
<div class="concept-block">
    <h4>2. Global Constraints</h4>
    <p>Use the System Prompt to enforce style guides. "Always use arrow functions. Never use `var`." This prevents you from correcting the same mistake 50 times.</p>
</div>

<h3>🛠️ Practical Application: .cursorrules</h3>
<p>In Cursor, you can create a `.cursorrules` file. This acts as a permanent System Prompt for your project.</p>
<pre><code>
// .cursorrules example
- You are an expert in Next.js 14 App Router.
- Always use Tailwind CSS for styling.
- Prefer Functional Components.
- Use TypeScript interfaces for all props.
</code></pre>

<h3>📝 Summary</h3>
<p>Don''t nag the AI. Set the rules once in the System Prompt, and let it follow them automatically. This is the "Set It and Forget It" of prompt engineering.</p>
' WHERE title = 'System Prompts vs User Prompts';

-- Lesson 8: The Vibe Coding Loop
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Iterative Creation:</b> The cycle of Prompt -> Generate -> Review -> Refine.</li>
    <li><b>Micro-Commits:</b> Why small steps are better than giant leaps.</li>
    <li><b>The Pivot is Cheap:</b> Changing direction in Vibe Coding costs minutes, not days.</li>
</ul>

<h3>📘 The Loop</h3>
<p>Vibe Coding is a loop. You never get the perfect code in one shot. The workflow is:</p>
<ol>
    <li><b>Prompt:</b> Describe the feature.</li>
    <li><b>Generate:</b> AI writes code.</li>
    <li><b>Review:</b> Visual check (does it look right?) + Logic check (does it work?).</li>
    <li><b>Refine:</b> "Move that button left," "Fix the bug."</li>
</ol>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Speed as a Feature</h4>
    <p>Because the loop is fast, you can afford to experiment. Try three different UI layouts. It takes 5 minutes. In the old world, that would take 3 days.</p>
</div>
<div class="concept-block">
    <h4>2. Keep It Small</h4>
    <p>Don''t ask for "The entire app." Ask for "The login form." Then "The validation logic." Then "The error styling." Small loops are less prone to hallucination.</p>
</div>

<h3>📝 Summary</h3>
<p>Embrace the loop. Don''t aim for perfection on the first prompt. Aim for a solid base, then sculpt it into perfection through rapid iteration.</p>
' WHERE title = 'The Vibe Coding Loop';

-- Lesson 9: Modular Thinking
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Atomic Design:</b> Breaking big problems into tiny components.</li>
    <li><b>Isolation:</b> Testing parts separately before combining them.</li>
    <li><b>AI Digestibility:</b> Why LLMs prefer small files.</li>
</ul>

<h3>📘 Thinking in Lego Blocks</h3>
<p>AI struggles with giant monoliths. It excels at small, isolated tasks. If you ask it to "Build Facebook," it fails. If you ask it to "Build a React component for a Like button," it succeeds perfectly. Modular Thinking is the art of breaking the monolith into these Lego blocks.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Single Responsibility Principle</h4>
    <p>Each file should do one thing. If a file is doing database calls AND UI rendering, ask the AI to split it. This makes debugging easier for both you and the AI.</p>
</div>
<div class="concept-block">
    <h4>2. Interface First</h4>
    <p>Define the inputs and outputs of a module before writing it. "I need a function that takes a User ID and returns a Profile Object." This gives the AI a clear target.</p>
</div>

<h3>📝 Summary</h3>
<p>Big problems are just a pile of small problems. Your job is to define the boundaries of the small problems so the AI can crush them one by one.</p>
' WHERE title = 'Modular Thinking';

-- ============================================
-- MODULE 4: The Vibe Toolkit (45+ Tools)
-- ============================================

-- Lesson 10: UI / Frontend AI (v0, bolt)
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Visual Generators:</b> Using tools like v0.dev and Bolt.new.</li>
    <li><b>Prompting for Design:</b> Describing atmosphere, spacing, and typography.</li>
    <li><b>Exporting to Code:</b> Moving from a generator to your codebase.</li>
</ul>

<h3>📘 Generative UI</h3>
<p>Tools like <b>v0.dev</b> (by Vercel) and <b>Bolt.new</b> allow you to generate UI by describing it. They are "Text-to-Website" engines. They are perfect for the initial layout phase.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. The "Napkin Sketch" Prompt</h4>
    <p>Describe the layout visually. "A dashboard with a sidebar on the left, a dark mode theme, and a card grid in the center."</p>
</div>
<div class="concept-block">
    <h4>2. Iterating in the Browser</h4>
    <p>These tools give you a live preview. Click elements and ask for changes. "Make this text larger." "Change the blue to purple."</p>
</div>

<h3>📉 Case Study: The Dashboard</h3>
<p><b>Goal:</b> Build an analytics dashboard.</p>
<p><b>Workflow:</b> Used v0.dev to generate the HTML/Tailwind shell. Exported the React code. Pasted it into the IDE. Used Cursor to wire up the real data.</p>
<p><b>Time Saved:</b> Saved roughly 6 hours of CSS tweaking.</p>

<h3>📝 Summary</h3>
<p>Don''t write CSS from scratch. Use generative UI tools to get 90% of the way there, then use your IDE to polish the final 10%.</p>
' WHERE title = 'UI / Frontend AI';

-- Lesson 11: Full-Stack & Auto Builders (Replit Agent)
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Autonomous Agents:</b> Understanding Replit Agent and similar tools.</li>
    <li><b>The "One-Shot" App:</b> Building a full MVP with a single prompt.</li>
    <li><b>Limitations:</b> When to use auto-builders vs. manual orchestration.</li>
</ul>

<h3>📘 The Auto-Builder</h3>
<p>Replit Agent and Databutton are "Auto-Builders." You give them a high-level goal ("Build a clone of Trello"), and they plan, write backend, write frontend, and deploy it autonomously. They are magic for prototypes.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. The Plan Phase</h4>
    <p>Watch the agent plan. If the plan looks wrong, interrupt it! The planning phase is your best chance to steer the ship.</p>
</div>
<div class="concept-block">
    <h4>2. The "Black Box" Risk</h4>
    <p>The downside is you precise control. If the agent makes a weird architectural choice, it can be hard to undo. Use these for MVPs, not enterprise scale.</p>
</div>

<h3>📝 Summary</h3>
<p>Auto-builders are the fastest way to go from 0 to 1. They are perfect for testing ideas (POCs). But for long-term maintenance, you will likely move the code to a proper IDE.</p>
' WHERE title = 'Full-Stack & Auto Builders';

-- Lesson 12: Backend, Logic & Data (Supabase AI)
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Text-to-SQL:</b> Writing database queries with English.</li>
    <li><b>Schema Design:</b> Asking AI to design your database structure.</li>
    <li><b>Edge Functions:</b> Generating serverless backend logic.</li>
</ul>

<h3>📘 AI in the Backend</h3>
<p>Backend logic is rigorous. A typo destroys data. AI is surprisingly good here because SQL is a very structured language. Tools like Supabase AI allow you to chat with your database.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Schema Generation</h4>
    <p>Don''t manually create tables. Ask AI: "I need a schema for a LMS with Users, Courses, and Lessons. Users can enroll in many Courses." It will handle the foreign keys perfectly.</p>
</div>
<div class="concept-block">
    <h4>2. Postgres Policies (RLS)</h4>
    <p>Security is hard. AI makes it easier. "Write a policy that allows users to see only their own data." It generates the complex Row Level Security rules for you.</p>
</div>

<h3>📝 Summary</h3>
<p>Let AI handle the boilerplate of backend code. You focus on the data model: what are the entities and how do they relate? The AI will write the SQL.</p>
' WHERE title = 'Backend, Logic & Data';

-- Lesson 13: Agentic IDEs (Command Centers)
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>The Big Three:</b> Cursor, Windsurf, Copilot.</li>
    <li><b>Inline vs. Sidebar:</b> Knowing where to prompt.</li>
    <li><b>Composer Mode:</b> Editing multiple files at once.</li>
</ul>

<h3>📘 The Command Center</h3>
<p>Your IDE is no longer just for typing. It''s an agentic interface. <b>Cursor</b> is currently the gold standard. Its "Composer" mode allows it to see and edit your entire project simultaneously.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Context Awareness</h4>
    <p>These IDEs index your files. They "know" your code. You can ask "Where is the login logic?" and it points you there.</p>
</div>
<div class="concept-block">
    <h4>2. Multi-File Edits</h4>
    <p>The superpower of Agentic IDEs is changing multiple files. "Rename the User component to Profile, and update all imports." It does it across 10 files instantly.</p>
</div>

<h3>📝 Summary</h3>
<p>If you are not using an Agentic IDE, you are coding with one hand tied behind your back. Master the keyboard shortcuts (Cmd+K, Cmd+I) to direct the agent fluidly.</p>
' WHERE title = 'Agentic IDEs (Command Centers)';

-- Lesson 14: AI Agents & Orchestration
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Beyond Code:</b> Agents that browse the web and use tools.</li>
    <li><b>Orchestration:</b> Chaining multiple agents together.</li>
    <li><b>The Future:</b> Software that runs itself.</li>
</ul>

<h3>📘 What is an Agent?</h3>
<p>An LLM generates text. An <b>Agent</b> can take action. It can open a browser, click a button, run a terminal command, or call an API. It has "hands."</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Tool Use</h4>
    <p>You give the agent tools (e.g., "Google Search", "Calculator"). It decides when to use them. If you ask "What is the weather?", it knows to use Search, not just guess.</p>
</div>
<div class="concept-block">
    <h4>2. Loops and Retries</h4>
    <p>Agents can self-correct. If an API call fails, the agent can gaze at the error, adjust the parameters, and try again. This autonomy is powerful but requires monitoring.</p>
</div>

<h3>📝 Summary</h3>
<p>We are entering the era of Agentic workflows, where software doesn''t just wait for user input—it proactively solves problems. As a Vibe Coder, you will eventually orchestrate teams of these agents.</p>
' WHERE title = 'AI Agents & Orchestration';
