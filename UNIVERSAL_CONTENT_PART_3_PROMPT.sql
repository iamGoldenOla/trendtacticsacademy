
-- UNIVERSAL CONTENT UPGRADE - PART 3
-- Prompt Engineering Course (Aligning to Gold Standard)
-- Adding Learning Objectives & Deep Content

-- ============================================================
-- MODULE 1: Advanced Prompting Architecture
-- ============================================================

-- Lesson 1: The Death of the Single Prompt
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>The Paradigm Shift:</b> Why "one-shot" prompting is dead.</li>
    <li><b>Behavior Architecture:</b> Designing systems, not just asking questions.</li>
    <li><b>Structuring Workflows:</b> Multi-turn dialogues for reliable results.</li>
</ul>

<h3>📘 The Evolution of Prompt Engineering</h3>
<p>In 2024, prompt engineering was about finding "magic words." In 2026, it''s about <b>Behavior Architecture</b>—designing reliable, repeatable systems of interaction.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Why Single Prompts Fail</h4>
    <p>A single prompt is like asking a stranger for directions without context. The AI doesn''t know your goal, audience, or constraints. It guesses, and usually guesses wrong.</p>
</div>
<div class="concept-block">
    <h4>2. Structured Dialogues</h4>
    <p>Modern prompting is a <b>conversation</b>. You set the stage (Persona), then the goal (Task), then the context (Constraints). It is an iterative process, not a lottery ticket.</p>
</div>

<h3>📝 Summary</h3>
<p>Stop looking for the "perfect prompt." Start building "perfect workflows." Divide your task into steps: Research -> Outline -> Draft -> Refine. This is how you get professional results.</p>
' WHERE title ILIKE '%Death of the Single Prompt%';

-- Lesson 2: Designing The Swarm
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Swarm Intelligence:</b> Why many agents are better than one.</li>
    <li><b>Specialization:</b> The role of Researcher, Writer, and Editor agents.</li>
    <li><b>Frameworks:</b> Intro to LangGraph and CrewAI.</li>
</ul>

<h3>📘 The Power of Specialization</h3>
<p>One AI model trying to do everything is mediocre at everything. A <b>Swarm</b> is a team of specialized agents. The "Researcher" agent only searches. The "Writer" agent only writes. The "Editor" agent only critiques.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Hand-offs</h4>
    <p>The magic happens in the hand-off. The Researcher passes a JSON summary to the Writer. The flow of data between agents is more important than the individual prompts.</p>
</div>
<div class="concept-block">
    <h4>2. The Controller</h4>
    <p>You need a "Manager" agent to oversee the swarm. If the Writer fails, the Manager rejects the output and asks for a retry. This loop creates resilience.</p>
</div>

<h3>📝 Summary</h3>
<p>Build squads, not soloists. By specializing your agents, you drastically reduce hallucinations and improve the depth of the final output.</p>
' WHERE title ILIKE '%Designing The Swarm%';

-- Lesson 3: Agent Control Planes
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Governance:</b> Keeping autonomous agents specific and safe.</li>
    <li><b>The Kill Switch:</b> How to stop a runaway agent.</li>
    <li><b>Audit Logs:</b> Tracking what your AI is doing in secret.</li>
</ul>

<h3>📘 Dangerous Autonomy</h3>
<p>Agents can call APIs. This means they can spend money, delete data, or email your boss. A <b>Control Plane</b> is the security layer that sits between the agent and the world.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Permission Systems</h4>
    <p>Never give an agent "Root" access. Give it "Read-Only" access first. Explicitly whitelist the tools it can use.</p>
</div>
<div class="concept-block">
    <h4>2. Rate Limiting</h4>
    <p>Agents can get into infinite loops. Always set a hard limit (e.g., "Max 10 steps") to prevent a $500 OpenAI bill overnight.</p>
</div>

<h3>📝 Summary</h3>
<p>Trust, but verify. And then verify again. A Control Plane is your insurance policy against AI chaos.</p>
' WHERE title ILIKE '%Agent Control Planes%';

-- Lesson 4: Recursive Prompts (Meta-Prompting)
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Self-Optimization:</b> Asking AI to rewrite its own prompts.</li>
    <li><b>The Recursive Loop:</b> Generate -> Critique -> Improve -> Repeat.</li>
    <li><b>Breaking Plateaus:</b> How to get that last 10% of quality.</li>
</ul>

<h3>📘 Meta-Prompting</h3>
<p>Why write the prompt yourself when the AI is a better writer? <b>Meta-Prompting</b> is the art of asking the AI to improve its own instructions based on the output it just generated.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. The Critique Step</h4>
    <p>Ask the AI: "Analyze your last response. What was missing? Logic gaps? Tone issues?" It is surprisingly good at finding its own flaws.</p>
</div>
<div class="concept-block">
    <h4>2. The Refinement</h4>
    <p>"Based on your critique, rewrite the original prompt to prevent these errors." This creates a virtuous cycle of improvement.</p>
</div>

<h3>📝 Summary</h3>
<p>Don''t settle for the first draft. Use recursion to polish the prompt until it shines. Let the AI do the heavy lifting of optimization.</p>
' WHERE title ILIKE '%Recursive Prompts%';

-- Lesson 5: Constitutional AI & Alignment
UPDATE lessons SET content = '
<h3>🎯 Learning Objectives</h3>
<ul>
    <li><b>Ethics as Code:</b> Embedding principles into the system.</li>
    <li><b>The Constitution:</b> Hard-coded rules the AI cannot break.</li>
    <li><b>Safety:</b> Preventing bias, toxicity, and harm.</li>
</ul>

<h3>📘 Constitutional AI</h3>
<p>Instead of training the AI on every possible bad output (RLHF), we give it a Constitution: "Be harmless. Be helpful. Be honest." The AI references this constitution before every response.</p>

<h3>🧠 Core Concepts</h3>
<div class="concept-block">
    <h4>1. Principle-Driven Logic</h4>
    <p>Principles scale better than rules. "Don''t be mean" is better than a list of 10,000 banned words.</p>
</div>
<div class="concept-block">
    <h4>2. Red Teaming</h4>
    <p>You must attack your own system. Try to trick it into being racist or violent. If the Constitution holds, you are ready for production.</p>
</div>

<h3>📝 Summary</h3>
<p>Safety is not a feature; it is a requirement. Constitutional AI provides a scalable framework for keeping your agents on the right path.</p>
' WHERE title ILIKE '%Constitutional AI%';
