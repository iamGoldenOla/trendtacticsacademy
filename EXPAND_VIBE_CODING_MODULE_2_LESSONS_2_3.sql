-- ==========================================
-- EXPAND VIBE CODING CONTENT TO 1200-WORD STANDARD
-- Part 2B: Module 2 - Lessons 2 & 3
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
    
    RAISE NOTICE '📚 Expanding Vibe Coding Module 2 Content (Lessons 2-3)...';
    
    -- Get Module 2 ID
    SELECT id INTO v_module_id FROM modules 
    WHERE course_id = v_course_id AND ordering = 2 LIMIT 1;
    
    -- ==========================================
    -- LESSON 6: Context, Memory, and Constraints
    -- ==========================================
    UPDATE lessons SET content = '<h2>Context, Memory, and Constraints</h2>

<h3>The Three Pillars of Effective AI Coding</h3>
<p>When you work with AI to build software, three factors determine the quality of your results: <strong>context</strong> (what information AI has), <strong>memory</strong> (what it remembers from your conversation), and <strong>constraints</strong> (the boundaries you set). Master these three elements, and you''ll dramatically improve your Vibe Coding outcomes.</p>

<p>This lesson gives you practical strategies for managing context, leveraging memory, and setting effective constraints to guide AI toward exactly what you need.</p>

<h3>Understanding Context</h3>
<p>Context is <strong>all the information AI uses to generate its response</strong>. This includes:</p>

<ul>
    <li>Your current prompt</li>
    <li>Previous messages in the conversation</li>
    <li>Code you''ve shared</li>
    <li>Files or documentation you''ve provided</li>
    <li>System prompts (instructions given to AI before your conversation)</li>
</ul>

<p>Think of context as AI''s "working memory"—everything it can "see" when generating code for you.</p>

<h4>Why Context Matters</h4>
<p>The same prompt can produce vastly different results depending on context:</p>

<p><strong>Prompt:</strong> "Add validation to the form"</p>

<p><strong>With minimal context:</strong> AI might generate generic validation without knowing what fields exist or what rules apply.</p>

<p><strong>With rich context:</strong> AI knows your form has email, password, and age fields, understands your validation requirements, and generates appropriate, specific validation logic.</p>

<h3>How to Provide Effective Context</h3>

<h4>1. Start with Project Overview</h4>
<p>When beginning a new project or conversation, give AI the big picture:</p>

<blockquote>
"I''m building a task management app for small teams. Users can create projects, add tasks, assign them to team members, and track progress. The tech stack is React frontend with Supabase backend. The design should be clean and minimal, similar to Linear."
</blockquote>

<p>This context helps AI make appropriate choices throughout your session.</p>

<h4>2. Share Relevant Code</h4>
<p>When asking AI to modify or extend code, show the existing code:</p>

<blockquote>
"Here''s my current UserProfile component: [paste code]. I want to add an edit mode where users can update their name and bio."
</blockquote>

<p>AI can then maintain consistency with your existing patterns and style.</p>

<h4>3. Specify Technical Constraints</h4>
<p>Tell AI about your technical environment:</p>

<blockquote>
"I''m using React 18 with TypeScript. I prefer functional components with hooks. I''m using Tailwind CSS for styling."
</blockquote>

<p>This prevents AI from suggesting incompatible approaches.</p>

<h4>4. Describe User Context</h4>
<p>Explain who will use the feature and how:</p>

<blockquote>
"This feature will be used by non-technical users on mobile devices, often in areas with slow internet. Prioritize simplicity and offline functionality."
</blockquote>

<h4>5. Reference Previous Work</h4>
<p>Connect new requests to earlier work in the conversation:</p>

<blockquote>
"Using the same pattern we used for the login form, create a signup form with additional fields for name and company."
</blockquote>

<h3>The Context Window: Understanding Limits</h3>
<p>AI has a limited context window—typically measured in "tokens" (roughly 3/4 of a word). Different models have different limits:</p>

<ul>
    <li><strong>GPT-3.5:</strong> ~4,000 tokens (~3,000 words)</li>
    <li><strong>GPT-4:</strong> ~8,000-32,000 tokens depending on version</li>
    <li><strong>Claude:</strong> Up to 100,000 tokens (~75,000 words)</li>
