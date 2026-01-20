-- ============================================================================
-- ENHANCE 5 PROFESSIONAL LESSONS - Complete Gold Standard Content
-- ============================================================================
-- This updates the 5 professional lessons with full content:
-- - Key Takeaways (Learning Objectives)
-- - Case Studies (2 real-world examples each)
-- - Interactive Playground
-- - 5 Quiz Questions
-- - Curated External Resources
-- ============================================================================

-- Note: These lessons already have great descriptions, we're just adding
-- the missing interactive elements to make them "Gold Standard"

-- We'll update them by title since they exist in the course already
-- ============================================================================

-- LESSON: The Death of the Single Prompt
UPDATE lessons SET
    key_takeaways = '["Single prompts fail for complex tasks - they try to do too much at once", "Multi-prompt systems break tasks into specialized steps (research → analyze → synthesize)", "Each prompt in a chain has ONE job and does it well", "Prompt chains are like assembly lines - each station perfects one thing", "Real-world example: Content creation uses 5+ prompts (research, outline, write, edit, SEO)"]'::jsonb,
    
    case_studies = '[{"title": "The Blog Post That Took 47 Attempts", "scenario": "A marketer tried writing a blog post with one mega-prompt containing: topic, audience, tone, SEO keywords, structure, examples, and CTA. Result: 47 attempts, still mediocre.", "analysis": "The prompt was doing 7 jobs at once. AI couldn''t balance all requirements. Some attempts had good SEO but poor readability. Others had great examples but wrong tone.", "outcome": "Split into 5 prompts: 1) Research keywords, 2) Create outline, 3) Write draft, 4) Add examples, 5) Optimize SEO. Result: Perfect post in 5 attempts. 90% time saved."}, {"title": "The Customer Service Disaster", "scenario": "A company used one prompt to handle all customer inquiries: ''Answer this question professionally and helpfully.'' Customers complained responses were generic and unhelpful.", "analysis": "One prompt couldn''t handle: product questions, complaints, returns, technical issues, and billing. Each needs different knowledge and tone.", "outcome": "Created 5 specialized prompts: Product Info Bot, Complaint Handler, Returns Processor, Tech Support, Billing Assistant. Customer satisfaction jumped from 3.2/5 to 4.7/5."}]'::jsonb,
    
    playground = '{"objective": "Experience the difference between single-prompt and multi-prompt approaches", "starter_prompt": "Task: Create a product launch email. Try BOTH approaches:\n\nApproach 1 (Single Prompt): ''Write a product launch email for a new smartwatch. Include: catchy subject line, engaging intro, 3 key features, customer testimonial, pricing, CTA, and PS with urgency.''\n\nApproach 2 (Multi-Prompt Chain):\n1. ''Generate 5 subject line options for a smartwatch launch''\n2. ''Write an engaging intro paragraph for the best subject line''\n3. ''List 3 key features of a premium smartwatch''\n4. ''Write a customer testimonial for the watch''\n5. ''Combine all elements into a final email with pricing and CTA''", "guided_steps": ["Try the single prompt first. Evaluate: Is it perfect? What''s missing?", "Now try the 5-prompt chain. Compare quality.", "Which approach gave better results?", "Which was easier to refine?"], "advanced_challenge": "Build a 7-step chain for creating a landing page: Research → Headlines → Features → Benefits → Social Proof → CTA → Final Assembly"}'::jsonb,
    
    extra_resources = '[{"title": "Why Single Prompts Fail", "url": "https://www.anthropic.com/index/prompting-long-context", "type": "article"}, {"title": "Building Prompt Chains", "url": "https://www.promptingguide.ai/techniques/prompt_chaining", "type": "guide"}, {"title": "LangChain Documentation", "url": "https://python.langchain.com/docs/modules/chains", "type": "docs"}, {"title": "Prompt Engineering Best Practices", "url": "https://platform.openai.com/docs/guides/prompt-engineering", "type": "docs"}]'::jsonb,
    
    quizzes = '[{"question": "Why do single prompts fail for complex tasks?", "options": ["They are too short", "They try to do too much at once, making it impossible to balance all requirements", "AI doesn''t understand them", "They cost too much"], "correctAnswer": 1}, {"question": "What is a prompt chain?", "options": ["A single very long prompt", "Multiple specialized prompts where each does ONE job well", "A type of AI model", "A security feature"], "correctAnswer": 1}, {"question": "In the blog post case study, how many prompts replaced the single mega-prompt?", "options": ["2", "3", "5", "10"], "correctAnswer": 2}, {"question": "What happened to customer satisfaction when the company switched from one prompt to five specialized prompts?", "options": ["It decreased", "It stayed the same", "It jumped from 3.2/5 to 4.7/5", "Customers left"], "correctAnswer": 2}, {"question": "Prompt chains are like:", "options": ["A single worker doing everything", "An assembly line where each station perfects one thing", "A broken system", "A waste of time"], "correctAnswer": 1}]'::jsonb

WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND title = 'The Death of the Single Prompt';

-- Continue with remaining 4 lessons in next section...
SELECT 'Lesson 1/5 updated: The Death of the Single Prompt' as status;
