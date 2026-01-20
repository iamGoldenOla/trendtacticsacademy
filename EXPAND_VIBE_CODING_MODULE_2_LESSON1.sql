-- ==========================================
-- EXPAND VIBE CODING CONTENT TO 1200-WORD STANDARD
-- Part 2: Module 2 - How AI Actually Builds Software
-- ==========================================

DO $$
DECLARE
    v_course_id UUID;
    v_module_id UUID;
BEGIN
    -- Get Vibe Coding course ID
    SELECT id INTO v_course_id FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1;
    
    IF v_course_id IS NULL THEN
        RAISE EXCEPTION 'Vibe Coding course not found';
    END IF;
    
    RAISE NOTICE '📚 Expanding Vibe Coding Module 2 Content...';
    
    -- Get Module 2 ID
    SELECT id INTO v_module_id FROM modules 
    WHERE course_id = v_course_id AND ordering = 2 LIMIT 1;
    
    -- ==========================================
    -- LESSON 5: How AI Thinks (and Why It Breaks)
    -- ==========================================
    UPDATE lessons SET content = '<h2>How AI Thinks (and Why It Breaks)</h2>

<h3>Understanding the AI Mind</h3>
<p>To work effectively with AI coding assistants, you need to understand how they actually "think." This isn''t about complex technical details—it''s about grasping the fundamental way AI processes your requests and generates code. When you understand this, you''ll know why AI sometimes produces brilliant solutions and other times makes baffling mistakes.</p>

<p>AI doesn''t think like a human programmer. It doesn''t have years of experience, doesn''t get tired, and doesn''t have intuition in the traditional sense. Instead, it operates on <strong>pattern recognition at massive scale</strong>.</p>

<h3>The Pattern Recognition Engine</h3>
<p>Modern AI coding assistants are built on large language models (LLMs) that have been trained on billions of lines of code from across the internet. They''ve seen countless examples of:</p>

<ul>
    <li>How functions are structured</li>
    <li>Common programming patterns</li>
    <li>Solutions to typical problems</li>
    <li>Documentation and explanations</li>
    <li>Code comments and discussions</li>
</ul>

<p>When you ask AI to generate code, it''s not "understanding" your request in a human sense. Instead, it''s finding patterns in its training data that match your description and synthesizing a response based on those patterns.</p>

<p><strong>Think of it like this:</strong> If you asked a human chef to make a "spicy pasta dish," they''d draw on experience, taste preferences, and creativity. If you ask AI, it''s analyzing millions of pasta recipes it''s seen, identifying patterns in "spicy" recipes, and generating something that statistically matches those patterns.</p>

<h3>How AI Generates Code: The Process</h3>
<p>Here''s what happens when you prompt AI to write code:</p>

<ol>
    <li><strong>Tokenization:</strong> Your prompt is broken into "tokens" (pieces of text)</li>
    <li><strong>Context Analysis:</strong> AI analyzes the context—what you''ve said before, what code already exists</li>
    <li><strong>Pattern Matching:</strong> It searches its training for similar patterns</li>
    <li><strong>Probability Calculation:</strong> For each next token, it calculates what''s most likely to come next</li>
    <li><strong>Generation:</strong> It produces code token by token, each choice influencing the next</li>
    <li><strong>Coherence Check:</strong> Modern models have some ability to verify their output makes sense</li>
</ol>

<p>This process happens incredibly fast, but it''s fundamentally probabilistic—AI is making educated guesses based on patterns, not executing a deterministic algorithm.</p>

<h3>Why AI Sometimes Produces Brilliant Code</h3>
<p>AI excels in certain scenarios:</p>

<h4>1. Common Patterns</h4>
<p>If you''re asking for something that appears frequently in its training data, AI will likely produce excellent code.</p>

<p><strong>Example:</strong> "Create a function to validate email addresses" → AI has seen thousands of email validation functions and can generate a robust solution.</p>

<h4>2. Well-Defined Problems</h4>
<p>When your request is specific and clear, AI can match it to known patterns effectively.</p>

<p><strong>Example:</strong> "Sort this array of objects by the ''price'' property in descending order" → Clear, specific, common pattern.</p>

<h4>3. Boilerplate and Structure</h4>
<p>AI is exceptional at generating repetitive code structures that follow established conventions.</p>