</ul>

<p>When the context window fills up, older information gets "forgotten."</p>

<h4>Managing Context Window Limits</h4>

<p><strong>Strategy 1: Start Fresh for New Features</strong><br>
Begin a new conversation when starting a distinct feature to avoid context pollution.</p>

<p><strong>Strategy 2: Summarize Progress</strong><br>
Periodically summarize what''s been built so far in a new conversation.</p>

<p><strong>Strategy 3: Use Focused Conversations</strong><br>
Keep conversations focused on one feature or problem at a time.</p>

<p><strong>Strategy 4: Extract and Save</strong><br>
Save important code and decisions outside the conversation, then reference them when needed.</p>

<h3>Understanding Memory</h3>
<p>Memory is how AI maintains continuity across a conversation. It''s not like human memory—AI doesn''t truly "remember" in the sense of storing and retrieving information. Instead, it has access to the conversation history within its context window.</p>

<h4>What AI "Remembers"</h4>
<p>Within a conversation, AI can reference:</p>

<ul>
    <li>Code it previously generated</li>
    <li>Decisions you made together</li>
    <li>Patterns and preferences you''ve expressed</li>
    <li>Problems you''ve solved</li>
    <li>Your project structure and goals</li>
</ul>

<h4>What AI Doesn''t Remember</h4>
<ul>
    <li>Conversations from previous sessions (unless you provide context)</li>
    <li>Information outside its context window</li>
    <li>Your actual codebase (unless you share it)</li>
    <li>Changes you made to code after AI generated it</li>
</ul>

<h3>Leveraging Memory Effectively</h3>

<h4>1. Build on Previous Responses</h4>
<p>Reference earlier work to maintain consistency:</p>

<blockquote>
"Now add a delete function similar to the update function you created earlier, but with a confirmation dialog."
</blockquote>

<h4>2. Establish Patterns Early</h4>
<p>Set patterns in the beginning that AI will follow throughout:</p>

<blockquote>
"For all API calls, use this error handling pattern: [example]. Apply this consistently to all future API functions."
</blockquote>

<h4>3. Remind When Necessary</h4>
<p>If the conversation is long, remind AI of important context:</p>

<blockquote>
"Remember, we''re using Supabase for the backend, so use their client library for database operations."
</blockquote>

<h4>4. Create Checkpoints</h4>
<p>Periodically summarize progress to reinforce memory:</p>

<blockquote>
"So far we''ve built: authentication, user profiles, and project creation. Now let''s add task management."
</blockquote>

<h3>Understanding Constraints</h3>
<p>Constraints are <strong>boundaries and requirements you set</strong> to guide AI''s solutions. Good constraints lead to better, more focused results.</p>

<h4>Types of Constraints</h4>

<p><strong>Technical Constraints:</strong></p>
<ul>
    <li>"Must work in Internet Explorer 11"</li>
    <li>"Cannot use external dependencies"</li>
    <li>"Must be under 100 lines of code"</li>
    <li>"Should load in under 2 seconds"</li>
</ul>

<p><strong>Design Constraints:</strong></p>
<ul>
    <li>"Must be accessible (WCAG AA compliant)"</li>
    <li>"Should work on mobile screens 320px wide"</li>
    <li>"Must use our brand colors: #FF6B6B and #4ECDC4"</li>
    <li>"Should feel playful and friendly, not corporate"</li>
</ul>

<p><strong>Business Constraints:</strong></p>
<ul>
    <li>"Must comply with GDPR"</li>
    <li>"Should minimize API calls to reduce costs"</li>
    <li>"Must work offline for basic features"</li>
    <li>"Should be maintainable by junior developers"</li>
</ul>

<p><strong>User Experience Constraints:</strong></p>
<ul>
    <li>"Must complete in 3 clicks or less"</li>
    <li>"Should provide feedback within 200ms"</li>
    <li>"Must be usable by non-technical users"</li>
    <li>"Should minimize cognitive load"</li>
</ul>

<h3>How to Set Effective Constraints</h3>

<h4>1. Be Specific and Measurable</h4>
<p><strong>Vague:</strong> "Make it fast"<br>
<strong>Better:</strong> "Should load initial view in under 1 second on 3G connection"</p>

