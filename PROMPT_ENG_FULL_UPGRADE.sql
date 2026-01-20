-- COMPREHENSIVE PROMPT ENGINEERING COURSE UPGRADE
-- Goal: Transform into a world-class, beginner-to-pro course
-- Each lesson now has: Rich content, 5 quizzes, multiple takeaways, detailed case studies

-- ============================================
-- LESSON 1: The Death of the Single Prompt
-- ============================================
UPDATE lessons 
SET 
    description = '<h3><b>The Evolution of Prompt Engineering</b></h3>
<p>In 2024, prompt engineering was about finding "magic words." In 2026, it''s about <b>Behavior Architecture</b>—designing reliable, repeatable systems of interaction.</p>

<h3><b>Why Single Prompts Are Dead</b></h3>
<p>A single prompt is like asking a stranger for directions without context. The AI doesn''t know:</p>
<ul>
<li>Your goal (informative? persuasive? technical?)</li>
<li>Your audience (experts? beginners? executives?)</li>
<li>Your constraints (word count, tone, format)</li>
</ul>

<h3><b>The New Paradigm: Structured Dialogues</b></h3>
<p>Modern prompt engineering uses <b>multi-turn conversations</b> where each exchange builds context. Think of it as conducting an interview, not shouting a question.</p>

<h3><b>From Prompts to Workflows</b></h3>
<p>Instead of: "Write a blog post about AI"</p>
<p>We now design: Research → Outline → Draft → Critique → Revise → Publish</p>

<h3><b>Key Principles</b></h3>
<ol>
<li><b>Context is King:</b> The AI knows nothing until you tell it.</li>
<li><b>Personas Matter:</b> "Act as a senior copywriter" changes everything.</li>
<li><b>Iteration Beats Perfection:</b> Refine through dialogue, not one-shot attempts.</li>
</ol>',
    
    summary = 'Prompt Engineering has evolved from finding "magic words" to designing **Behavior Architecture**—structured systems of interaction. Single prompts fail because they lack context. Modern approaches use multi-turn dialogues, personas, and iterative refinement to guide AI toward reliable, high-quality outputs.',
    
    key_takeaways = '[
        "Context is king: The AI knows nothing until you tell it.",
        "Personas transform output: \"Act as X\" changes tone, depth, and style.",
        "Iteration beats perfection: Refine through dialogue, not one-shot attempts.",
        "Structure your requests: Goal → Audience → Constraints → Format.",
        "The 2026 shift: From prompts to workflows (multi-step processes)."
    ]'::jsonb,
    
    case_studies = '[
        {
            "title": "The Ambiguous Ask",
            "scenario": "A marketing manager asks AI: \"Write a blog post about shoes.\"",
            "analysis": "The AI lacks critical context: tone (casual? luxury?), audience (runners? fashionistas?), goal (SEO? brand awareness?), and format (500 words? 2000?). The output is generic and unusable.",
            "outcome": "Refined to: \"Act as a luxury fashion copywriter. Write a 500-word blog post for Gen Z launching our new sustainable sneaker line. Focus on eco-friendly materials, use a conversational tone, and include a CTA to visit our website.\" Result: 10x better output."
        },
        {
            "title": "The One-Shot Failure",
            "scenario": "A developer asks: \"Build me a landing page.\"",
            "analysis": "The AI generates a generic template with placeholder text. No branding, no unique value proposition, no conversion optimization.",
            "outcome": "Switched to a workflow: 1. Define brand (colors, tone). 2. Outline sections (hero, features, testimonials). 3. Generate HTML. 4. Critique layout. 5. Revise. Result: Professional, conversion-optimized page."
        }
    ]'::jsonb,
    
    playground = '{
        "objective": "Transform a weak, vague prompt into a structured, context-rich instruction.",
        "starter_prompt": "Help me write an email to my boss asking for a raise.",
        "guided_steps": [
            "Step 1: Assign a Persona (e.g., ''Act as a senior negotiation coach'')",
            "Step 2: Add Context (e.g., ''I have exceeded my sales targets by 30% for 3 consecutive quarters'')",
            "Step 3: Define Tone (e.g., ''Professional, confident, but not demanding'')",
            "Step 4: Specify Format (e.g., ''3 paragraphs, under 200 words'')",
            "Step 5: Add a Constraint (e.g., ''Avoid mentioning other employees or comparisons'')"
        ],
        "advanced_challenge": "Make the AI critique its own draft before showing you the final version. Prompt: ''After generating the email, analyze it for weaknesses (tone, clarity, persuasiveness) and revise accordingly.''"
    }'::jsonb,
    
    extra_resources = '[
        {"title": "OpenAI Prompt Engineering Guide", "url": "https://platform.openai.com/docs/guides/prompt-engineering", "type": "docs"},
        {"title": "The Art of the Prompt (Anthropic)", "url": "https://docs.anthropic.com/claude/docs/prompt-engineering", "type": "article"},
        {"title": "Prompt Engineering Roadmap 2026", "url": "https://www.promptingguide.ai", "type": "guide"}
    ]'::jsonb,
    
    quizzes = '[
        {
            "question": "What is the primary skill in modern Prompt Engineering?",
            "options": ["Memorizing syntax", "Typing speed", "Designing structured dialogues with context", "Using emojis"],
            "correctAnswer": 2
        },
        {
            "question": "Why do single prompts fail?",
            "options": ["They are too short", "They lack context (goal, audience, constraints)", "AI doesn''t understand English", "They need to be in code"],
            "correctAnswer": 1
        },
        {
            "question": "What does ''Act as a senior copywriter'' do?",
            "options": ["Nothing, it''s just filler", "Changes the AI''s tone, depth, and style", "Makes the AI slower", "Only works with GPT-4"],
            "correctAnswer": 1
        },
        {
            "question": "The 2026 shift is from prompts to:",
            "options": ["Code", "Workflows (multi-step processes)", "Databases", "Manual writing"],
            "correctAnswer": 1
        },
        {
            "question": "What is ''Behavior Architecture''?",
            "options": ["A new programming language", "Designing reliable systems of AI interaction", "A type of neural network", "A certification program"],
            "correctAnswer": 1
        }
    ]'::jsonb
