
-- UNIVERSAL CONTENT UPGRADE - PART 2
-- Vibe Coding Modules 5-8 (Lessons 15-26)
-- Applying Gold Standard Template

-- ============================================================
-- MODULE 5: Building Real Software
-- ============================================================

-- Lesson 15: Debugging AI Systems
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>AI Debugging:</b> Diagnosing when the prompt is wrong versus when the code is wrong.</li>
    <li><b>Context Pollution:</b> How old messages break new requests.</li>
    <li><b>The "Fresh Chat" Trick:</b> The most effective debugging tool for LLMs.</li>
</ul>

<h3>📘 Debugging the Vibe</h3>
<p>Debugging AI code is different from debugging written code. When an AI generates a bug, you don''t just fix the line; you fix the <b>prompt</b> that generated the line. If you fix the code but not the prompt, the AI will just overwrite your fix in the next iteration.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Context Pollution</h4>
    <p>As a chat gets long, the AI gets confused. It might remember a rule you deleted 20 messages ago. Signs of pollution: loops, ignoring constraints, repeating errors.</p>
</div>
<div class="concept-block">
    <h4>2. Root Cause Analysis</h4>
    <p>Ask the AI: "Why did you write it this way?" It will explain its reasoning. Often, its logic is sound but its assumption (which you forgot to correct) was wrong.</p>
</div>

<h3>📝 Summary</h3>
<p>When the AI breaks, stop giving it more code. Step back, clear the context, and re-state the goal. Debug the intent, not the syntax.</p>
' WHERE title = 'Debugging AI Systems';

-- Lesson 16: Building a SaaS with AI
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Speed Running:</b> Going from idea to deployed app in < 24 hours.</li>
    <li><b>Tech Stack:</b> Why Next.js + Supabase + Tailwind is the Vibe Coding "Holy Trinity".</li>
    <li><b>MVP Mindset:</b> Ignoring scalability to focus on shipping.</li>
</ul>

<h3>📘 The 24-Hour SaaS</h3>
<p>With AI, the cost of trying an idea is near zero. This means you can build "micro-SaaS" products in a weekend. The key is to pick a stack that the AI knows perfectly.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. The Holy Trinity</h4>
    <p>We use Next.js, Supabase, and Tailwind not because they are "best" (though they are great), but because the AI has seen <i>millions</i> of examples of them. It hallucinates less with this stack.</p>
</div>
<div class="concept-block">
    <h4>2. Vertical Slicing</h4>
    <p>Build one feature end-to-end (UI -> API -> DB) before starting the next. Don''t build all DB tables, then all APIs. Build the "Login" slice. Then the "Payment" slice.</p>
</div>

<h3>📝 Summary</h3>
<p>Don''t overengineer. Use the boring stack that the AI knows best. Ship the MVP. If it gets traction, you can rewrite it later (with AI).</p>
' WHERE title = 'Building a SaaS with AI';

-- Lesson 17: Building an LMS
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Complex Relations:</b> Handling Users, Courses, Modules, Lessons interactions.</li>
    <li><b>Video Integration:</b> Embedding YouTube/Vimeo dynamically.</li>
    <li><b>Tracking Progress:</b> Simple state management for "Mark as Complete".</li>
</ul>

<h3>📘 App Architecture</h3>
<p>An LMS (Learning Management System) is the classic CRUD app test. It requires relational data (A Course has many Modules), protected content (must be logged in), and media rendering.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Data Hierarchy</h4>
    <p>Course -> Module -> Lesson. This hierarchy must be reflected in your Database Schema and your UI Routing (e.g., `/course/[id]/lesson/[lessonId]`).</p>
</div>
<div class="concept-block">
    <h4>2. Completion Logic</h4>
    <p>A "completed_lessons" table linking `user_id` and `lesson_id` is better than a boolean on the lesson itself, because it allows multiple users to track progress independently.</p>
</div>

<h3>📝 Summary</h3>
<p>Building this LMS proves you can handle relational data and user state—the two pillars of almost every SaaS application.</p>
' WHERE title = 'Building an LMS';

-- ============================================================
-- MODULE 6: Data, State & Auth
-- ============================================================

-- Lesson 18: Databases Without Fear
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>SQL vs. NoSQL:</b> Why we chose Postgres (SQL).</li>
    <li><b>Visual Editing:</b> Using the Supabase Dashboard.</li>
    <li><b>Migrations:</b> Controlling database changes.</li>
</ul>

