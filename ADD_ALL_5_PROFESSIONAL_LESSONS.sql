-- ============================================================================
-- ADD 5 PROFESSIONAL LESSONS TO PROMPT ENGINEERING COURSE
-- ============================================================================
-- Run this file ONCE to add all 5 professional lessons
-- ============================================================================

-- First, remove duplicates
DELETE FROM lessons WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' AND title = 'What is Prompt Engineering?' AND id NOT IN (SELECT MIN(id) FROM lessons WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' AND title = 'What is Prompt Engineering?');
DELETE FROM lessons WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' AND title = 'Understanding AI Models' AND id NOT IN (SELECT MIN(id) FROM lessons WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' AND title = 'Understanding AI Models');

-- Now add the 5 professional lessons
-- These will be added to Modules 1, 3, and 4

-- Get module IDs
DO $$
DECLARE
    v_course_id UUID := '123e4567-e89b-12d3-a456-426614174001';
    v_mod1 UUID;
    v_mod3 UUID;
    v_mod4 UUID;
BEGIN
    SELECT id INTO v_mod1 FROM modules WHERE course_id = v_course_id AND ordering = 1;
    SELECT id INTO v_mod3 FROM modules WHERE course_id = v_course_id AND ordering = 3;
    SELECT id INTO v_mod4 FROM modules WHERE course_id = v_course_id AND ordering = 4;

    -- LESSON 1: The Death of the Single Prompt
    INSERT INTO lessons (course_id, module_id, title, description, summary, key_takeaways, case_studies, playground, extra_resources, quizzes, order_index)
    VALUES (v_course_id, v_mod1, 'The Death of the Single Prompt',
    '<h2>Why Single Prompts Fail</h2><p>Single prompts try to do everything at once: understand context, generate ideas, evaluate quality, refine output, and format results. Result: Mediocre at everything, excellent at nothing.</p><h3>The Multi-Prompt Revolution</h3><p>Break complex tasks into specialized prompts: Research → Analysis → Generation → Critique → Refinement. Each prompt does ONE thing exceptionally well.</p>',
    'Single prompts fail for complex tasks. Multi-prompt systems break tasks into specialized steps where each prompt excels at ONE thing.',
    '["Single prompts fail - they try to do too much at once", "Multi-prompt systems = specialized steps", "Each prompt has ONE job", "Like assembly lines - each station perfects one thing", "Example: Content creation uses 5+ prompts"]'::jsonb,
    '[{"title": "Blog Post: 47 Attempts", "scenario": "One mega-prompt with 7 requirements. 47 attempts, still mediocre.", "outcome": "Split into 5 prompts. Perfect in 5 attempts. 90% time saved."}]'::jsonb,
    '{"objective": "Compare single vs multi-prompt", "starter_prompt": "Create product launch email. Try both approaches."}'::jsonb,
    '[{"title": "Prompt Chains", "url": "https://www.promptingguide.ai/techniques/prompt_chaining", "type": "guide"}]'::jsonb,
    '[{"question": "Why do single prompts fail?", "options": ["Too short", "Try to do too much at once", "AI doesn''t understand", "Too expensive"], "correctAnswer": 1}]'::jsonb,
    100);

    -- LESSON 2: Designing The Swarm
    INSERT INTO lessons (course_id, module_id, title, description, summary, key_takeaways, case_studies, playground, extra_resources, quizzes, order_index)
    VALUES (v_course_id, v_mod3, 'Designing The Swarm',
    '<h2>Swarm Intelligence</h2><p>Multiple specialized agents working together outperform one generalist. Each agent has a specific role: researcher, analyst, writer, critic, optimizer.</p>',
    'Swarm intelligence: Multiple specialized agents collaborating create emergent intelligence.',
    '["Swarm = multiple specialized agents", "Each agent has one role", "Agents communicate through handoffs", "Swarm > sum of parts", "Real uses: content, code, support"]'::jsonb,
    '[{"title": "Marketing Agency 10x", "scenario": "One AI: 3 campaigns/week. Five-agent swarm: 30 campaigns/week, 40% higher conversion."}]'::jsonb,
    '{"objective": "Build your first AI swarm", "starter_prompt": "Create product description using 4-agent swarm."}'::jsonb,
    '[{"title": "Multi-Agent Systems", "url": "https://microsoft.github.io/autogen/", "type": "tool"}]'::jsonb,
    '[{"question": "What is swarm intelligence?", "options": ["One smart AI", "Multiple specialized agents working together", "A database", "A language"], "correctAnswer": 1}]'::jsonb,
    200);

    -- LESSON 3: Agent Control Planes
    INSERT INTO lessons (course_id, module_id, title, description, summary, key_takeaways, case_studies, playground, extra_resources, quizzes, order_index)
    VALUES (v_course_id, v_mod3, 'Agent Control Planes',
    '<h2>Orchestrating Agent Swarms</h2><p>Control planes decide which agent runs when. Three strategies: Sequential (A→B→C), Parallel (A+B+C→Merge), Conditional (IF/THEN routing).</p>',
    'Control planes orchestrate agent swarms with sequential, parallel, or conditional routing.',
    '["Control planes orchestrate swarms", "Three strategies: Sequential, Parallel, Conditional", "Handle errors: retry, fallback, escalate", "Tools: Airflow, LangGraph", "Must be observable"]'::jsonb,
    '[{"title": "Runaway Swarm", "scenario": "No control plane. Chaos. Added orchestration: reliable output."}]'::jsonb,
    '{"objective": "Build control plane for 3-agent swarm", "starter_prompt": "Design dependency graph with error handling."}'::jsonb,
    '[{"title": "LangGraph", "url": "https://python.langchain.com/docs/langgraph", "type": "tool"}]'::jsonb,
    '[{"question": "What is a control plane?", "options": ["AI model", "Orchestrator that decides which agent runs when", "Database", "UI"], "correctAnswer": 1}]'::jsonb,
    201);

    -- LESSON 4: Recursive Prompts
    INSERT INTO lessons (course_id, module_id, title, description, summary, key_takeaways, case_studies, playground, extra_resources, quizzes, order_index)
    VALUES (v_course_id, v_mod4, 'Recursive Prompts',
    '<h2>Self-Improving Prompts</h2><p>Recursive prompts call themselves until a condition is met. Pattern: Generate → Evaluate → IF not good enough → Recurse with feedback. Always set max depth (3-5 iterations).</p>',
    'Recursive prompts improve iteratively: generate, evaluate, recurse if needed.',
    '["Recursive = calls itself until condition met", "Pattern: Generate → Evaluate → Recurse", "Use: refinement, reasoning, improvement", "Set max depth (3-5)", "Examples: debugging, writing, design"]'::jsonb,
    '[{"title": "Self-Improving Essay", "scenario": "One-shot: C-grade. Recursive (3 iterations): A-grade, zero manual editing."}]'::jsonb,
    '{"objective": "Build recursive prompt", "starter_prompt": "Write tagline. Critique. Regenerate if score < 8. Max 3 iterations."}'::jsonb,
    '[{"title": "Self-Refine", "url": "https://arxiv.org/abs/2303.17651", "type": "paper"}]'::jsonb,
    '[{"question": "What is recursive prompt?", "options": ["Long prompt", "Calls itself until condition met", "Broken prompt", "Never finishes"], "correctAnswer": 1}]'::jsonb,
    300);

    -- LESSON 5: Constitutional AI
    INSERT INTO lessons (course_id, module_id, title, description, summary, key_takeaways, case_studies, playground, extra_resources, quizzes, order_index)
    VALUES (v_course_id, v_mod4, 'Constitutional AI & Alignment',
    '<h2>Safe, Aligned AI</h2><p>Constitutional AI follows principles (constitution) to ensure safe, helpful, honest outputs. Alignment: making AI do what humans actually want. Techniques: RLHF, Constitutional AI, Red Teaming.</p>',
    'Constitutional AI follows principles to ensure safety. Alignment makes AI do what humans want.',
    '["Constitutional AI = follows principles", "Alignment = do what humans want", "Red teaming = find vulnerabilities", "Techniques: RLHF, Constitutional AI", "Prevents harm, bias, misinformation"]'::jsonb,
    '[{"title": "Chatbot Gone Rogue", "scenario": "No guardrails. Insulted customers, leaked info. Added constitution: zero incidents in 6 months."}]'::jsonb,
    '{"objective": "Build constitutionally-aligned chatbot", "starter_prompt": "Create chatbot with 5 constitutional principles. Red team it."}'::jsonb,
    '[{"title": "Constitutional AI", "url": "https://arxiv.org/abs/2212.08073", "type": "paper"}]'::jsonb,
    '[{"question": "What is Constitutional AI?", "options": ["AI for lawyers", "AI that follows principles for safety", "AI that votes", "AI for government"], "correctAnswer": 1}]'::jsonb,
    301);

    RAISE NOTICE '✅ All 5 professional lessons added!';
END $$;

-- Verify
SELECT title, m.title as module FROM lessons l JOIN modules m ON l.module_id = m.id WHERE l.course_id = '123e4567-e89b-12d3-a456-426614174001' ORDER BY l.order_index;
