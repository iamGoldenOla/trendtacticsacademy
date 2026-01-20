-- ============================================================================
-- COMPLETE PROMPT ENGINEERING COURSE - MODULE 1: FOUNDATIONS
-- ============================================================================
-- 17-Lesson Professional Curriculum: Beginner → Intermediate → Advanced → Professional
-- This file contains Module 1 (Lessons 1-4): Absolute Beginner Foundation
-- ============================================================================

-- First, we need to add these new lessons to the database
-- We'll insert them into the lessons table with the correct course_id

-- Note: You'll need to run this AFTER creating the module structure in your JSON
-- For now, I'll create the UPDATE statements assuming the lessons exist

-- ============================================
-- LESSON 1: What is Prompt Engineering?
-- ============================================
-- This lesson introduces complete beginners to the field
-- Target: Someone who has never used ChatGPT or any AI tool

INSERT INTO lessons (
    course_id,
    module_id,
    title,
    description,
    summary,
    key_takeaways,
    case_studies,
    playground,
    extra_resources,
    quizzes,
    order_index
)
SELECT 
    c.id as course_id,
    m.id as module_id,
    'What is Prompt Engineering?' as title,
    '<h2><b>Welcome to the Future of Work</b></h2>

<p>Imagine having a brilliant assistant who can write, code, analyze data, create art, and solve complex problems—all in seconds. This isn''t science fiction. It''s 2026, and AI assistants like ChatGPT, Claude, and Gemini are transforming how we work, learn, and create.</p>

<p>But here''s the catch: these AI tools are incredibly powerful, yet most people use only 10% of their capabilities. Why? Because they don''t know how to <b>communicate effectively with AI</b>.</p>

<p>That''s where <b>Prompt Engineering</b> comes in.</p>

<h3><b>Definition: Prompt Engineering</b></h3>
<p><b>Prompt Engineering</b> is the practice of designing, refining, and optimizing text instructions (called "prompts") to guide AI models toward producing desired outputs. It''s the bridge between human intent and AI capability—the skill of asking the right questions in the right way to get exceptional results.</p>

<h3><b>Why Does This Matter?</b></h3>

<p>Think of AI as a genius who speaks a different language. If you say "help me," they''re confused. If you say "Act as a senior marketing strategist and create a 5-step social media campaign for launching a sustainable fashion brand targeting Gen Z," they produce brilliance.</p>

<p>The difference? <b>Prompt Engineering.</b></p>

<p>In 2026, Prompt Engineering is one of the most valuable skills in the job market. Companies are hiring "Prompt Engineers" at $150,000-$300,000/year. Why? Because someone who can unlock AI''s full potential can:</p>

<ul>
<li>Write a week''s worth of content in 2 hours</li>
<li>Analyze 1000 customer reviews in 10 minutes</li>
<li>Generate code that would take a developer 3 days in 30 minutes</li>
<li>Create marketing campaigns that previously required a team of 5</li>
</ul>

<h3><b>What is a "Prompt"?</b></h3>

<p>A <b>prompt</b> is simply the text you give to an AI model. It can be:</p>

<ul>
<li><b>A question:</b> "What are the benefits of meditation?"</li>
<li><b>A command:</b> "Write a poem about the ocean."</li>
<li><b>A request:</b> "Summarize this article in 3 bullet points."</li>
<li><b>A complex instruction:</b> "Act as a Python expert. Debug this code and explain each fix."</li>
</ul>

<p>The quality of your prompt determines the quality of the AI''s response. Garbage in, garbage out. Excellence in, excellence out.</p>

<h3><b>Definition: Prompt</b></h3>
<p><b>Prompt</b> is the text input you provide to an AI model to guide its response. It can be a question, command, request, or complex multi-part instruction. The prompt is your primary tool for controlling AI behavior and output quality.</p>

<h3><b>The Evolution of Prompt Engineering</b></h3>

<p>Prompt Engineering has evolved through three distinct eras:</p>

<h4><b>Era 1: Trial and Error (2020-2023)</b></h4>
<p>People treated prompts like magic spells. They''d try random phrases, add emojis, use ALL CAPS, hoping to "trick" the AI into better responses. No systematic approach. No understanding of why things worked.</p>

<h4><b>Era 2: Pattern Recognition (2023-2025)</b></h4>
<p>Researchers discovered patterns: "Act as X" changes tone. "Step-by-step" improves reasoning. "In the style of Y" affects creativity. People started sharing templates and frameworks.</p>

<h4><b>Era 3: Behavior Architecture (2025-Present)</b></h4>
<p>We now understand that prompts aren''t isolated commands—they''re part of <b>systems</b>. Multi-agent workflows, recursive optimization, constitutional guardrails. Prompt Engineering became a professional discipline.</p>

<h3><b>What You''ll Learn in This Course</b></h3>

<p>This course takes you from absolute beginner to professional Prompt Engineer in 17 lessons:</p>