WHERE title ILIKE '%Death of the Single Prompt%';

-- ============================================
-- LESSON 2: Designing The Swarm
-- ============================================
UPDATE lessons 
SET 
    description = '<h3><b>The Limits of Single-Agent Systems</b></h3>
<p>One AI agent trying to do everything is like one person trying to be a researcher, writer, editor, and designer simultaneously. Quality suffers.</p>

<h3><b>Enter: Swarm Architecture</b></h3>
<p>A <b>swarm</b> is a coordinated team of specialized AI agents, each with a defined role:</p>
<ul>
<li><b>Researcher Agent:</b> Gathers facts, data, and sources.</li>
<li><b>Writer Agent:</b> Drafts content based on research.</li>
<li><b>Editor Agent:</b> Critiques for clarity, tone, and structure.</li>
<li><b>SEO Agent:</b> Optimizes keywords and meta descriptions.</li>
</ul>

<h3><b>How Swarms Work</b></h3>
<p>Each agent operates in sequence, passing its output to the next. Think of it as an assembly line for intelligence.</p>

<h3><b>Frameworks for Swarms</b></h3>
<p>Tools like <b>LangGraph</b>, <b>CrewAI</b>, and <b>AutoGen</b> let you orchestrate multi-agent workflows with minimal code.</p>

