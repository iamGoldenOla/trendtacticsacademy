-- ==========================================
-- EXPAND VIBE CODING CONTENT TO 1200-WORD STANDARD
-- Part 1: Module 1 - Foundations of Vibe Coding
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
    
    RAISE NOTICE '📚 Expanding Vibe Coding Module 1 Content...';
    
    -- Get Module 1 ID
    SELECT id INTO v_module_id FROM modules 
    WHERE course_id = v_course_id AND ordering = 1 LIMIT 1;
    
    -- ==========================================
    -- LESSON 1: Intent Is the New Programming Language
    -- ==========================================
    UPDATE lessons SET content = '<h2>Intent Is the New Programming Language</h2>

<h3>The Paradigm Shift in Software Development</h3>
<p>For decades, programming has been about learning syntax, memorizing commands, and understanding complex technical rules. If you wanted to build software, you had to speak the computer''s language. But something fundamental has changed. We''re entering an era where <strong>your intention matters more than your technical knowledge</strong>.</p>

<p>This isn''t just a minor improvement in how we code—it''s a complete transformation of what it means to create software. Instead of translating your ideas into code line by line, you can now express what you want to achieve, and AI systems help bridge the gap between your vision and working software.</p>

<h3>What Does "Intent-Driven Development" Actually Mean?</h3>
<p>Intent-driven development means focusing on <strong>what you want to accomplish</strong> rather than <strong>how to accomplish it technically</strong>. Think about the difference between these two approaches:</p>

<p><strong>Traditional Approach:</strong> "I need to create a function that iterates through an array, filters items based on a condition, maps the results to a new structure, and returns a sorted list."</p>

<p><strong>Intent-Driven Approach:</strong> "I want to show users only the products they''ve favorited, sorted by price from lowest to highest."</p>

<p>Notice how the second approach focuses on the <em>business goal</em> and <em>user experience</em>, not the technical implementation. This is the essence of intent-driven development.</p>

<h3>Why This Changes Everything</h3>
<p>When intent becomes the primary programming language, several transformative things happen:</p>

<ol>
    <li><strong>Democratization of Software Creation</strong> - You no longer need years of training to build functional software. If you can clearly articulate what you want, you can create it.</li>
    <li><strong>Faster Iteration</strong> - Instead of spending hours debugging syntax errors, you spend time refining your vision and improving the user experience.</li>
    <li><strong>Better Communication</strong> - Your "code" becomes readable by non-technical stakeholders because it''s expressed in business terms.</li>
    <li><strong>Focus on Problem-Solving</strong> - You spend more time thinking about what problems to solve and less time wrestling with technical implementation details.</li>
</ol>

<h3>The Role of AI in Intent-Driven Development</h3>
<p>AI systems like GPT-4, Claude, and specialized coding assistants act as <strong>translators between human intent and machine execution</strong>. They understand context, infer requirements, and generate appropriate technical solutions.</p>

<p>Here''s what makes modern AI particularly powerful for this:</p>

<ul>
    <li><strong>Natural Language Understanding</strong> - AI can interpret your descriptions, even when they''re imprecise or incomplete</li>
    <li><strong>Contextual Awareness</strong> - It remembers what you''re building and makes suggestions that fit your project</li>
    <li><strong>Pattern Recognition</strong> - It has learned from millions of code examples and can apply best practices automatically</li>
    <li><strong>Iterative Refinement</strong> - You can have a conversation with AI, clarifying and adjusting until the output matches your intent</li>
</ul>

<h3>Real-World Example: Building a Feature</h3>
<p>Let''s see intent-driven development in action. Imagine you''re building a task management app and want to add a "priority sorting" feature.</p>

<p><strong>Your Intent Statement:</strong></p>
<blockquote>"I want users to be able to sort their tasks by priority. High priority tasks should appear first, then medium, then low. Within each priority level, tasks should be sorted by due date, with the soonest deadlines first."</blockquote>

<p>With traditional coding, you''d need to:</p>
<ul>
    <li>Understand sorting algorithms</li>
    <li>Know how to implement multi-level sorting</li>
    <li>Handle edge cases (what if there''s no due date?)</li>
    <li>Write the actual code in a specific programming language</li>
    <li>Test and debug the implementation</li>
</ul>

<p>With intent-driven development using AI:</p>
<ul>
    <li>You describe what you want (as shown above)</li>
    <li>AI generates the sorting logic</li>
    <li>You review the result and test it</li>
    <li>If something isn''t right, you clarify your intent and AI adjusts</li>