<ul>
<li><b>Module 1 (Lessons 1-4):</b> Foundations - Understanding AI, basic prompts, anatomy of effective prompts</li>
<li><b>Module 2 (Lessons 5-9):</b> Core Techniques - Patterns, context, examples, reasoning, workflows</li>
<li><b>Module 3 (Lessons 10-13):</b> Advanced Workflows - Multi-agent systems, governance, chaining, dynamic prompts</li>
<li><b>Module 4 (Lessons 14-17):</b> Professional Mastery - Meta-prompting, ethics, production deployment, industry applications</li>
</ul>

<h3><b>Who is This Course For?</b></h3>

<ul>
<li><b>Complete Beginners:</b> Never used ChatGPT? Start here.</li>
<li><b>Casual Users:</b> Used AI but want to get better results? This will 10x your skills.</li>
<li><b>Professionals:</b> Want to add AI to your workflow? Learn production-ready techniques.</li>
<li><b>Career Changers:</b> Want to become a Prompt Engineer? This is your roadmap.</li>
</ul>

<h3><b>Real-World Applications</b></h3>

<p>Prompt Engineering isn''t just theoretical. Here''s what professionals use it for:</p>

<ul>
<li><b>Content Creators:</b> Generate blog posts, social media, video scripts</li>
<li><b>Developers:</b> Write code, debug, create documentation</li>
<li><b>Marketers:</b> Create campaigns, analyze data, generate ad copy</li>
<li><b>Researchers:</b> Summarize papers, extract insights, generate hypotheses</li>
<li><b>Educators:</b> Create lesson plans, quizzes, personalized learning paths</li>
<li><b>Lawyers:</b> Draft contracts, analyze cases, research precedents</li>
<li><b>Healthcare:</b> Summarize patient notes, generate reports, research treatments</li>
</ul>

<h3><b>The Prompt Engineering Mindset</b></h3>

<p>To succeed in this course, adopt these principles:</p>

<ol>
<li><b>Be Specific:</b> Vague prompts get vague results. Precision matters.</li>
<li><b>Iterate:</b> Your first prompt won''t be perfect. Refine based on results.</li>
<li><b>Experiment:</b> Try different approaches. There''s no single "right" way.</li>
<li><b>Learn from Examples:</b> Study what works for others, then adapt.</li>
<li><b>Think in Systems:</b> Complex tasks need workflows, not single prompts.</li>
</ol>

<h3><b>What Makes a Good Prompt Engineer?</b></h3>

<p>The best Prompt Engineers share these traits:</p>

<ul>
<li><b>Clarity:</b> They communicate intent precisely</li>
<li><b>Creativity:</b> They find novel ways to frame problems</li>
<li><b>Analytical Thinking:</b> They diagnose why prompts fail</li>
<li><b>Domain Knowledge:</b> They understand the subject matter</li>
<li><b>Patience:</b> They iterate until they get it right</li>
</ul>

<h3><b>Your First Assignment</b></h3>

<p>Before moving to Lesson 2, try this simple exercise:</p>

<ol>
<li>Open ChatGPT, Claude, or any AI tool</li>
<li>Ask: "What is artificial intelligence?"</li>
<li>Now ask: "Explain artificial intelligence to a 10-year-old using a cooking analogy"</li>
<li>Compare the responses. Notice the difference?</li>
</ol>

<p>That''s Prompt Engineering in action. The second prompt is more specific (audience: 10-year-old, format: analogy, topic: cooking). The result is dramatically better.</p>

<h3><b>Conclusion: The Journey Begins</b></h3>

<p>Prompt Engineering is the most important skill of the AI age. It''s not about replacing human intelligence—it''s about amplifying it. By the end of this course, you''ll be able to harness AI''s full potential to work faster, think deeper, and create better.</p>