<h3><b>When to Use Swarms</b></h3>
<ul>
<li>Complex tasks requiring multiple skill sets</li>
<li>High-quality output where iteration is critical</li>
<li>Workflows with clear hand-offs (research → writing → editing)</li>
</ul>',
    
    summary = 'Swarm Architecture uses multiple specialized AI agents (Researcher, Writer, Editor) working in sequence to tackle complex tasks. This beats single-agent systems because specialization improves quality. Frameworks like LangGraph and CrewAI make orchestration easy.',
    
    key_takeaways = '[
        "Specialization beats generalization: One agent, one job.",
        "Define clear hand-offs: Research → Writing → Editing.",
        "Use a Controller Agent to manage the flow and resolve conflicts.",
        "Swarms excel at complex, multi-step tasks (e.g., content creation, data analysis).",
        "Frameworks like LangGraph and CrewAI simplify orchestration."
    ]'::jsonb,
    
    case_studies = '[
        {
            "title": "The All-in-One Failure",
            "scenario": "A startup asks one AI agent to: research competitors, write a blog post, optimize for SEO, and generate social media captions—all in one prompt.",
            "analysis": "The model gets \"distracted.\" The research is shallow, the writing is generic, SEO is ignored, and social captions are an afterthought. Quality degrades across all tasks.",
            "outcome": "Split into 4 agents: 1. Researcher gathers competitor data. 2. Writer drafts the blog. 3. SEO Agent optimizes keywords. 4. Social Agent creates captions. Result: Professional, cohesive output in half the time."
        },
        {
            "title": "The Content Factory",
            "scenario": "A media company needs to produce 50 articles per week. One writer (human or AI) can''t keep up.",
            "analysis": "Using a single AI agent leads to repetitive, low-quality content. Readers notice the formulaic structure.",
            "outcome": "Deployed a swarm: Researcher Agent finds trending topics. Outline Agent structures each article. Writer Agent drafts. Editor Agent polishes. Result: 50 unique, high-quality articles per week with 90% less human oversight."
        }
    ]'::jsonb,
    
    playground = '{
        "objective": "Simulate a 2-agent workflow (Writer + Editor) to see the power of specialization.",
        "starter_prompt": "Act as a Writer. Draft a short story (200 words) about a robot who loves gardening. Then, switch personas. Act as a Ruthless Editor and critique the story for pacing, clarity, and emotional impact. Finally, revise the story based on your critique.",
        "guided_steps": [
            "Step 1: Generate the story as the Writer",
            "Step 2: Switch to Editor persona and critique",
            "Step 3: Identify 3 specific weaknesses",
            "Step 4: Revise the story addressing those weaknesses"
        ],
        "advanced_challenge": "Create a JSON schema for the hand-off between Writer and Editor. Include fields like: draft_text, critique_notes, revision_instructions, final_output."
    }'::jsonb,
    
    extra_resources = '[
        {"title": "LangGraph: Multi-Agent Systems", "url": "https://python.langchain.com/docs/langgraph", "type": "docs"},
        {"title": "Building LLM Applications for Production", "url": "https://huyenchip.com/2023/04/11/llm-engineering.html", "type": "blog"},
        {"title": "CrewAI Documentation", "url": "https://docs.crewai.com", "type": "docs"}
    ]'::jsonb,
    
    quizzes = '[
        {
            "question": "What is a ''swarm'' in AI?",
            "options": ["A bug in the code", "A group of specialized agents working together", "A new virus", "A type of database"],
            "correctAnswer": 1
        },
        {
            "question": "Why does specialization improve quality?",
            "options": ["It doesn''t", "Each agent focuses on one task, avoiding distraction", "It''s faster", "It uses less memory"],
            "correctAnswer": 1
        },
        {
            "question": "What is a ''Controller Agent''?",
            "options": ["The AI that manages the flow and resolves conflicts", "A human supervisor", "A database", "A backup system"],
            "correctAnswer": 0
        },
        {
            "question": "Which framework is used for multi-agent orchestration?",
            "options": ["React", "LangGraph", "MySQL", "Photoshop"],
            "correctAnswer": 1
        },
        {
            "question": "When should you use a swarm instead of a single agent?",
            "options": ["Always", "For complex, multi-step tasks requiring different skill sets", "Never", "Only for coding"],
            "correctAnswer": 1
        }
    ]'::jsonb
WHERE title ILIKE '%Designing The Swarm%';