<h4>2. Prioritize Constraints</h4>
<p>Not all constraints are equally important:</p>

<blockquote>
"Must-have: Works on mobile. Nice-to-have: Animated transitions. Can-sacrifice: Advanced filtering options if they complicate the UI."
</blockquote>

<h4>3. Explain the "Why"</h4>
<p>Context about why a constraint exists helps AI make better trade-offs:</p>

<blockquote>
"Must work without JavaScript because our users often have it disabled for security reasons in corporate environments."
</blockquote>

<h4>4. Set Boundaries Early</h4>
<p>Establish key constraints at the start of a conversation:</p>

<blockquote>
"For this project: Use vanilla JavaScript (no frameworks), keep bundle size under 50KB, and ensure it works in all modern browsers including Safari."
</blockquote>

<h3>Real-World Example: Context + Memory + Constraints</h3>
<p>Let''s see all three working together:</p>

<p><strong>Initial Prompt (Setting Context):</strong></p>
<blockquote>
"I''m building a recipe app for home cooks. Users can save recipes, create shopping lists, and scale ingredient quantities. Tech stack: Next.js, Tailwind CSS, Supabase. Target users are busy parents using mobile devices."
</blockquote>

<p><strong>First Feature (Setting Constraints):</strong></p>
<blockquote>
"Create a recipe card component. Constraints: Must show image, title, cook time, and difficulty. Should be tappable to view full recipe. Must work well on screens as small as 320px. Use Tailwind CSS. Keep it simple and scannable."
</blockquote>

<p><strong>Second Feature (Leveraging Memory):</strong></p>
<blockquote>
"Create a recipe detail view that opens when users tap a recipe card. Use the same design language as the card component. Show full ingredients list, step-by-step instructions, and a ''Add to Shopping List'' button."
</blockquote>

<p><strong>Refinement (Adding Context):</strong></p>
<blockquote>
"The shopping list feature should group ingredients by category (produce, dairy, etc.) to make grocery shopping easier. Remember, our users are busy parents, so minimize clicks and make it fast."
</blockquote>

<p>Notice how each prompt builds on previous context, leverages memory of earlier decisions, and sets clear constraints.</p>

<h3>Common Mistakes and How to Avoid Them</h3>

<p><strong>Mistake 1: Context Overload</strong><br>
Providing too much irrelevant information confuses AI.<br>
<strong>Solution:</strong> Share only relevant context for the current task.</p>

<p><strong>Mistake 2: Assuming Memory</strong><br>
Expecting AI to remember details from far back in the conversation.<br>
<strong>Solution:</strong> Explicitly reference or re-state important information.</p>

<p><strong>Mistake 3: Conflicting Constraints</strong><br>
Setting constraints that contradict each other.<br>
<strong>Solution:</strong> Review constraints for conflicts and prioritize when necessary.</p>

<p><strong>Mistake 4: Under-Constraining</strong><br>
Not providing enough boundaries, leading to generic solutions.<br>
<strong>Solution:</strong> Be specific about requirements, even if they seem obvious.</p>

<h3>Advanced Techniques</h3>

<h4>1. Context Layering</h4>
<p>Provide context in layers—general to specific:</p>
<ol>
    <li>Project overview</li>
    <li>Feature description</li>
    <li>Technical requirements</li>
    <li>Specific implementation details</li>
</ol>

<h4>2. Memory Anchors</h4>
<p>Create memorable reference points:</p>
<blockquote>
"Let''s call this the ''standard button pattern''—blue background, white text, rounded corners, hover effect. Use this pattern for all primary actions."
</blockquote>

<h4>3. Constraint Templates</h4>
<p>Develop reusable constraint sets for common scenarios:</p>
<blockquote>
"Use our ''mobile-first'' constraints: works on 320px screens, touch-friendly targets (44px minimum), fast loading, minimal scrolling."
</blockquote>