</ul>

<h3>The Skill Shift: From Syntax to Strategy</h3>
<p>This doesn''t mean technical knowledge becomes worthless. Instead, the valuable skills shift:</p>

<table>
    <tr>
        <th>Old Valuable Skills</th>
        <th>New Valuable Skills</th>
    </tr>
    <tr>
        <td>Memorizing syntax</td>
        <td>Clearly articulating requirements</td>
    </tr>
    <tr>
        <td>Debugging code line-by-line</td>
        <td>Evaluating whether solutions meet user needs</td>
    </tr>
    <tr>
        <td>Knowing specific frameworks</td>
        <td>Understanding system architecture and design patterns</td>
    </tr>
    <tr>
        <td>Writing efficient algorithms</td>
        <td>Asking the right questions and iterating on solutions</td>
    </tr>
</table>

<h3>Practical Application: Your First Intent-Driven Project</h3>
<p>To practice intent-driven development, start with a simple project. Here''s a framework:</p>

<ol>
    <li><strong>Define the User Need</strong> - Who will use this and what problem does it solve?</li>
    <li><strong>Describe the Core Functionality</strong> - What should it do? Be specific but focus on outcomes, not implementation.</li>
    <li><strong>Identify Key Interactions</strong> - How will users interact with it?</li>
    <li><strong>Specify Edge Cases</strong> - What should happen in unusual situations?</li>
    <li><strong>Communicate This to AI</strong> - Use your descriptions as prompts to generate working code</li>
</ol>

<h3>Common Misconceptions About Intent-Driven Development</h3>

<p><strong>Misconception 1:</strong> "You don''t need to understand anything technical."<br>
<strong>Reality:</strong> You still benefit from understanding concepts like databases, APIs, and user interfaces. You just don''t need to memorize syntax.</p>

<p><strong>Misconception 2:</strong> "AI will always get it right on the first try."<br>
<strong>Reality:</strong> Intent-driven development is iterative. You''ll often need to refine your descriptions and test the results.</p>

<p><strong>Misconception 3:</strong> "This only works for simple projects."<br>
<strong>Reality:</strong> Intent-driven development scales. Complex projects just require more detailed intent descriptions and better organization.</p>

<h3>The Future Is Intent-First</h3>
<p>As AI systems become more sophisticated, the gap between intent and implementation will continue to shrink. We''re moving toward a future where:</p>

<ul>
    <li>Business analysts can prototype their own solutions</li>
    <li>Designers can build functional interfaces without developer handoff</li>
    <li>Entrepreneurs can validate ideas with working MVPs in days, not months</li>
    <li>Developers focus on architecture, optimization, and complex problem-solving rather than routine coding</li>
</ul>

<h3>Key Takeaways</h3>
<ul>
    <li>Intent-driven development prioritizes <strong>what you want to achieve</strong> over <strong>how to code it</strong></li>
    <li>AI acts as a translator between human intention and machine execution</li>
    <li>The valuable skills are shifting from syntax memorization to clear communication and strategic thinking</li>
    <li>This approach democratizes software creation while raising the ceiling for what''s possible</li>
    <li>Understanding concepts remains important, but memorizing implementation details becomes less critical</li>
</ul>

<p>In the next lesson, we''ll explore what Vibe Coding is at a deeper level and how it embodies these intent-driven principles in a practical, accessible framework.</p>'
    WHERE module_id = v_module_id AND ordering = 1;
    
    RAISE NOTICE '✅ Lesson 1 expanded';
    
    -- ==========================================
    -- LESSON 2: What Is Vibe Coding (Deep)
    -- ==========================================
    UPDATE lessons SET content = '<h2>What Is Vibe Coding? (Deep Dive)</h2>

<h3>Beyond the Surface Definition</h3>
<p>You''ve heard that Vibe Coding is about creating software by focusing on ideas and intention rather than technical syntax. But what does that actually mean in practice? How is it different from just "using AI to code"? And why is it called "Vibe" Coding?</p>

<p>This lesson goes deep into the philosophy, methodology, and practical reality of Vibe Coding. By the end, you''ll understand not just <em>what</em> Vibe Coding is, but <em>why</em> it works and <em>how</em> to apply it effectively.</p>

