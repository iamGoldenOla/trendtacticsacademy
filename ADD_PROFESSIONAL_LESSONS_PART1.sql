-- ============================================================================
-- ADD 5 PROFESSIONAL LESSONS + CLEAN UP DUPLICATES
-- ============================================================================
-- This adds the professional lessons to your existing course
-- and removes duplicate lessons
-- ============================================================================

-- STEP 1: Delete duplicate lessons (keep only one of each)
-- ============================================================================

-- Delete duplicate "What is Prompt Engineering?" (keep the first one)
DELETE FROM lessons 
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND title = 'What is Prompt Engineering?'
AND id NOT IN (
    SELECT MIN(id) FROM lessons 
    WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
    AND title = 'What is Prompt Engineering?'
);

-- Delete duplicate "Understanding AI Models" (keep the first one)
DELETE FROM lessons 
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND title = 'Understanding AI Models'
AND id NOT IN (
    SELECT MIN(id) FROM lessons 
    WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
    AND title = 'Understanding AI Models'
);

SELECT 'Duplicates removed ✅' as status;

-- STEP 2: Add the 5 professional lessons
-- ============================================================================

-- Get the module IDs we need
DO $$
DECLARE
    v_course_id UUID := '123e4567-e89b-12d3-a456-426614174001';
    v_module1_id UUID;
    v_module3_id UUID;
    v_module4_id UUID;
