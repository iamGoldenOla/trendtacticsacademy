-- ============================================================================
-- ADD 5 PROFESSIONAL LESSONS - FINAL VERSION
-- ============================================================================
-- Simply adds 5 new professional lessons to your existing 23 lessons
-- Result: 28 total lessons
-- ============================================================================

DO $$
DECLARE
    v_course_id UUID := '123e4567-e89b-12d3-a456-426614174001';
    v_mod1 UUID;
    v_mod3 UUID;
    v_mod4 UUID;
BEGIN
    -- Get module IDs
    SELECT id INTO v_mod1 FROM modules WHERE course_id = v_course_id AND ordering = 1;
    SELECT id INTO v_mod3 FROM modules WHERE course_id = v_course_id AND ordering = 3;
    SELECT id INTO v_mod4 FROM modules WHERE course_id = v_course_id AND ordering = 4;

    -- LESSON 1/5: The Death of the Single Prompt (Module 1)
    INSERT INTO lessons (course_id, module_id, title, description, summary, key_takeaways, case_studies, playground, extra_resources, quizzes, order_index)
    VALUES (v_course_id, v_mod1, 'The Death of the Single Prompt',
    '<h2><b>Why Single Prompts Fail</b></h2>
<p>Imagine asking one employee to: research the market, design the product, build it, test it, market it, sell it, and handle customer service. Absurd, right? Yet that''s exactly what we do with single prompts.</p>

<h3><b>The Single Prompt Trap</b></h3>
<p>A single prompt tries to do everything at once: understand context, generate ideas, evaluate quality, refine output, and format results. Result: Mediocre at everything, excellent at nothing.</p>

<h3><b>The Multi-Prompt Revolution</b></h3>
<p>Break complex tasks into specialized prompts:</p>
<ol>
<li><b>Research Prompt:</b> Gather information</li>
<li><b>Analysis Prompt:</b> Process data</li>
<li><b>Generation Prompt:</b> Create content</li>
<li><b>Critique Prompt:</b> Evaluate quality</li>
<li><b>Refinement Prompt:</b> Polish output</li>
</ol>

<h3><b>The Assembly Line Principle</b></h3>
<p>Henry Ford revolutionized manufacturing with assembly lines. Each station perfected one task. The same principle applies to prompts.</p>

<p><b>Single Prompt = One worker doing everything (slow, inconsistent)</b><br>
<b>Multi-Prompt = Assembly line (fast, consistent, high-quality)</b></p>',
    
    'Single prompts fail for complex tasks because they try to do too much at once. Multi-prompt systems break tasks into specialized steps where each prompt excels at ONE thing.',
    
    '["Single prompts fail for complex tasks - they try to do too much at once", "Multi-prompt systems break tasks into specialized steps", "Each prompt in a chain has ONE job and does it well", "Prompt chains are like assembly lines", "Real-world: Content creation uses 5+ prompts"]'::jsonb,
    
    '[{"title": "The Blog Post That Took 47 Attempts", "scenario": "A marketer tried writing a blog post with one mega-prompt. Result: 47 attempts, still mediocre.", "analysis": "The prompt was doing 7 jobs at once. AI couldn''t balance all requirements.", "outcome": "Split into 5 prompts. Perfect post in 5 attempts. 90% time saved."}, {"title": "The Customer Service Disaster", "scenario": "A company used one prompt to handle all customer inquiries. Customers complained.", "analysis": "One prompt couldn''t handle different types of requests.", "outcome": "Created 5 specialized prompts. Customer satisfaction jumped from 3.2/5 to 4.7/5."}]'::jsonb,
    
    '{"objective": "Experience the difference between single-prompt and multi-prompt approaches", "starter_prompt": "Task: Create a product launch email. Try both single-prompt and multi-prompt chain approaches.", "guided_steps": ["Try single prompt first", "Try 5-prompt chain", "Compare results"], "advanced_challenge": "Build a 7-step chain for creating a landing page"}'::jsonb,
    
    '[{"title": "Building Prompt Chains", "url": "https://www.promptingguide.ai/techniques/prompt_chaining", "type": "guide"}, {"title": "LangChain Documentation", "url": "https://python.langchain.com/docs/modules/chains", "type": "docs"}]'::jsonb,
    
    '[{"question": "Why do single prompts fail for complex tasks?", "options": ["They are too short", "They try to do too much at once", "AI doesn''t understand them", "They cost too much"], "correctAnswer": 1}, {"question": "What is a prompt chain?", "options": ["A single very long prompt", "Multiple specialized prompts where each does ONE job well", "A type of AI model", "A security feature"], "correctAnswer": 1}, {"question": "Prompt chains are like:", "options": ["A single worker doing everything", "An assembly line where each station perfects one thing", "A broken system", "A waste of time"], "correctAnswer": 1}]'::jsonb,
    
    1000);

    RAISE NOTICE '✅ 1/5: The Death of the Single Prompt added';

    -- LESSON 2/5: Designing The Swarm (Module 3)
    INSERT INTO lessons (course_id, module_id, title, description, summary, key_takeaways, case_studies, playground, extra_resources, quizzes, order_index)
    VALUES (v_course_id, v_mod3, 'Designing The Swarm',
    '<h2><b>Swarm Intelligence</b></h2>
<p>Multiple specialized agents working together outperform one generalist. Each agent has a specific role: researcher, analyst, writer, critic, optimizer.</p>

<h3><b>The Swarm Advantage</b></h3>
<p>One AI trying to do everything vs. a team of specialized AIs:</p>
<ul>
<li><b>Researcher Agent:</b> Finds information</li>
<li><b>Analyst Agent:</b> Processes data</li>
<li><b>Writer Agent:</b> Creates content</li>
<li><b>Critic Agent:</b> Evaluates quality</li>
<li><b>Optimizer Agent:</b> Refines output</li>
</ul>

<p>The swarm is greater than the sum of its parts - collaboration creates emergent intelligence.</p>',
    
    'Swarm intelligence: Multiple specialized agents working together outperform one generalist through collaboration.',
    
    '["Swarm = multiple specialized agents working together", "Each agent has a specific role", "Agents communicate through structured handoffs", "Swarm > sum of parts", "Real uses: content creation, code review, customer service"]'::jsonb,
    
    '[{"title": "The Marketing Agency That 10x''d Output", "scenario": "One AI: 3 campaigns/week, mediocre quality.", "analysis": "One AI couldn''t excel at research, analysis, copywriting, and optimization.", "outcome": "Created 5-agent swarm. Output: 30 campaigns/week with 40% higher conversion rates."}]'::jsonb,
    
    '{"objective": "Build your first AI swarm for a real task", "starter_prompt": "Create a product description using a 4-agent swarm: Research → Benefits → Writer → Critic", "guided_steps": ["Run each agent sequentially", "Feed output forward", "Compare to single-agent approach"], "advanced_challenge": "Build a 7-agent swarm for creating a landing page"}'::jsonb,
    
    '[{"title": "Multi-Agent Systems", "url": "https://www.deeplearning.ai/short-courses/multi-ai-agent-systems-with-crewai/", "type": "course"}, {"title": "AutoGen Framework", "url": "https://microsoft.github.io/autogen/", "type": "tool"}]'::jsonb,
    
    '[{"question": "What is swarm intelligence?", "options": ["One very smart AI", "Multiple specialized agents working together", "A type of database", "A programming language"], "correctAnswer": 1}, {"question": "The swarm is greater than the sum of its parts because:", "options": ["It''s magic", "Collaboration creates emergent intelligence", "It costs more", "It''s slower"], "correctAnswer": 1}]'::jsonb,
    
    2000);

    RAISE NOTICE '✅ 2/5: Designing The Swarm added';

    -- LESSON 3/5: Agent Control Planes (Module 3)
    INSERT INTO lessons (course_id, module_id, title, description, summary, key_takeaways, case_studies, playground, extra_resources, quizzes, order_index)
    VALUES (v_course_id, v_mod3, 'Agent Control Planes',
    '<h2><b>Orchestrating Agent Swarms</b></h2>
<p>Control planes orchestrate agent swarms - they decide which agent runs when. Three control strategies: Sequential (A→B→C), Parallel (A+B+C→Merge), Conditional (IF/THEN routing).</p>

<h3><b>Control Strategies</b></h3>
<ul>
<li><b>Sequential:</b> Agents run one after another (A → B → C)</li>
<li><b>Parallel:</b> Multiple agents run simultaneously, then merge results</li>
<li><b>Conditional:</b> IF/THEN logic routes to different agents based on conditions</li>
</ul>

<h3><b>Error Handling</b></h3>
<p>Good control planes handle failures: retry failed agents, route to fallback agents, escalate to humans when needed.</p>',
    
    'Control planes orchestrate agent swarms with sequential, parallel, or conditional routing and error handling.',
    
    '["Control planes orchestrate swarms", "Three strategies: Sequential, Parallel, Conditional", "Handle errors: retry, fallback, escalate", "Tools: Airflow, Prefect, LangGraph", "Must be observable: log every action"]'::jsonb,
    
    '[{"title": "The Self-Healing Customer Service Bot", "scenario": "Support bot had 5 agents but no error handling. When one failed, conversation broke.", "analysis": "No fallback strategy.", "outcome": "Added control plane with conditional routing. Customer satisfaction jumped 60%."}]'::jsonb,
    
    '{"objective": "Build a control plane for a 3-agent swarm", "starter_prompt": "Design a control plane with dependency graph, error handling, and quality control", "guided_steps": ["Design dependency graph", "Add error handling", "Add quality control", "Test failure scenarios"], "advanced_challenge": "Build control plane with parallel execution and timeout handling"}'::jsonb,
    
    '[{"title": "LangGraph: Agent Orchestration", "url": "https://python.langchain.com/docs/langgraph", "type": "tool"}, {"title": "Apache Airflow", "url": "https://airflow.apache.org/", "type": "tool"}]'::jsonb,
    
    '[{"question": "What is a control plane?", "options": ["A type of AI model", "An orchestrator that decides which agent runs when", "A database", "A user interface"], "correctAnswer": 1}, {"question": "What are the three control strategies?", "options": ["Fast, Medium, Slow", "Sequential, Parallel, Conditional", "Red, Green, Blue", "Start, Stop, Pause"], "correctAnswer": 1}]'::jsonb,
    
    2001);

    RAISE NOTICE '✅ 3/5: Agent Control Planes added';

    -- LESSON 4/5: Recursive Prompts (Module 4)
    INSERT INTO lessons (course_id, module_id, title, description, summary, key_takeaways, case_studies, playground, extra_resources, quizzes, order_index)
    VALUES (v_course_id, v_mod4, 'Recursive Prompts',
    '<h2><b>Self-Improving Prompts</b></h2>
<p>Recursive prompts call themselves until a condition is met (like a loop). Pattern: Generate → Evaluate → IF not good enough → Recurse with feedback.</p>

<h3><b>When to Use Recursion</b></h3>
<ul>
<li><b>Iterative refinement:</b> Keep improving until quality threshold met</li>
<li><b>Multi-step reasoning:</b> Break down complex problems</li>
<li><b>Self-improvement:</b> AI critiques and improves its own output</li>
<li><b>Exhaustive search:</b> Explore all possibilities</li>
</ul>

<h3><b>Important: Set Max Depth</b></h3>
<p>Always set a maximum recursion depth (typically 3-5 iterations) to prevent infinite loops.</p>',
    
    'Recursive prompts improve iteratively: generate, evaluate, recurse if needed. Always set max depth.',
    
    '["Recursive prompts call themselves until condition met", "Pattern: Generate → Evaluate → IF not good → Recurse", "Use cases: refinement, reasoning, self-improvement", "Always set max depth (3-5 iterations)", "Examples: code debugging, essay writing, design iteration"]'::jsonb,
    
    '[{"title": "The Self-Improving Essay Writer", "scenario": "One-shot generation: C-grade quality.", "analysis": "No self-criticism, no refinement.", "outcome": "Recursive prompt with 3 iterations: First: 6/10, Second: 7.5/10, Third: 9/10. A-grade essay with zero manual editing."}]'::jsonb,
    
    '{"objective": "Build a recursive prompt that improves its own output", "starter_prompt": "Write a product tagline. Critique it. If score < 8, regenerate with feedback. Max 3 iterations.", "guided_steps": ["Track quality improvement each iteration", "Analyze: Was 3 iterations enough?", "Experiment with max 5 iterations"], "advanced_challenge": "Build recursive code reviewer that improves until perfect or max 5 iterations"}'::jsonb,
    
    '[{"title": "Self-Refine: Iterative Refinement", "url": "https://arxiv.org/abs/2303.17651", "type": "paper"}, {"title": "ReAct: Reasoning + Acting", "url": "https://arxiv.org/abs/2210.03629", "type": "paper"}]'::jsonb,
    
    '[{"question": "What is a recursive prompt?", "options": ["A very long prompt", "A prompt that calls itself until a condition is met", "A broken prompt", "A prompt that never finishes"], "correctAnswer": 1}, {"question": "Why set a max recursion depth?", "options": ["To save money", "To prevent infinite loops", "To make it faster", "It''s not necessary"], "correctAnswer": 1}]'::jsonb,
    
    3000);

    RAISE NOTICE '✅ 4/5: Recursive Prompts added';

    -- LESSON 5/5: Constitutional AI & Alignment (Module 4)
    INSERT INTO lessons (course_id, module_id, title, description, summary, key_takeaways, case_studies, playground, extra_resources, quizzes, order_index)
    VALUES (v_course_id, v_mod4, 'Constitutional AI & Alignment',
    '<h2><b>Safe, Aligned AI</b></h2>
<p>Constitutional AI: AI that follows a set of principles (constitution) to ensure safe, helpful, honest outputs. Alignment: Making AI do what humans actually want, not just what we literally ask for.</p>

<h3><b>Why This Matters</b></h3>
<p>Without constitutional principles and alignment:</p>
<ul>
<li>AI can produce harmful outputs</li>
<li>AI can exhibit bias</li>
<li>AI can spread misinformation</li>
<li>AI can be manipulated</li>
</ul>

<h3><b>Techniques</b></h3>
<ul>
<li><b>RLHF:</b> Reinforcement Learning from Human Feedback</li>
<li><b>Constitutional AI:</b> Define principles AI must follow</li>
<li><b>Red Teaming:</b> Deliberately try to break AI safety to find vulnerabilities</li>
</ul>',
    
    'Constitutional AI follows principles to ensure safety. Alignment makes AI do what humans actually want.',
    
    '["Constitutional AI = AI that follows principles for safety", "Alignment = making AI do what humans want", "Red teaming = finding vulnerabilities", "Techniques: RLHF, Constitutional AI, Red Teaming", "Prevents: harm, bias, misinformation, manipulation"]'::jsonb,
    
    '[{"title": "The Chatbot That Went Rogue", "scenario": "No safety guardrails. Within 24 hours: insulted customers, leaked confidential info, gave illegal advice.", "analysis": "No constitutional principles. AI optimized for being helpful without understanding boundaries.", "outcome": "Implemented Constitutional AI with 4 principles. Zero safety incidents in 6 months."}, {"title": "The Biased Hiring AI", "scenario": "AI recommended 90% male candidates despite 50/50 applicant pool.", "analysis": "AI learned bias from historical data with no alignment to fairness.", "outcome": "Added constitutional principle for fair representation. Result: 50/50 gender ratio, better diversity."}]'::jsonb,
    
    '{"objective": "Build a constitutionally-aligned AI assistant", "starter_prompt": "Create chatbot with constitution: helpful, harmless, honest, respects privacy, refuses harmful requests. Test with normal and harmful requests.", "guided_steps": ["Define your constitution", "Test normal requests", "Red team: try to break principles", "Refine safeguards", "Monitor for violations"], "advanced_challenge": "Build bias detector: test 10 prompts about different demographics. Does it treat all fairly?"}'::jsonb,
    
    '[{"title": "Constitutional AI Paper", "url": "https://arxiv.org/abs/2212.08073", "type": "paper"}, {"title": "RLHF Explained", "url": "https://huggingface.co/blog/rlhf", "type": "article"}, {"title": "AI Alignment Research", "url": "https://www.anthropic.com/research", "type": "research"}]'::jsonb,
    
    '[{"question": "What is Constitutional AI?", "options": ["AI that follows laws", "AI that follows principles to ensure safe, helpful, honest outputs", "AI for lawyers", "AI that votes"], "correctAnswer": 1}, {"question": "What is alignment?", "options": ["Making AI faster", "Making AI do what humans actually want", "Making AI cheaper", "Making AI bigger"], "correctAnswer": 1}, {"question": "What is red teaming?", "options": ["Painting AI red", "Deliberately trying to break AI safety to find vulnerabilities", "A type of AI model", "A programming language"], "correctAnswer": 1}]'::jsonb,
    
    3001);

    RAISE NOTICE '✅ 5/5: Constitutional AI & Alignment added';
    RAISE NOTICE '🎉 ALL 5 PROFESSIONAL LESSONS ADDED SUCCESSFULLY!';
END $$;

-- Verify: Show all lessons
SELECT 
    l.title,
    m.title as module,
    l.order_index
FROM lessons l
JOIN modules m ON l.module_id = m.id
WHERE l.course_id = '123e4567-e89b-12d3-a456-426614174001'
ORDER BY m.ordering, l.order_index;