<h3>The Philosophy: Vibe Over Syntax</h3>
<p>The term "Vibe" isn''t just a trendy word—it captures something essential about this approach. When you''re Vibe Coding, you''re working with the <strong>essence and feeling</strong> of what you want to create, not the rigid technical specifications.</p>

<p>Think about how you might describe a room''s atmosphere: "cozy," "professional," "energetic." You''re not specifying exact paint colors, furniture dimensions, or lighting temperatures, but anyone who understands design can translate that vibe into concrete choices. Vibe Coding works the same way with software.</p>

<h3>The Three Pillars of Vibe Coding</h3>

<h4>1. Intent-First Thinking</h4>
<p>Every Vibe Coding session starts with clarity about <strong>what you''re trying to achieve and why</strong>. This isn''t just writing down features—it''s understanding the underlying purpose.</p>

<p><strong>Example:</strong> Instead of "I need a login form," you think: "Users need a secure, frictionless way to access their personalized dashboard."</p>

<p>This intent-first approach leads to better solutions because you''re solving the real problem, not just implementing a technical requirement.</p>

<h4>2. Conversational Development</h4>
<p>Vibe Coding treats software development as a <strong>dialogue</strong> rather than a monologue. You''re having a conversation with AI tools, iterating and refining based on what emerges.</p>

<p>Traditional coding: Write code → Test → Debug → Repeat<br>
Vibe Coding: Describe intent → Review output → Refine description → Iterate</p>

<p>This conversational approach means you''re constantly learning and adjusting, making the development process more dynamic and responsive.</p>

<h4>3. Outcome-Oriented Evaluation</h4>
<p>In Vibe Coding, you judge success by <strong>whether the software does what users need</strong>, not by whether the code follows specific patterns or uses particular technologies.</p>

<p>This doesn''t mean code quality doesn''t matter—it means quality is measured by user outcomes, not technical purity for its own sake.</p>

<h3>How Vibe Coding Actually Works</h3>
<p>Let''s break down a typical Vibe Coding workflow with a concrete example. Imagine you want to build a simple expense tracker.</p>

<p><strong>Step 1: Define the Vibe</strong><br>
"I want users to feel in control of their spending. They should be able to quickly add expenses, see where their money goes, and get gentle nudges when they''re overspending in a category."</p>

<p><strong>Step 2: Translate Vibe to Features</strong><br>
From that vibe, you identify core features:
<ul>
    <li>Quick expense entry (mobile-friendly)</li>
    <li>Visual breakdown by category</li>
    <li>Budget alerts (friendly, not alarming)</li>
    <li>Historical trends</li>
</ul>
</p>

<p><strong>Step 3: Describe to AI</strong><br>
You tell your AI tool: "Create an expense tracker where users can quickly log expenses with amount, category, and optional notes. Show a pie chart of spending by category. Let users set monthly budgets per category and get friendly notifications when they''re at 80% of budget."</p>

<p><strong>Step 4: Review and Refine</strong><br>
The AI generates a working prototype. You test it and notice the expense entry form feels too formal. You refine: "Make the expense entry feel more casual—like sending a quick text message rather than filling out a form."</p>

<p><strong>Step 5: Iterate on the Vibe</strong><br>
You continue this process, constantly checking: Does this match the vibe? Does it feel right? Does it solve the user''s problem?</p>

<h3>What Makes Vibe Coding Different</h3>

<p><strong>vs. Traditional Coding:</strong><br>
Traditional coding requires you to think in the computer''s language from the start. Vibe Coding lets you think in human terms and translate later.</p>

<p><strong>vs. No-Code Tools:</strong><br>
No-code tools are limited to predefined templates and features. Vibe Coding gives you the flexibility of custom code without needing to write it yourself.</p>

<p><strong>vs. Just "Using AI":</strong><br>
Many people use AI to help with specific coding tasks. Vibe Coding is a complete methodology that puts AI at the center of the entire development process.</p>

<h3>The Vibe Coding Mindset</h3>
<p>To succeed with Vibe Coding, cultivate these mental habits:</p>

<ol>
    <li><strong>Start with "Why"</strong> - Always begin by understanding the purpose behind what you''re building</li>
    <li><strong>Think in User Stories</strong> - Frame features as "As a user, I want to..." rather than technical specifications</li>
    <li><strong>Embrace Iteration</strong> - Your first description won''t be perfect, and that''s okay</li>
    <li><strong>Trust the Process</strong> - AI will sometimes surprise you with solutions you hadn''t considered</li>
    <li><strong>Stay Outcome-Focused</strong> - Judge results by whether they solve the problem, not by technical elegance</li>