BEGIN
    -- Get module IDs
    SELECT id INTO v_module1_id FROM modules WHERE course_id = v_course_id AND title ILIKE '%Foundations%' LIMIT 1;
    SELECT id INTO v_module3_id FROM modules WHERE course_id = v_course_id AND title ILIKE '%Advanced Workflows%' LIMIT 1;
    SELECT id INTO v_module4_id FROM modules WHERE course_id = v_course_id AND title ILIKE '%Professional Mastery%' LIMIT 1;

    -- LESSON 1: The Death of the Single Prompt (Module 1)
    INSERT INTO lessons (course_id, module_id, title, description, summary, key_takeaways, case_studies, playground, extra_resources, quizzes, order_index)
    VALUES (
        v_course_id,
        v_module1_id,
        'The Death of the Single Prompt',
        '<h2><b>Why Single Prompts Fail</b></h2>
<p>Imagine asking one employee to: research the market, design the product, build it, test it, market it, sell it, and handle customer service. Absurd, right? Yet that''s exactly what we do with single prompts.</p>

<h3><b>The Single Prompt Trap</b></h3>
<p>A single prompt tries to do everything at once:</p>
<ul>
<li>Understand context</li>
<li>Generate ideas</li>
<li>Evaluate quality</li>
<li>Refine output</li>
<li>Format results</li>
</ul>

<p>Result: Mediocre at everything, excellent at nothing.</p>

<h3><b>The Multi-Prompt Revolution</b></h3>
<p>Break complex tasks into specialized prompts:</p>
<ol>
<li><b>Research Prompt:</b> Gather information</li>
<li><b>Analysis Prompt:</b> Process data</li>
<li><b>Generation Prompt:</b> Create content</li>
<li><b>Critique Prompt:</b> Evaluate quality</li>
<li><b>Refinement Prompt:</b> Polish output</li>
</ol>

<p>Each prompt does ONE thing exceptionally well.</p>

<h3><b>Real-World Example: Blog Post Creation</b></h3>
<p><b>Single Prompt Approach:</b> "Write a 1000-word blog post about AI in healthcare with SEO keywords, examples, and a compelling CTA."</p>
<p><b>Result:</b> Generic content, poor SEO, weak examples.</p>

<p><b>Multi-Prompt Approach:</b></p>
<ol>
<li>Research: "Find 10 trending AI healthcare applications"</li>
<li>Keywords: "Generate 20 SEO keywords for AI in healthcare"</li>
<li>Outline: "Create a blog outline using these topics and keywords"</li>
<li>Write: "Write introduction using this outline"</li>
<li>Examples: "Add 3 real-world case studies"</li>
<li>CTA: "Write a compelling call-to-action"</li>
<li>Polish: "Edit for clarity and engagement"</li>
</ol>

<p><b>Result:</b> Professional, SEO-optimized, engaging content.</p>

<h3><b>The Assembly Line Principle</b></h3>
<p>Henry Ford revolutionized manufacturing with assembly lines. Each station perfected one task. The same principle applies to prompts.</p>

<p><b>Single Prompt = One worker doing everything (slow, inconsistent)</b><br>
<b>Multi-Prompt = Assembly line (fast, consistent, high-quality)</b></p>',
        
        'Single prompts fail for complex tasks because they try to do too much at once. Multi-prompt systems break tasks into specialized steps where each prompt excels at ONE thing. This assembly-line approach produces better results faster.',
        
        '["Single prompts fail for complex tasks - they try to do too much at once", "Multi-prompt systems break tasks into specialized steps (research → analyze → synthesize)", "Each prompt in a chain has ONE job and does it well", "Prompt chains are like assembly lines - each station perfects one thing", "Real-world example: Content creation uses 5+ prompts (research, outline, write, edit, SEO)"]'::jsonb,
        
        '[{"title": "The Blog Post That Took 47 Attempts", "scenario": "A marketer tried writing a blog post with one mega-prompt containing: topic, audience, tone, SEO keywords, structure, examples, and CTA. Result: 47 attempts, still mediocre.", "analysis": "The prompt was doing 7 jobs at once. AI couldn''t balance all requirements. Some attempts had good SEO but poor readability. Others had great examples but wrong tone.", "outcome": "Split into 5 prompts: 1) Research keywords, 2) Create outline, 3) Write draft, 4) Add examples, 5) Optimize SEO. Result: Perfect post in 5 attempts. 90% time saved."}, {"title": "The Customer Service Disaster", "scenario": "A company used one prompt to handle all customer inquiries. Customers complained responses were generic and unhelpful.", "analysis": "One prompt couldn''t handle: product questions, complaints, returns, technical issues, and billing. Each needs different knowledge and tone.", "outcome": "Created 5 specialized prompts: Product Info Bot, Complaint Handler, Returns Processor, Tech Support, Billing Assistant. Customer satisfaction jumped from 3.2/5 to 4.7/5."}]'::jsonb,
        
        '{"objective": "Experience the difference between single-prompt and multi-prompt approaches", "starter_prompt": "Task: Create a product launch email.\n\nApproach 1 (Single Prompt): Write a product launch email for a new smartwatch. Include: catchy subject line, engaging intro, 3 key features, customer testimonial, pricing, CTA, and PS with urgency.\n\nApproach 2 (Multi-Prompt Chain):\n1. Generate 5 subject line options for a smartwatch launch\n2. Write an engaging intro paragraph\n3. List 3 key features\n4. Write a customer testimonial\n5. Combine all elements into final email", "guided_steps": ["Try the single prompt first. Evaluate quality.", "Now try the 5-prompt chain. Compare results.", "Which approach gave better results?", "Which was easier to refine?"], "advanced_challenge": "Build a 7-step chain for creating a landing page: Research → Headlines → Features → Benefits → Social Proof → CTA → Final Assembly"}'::jsonb,
        
        '[{"title": "Why Single Prompts Fail", "url": "https://www.anthropic.com/index/prompting-long-context", "type": "article"}, {"title": "Building Prompt Chains", "url": "https://www.promptingguide.ai/techniques/prompt_chaining", "type": "guide"}, {"title": "LangChain Documentation", "url": "https://python.langchain.com/docs/modules/chains", "type": "docs"}, {"title": "Prompt Engineering Best Practices", "url": "https://platform.openai.com/docs/guides/prompt-engineering", "type": "docs"}]'::jsonb,
        
        '[{"question": "Why do single prompts fail for complex tasks?", "options": ["They are too short", "They try to do too much at once, making it impossible to balance all requirements", "AI doesn''t understand them", "They cost too much"], "correctAnswer": 1}, {"question": "What is a prompt chain?", "options": ["A single very long prompt", "Multiple specialized prompts where each does ONE job well", "A type of AI model", "A security feature"], "correctAnswer": 1}, {"question": "In the blog post case study, how many prompts replaced the single mega-prompt?", "options": ["2", "3", "5", "10"], "correctAnswer": 2}, {"question": "What happened to customer satisfaction when the company switched from one prompt to five specialized prompts?", "options": ["It decreased", "It stayed the same", "It jumped from 3.2/5 to 4.7/5", "Customers left"], "correctAnswer": 2}, {"question": "Prompt chains are like:", "options": ["A single worker doing everything", "An assembly line where each station perfects one thing", "A broken system", "A waste of time"], "correctAnswer": 1}]'::jsonb,
        
        100
    );

    RAISE NOTICE 'Added: The Death of the Single Prompt ✅';

    -- Continue with remaining 4 lessons in next section...
    -- (Due to length limits, I'll create this in multiple files)
    
END $$;

SELECT 'Professional lessons being added...' as status;