<p><strong>Example:</strong> "Create a REST API with CRUD endpoints for a User model" → Standard pattern with clear conventions.</p>

<h4>4. Combining Existing Patterns</h4>
<p>AI can creatively combine patterns it''s seen to solve new problems.</p>

<p><strong>Example:</strong> "Create a debounced search input that calls an API" → Combines debouncing pattern + API call pattern + input handling pattern.</p>

<h3>Why AI Sometimes Breaks</h3>
<p>Understanding AI''s limitations is crucial for working with it effectively:</p>

<h4>1. Novel or Rare Scenarios</h4>
<p>If you''re asking for something AI hasn''t seen much in training, it may struggle or "hallucinate" solutions.</p>

<p><strong>Example:</strong> "Implement a custom algorithm for [very specific, uncommon use case]" → AI might generate plausible-looking but incorrect code.</p>

<p><strong>Why it happens:</strong> Not enough training examples to establish reliable patterns.</p>

<h4>2. Context Overflow</h4>
<p>AI has a limited "context window"—it can only consider a certain amount of information at once.</p>

<p><strong>Example:</strong> In a very long conversation or large codebase, AI might "forget" earlier details and generate inconsistent code.</p>

<p><strong>Why it happens:</strong> The context window fills up, and older information gets pushed out.</p>

<h4>3. Ambiguous Instructions</h4>
<p>When your prompt is vague, AI fills in the gaps with its best guess—which might not match your intent.</p>

<p><strong>Example:</strong> "Make it better" → AI doesn''t know what "better" means in your context.</p>

<p><strong>Why it happens:</strong> Multiple valid interpretations exist, and AI picks one probabilistically.</p>

<h4>4. Logical Inconsistencies</h4>
<p>AI can generate code that looks syntactically correct but contains logical errors.</p>

<p><strong>Example:</strong> Generating a function that handles edge cases incorrectly or has off-by-one errors.</p>

<p><strong>Why it happens:</strong> AI matches surface patterns but doesn''t truly "understand" the logic.</p>

<h4>5. Outdated Information</h4>
<p>AI''s training data has a cutoff date. It doesn''t know about features, libraries, or best practices introduced after training.</p>

<p><strong>Example:</strong> Suggesting deprecated methods or missing newer, better approaches.</p>

<p><strong>Why it happens:</strong> Training data is frozen in time.</p>

<h4>6. Hallucinations</h4>
<p>Sometimes AI generates code that references non-existent functions, libraries, or APIs.</p>

<p><strong>Example:</strong> "Use the imaginaryLibrary.doSomething() function" when no such library exists.</p>

<p><strong>Why it happens:</strong> AI generates plausible-sounding patterns that don''t actually exist.</p>

<h3>Common Breaking Patterns and How to Avoid Them</h3>

<p><strong>Breaking Pattern 1: The Confidence Trap</strong><br>
AI presents all answers with equal confidence, even when wrong.</p>

<p><strong>Solution:</strong> Always test generated code. Don''t assume correctness based on how confident AI sounds.</p>

<p><strong>Breaking Pattern 2: The Context Drift</strong><br>
In long conversations, AI loses track of earlier decisions.</p>

<p><strong>Solution:</strong> Start fresh conversations for new features. Summarize important context in each prompt.</p>

<p><strong>Breaking Pattern 3: The Overcomplexity Spiral</strong><br>
AI sometimes generates unnecessarily complex solutions.</p>

<p><strong>Solution:</strong> Ask for "simple" or "minimal" solutions explicitly. Request explanations to verify complexity is justified.</p>

<p><strong>Breaking Pattern 4: The Copy-Paste Syndrome</strong><br>
AI might generate code that worked in its training data but doesn''t fit your specific context.</p>

<p><strong>Solution:</strong> Provide context about your project structure, existing code, and constraints.</p>

<h3>How to Work With AI''s Thinking Style</h3>

<h4>1. Be Specific and Explicit</h4>
<p>Instead of: "Add error handling"<br>
Try: "Add try-catch blocks that log errors to console and show user-friendly messages in a toast notification"</p>

<h4>2. Provide Examples</h4>
<p>Instead of: "Make it look like modern design"<br>
Try: "Use a design similar to Stripe''s dashboard—clean, lots of white space, subtle shadows, blue accent color"</p>