</ol>

<h3>Common Vibe Coding Patterns</h3>

<p><strong>The Refinement Loop:</strong><br>
Describe → Generate → Test → Refine Description → Regenerate</p>

<p><strong>The Feature Expansion:</strong><br>
Start with core functionality, get it working, then add features one at a time</p>

<p><strong>The Vibe Check:</strong><br>
Regularly step back and ask: "Does this feel right? Does it match the intended user experience?"</p>

<h3>Real-World Vibe Coding Example</h3>
<p>Let''s look at how someone used Vibe Coding to build a real product:</p>

<p><strong>The Goal:</strong> A meditation timer app that feels calming and distraction-free</p>

<p><strong>The Vibe:</strong> "Zen garden meets modern minimalism. Every interaction should feel intentional and peaceful."</p>

<p><strong>The Process:</strong></p>
<ol>
    <li>Described the core experience: "Users select a duration, press start, and see a slowly changing visual (like ripples in water) with gentle chimes at intervals."</li>
    <li>AI generated a basic timer with animations</li>
    <li>Refined: "The colors are too bright. Make everything in shades of blue-gray and cream. The chimes should be more subtle."</li>
    <li>Added: "Include optional guided breathing cues—a gentle expanding/contracting circle."</li>
    <li>Polished: "Add a simple stats screen showing meditation streak, but make it feel encouraging, not gamified."</li>
</ol>

<p><strong>The Result:</strong> A fully functional meditation app built in a few hours, not weeks, by someone with no prior coding experience.</p>

<h3>The Limitations of Vibe Coding</h3>
<p>Vibe Coding is powerful, but it''s not magic. Understanding its limitations helps you use it effectively:</p>

<ul>
    <li><strong>Complexity Ceiling:</strong> Extremely complex systems with intricate business logic may require traditional development approaches</li>
    <li><strong>Performance Optimization:</strong> AI-generated code may not be optimally efficient for high-scale applications</li>
    <li><strong>Unique Algorithms:</strong> If you''re inventing new algorithms or solving novel technical problems, you''ll need deeper technical knowledge</li>
    <li><strong>Debugging Deep Issues:</strong> When things go wrong in complex ways, understanding code helps troubleshoot faster</li>
</ul>

<h3>Who Is Vibe Coding For?</h3>
<p>Vibe Coding is particularly powerful for:</p>
<ul>
    <li><strong>Entrepreneurs</strong> who want to validate ideas quickly without hiring developers</li>
    <li><strong>Designers</strong> who want to create functional prototypes, not just mockups</li>
    <li><strong>Product Managers</strong> who want to communicate ideas through working demos</li>
    <li><strong>Beginners</strong> who want to learn programming concepts without getting stuck on syntax</li>
    <li><strong>Experienced Developers</strong> who want to move faster on routine tasks and focus on architecture</li>
</ul>

<h3>The Cultural Shift</h3>
<p>Vibe Coding represents a broader shift in how we think about software creation. It''s moving from "software development as specialized craft" to "software creation as accessible tool."</p>

<p>This doesn''t diminish the value of deep technical expertise—it raises the floor of what''s possible for everyone while allowing experts to focus on truly complex challenges.</p>

<h3>Key Takeaways</h3>
<ul>
    <li>Vibe Coding is a <strong>complete methodology</strong>, not just using AI to help with code</li>
    <li>It''s built on three pillars: <strong>Intent-First Thinking, Conversational Development, and Outcome-Oriented Evaluation</strong></li>
    <li>The process is <strong>iterative and conversational</strong>, treating development as a dialogue</li>
    <li>Success is measured by <strong>user outcomes</strong>, not technical purity</li>
    <li>It has limitations but is incredibly powerful for a wide range of applications</li>
    <li>The mindset shift—from syntax to intent—is as important as the tools</li>
</ul>

<p>In the next lesson, we''ll explore how Vibe Coding transforms you from someone who writes code to someone who directs systems—a fundamental shift in your role as a creator.</p>'
    WHERE module_id = v_module_id AND ordering = 2;
    
    RAISE NOTICE '✅ Lesson 2 expanded';
    
    RAISE NOTICE '🎉 Module 1 content expansion complete!';
    
END $$;

-- Verify the updates
SELECT 
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
WHERE c.title ILIKE '%Vibe Coding%' AND m.ordering = 1
ORDER BY l.ordering;