<h3>📘 The Database as a Spreadsheet</h3>
<p>Supabase makes Postgres look like a spreadsheet (Airtable-style). This lowers the barrier to entry. But under the hood, it is an enterprise-grade SQL database.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Relational Integrity</h4>
    <p>Foreign Keys ensure data sanity. If you delete a User, their Progress should also be deleted (Cascade). Let the database handle this cleanup, not your code.</p>
</div>
<div class="concept-block">
    <h4>2. Types are Truth</h4>
    <p>If the column is an Integer, the DB won''t let you save text. This strictness is your friend. It prevents "undefined is not a function" errors in your UI.</p>
</div>

<h3>📝 Summary</h3>
<p>Don''t fear the DB. Treat it as the source of truth. If your data model is clean, your frontend code will be clean. If your data model is messy, no amount of AI can save you.</p>
' WHERE title = 'Databases Without Fear';

-- Lesson 19: Authentication & Roles
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Auth vs. AuthZ:</b> The difference between "Who are you?" and "What can you do?"</li>
    <li><b>Row Level Security (RLS):</b> The magic of Supabase security.</li>
    <li><b>Middleware Protection:</b> Protecting routes.</li>
</ul>

<h3>📘 Security First</h3>
<p>Authentication is hard. Do not write your own hashing algorithms. Use a provider (Supabase Auth, Clerk, NextAuth). They handle the security complexities (JWTs, session expiry) for you.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. RLS (Row Level Security)</h4>
    <p>Normally, API code checks permissions. With RLS, the <i>Database</i> checks permissions. Even if a hacker hacks your API, the Database will reject the query if the `user_id` doesn''t match.</p>
</div>
<div class="concept-block">
    <h4>2. Admin Roles</h4>
    <p>Create a `profiles` table with a `role` column. Check this role in your RLS policies to allow Admins to edit courses.</p>
</div>

<h3>📝 Summary</h3>
<p>Security should be at the database level, not just the UI level. Hiding a "Delete" button doesn''t stop a hacker. RLS policies do.</p>
' WHERE title = 'Authentication & Roles';

-- Lesson 20: State, Caching & Persistence
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Client vs. Server State:</b> When to use React State vs. Database.</li>
    <li><b>Local Storage:</b> Quick and dirty persistence (Themes, basic prefs).</li>
    <li><b>SWR / React Query:</b> Smart fetching and caching.</li>
</ul>

<h3>📘 Where does data live?</h3>
<p>State is the hardest part of frontend dev. Is the user logged in? Is the modal open? Is the data fresh? Managing this sync is crucial.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Optimistic Updates</h4>
    <p>When a user likes a post, turn the heart red <i>immediately</i>, then call the API. If the API fails, turn it back. This makes the app feel "instant."</p>
</div>
<div class="concept-block">
    <h4>2. The Cache</h4>
    <p>Don''t fetch the same data 10 times. Tools like React Query cache the result. If the user navigates back, the data shows instantly.</p>
</div>

<h3>📝 Summary</h3>
<p>Good state management makes apps feel solid. Bad state management makes them feel glitchy. Use libraries (Zustand, React Query) to handle the hard stuff.</p>
' WHERE title = 'State, Caching & Persistence';

-- ============================================================
-- MODULE 7: Advanced Vibe Coding
-- ============================================================

-- Lesson 21: Verification Prompts
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Trust but Verify:</b> The Vibe Coder''s mantra.</li>
    <li><b>Test Generation:</b> Asking AI to write tests for its own code.</li>
    <li><b>Logic Audits:</b> "Walk me through this function step by step."</li>
</ul>

<h3>📘 The Second Pair of Eyes</h3>
<p>You verify the AI, but who verifies you? The AI. Use "Verification Prompts" to ask the AI to critique your architecture or find bugs in its own output.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. The "Devil''s Advocate" Prompt</h4>
    <p>Prompt: "Review this code. Identify 3 ways it could fail in production. Be critical." This forces the AI to switch from "Builder Mode" to "Tester Mode."</p>
</div>
<div class="concept-block">
    <h4>2. Unit Tests</h4>
    <p>Don''t just read the code. Ask: "Write a Jest test suite for this component." Running the test is the ultimate verification.</p>
</div>

<h3>📝 Summary</h3>
<p>The AI is your partner. Use it to double-check the work. It won''t feel insulted if you ask it to find bugs.</p>
' WHERE title = 'Verification Prompts';