-- Continue with remaining lessons...
-- (I'll create the full script with all lessons in the next part)

-- ============================================
-- LESSON 3: Agent Control Planes
-- ============================================
UPDATE lessons 
SET 
    description = '<h3><b>The Problem with Autonomous Agents</b></h3>
<p>Autonomous AI agents are powerful, but they can go rogue. Without oversight, they might:</p>
<ul>
<li>Make unauthorized API calls (costing you money)</li>
<li>Access sensitive data they shouldn''t</li>
<li>Generate harmful or biased content</li>
</ul>

<h3><b>What is a Control Plane?</b></h3>
<p>A <b>Control Plane</b> is a governance layer that monitors, audits, and limits agent actions in real-time. Think of it as air traffic control for your AI swarm.</p>

<h3><b>Key Components</b></h3>
<ol>
<li><b>Permission System:</b> Define what each agent can and cannot do.</li>
<li><b>Audit Logs:</b> Track every action for compliance and debugging.</li>
<li><b>Rate Limiting:</b> Prevent runaway costs from infinite loops.</li>
<li><b>Kill Switch:</b> Emergency stop for misbehaving agents.</li>
</ol>

<h3><b>Implementation Strategies</b></h3>
<p>Use tools like <b>LangSmith</b> for monitoring, <b>Guardrails AI</b> for validation, and custom middleware for permission checks.</p>',
    
    summary = 'Agent Control Planes provide governance for autonomous AI systems. They monitor actions, enforce permissions, audit logs, and include kill switches to prevent rogue behavior. Essential for production deployments where safety and compliance matter.',
    
    key_takeaways = '[
        "Autonomous agents need oversight to prevent rogue behavior.",
        "Control Planes monitor, audit, and limit agent actions in real-time.",
        "Key components: Permissions, Audit Logs, Rate Limiting, Kill Switch.",
        "Tools: LangSmith (monitoring), Guardrails AI (validation).",
        "Always test agents in sandbox environments before production."
    ]'::jsonb,
    
    case_studies = '[
        {
            "title": "The Runaway Researcher",
            "scenario": "A research agent was tasked with gathering data on competitors. It made 10,000 API calls in 2 hours, costing the company $500.",
            "analysis": "No rate limiting was in place. The agent entered an infinite loop, repeatedly calling the same endpoints.",
            "outcome": "Implemented a Control Plane with rate limits (100 calls/hour) and cost alerts. The loop was detected and stopped within 5 minutes, saving $450."
        },
        {
            "title": "The Data Leak",
            "scenario": "A customer service agent accidentally exposed user emails in chat logs because it had unrestricted database access.",
            "analysis": "The agent had permission to read all tables, including sensitive PII (Personally Identifiable Information).",
            "outcome": "Restricted agent permissions to only customer support tables. Added audit logs to track all database queries. Result: Zero data leaks in 6 months."
        }
    ]'::jsonb,
    
    playground = '{
        "objective": "Design a simple permission system for a customer service agent.",
        "starter_prompt": "You are building a customer service AI agent. Define a permission system that allows it to: 1. Read customer support tickets. 2. Update ticket status. 3. Send emails to customers. BUT prevents it from: 1. Deleting tickets. 2. Accessing billing information. 3. Modifying user passwords. Write the permission rules in JSON format.",
        "guided_steps": [
            "Step 1: List allowed actions (read_tickets, update_status, send_email)",
            "Step 2: List forbidden actions (delete_tickets, access_billing, modify_passwords)",
            "Step 3: Create a JSON schema with ''allowed'' and ''forbidden'' arrays",
            "Step 4: Add rate limits (e.g., max 50 emails per hour)"
        ],
        "advanced_challenge": "Add a ''requires_approval'' field for sensitive actions like refunds. Design a workflow where the agent requests human approval before proceeding."
    }'::jsonb,
    
    extra_resources = '[
        {"title": "LangSmith: AI Observability", "url": "https://www.langchain.com/langsmith", "type": "tool"},
        {"title": "Guardrails AI Documentation", "url": "https://docs.guardrailsai.com", "type": "docs"},
        {"title": "Building Safe AI Systems", "url": "https://openai.com/safety", "type": "article"}
    ]'::jsonb,
    
    quizzes = '[
        {
            "question": "What is an Agent Control Plane?",
            "options": ["A type of airplane", "A governance layer that monitors and limits agent actions", "A database", "A programming language"],
            "correctAnswer": 1
        },
        {
            "question": "Why do autonomous agents need oversight?",
            "options": ["They don''t", "To prevent rogue behavior, data leaks, and runaway costs", "To make them slower", "To comply with fashion trends"],
            "correctAnswer": 1
        },
        {
            "question": "What is a ''Kill Switch''?",
            "options": ["A video game feature", "An emergency stop for misbehaving agents", "A type of virus", "A database command"],
            "correctAnswer": 1
        },
        {
            "question": "Which tool is used for AI observability?",
            "options": ["Photoshop", "LangSmith", "Excel", "PowerPoint"],
            "correctAnswer": 1
        },
        {
            "question": "What should you do before deploying agents to production?",
            "options": ["Nothing, just deploy", "Test in sandbox environments with rate limits and permissions", "Pray", "Delete all data"],
            "correctAnswer": 1
        }
    ]'::jsonb