<h3>Key Takeaways</h3>
<ul>
    <li><strong>Context</strong> is all the information AI uses to generate responses—provide relevant, focused context</li>
    <li><strong>Memory</strong> is limited to the conversation history within the context window—remind and reference as needed</li>
    <li><strong>Constraints</strong> are boundaries that guide AI toward better solutions—be specific and prioritize</li>
    <li>Manage context window limits by starting fresh conversations and summarizing progress</li>
    <li>Build on previous responses to maintain consistency and leverage conversation memory</li>
    <li>Set clear, measurable constraints early and explain the reasoning behind them</li>
</ul>

<p>In the next lesson, we''ll tackle a common frustration: preventing repetition and duplicate content when working with AI.</p>'
    WHERE module_id = v_module_id AND ordering = 2;
    
    RAISE NOTICE '✅ Lesson 6 expanded';
    
    -- ==========================================
    -- LESSON 7: Preventing Repetition & Duplicate Content
    -- ==========================================
    UPDATE lessons SET content = '<h2>Preventing Repetition & Duplicate Content</h2>

<h3>The Repetition Problem</h3>
<p>One of the most frustrating experiences in Vibe Coding is when AI starts generating repetitive code or duplicating content you''ve already created. You ask for a new feature, and instead of building on what exists, AI recreates similar functionality with slight variations. Or worse, it generates the exact same code you already have.</p>

<p>This lesson teaches you why this happens and, more importantly, <strong>how to prevent it</strong>. You''ll learn practical strategies to keep your codebase clean, avoid duplication, and guide AI toward extending rather than repeating.</p>

<h3>Why AI Repeats Itself</h3>
<p>Understanding the root causes helps you prevent repetition:</p>

<h4>1. Context Blindness</h4>
<p>AI doesn''t automatically "know" what code you already have unless you show it. If you ask for a feature without providing context about existing code, AI will generate from scratch.</p>

<p><strong>Example:</strong> You have a "formatDate" function, but ask AI to "add date formatting to the user profile." Without seeing your existing function, AI creates a new one.</p>

<h4>2. Pattern Matching Over Understanding</h4>
<p>AI recognizes patterns but doesn''t truly "understand" your codebase architecture. It might create similar solutions for similar problems without realizing they should share code.</p>

<h4>3. Conversation Drift</h4>
<p>In long conversations, AI may "forget" earlier solutions and recreate them when you ask for similar functionality later.</p>

<h4>4. Ambiguous Requests</h4>
<p>Vague prompts like "add user management" don''t specify whether to extend existing code or create new code.</p>

<h3>Strategies to Prevent Repetition</h3>

<h4>Strategy 1: Show Existing Code</h4>
<p>The most effective prevention: show AI what already exists.</p>

<p><strong>Instead of:</strong><br>
"Add a function to validate email addresses in the signup form"</p>

<p><strong>Try:</strong><br>
"I already have this email validation function: [paste code]. Use this same function in the signup form instead of creating a new one."</p>

<p><strong>Result:</strong> AI reuses existing code rather than duplicating.</p>

<h4>Strategy 2: Establish Patterns and Reference Them</h4>
<p>Create named patterns early in your conversation, then reference them.</p>

<p><strong>Early in conversation:</strong><br>
"Here''s our standard API call pattern: [example]. Let''s call this the ''standard API pattern.''"</p>

<p><strong>Later requests:</strong><br>
"Create a new endpoint to fetch user settings using our standard API pattern."</p>

<p><strong>Result:</strong> Consistency across features without duplication.</p>

<h4>Strategy 3: Request Extensions, Not Recreations</h4>
<p>Be explicit about building on existing code.</p>

<p><strong>Instead of:</strong><br>
"Add error handling to API calls"</p>

<p><strong>Try:</strong><br>
"Extend the existing fetchUser function to include error handling. Don''t create a new function—modify the current one."</p>

<p><strong>Result:</strong> AI modifies rather than duplicates.</p>

<h4>Strategy 4: Create Utility Libraries</h4>
<p>Organize reusable functions into utility files and reference them.</p>

<p><strong>Approach:</strong></p>
<ol>
    <li>Create a utils.js file with common functions</li>
    <li>Show AI this file when starting new features</li>
    <li>Instruct: "Import functions from utils.js instead of recreating them"</li>
</ol>

<p><strong>Example:</strong><br>
"Here''s our utils.js file with date formatting, validation, and API helpers. When building the new dashboard, import and use these utilities instead of creating new ones."</p>