-- Lesson 22: Cost, Performance & Sanity
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Token Costs:</b> Understanding API pricing.</li>
    <li><b>Latency:</b> Speed vs. Intelligence (GPT-4 vs 4o-mini).</li>
    <li><b>Developer Sanity:</b> Knowing when to take a break.</li>
</ul>

<h3>📘 Optimization</h3>
<p>AI isn''t free. Every prompt costs money. While cheap now, scaling an AI app requires watching the margins. Optimization is about balancing Cost, Speed, and Quality.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Model Selection</h4>
    <p>Use "Smart" models (Claude 3.5, GPT-4) for architecture and difficult logic. Use "Fast" models (4o-mini, Haiku) for simple loops, generation, and categorization.</p>
</div>
<div class="concept-block">
    <h4>2. Caching Responses</h4>
    <p>If users ask the same question, cache the AI answer. Don''t pay for the same computation twice.</p>
</div>

<h3>📝 Summary</h3>
<p>Optimize late. First, make it work. Then, make it cheap. Then, make it fast.</p>
' WHERE title = 'Cost, Performance & Sanity';

-- Lesson 23: When NOT to Use AI
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>The Danger Zone:</b> Crypto, Medical, Safety-Critical systems.</li>
    <li><b>Liability:</b> Who is responsible when AI fails?</li>
    <li><b>The "Human Touch":</b> Where humans still beat machines.</li>
</ul>

<h3>📘 The Guardrails</h3>
<p>AI is a probabilistic engine. It is never 100% correct. Therefore, it should never be the sole decision-maker in systems where failure means death or financial ruin.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Human in the Loop (HITL)</h4>
    <p>For critical actions (approving a refund, diagnosing a patient), AI should draft the decision, but a human must sign it.</p>
</div>
<div class="concept-block">
    <h4>2. Creative Soul</h4>
    <p>AI can mimic style, but it lacks true lived experience. Use AI for structure, but inject your own soul/voice into the final creative output.</p>
</div>

<h3>📝 Summary</h3>
<p>Vibe Coding is powerful, but it is not magic. Know the limits. Use AI to amplify human capability, not to replace human responsibility.</p>
' WHERE title = 'When NOT to Use AI';

-- ============================================================
-- MODULE 8: Applications & Career
-- ============================================================

-- Lesson 24: Internal Tools
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>The Hidden Market:</b> Why B2B internal tools are a goldmine.</li>
    <li><b>Retool / admin panels:</b> Building dashboards for operations.</li>
    <li><b>Automation:</b> Replacing spreadsheets with apps.</li>
</ul>

<h3>📘 The Efficiency Engine</h3>
<p>Most software isn''t customer-facing SaaS. It''s internal tools used by companies to manage inventory, track sales, or onboard employees. This is the perfect playground for Vibe Coding because the UI requirements are lower (function > form).</p>

<h3>📝 Summary</h3>
<p>Start your career by building internal tools. The feedback loop is tight (you know the users), and the value is immediate.</p>
' WHERE title = 'Internal Tools';

-- Lesson 25: Client Work
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Selling Speed:</b> How to price Vibe Coding services.</li>
    <li><b>The "hourly" trap:</b> Why you must switch to value-based pricing.</li>
    <li><b>Client Expectations:</b> Managing the "AI can do anything" myth.</li>
</ul>

<h3>📘 Freelancing 2.0</h3>
<p>If you can build an app in 2 days instead of 2 weeks, do not charge by the hour. Charge for the deliverable. Vibe Coding massively increases your effective hourly rate, but only if you price correctly.</p>

<h3>📝 Summary</h3>
<p>Position yourself as a "Solution Architect" not a "Coder." Clients pay for solved problems, not for typed syntax.</p>
' WHERE title = 'Client Work';

-- Lesson 26: The Future of Software
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>2026 and Beyond:</b> The rise of self-healing software.</li>
    <li><b>Natural Language Interfaces:</b> Apps with no UI, just chat.</li>
    <li><b>Continuous Learning:</b> Staying ahead of the robots.</li>
</ul>

<h3>📘 The Next Horizon</h3>
<p>We are moving toward "Software 3.0" where software is grown, not built. It adapts to the user. The screen might disappear entirely, replaced by ambient voice interfaces.</p>

<h3>📝 Summary</h3>
<p>The only constant is change. Vibe Coding is the skill of surfing that change. Stay curious, stay flexible, and keep your hands on the conductor''s baton.</p>
' WHERE title = 'The Future of Software' OR title = 'Future of Software 2025';