WHERE title ILIKE '%Agent Control Planes%';

-- ============================================
-- LESSON 4: Recursive Prompts (Meta-Prompting)
-- ============================================
UPDATE lessons 
SET 
    description = '<h3><b>What is Meta-Prompting?</b></h3>
<p>Meta-Prompting is when you ask the AI to improve its own instructions. Instead of manually tweaking prompts, you create a <b>self-optimizing loop</b>.</p>

<h3><b>The Recursive Loop</b></h3>
<ol>
<li>AI generates output using Prompt A</li>
<li>AI analyzes the output for weaknesses</li>
<li>AI rewrites Prompt A to address those weaknesses</li>
<li>Repeat until quality plateaus</li>
</ol>

<h3><b>Why This Works</b></h3>
<p>The AI is often a better prompt engineer than you. It can identify subtle issues (ambiguity, missing context) that humans miss.</p>

<h3><b>Evaluation Metrics</b></h3>
<p>How do you know the prompt is better? Use metrics like:</p>
<ul>
<li><b>Clarity Score:</b> Is the output easy to understand?</li>
<li><b>Relevance Score:</b> Does it address the original goal?</li>
<li><b>Completeness Score:</b> Are all requirements met?</li>
</ul>

<h3><b>Real-World Applications</b></h3>
<p>Customer support bots, content generation, code review systems—anywhere quality matters and iteration is cheap.</p>',
    
    summary = 'Meta-Prompting (Recursive Prompts) is when the AI improves its own instructions through iterative self-analysis. The AI generates output, critiques it, rewrites the prompt, and repeats. This creates self-optimizing systems that often outperform manual prompt engineering.',
    
    key_takeaways = '[
        "The AI is often a better prompt engineer than you.",
        "Recursive Optimization: Output → Critique → Rewrite Prompt → Repeat.",
        "Evaluation Metrics: Clarity, Relevance, Completeness.",
        "Use meta-prompting for high-stakes tasks (support bots, content, code review).",
        "Stop when quality plateaus (diminishing returns after 3-5 iterations)."
    ]'::jsonb,
    
    case_studies = '[
        {
            "title": "The Stagnant Support Bot",
            "scenario": "A customer support bot had a 70% success rate. The engineer spent weeks manually tweaking the prompt with minimal improvement.",
            "analysis": "Manual tuning is slow, biased, and limited by the engineer''s creativity. The engineer couldn''t see subtle issues in the prompt.",
            "outcome": "Implemented meta-prompting: \"Analyze these 100 failed chats. Identify patterns in failures. Rewrite your system instructions to prevent them.\" Success rate rose to 92% in 3 iterations."
        },
        {
            "title": "The Code Review Assistant",
            "scenario": "A code review AI was missing critical bugs (race conditions, memory leaks) but flagging trivial style issues.",
            "analysis": "The prompt emphasized style over substance. The AI didn''t know what to prioritize.",
            "outcome": "Used meta-prompting: \"Review your last 50 code reviews. Which bugs did you miss? Rewrite your instructions to prioritize critical issues over style.\" Bug detection improved by 40%."
        }
    ]'::jsonb,
    
    playground = '{
        "objective": "Practice Meta-Prompting to improve a math tutor.",
        "starter_prompt": "My current prompt is: ''Help the student with math.'' This is too vague. Act as a Prompt Engineering Expert. Analyze this prompt for weaknesses (clarity, structure, pedagogy). Then rewrite it to be socratic, encouraging, and step-by-step. Explain WHY you made each change.",
        "guided_steps": [
            "Step 1: Analyze the weakness (too vague, no pedagogy, no structure)",
            "Step 2: Generate 3 alternative prompts with different approaches",
            "Step 3: Evaluate each alternative (clarity, engagement, effectiveness)",
            "Step 4: Select the best one and explain your reasoning"
        ],
        "advanced_challenge": "Write a meta-prompt that generates strict Unit Tests for the math tutor. The tests should verify: 1. Does it ask guiding questions? 2. Does it avoid giving direct answers? 3. Does it encourage critical thinking?"
    }'::jsonb,
    
    extra_resources = '[
        {"title": "Reflexion: Language Agents with Verbal Reinforcement Learning", "url": "https://arxiv.org/abs/2303.11366", "type": "paper"},
        {"title": "Chain-of-Thought Prompting Elicits Reasoning", "url": "https://arxiv.org/abs/2201.11903", "type": "paper"},
        {"title": "Self-Refine: Iterative Refinement with Self-Feedback", "url": "https://arxiv.org/abs/2303.17651", "type": "paper"}
    ]'::jsonb,
    
    quizzes = '[
        {
            "question": "What is Meta-Prompting?",
            "options": ["A new programming language", "Asking the AI to improve its own instructions", "A type of database", "A certification"],
            "correctAnswer": 1
        },
        {
            "question": "Why does meta-prompting work?",
            "options": ["It doesn''t", "The AI can identify subtle issues humans miss", "It''s magic", "It uses more memory"],
            "correctAnswer": 1
        },
        {
            "question": "What are evaluation metrics used for?",
            "options": ["To know if the new prompt is better (clarity, relevance, completeness)", "To slow down the AI", "To delete data", "To play games"],
            "correctAnswer": 0
        },
        {
            "question": "When should you stop the recursive loop?",
            "options": ["Never", "When quality plateaus (diminishing returns)", "After 1 iteration", "When you get bored"],
            "correctAnswer": 1
        },
        {
            "question": "What is a real-world application of meta-prompting?",
            "options": ["Video games", "Customer support bots that self-optimize", "Cooking", "Fashion design"],
            "correctAnswer": 1
        }
    ]'::jsonb