<h4>3. Break Down Complex Requests</h4>
<p>Instead of: "Build a complete authentication system"<br>
Try: Step-by-step requests for signup, login, password reset, session management</p>

<h4>4. Verify and Test</h4>
<p>Always test AI-generated code. Use it as a starting point, not a final solution.</p>

<h4>5. Iterate Based on Results</h4>
<p>If AI''s first attempt isn''t right, refine your prompt based on what it got wrong.</p>

<h3>The AI Debugging Mindset</h3>
<p>When AI-generated code breaks, approach it systematically:</p>

<ol>
    <li><strong>Identify the Issue:</strong> What specifically isn''t working?</li>
    <li><strong>Check Assumptions:</strong> Did AI misunderstand your intent?</li>
    <li><strong>Verify Context:</strong> Does AI have all the information it needs?</li>
    <li><strong>Test Components:</strong> Break down the problem to isolate the issue</li>
    <li><strong>Refine the Prompt:</strong> Provide more specific guidance</li>
    <li><strong>Ask for Explanation:</strong> Have AI explain its approach to spot logical errors</li>
</ol>

<h3>Real-World Example: AI Thinking in Action</h3>
<p>Let''s trace how AI might handle a request:</p>

<p><strong>Your Prompt:</strong> "Create a function to calculate shipping cost based on weight and distance"</p>

<p><strong>AI''s Internal Process (simplified):</strong></p>
<ol>
    <li>Recognizes pattern: function creation</li>
    <li>Identifies inputs: weight, distance</li>
    <li>Identifies output: cost</li>
    <li>Searches training for similar calculations</li>
    <li>Finds patterns: tiered pricing, distance multipliers, weight brackets</li>
    <li>Synthesizes a solution combining these patterns</li>
    <li>Generates code with reasonable defaults</li>
</ol>

<p><strong>Potential Issues:</strong></p>
<ul>
    <li>May use arbitrary pricing tiers (you didn''t specify)</li>
    <li>Might assume units (kg vs lbs, km vs miles)</li>
    <li>Could include edge cases you don''t need</li>
    <li>Might miss edge cases you do need</li>
</ul>

<p><strong>Better Prompt:</strong> "Create a function that calculates shipping cost. Weight is in pounds, distance in miles. Cost is $5 base + $0.50 per pound + $0.10 per mile. Round to 2 decimal places."</p>

<h3>Advanced: Understanding Model Differences</h3>
<p>Different AI models have different strengths:</p>

<ul>
    <li><strong>GPT-4:</strong> Better at complex reasoning, longer context</li>
    <li><strong>GPT-3.5:</strong> Faster, good for simple tasks</li>
    <li><strong>Claude:</strong> Excellent at following detailed instructions, strong with long documents</li>
    <li><strong>Specialized Models:</strong> Code-specific models (like Codex) may be better at pure code generation</li>
</ul>

<p>Choose your model based on the task complexity and your needs.</p>

<h3>The Future: AI That Breaks Less</h3>
<p>AI coding assistants are rapidly improving:</p>

<ul>
    <li>Larger context windows (remembering more)</li>
    <li>Better reasoning capabilities</li>
    <li>Integration with testing and verification tools</li>
    <li>Ability to search current documentation</li>
    <li>Multi-step planning and execution</li>
</ul>

<p>But the fundamental pattern-based nature will remain, so understanding how AI thinks will continue to be valuable.</p>

<h3>Key Takeaways</h3>
<ul>
    <li>AI generates code through <strong>pattern recognition</strong>, not true understanding</li>
    <li>It excels at <strong>common patterns</strong> and well-defined problems</li>
    <li>It breaks with <strong>novel scenarios, ambiguous instructions, and context overflow</strong></li>
    <li><strong>Specific, clear prompts</strong> with context produce better results</li>
    <li><strong>Always test</strong> AI-generated code—confidence doesn''t equal correctness</li>
    <li>Understanding these limitations makes you a <strong>more effective Vibe Coder</strong></li>
</ul>

<p>In the next lesson, we''ll explore how context, memory, and constraints shape AI''s code generation, giving you even more control over the results.</p>'
    WHERE module_id = v_module_id AND ordering = 1;
    
    RAISE NOTICE '✅ Lesson 5 expanded';
    
    RAISE NOTICE '🎉 Module 2 Lesson 1 complete!';
    
END $$;