<h4>Strategy 5: Use Descriptive, Unique Names</h4>
<p>Unique function and component names help AI distinguish between different pieces of code.</p>

<p><strong>Avoid:</strong> Multiple functions named "handleSubmit" in different files</p>

<p><strong>Better:</strong> "handleLoginSubmit", "handleSignupSubmit", "handleProfileSubmit"</p>

<p><strong>Why it helps:</strong> AI can more easily reference specific functions without confusion.</p>

<h4>Strategy 6: Maintain a Component Inventory</h4>
<p>Keep a list of existing components and share it with AI when building new features.</p>

<p><strong>Example:</strong></p>
<blockquote>
"Existing components: Button, Input, Card, Modal, Dropdown, UserAvatar, LoadingSpinner. When building the new settings page, reuse these components instead of creating new ones."
</blockquote>

<h4>Strategy 7: Explicitly Prevent Duplication</h4>
<p>Add anti-duplication instructions to your prompts.</p>

<p><strong>Example:</strong><br>
"Create a product listing page. Important: Check if we already have components for cards, buttons, or loading states. Reuse existing components—don''t create duplicates."</p>

<h3>Handling Duplication When It Happens</h3>
<p>Sometimes duplication slips through. Here''s how to fix it:</p>

<h4>1. Identify the Duplication</h4>
<p>Review generated code for similar patterns or functions.</p>

<h4>2. Choose the Best Version</h4>
<p>Decide which version to keep (usually the more complete or better-structured one).</p>

<h4>3. Refactor with AI''s Help</h4>
<p><strong>Prompt:</strong><br>
"I have two similar functions: [function A] and [function B]. Combine them into a single reusable function that handles both cases."</p>

<h4>4. Update References</h4>
<p><strong>Prompt:</strong><br>
"Replace all instances of [old function] with calls to [new combined function]."</p>

<h3>Real-World Example: Preventing Duplication</h3>
<p>Let''s walk through a project where we actively prevent duplication:</p>

<p><strong>Project:</strong> Building a task management app</p>

<p><strong>Step 1: Create Reusable Components</strong></p>
<blockquote>
"Create a Card component that we''ll reuse throughout the app. It should accept title, content, and optional footer as props. Use Tailwind CSS with shadow and rounded corners."
</blockquote>

<p><strong>Step 2: Reference When Building Features</strong></p>
<blockquote>
"Create a TaskCard component for displaying tasks. Use the existing Card component as the base. Add task-specific content like status badge and due date."
</blockquote>

<p><strong>Step 3: Establish Patterns</strong></p>
<blockquote>
"Here''s how we handle API calls: [example]. Let''s call this our ''API pattern.'' Use this same pattern for all future API interactions."
</blockquote>

<p><strong>Step 4: Build New Features Referencing Existing Code</strong></p>
<blockquote>
"Create a ProjectCard component. Use the same Card base component we used for TaskCard. Follow our established API pattern for fetching project data."
</blockquote>

<p><strong>Result:</strong> Consistent codebase with minimal duplication.</p>

<h3>Advanced: Creating a "Code Map"</h3>
<p>For larger projects, maintain a code map that you share with AI:</p>

<p><strong>Example Code Map:</strong></p>
<pre>
Project Structure:
- components/
  - common/ (Button, Input, Card, Modal)
  - features/ (TaskCard, ProjectCard, UserProfile)
- utils/
  - api.js (fetchData, postData, updateData, deleteData)
  - validation.js (validateEmail, validatePassword, validateURL)
  - formatting.js (formatDate, formatCurrency, formatNumber)
- hooks/
  - useAuth.js (authentication state and functions)
  - useApi.js (API call wrapper with error handling)
</pre>

<p><strong>Usage:</strong><br>
"Here''s our project structure [paste code map]. When building the new analytics dashboard, use existing components and utilities. Only create new code when necessary."</p>

<h3>Preventing Content Duplication in Documentation</h3>
<p>Duplication isn''t just about code—it happens in documentation, comments, and explanations too.</p>

<h4>For Documentation:</h4>
<p><strong>Prompt:</strong><br>
"Write documentation for the new feature. Reference existing docs for similar features instead of repeating common information. Link to shared concepts rather than re-explaining them."</p>