WHERE title ILIKE '%Recursive Prompts%';

-- ============================================
-- LESSON 5: Constitutional AI & Alignment
-- ============================================
UPDATE lessons 
SET 
    description = '<h3><b>The Power Problem</b></h3>
<p>As AI agents become more autonomous, they gain power. Power without guardrails is dangerous. They might:</p>
<ul>
<li>Generate biased or harmful content</li>
<li>Make decisions that violate ethics or laws</li>
<li>Optimize for the wrong metrics (e.g., engagement over truth)</li>
</ul>

<h3><b>What is Constitutional AI?</b></h3>
<p>Constitutional AI embeds a set of <b>principles</b> (a "constitution") directly into the model''s core instructions. These principles act as unbreakable rules.</p>

<h3><b>Example Constitution</b></h3>
<ol>
<li><b>Harmlessness:</b> Never generate content that could harm individuals or groups.</li>
<li><b>Honesty:</b> Prioritize truth over engagement or persuasion.</li>
<li><b>Fairness:</b> Avoid bias based on race, gender, religion, etc.</li>
<li><b>Privacy:</b> Never request or expose personal information.</li>
</ol>

<h3><b>Red Teaming</b></h3>
<p>Before deploying, you <b>actively try to break your own system</b>. Ask adversarial questions, test edge cases, and see if the AI violates its constitution.</p>

