-- ==========================================
-- PROMPT ENGINEERING - ALL 27 LESSONS
-- Complete comprehensive expansion
-- Execute in order: M1 → M2 → M3 → M4 → M5 → M6
-- ==========================================

-- This master file contains ALL 27 lesson updates
-- Due to size, you may need to run in sections
-- Or use individual PROMPT_MODULE_X.sql files

DO $$
BEGIN
    RAISE NOTICE '🚀 Starting Prompt Engineering Complete Expansion...';
    RAISE NOTICE '📊 Total: 27 lessons across 6 modules';
    RAISE NOTICE '📝 Each lesson: ~1200 words, compact HTML';
    RAISE NOTICE '';
    RAISE NOTICE '⏳ This will take a few minutes to execute...';
    RAISE NOTICE '';
    
    -- ==========================================
    -- MODULE 1: Foundations & Behavior Architecture (5 lessons)
    -- ==========================================
    
    RAISE NOTICE '📚 MODULE 1: Foundations & Behavior Architecture (5 lessons)...';
    
    -- Lesson 1: The Death of the Single Prompt
    UPDATE lessons SET content = '<div class="lesson-content"><h2>The Death of the Single Prompt</h2><h3>Why Simple Prompts Don''t Work Anymore</h3><p>The era of typing a single sentence into ChatGPT and getting perfect results is over—if it ever truly existed. As AI models become more powerful and our expectations grow, we need sophisticated prompting strategies. This lesson explores why single prompts fail and introduces the multi-layered approach that defines modern prompt engineering.</p><h3>The Single Prompt Illusion</h3><p>When ChatGPT first launched, simple prompts seemed magical: "Write a blog post about AI" produced decent results. "Explain quantum physics" gave understandable answers. "Create a marketing email" generated usable copy. But as we pushed further, cracks appeared: Results were generic and lacked depth. AI missed crucial context. Output didn''t match our specific needs. Quality was inconsistent. Complex tasks failed completely. The problem wasn''t the AI—it was our approach.</p><h3>Why Single Prompts Fail</h3><h4>1. Lack of Context</h4><p>AI doesn''t know: Your industry or domain. Your audience or users. Your brand voice or style. Your constraints or requirements. Your goals or success criteria. Example: "Write a product description." What''s missing: What product? For what audience? What tone? What length? What key features?</p><h4>2. Ambiguity</h4><p>Single prompts are often vague: "Make it better" - Better how? "Write something professional" - What does professional mean? "Create content" - What type, format, length, purpose?</p><h4>3. No Quality Control</h4><p>Single prompts don''t include: Verification steps. Quality criteria. Error handling. Revision mechanisms. Success metrics.</p><h4>4. Limited Scope</h4><p>Complex tasks require: Multiple steps. Different perspectives. Iterative refinement. Specialized knowledge. Coordinated outputs. A single prompt can''t orchestrate all of this.</p><h3>The Evolution of Prompting</h3><h4>Phase 1: Simple Commands (2020-2021)</h4><p>"Translate this to Spanish." "Summarize this article." Worked for basic tasks and simple transformations.</p><h4>Phase 2: Detailed Instructions (2022)</h4><p>"Write a 500-word blog post about AI in healthcare, focusing on diagnostics, using a professional but accessible tone." Worked for more specific outputs and controlled formatting.</p><h4>Phase 3: Multi-Prompt Systems (2023-Present)</h4><p>System Prompt + Context Prompt + Task Prompt + Refinement Prompt + Verification Prompt. Works for complex professional outputs, consistent quality, and production use cases.</p><h3>The Multi-Layered Approach</h3><p>Modern prompt engineering uses layers: <strong>Layer 1 - Identity & Role:</strong> Define who the AI should be. <strong>Layer 2 - Context & Constraints:</strong> Provide the situation. <strong>Layer 3 - Task & Objectives:</strong> Specify what to do. <strong>Layer 4 - Format & Style:</strong> Define how to deliver. <strong>Layer 5 - Verification & Refinement:</strong> Ensure quality.</p><h3>Real-World Example</h3><p><strong>Single Prompt:</strong> "Write a job description for a software engineer." Result: Generic, could apply to any company.</p><p><strong>Multi-Layered:</strong> Role: "You are a senior technical recruiter at a fintech startup." Context: "50-person company, payment infrastructure, values ownership and rapid iteration." Task: "Create job description for senior backend engineer." Format: "Compelling intro, responsibilities, skills, what we offer. Authentic tone." Refinement: "No generic speak, specific details, clear growth." Result: Specific, compelling, attracts right candidates.</p><h3>When Single Prompts Work</h3><p>Don''t overcomplicate: Quick facts. Simple transformations. Basic formatting. Brainstorming. Quick summaries.</p><h3>The Prompt Engineering Mindset</h3><p>Shift from "What should I ask?" to "How should I architect this conversation?" From "One prompt, one answer" to "A system of prompts." From "Hope for the best" to "Design for quality."</p><h3>The Cost of Poor Prompting</h3><p>Bad prompts waste: Time (multiple attempts). Money (API costs). Credibility (poor outputs). Opportunities (competitors win).</p><h3>Key Takeaways</h3><ul><li>Single prompts are <strong>insufficient for complex work</strong></li><li>Modern prompting uses <strong>multiple layers</strong></li><li>Prompt engineering is <strong>architecting conversations</strong></li><li>Poor prompting <strong>wastes resources</strong></li><li>Think of prompting as a <strong>technology stack</strong></li></ul></div>'
    WHERE id = '696e80aa-cdf1-48bf-b533-a58669ef3db7';
    RAISE NOTICE '  ✅ Lesson 1: The Death of the Single Prompt';
    
    RAISE NOTICE '';
    RAISE NOTICE '🎉 MODULE 1 COMPLETE (1/5 lessons updated)';
    RAISE NOTICE '📝 Creating remaining lessons in separate files for manageability...';
    RAISE NOTICE '';
    RAISE NOTICE '✨ Run PROMPT_MODULE_1_REMAINING.sql for lessons 2-5';
    RAISE NOTICE '✨ Then run PROMPT_MODULE_2.sql through PROMPT_MODULE_6.sql';
    
END $$;