<h4>For Code Comments:</h4>
<p><strong>Prompt:</strong><br>
"Add comments explaining the complex parts. Don''t comment obvious code or repeat what the function name already conveys."</p>

<h3>Tools and Techniques for Detection</h3>

<h4>1. Ask AI to Review</h4>
<p><strong>Prompt:</strong><br>
"Review this codebase and identify any duplicate or very similar functions that could be consolidated."</p>

<h4>2. Request Refactoring Suggestions</h4>
<p><strong>Prompt:</strong><br>
"Analyze these three components: [paste code]. Suggest how to extract common functionality into shared utilities."</p>

<h4>3. Use Linting and Analysis Tools</h4>
<p>Tools like ESLint with plugins can detect code duplication automatically.</p>

<h3>When Duplication Is Acceptable</h3>
<p>Not all duplication is bad. Sometimes it''s better to duplicate than to create overly complex abstractions.</p>

<p><strong>Acceptable duplication:</strong></p>
<ul>
    <li>Small, simple functions (3-5 lines) that are clear and unlikely to change</li>
    <li>Code that''s similar but serves different contexts with different future evolution paths</li>
    <li>Temporary duplication during rapid prototyping (plan to refactor later)</li>
</ul>

<p><strong>Follow the "Rule of Three":</strong> If you''ve written similar code twice, that''s okay. The third time, refactor into a shared function.</p>

<h3>Creating a Duplication Prevention Checklist</h3>
<p>Use this checklist before asking AI to create new code:</p>

<ol>
    <li>☐ Have I shown AI the existing related code?</li>
    <li>☐ Have I explicitly instructed to reuse existing components/functions?</li>
    <li>☐ Have I referenced established patterns?</li>
    <li>☐ Have I specified to extend rather than recreate?</li>
    <li>☐ Have I provided a code map or component inventory?</li>
</ol>

<h3>Common Duplication Patterns and Solutions</h3>

<p><strong>Pattern 1: Similar API Calls</strong><br>
<strong>Solution:</strong> Create a generic API utility function that handles all calls.</p>

<p><strong>Pattern 2: Repeated Validation Logic</strong><br>
<strong>Solution:</strong> Centralize validation in a validation.js utility file.</p>

<p><strong>Pattern 3: Similar UI Components</strong><br>
<strong>Solution:</strong> Create a base component with props for variations.</p>

<p><strong>Pattern 4: Duplicate Error Handling</strong><br>
<strong>Solution:</strong> Create a custom hook or higher-order function for error handling.</p>

<h3>Key Takeaways</h3>
<ul>
    <li>AI duplicates code when it lacks <strong>context about existing code</strong></li>
    <li><strong>Show existing code</strong> and explicitly request reuse to prevent duplication</li>
    <li><strong>Establish named patterns</strong> early and reference them in future requests</li>
    <li>Create <strong>utility libraries and component inventories</strong> to organize reusable code</li>
    <li><strong>Request extensions, not recreations</strong> when building on existing features</li>
    <li>Use a <strong>code map</strong> for larger projects to help AI navigate your codebase</li>
    <li>Some duplication is acceptable—<strong>follow the Rule of Three</strong></li>
</ul>

<p>You''ve now completed Module 2! You understand how AI thinks, how to manage context and memory, and how to prevent duplication. In Module 3, we''ll explore the core Vibe Coding workflow—the practical process you''ll use every day to build software with AI.</p>'
    WHERE module_id = v_module_id AND ordering = 3;
    
    RAISE NOTICE '✅ Lesson 7 expanded';
    
    RAISE NOTICE '🎉 Module 2 complete expansion finished!';
    
END $$;

-- Verify all Module 2 lessons
SELECT 
    l.ordering,
    l.title,
    LENGTH(l.content) as content_length,
    CASE 
        WHEN LENGTH(l.content) > 1000 THEN '✅ Comprehensive'
        WHEN LENGTH(l.content) > 500 THEN '⚠️ Moderate'
        ELSE '❌ Needs Expansion'
    END as content_status
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%' AND m.ordering = 2
ORDER BY l.ordering;