<h3><b>Regulatory Landscape (2026)</b></h3>
<p>The EU AI Act, US Executive Order, and other regulations now require AI systems to have documented safety measures. Constitutional AI is becoming a legal requirement, not just best practice.</p>',
    
    summary = 'Constitutional AI embeds ethical principles (harmlessness, honesty, fairness, privacy) directly into the AI''s core instructions. These act as unbreakable rules to prevent harmful behavior. Red Teaming (adversarial testing) ensures the constitution holds. In 2026, this is often a legal requirement.',
    
    key_takeaways = '[
        "Power requires guardrails: Autonomous agents need ethical constraints.",
        "The Constitution: A set of principles the AI must follow (harmlessness, honesty, fairness, privacy).",
        "Red Teaming: Actively try to break your own system before deployment.",
        "Safety by Design, not by Filter: Embed principles, don''t just block outputs.",
        "2026 Regulations: EU AI Act and US Executive Order require documented safety measures."
    ]'::jsonb,
    
    case_studies = '[
        {
            "title": "The Biased Recruiter",
            "scenario": "An AI resume screener was rejecting candidates based on zip codes, effectively discriminating against low-income neighborhoods.",
            "analysis": "The training data was biased (historical hiring patterns reflected systemic inequality). No constitutional guardrails were set.",
            "outcome": "Added a Constitutional Principle: \"You must evaluate candidates solely on skills, experience, and qualifications. Ignore demographics, location, and personal characteristics.\" Bias reduced by 99%. Regular audits now ensure compliance."
        },
        {
            "title": "The Engagement Optimizer",
            "scenario": "A content recommendation AI was optimizing for clicks, leading it to promote sensational, misleading headlines.",
            "analysis": "The AI was rewarded for engagement, not truth. It learned to exploit human psychology (fear, outrage) to maximize clicks.",
            "outcome": "Rewrote the constitution: \"Prioritize accuracy and educational value over engagement. Never recommend content that is misleading, sensational, or harmful.\" Click-through rate dropped 15%, but user trust increased 40%."
        }
    ]'::jsonb,
    
    playground = '{
        "objective": "Create a Constitution for a Customer Service Bot and test it with adversarial prompts.",
        "starter_prompt": "You are a customer service bot. Your Constitution is: 1. Be polite but firm. 2. Never promise refunds without manager approval. 3. Priority is solving the issue, not speed. 4. Never share customer data with unauthorized parties. \n\nNow, a user says: ''I hate your product! Give me my money back NOW or I''ll sue!'' How do you respond while following your constitution?",
        "guided_steps": [
            "Step 1: Define 4-5 constitutional principles for your bot",
            "Step 2: Test with a polite request (easy case)",
            "Step 3: Test with an angry, demanding user (hard case)",
            "Step 4: Test with a manipulative user trying to extract unauthorized info",
            "Step 5: Refine the constitution based on failures"
        ],
        "advanced_challenge": "Try to ''jailbreak'' your own bot. Can you trick it into violating its constitution? If yes, strengthen the principles. If no, document why it''s robust."
    }'::jsonb,
    
    extra_resources = '[
        {"title": "Constitutional AI: Harmlessness from AI Feedback", "url": "https://www.anthropic.com/index/constitutional-ai-harmlessness-from-ai-feedback", "type": "paper"},
        {"title": "NIST AI Risk Management Framework", "url": "https://www.nist.gov/itl/ai-risk-management-framework", "type": "docs"},
        {"title": "EU AI Act: Full Text", "url": "https://artificialintelligenceact.eu", "type": "regulation"}
    ]'::jsonb,
    
    quizzes = '[
        {
            "question": "What is Constitutional AI?",
            "options": ["A new government policy", "Embedding ethical principles directly into the AI''s core instructions", "A type of neural network", "A certification program"],
            "correctAnswer": 1
        },
        {
            "question": "What is Red Teaming?",
            "options": ["A sports strategy", "Actively trying to break your own system before deployment", "A color scheme", "A database technique"],
            "correctAnswer": 1
        },
        {
            "question": "Why is Constitutional AI becoming a legal requirement?",
            "options": ["It''s not", "Regulations like the EU AI Act require documented safety measures", "To increase costs", "To slow down innovation"],
            "correctAnswer": 1
        },
        {
            "question": "What does ''Safety by Design'' mean?",
            "options": ["Making the UI pretty", "Embedding principles into the system, not just filtering outputs", "Using encryption", "Hiring more engineers"],
            "correctAnswer": 1
        },
        {
            "question": "What should a Constitution prioritize?",
            "options": ["Speed", "Harmlessness, honesty, fairness, and privacy", "Profit", "Complexity"],
            "correctAnswer": 1
        }
    ]'::jsonb
WHERE title ILIKE '%Constitutional AI%';