<p>Welcome to the future. Let''s build it together.</p>' as description,
    
    'Prompt Engineering is the practice of designing text instructions (prompts) to guide AI models toward desired outputs. It''s the bridge between human intent and AI capability. In 2026, it''s one of the most valuable skills ($150K-$300K salaries). This course takes you from beginner to professional in 17 lessons across 4 modules: Foundations, Core Techniques, Advanced Workflows, and Professional Mastery.' as summary,
    
    '[
        "Prompt Engineering: Designing text instructions to guide AI toward desired outputs.",
        "A Prompt: The text input you give to an AI model (question, command, request, or instruction).",
        "Why it matters: Unlocks AI''s full potential—10x productivity, better results, career opportunities.",
        "Evolution: Trial & Error (2020-2023) → Patterns (2023-2025) → Behavior Architecture (2025-present).",
        "The Mindset: Be specific, iterate, experiment, learn from examples, think in systems."
    ]'::jsonb as key_takeaways,
    
    '[
        {
            "title": "The $200K Career Pivot",
            "scenario": "Sarah, a marketing manager, was frustrated with her job. She spent 80% of her time on repetitive tasks: writing social media posts, analyzing campaign data, creating reports. She wanted to be strategic, but had no time.",
            "analysis": "Sarah discovered Prompt Engineering. She learned to use AI to automate her repetitive work: AI wrote first drafts of posts (she edited), analyzed data (she interpreted), generated reports (she refined). Her productivity increased 5x.",
            "outcome": "Sarah applied for a ''Prompt Engineer'' role at a tech company. Salary: $200,000 (double her previous job). Her new role: designing AI workflows for the marketing team. She now does strategic work full-time, using AI for execution."
        },
        {
            "title": "The Student Who Aced Every Class",
            "scenario": "James, a college student, was struggling. He had 5 classes, 3 part-time jobs, and no time to study. His GPA was 2.5. He was on academic probation.",
            "analysis": "James learned basic Prompt Engineering. He used AI to: 1) Summarize textbook chapters (saved 10 hours/week), 2) Generate practice quizzes (improved retention), 3) Explain complex concepts in simple terms (better understanding), 4) Create study guides (organized knowledge).",
            "outcome": "James'' GPA rose to 3.8 in one semester. He got off probation, earned a scholarship, and now tutors other students in ''AI-assisted learning.'' He didn''t cheat—he used AI as a study partner, not a replacement for learning."
        }
    ]'::jsonb as case_studies,
    
    '{
        "objective": "Experience the power of Prompt Engineering by comparing a vague prompt to a specific one.",
        "starter_prompt": "Try these two prompts in any AI tool (ChatGPT, Claude, Gemini): \n\nPrompt 1 (Vague): ''Tell me about climate change.''\n\nPrompt 2 (Specific): ''Act as an environmental scientist. Explain the top 3 causes of climate change to a high school student. Use simple language and include one real-world example for each cause. Keep it under 200 words.''",
        "guided_steps": [
            "Step 1: Copy Prompt 1 into an AI tool. Read the response. Rate it 1-10 for clarity and usefulness.",
            "Step 2: Copy Prompt 2 into the same AI tool. Read the response. Rate it 1-10.",
            "Step 3: Compare the two responses. Which is better? Why?",
            "Step 4: Identify what made Prompt 2 better (role, audience, constraints, format).",
            "Step 5: Create your own Prompt 3 on a different topic using the same structure.",
            "Step 6: Test Prompt 3. Did it work? If not, refine and try again."
        ],
        "advanced_challenge": "Choose a task you do regularly (writing emails, creating presentations, analyzing data). Write a vague prompt for it, then a specific prompt. Compare the AI''s outputs. Can AI save you time on this task?"
    }'::jsonb as playground,
    
    '[
        {"title": "OpenAI: Introduction to Prompt Engineering", "url": "https://platform.openai.com/docs/guides/prompt-engineering", "type": "docs"},
        {"title": "Anthropic: Prompt Engineering Guide", "url": "https://docs.anthropic.com/claude/docs/intro-to-prompting", "type": "docs"},
        {"title": "Learn Prompting: Free Course", "url": "https://learnprompting.org", "type": "course"},
        {"title": "Prompt Engineering Jobs on LinkedIn", "url": "https://www.linkedin.com/jobs/prompt-engineer-jobs", "type": "career"}
    ]'::jsonb as extra_resources,
    
    '[
        {
            "question": "What is Prompt Engineering?",
            "options": [
                "A type of software development",
                "The practice of designing text instructions to guide AI models toward desired outputs",
                "A new programming language",
                "A certification program"
            ],
            "correctAnswer": 1
        },
        {
            "question": "What is a ''prompt''?",
            "options": [
                "A type of AI model",
                "The text input you give to an AI model to guide its response",
                "A database query",
                "A programming function"
            ],
            "correctAnswer": 1
        },
        {
            "question": "Why is Prompt Engineering valuable in 2026?",
            "options": [
                "It''s not valuable, it''s a fad",
                "It unlocks AI''s full potential, increases productivity, and creates high-paying career opportunities",
                "It''s only useful for programmers",
                "It''s required by law"
            ],
            "correctAnswer": 1
        },
        {
            "question": "What is the current era of Prompt Engineering called?",
            "options": [
                "Trial and Error",
                "Pattern Recognition",
                "Behavior Architecture",
                "Magic Spell Casting"
            ],
            "correctAnswer": 2
        },
        {
            "question": "Which of these is a key principle of the Prompt Engineering mindset?",
            "options": [
                "Use as few words as possible",
                "Be specific, iterate, and experiment",
                "Never change your first prompt",
                "Only use prompts that others have tested"
            ],
            "correctAnswer": 1
        }
    ]'::jsonb as quizzes,
    1 as order_index
FROM courses c
CROSS JOIN modules m
WHERE c.title ILIKE '%Prompt Engineering%'
AND m.title ILIKE '%Foundations%'
LIMIT 1;
