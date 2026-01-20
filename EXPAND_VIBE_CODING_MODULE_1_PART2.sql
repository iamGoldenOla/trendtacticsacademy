-- ==========================================
-- EXPAND VIBE CODING CONTENT TO 1200-WORD STANDARD
-- Part 1B: Module 1 - Lessons 3 & 4
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
    
    RAISE NOTICE '📚 Expanding Vibe Coding Module 1 Content (Part 2)...';
    
    -- Get Module 1 ID
    SELECT id INTO v_module_id FROM modules 
    WHERE course_id = v_course_id AND ordering = 1 LIMIT 1;
    
    -- ==========================================
    -- LESSON 3: From Writing Code to Directing Systems
    -- ==========================================
    UPDATE lessons SET content = '<h2>From Writing Code to Directing Systems</h2>

<h3>The Role Transformation</h3>
<p>The most profound shift in Vibe Coding isn''t about the tools you use—it''s about <strong>who you become</strong> in the development process. You''re no longer a code writer. You''re a <strong>system director</strong>, an <strong>architect of experiences</strong>, a <strong>conductor orchestrating digital solutions</strong>.</p>

<p>This lesson explores what it means to direct systems rather than write code, why this transformation matters, and how to develop the skills that make you effective in this new role.</p>

<h3>Understanding the Director Mindset</h3>
<p>Think about a film director. They don''t operate the cameras, edit the footage, or compose the music. Instead, they:</p>

<ul>
    <li>Hold the vision for the final product</li>
    <li>Communicate that vision to specialists</li>
    <li>Make decisions about what works and what doesn''t</li>
    <li>Iterate until the result matches the vision</li>
    <li>Understand enough about each discipline to guide effectively</li>
</ul>

<p>As a system director in Vibe Coding, you do the same with software. You don''t write every line of code, but you <strong>guide the creation process</strong> with clear vision and informed decisions.</p>

<h3>What You''re Actually Directing</h3>
<p>When you direct systems, you''re orchestrating several layers:</p>

<h4>1. User Experience Layer</h4>
<p>How will users interact with your system? What should they feel at each step? This is about understanding human psychology, design principles, and user needs.</p>

<p><strong>Example Direction:</strong> "When users complete a task, they should feel accomplished. Show a satisfying animation and a brief encouraging message. Don''t interrupt their flow with unnecessary popups."</p>

<h4>2. Functional Layer</h4>
<p>What should the system actually do? What are the core capabilities and how do they connect?</p>

<p><strong>Example Direction:</strong> "The system needs to accept file uploads, process them in the background, and notify users when processing is complete. If processing fails, explain why in plain language and suggest fixes."</p>

<h4>3. Data Layer</h4>
<p>What information needs to be stored, retrieved, and transformed? How should data flow through the system?</p>

<p><strong>Example Direction:</strong> "Store user preferences so they persist across sessions. Keep a history of their last 10 actions so they can undo mistakes. Delete sensitive data after 30 days for privacy."</p>

<h4>4. Integration Layer</h4>
<p>How does your system connect with external services, APIs, or other tools?</p>

<p><strong>Example Direction:</strong> "When a user signs up, create their account in our database and also add them to our email newsletter through the Mailchimp API. If the email addition fails, still create the account but log the error."</p>

<h3>The Skills of a System Director</h3>
<p>Directing systems requires a different skill set than writing code:</p>

<table>
    <tr>
        <th>Traditional Coding Skills</th>
        <th>System Directing Skills</th>
    </tr>
    <tr>
        <td>Syntax mastery</td>
        <td>Clear communication of intent</td>
    </tr>
    <tr>
        <td>Algorithm implementation</td>
        <td>Problem decomposition</td>
    </tr>
    <tr>
        <td>Debugging code</td>
        <td>Evaluating system behavior</td>
    </tr>
    <tr>
        <td>Framework knowledge</td>
        <td>Architectural understanding</td>
    </tr>
    <tr>
        <td>Performance optimization</td>
        <td>User experience refinement</td>
    </tr>
</table>

<h3>How to Give Effective Directions</h3>
<p>The quality of your directions determines the quality of your results. Here''s how to direct effectively:</p>

<h4>1. Be Specific About Outcomes, Flexible About Implementation</h4>
<p><strong>Good:</strong> "Users should be able to filter products by price range, category, and rating. The filters should update results instantly without page reload."</p>

<p><strong>Less Effective:</strong> "Add some filters."</p>

<p>Notice how the good direction specifies <em>what</em> should happen (instant updates, specific filter types) but doesn''t prescribe <em>how</em> to implement it technically.</p>

<h4>2. Provide Context and Constraints</h4>
<p><strong>Good:</strong> "This feature will be used primarily on mobile devices by users in low-bandwidth areas. Prioritize speed and data efficiency over visual complexity."</p>

<p>Context helps AI make better implementation choices aligned with your actual needs.</p>

<h4>3. Describe the User Journey</h4>
<p><strong>Good:</strong> "When a user clicks ''Share'', show them options for email, social media, and copy link. After they select one, confirm the action with a brief success message, then return them to what they were doing."</p>

<p>Walking through the user experience step-by-step ensures nothing gets missed.</p>

<h4>4. Specify Edge Cases and Error Handling</h4>
<p><strong>Good:</strong> "If the user tries to submit without filling required fields, highlight the empty fields in red and show a friendly message: ''Please fill in all required fields.'' Don''t clear what they''ve already entered."</p>

<p>Thinking through what happens when things go wrong leads to more robust systems.</p>

<h3>Real-World Example: Directing a Complete Feature</h3>
<p>Let''s watch a system director build a "password reset" feature:</p>

<p><strong>Initial Direction:</strong><br>
"I need a password reset flow. User clicks ''Forgot Password'', enters their email, receives a reset link, clicks it, sets a new password, and gets logged in automatically."</p>

<p><strong>AI Response:</strong> Generates basic flow</p>

<p><strong>Refinement 1:</strong><br>
"The reset link should expire after 1 hour for security. If they try to use an expired link, explain it''s expired and offer to send a new one."</p>

<p><strong>Refinement 2:</strong><br>
"The new password must be at least 8 characters with at least one number. Show password strength as they type (weak/medium/strong) to help them create a secure password."</p>

<p><strong>Refinement 3:</strong><br>
"If someone requests a reset for an email that doesn''t exist in our system, don''t reveal that—just say ''If that email is in our system, you''ll receive a reset link.'' This prevents email enumeration attacks."</p>

<p><strong>Refinement 4:</strong><br>
"After successful password reset, send them to their dashboard with a welcome back message, not just a generic success page."</p>

<p>Notice how each refinement adds important details without specifying technical implementation. The director is thinking about security, user experience, and edge cases—not about which encryption library to use.</p>

<h3>The Feedback Loop: Direction → Implementation → Evaluation</h3>
<p>Effective system direction is iterative:</p>

<ol>
    <li><strong>Give Direction:</strong> Clearly describe what you want</li>
    <li><strong>Review Implementation:</strong> Test what gets created</li>
    <li><strong>Evaluate Against Intent:</strong> Does it match your vision?</li>
    <li><strong>Refine Direction:</strong> Clarify, adjust, or expand based on what you learned</li>
    <li><strong>Repeat:</strong> Continue until it matches your intent</li>
</ol>

<p>This loop is faster than traditional development because you''re not debugging syntax errors—you''re refining requirements and user experience.</p>

<h3>Common Directing Mistakes and How to Avoid Them</h3>

<p><strong>Mistake 1: Being Too Vague</strong><br>
"Make it look nice" doesn''t give enough direction.<br>
<strong>Better:</strong> "Use a clean, modern design with plenty of white space. Primary color should be blue (#2563EB). Typography should feel professional but approachable."</p>

<p><strong>Mistake 2: Over-Specifying Implementation</strong><br>
"Use React hooks with useState for the counter and useEffect for the API call" is too technical.<br>
<strong>Better:</strong> "The counter should update immediately when clicked. Load the initial value from the API when the page loads."</p>

<p><strong>Mistake 3: Ignoring the User Perspective</strong><br>
"Store the data in a database" focuses on technical details.<br>
<strong>Better:</strong> "Users should see their data persist across sessions. If they close the app and reopen it, their work should still be there."</p>

<p><strong>Mistake 4: Not Providing Enough Context</strong><br>
"Add a search feature" leaves too many questions unanswered.<br>
<strong>Better:</strong> "Add a search feature that looks through product names and descriptions. Results should appear as the user types (after 3 characters). Show up to 10 results, sorted by relevance."</p>

<h3>Developing Your Director Skills</h3>
<p>To become a better system director:</p>

<ol>
    <li><strong>Study User Experience:</strong> Learn what makes software feel good to use</li>
    <li><strong>Practice Describing Interactions:</strong> Walk through user flows step-by-step</li>
    <li><strong>Think in Systems:</strong> Understand how different parts connect and affect each other</li>
    <li><strong>Learn to Evaluate:</strong> Develop taste for what works and what doesn''t</li>
    <li><strong>Understand Constraints:</strong> Know enough about technology to set realistic expectations</li>
</ol>

<h3>The Power of the Director Role</h3>
<p>When you direct systems instead of writing code, several powerful things happen:</p>

<ul>
    <li><strong>You Move Faster:</strong> No time wasted on syntax errors or debugging typos</li>
    <li><strong>You Think Bigger:</strong> Focus on solving problems, not implementation details</li>
    <li><strong>You Stay Creative:</strong> More time for design thinking and user experience</li>
    <li><strong>You Remain Flexible:</strong> Easy to pivot and try different approaches</li>
    <li><strong>You Scale Better:</strong> Can direct multiple AI assistants on different parts of a project</li>
</ul>

<h3>What This Means for Your Career</h3>
<p>The shift from code writer to system director opens new possibilities:</p>

<ul>
    <li><strong>Entrepreneurs</strong> can build their own MVPs without technical co-founders</li>
    <li><strong>Designers</strong> can create functional prototypes, not just mockups</li>
    <li><strong>Product Managers</strong> can validate ideas with working software</li>
    <li><strong>Consultants</strong> can deliver custom solutions without large development teams</li>
    <li><strong>Developers</strong> can focus on architecture and complex problems, delegating routine implementation</li>
</ul>

<h3>The Future of System Direction</h3>
<p>As AI systems become more sophisticated, the director role will become even more powerful. We''re moving toward a future where:</p>

<ul>
    <li>Directors can manage increasingly complex systems with the same effort</li>
    <li>The gap between idea and implementation continues to shrink</li>
    <li>More people can participate in software creation</li>
    <li>The bottleneck shifts from "can we build it?" to "should we build it?"</li>
</ul>

<h3>Key Takeaways</h3>
<ul>
    <li>Vibe Coding transforms you from a <strong>code writer to a system director</strong></li>
    <li>Directors focus on <strong>vision, communication, and evaluation</strong> rather than syntax</li>
    <li>Effective direction requires <strong>clarity about outcomes, context, and user experience</strong></li>
    <li>The feedback loop is <strong>faster and more creative</strong> than traditional development</li>
    <li>This role shift <strong>opens new career possibilities</strong> and ways of working</li>
    <li>The skills you need are <strong>learnable and valuable</strong> across many domains</li>
</ul>

<p>In the next lesson, we''ll explore the ecosystem of tools and resources that make Vibe Coding possible, helping you choose the right tools for your projects.</p>'
    WHERE module_id = v_module_id AND ordering = 3;
    
    RAISE NOTICE '✅ Lesson 3 expanded';
    
    -- ==========================================
    -- LESSON 4: Recommended Resources & Ecosystem
    -- ==========================================
    UPDATE lessons SET content = '<h2>Recommended Resources & Ecosystem</h2>

<h3>Navigating the Vibe Coding Landscape</h3>
<p>The Vibe Coding ecosystem is vast and rapidly evolving. New tools emerge weekly, existing tools add powerful features, and the landscape shifts constantly. This lesson gives you a curated map of the essential resources, tools, and learning materials you need to thrive as a Vibe Coder.</p>

<p>Rather than overwhelming you with every option, we''ll focus on <strong>high-impact resources</strong> organized by your goals and experience level.</p>

<h3>The Core Tool Categories</h3>
<p>Understanding the ecosystem starts with recognizing the main categories of tools:</p>

<h4>1. AI Coding Assistants</h4>
<p>These are AI systems that help you generate, understand, and modify code through natural language.</p>

<p><strong>Top Recommendations:</strong></p>
<ul>
    <li><strong>ChatGPT (GPT-4):</strong> Best for general-purpose coding assistance, explaining concepts, and generating code snippets</li>
    <li><strong>Claude (Anthropic):</strong> Excellent for longer, more complex code generation and detailed explanations</li>
    <li><strong>GitHub Copilot:</strong> Integrated directly into your code editor for real-time suggestions</li>
</ul>

<p><strong>When to Use:</strong> Learning concepts, generating specific functions, debugging issues, or getting explanations of existing code.</p>

<h4>2. Full-Stack AI Builders</h4>
<p>These platforms generate complete, working applications from descriptions.</p>

<p><strong>Top Recommendations:</strong></p>
<ul>
    <li><strong>Bolt.new:</strong> Fastest for simple web apps and prototypes. Great for beginners.</li>
    <li><strong>Lovable (formerly GPT Engineer):</strong> Best for design-focused applications with beautiful UIs</li>
    <li><strong>Replit:</strong> Ideal when you need backend logic, databases, or want to learn by modifying code</li>
    <li><strong>v0 by Vercel:</strong> Excellent for generating React components and modern web interfaces</li>
</ul>

<p><strong>When to Use:</strong> Building MVPs, creating prototypes, or launching simple products quickly.</p>

<h4>3. AI-Enhanced IDEs</h4>
<p>These are professional development environments with deep AI integration.</p>

<p><strong>Top Recommendations:</strong></p>
<ul>
    <li><strong>Cursor:</strong> VS Code fork with powerful AI features. Best for professional developers.</li>
    <li><strong>Windsurf:</strong> Newer IDE focused on "flow state" coding with AI</li>
    <li><strong>Codeium:</strong> Free alternative with strong code completion</li>
</ul>

<p><strong>When to Use:</strong> Working on complex projects, existing codebases, or when you need full control.</p>

<h4>4. Specialized AI Tools</h4>
<p>Tools designed for specific tasks in the development process.</p>

<p><strong>Top Recommendations:</strong></p>
<ul>
    <li><strong>Figma AI:</strong> Design to code conversion</li>
    <li><strong>Supabase:</strong> Backend-as-a-service with AI assistance</li>
    <li><strong>Vercel v0:</strong> Component generation for React/Next.js</li>
    <li><strong>Framer:</strong> Design tool with AI-powered code export</li>
</ul>

<h3>Learning Resources by Experience Level</h3>

<h4>Complete Beginners</h4>
<p>If you''re brand new to software creation:</p>

<ol>
    <li><strong>Start Here:</strong> This Vibe Coding course (you''re already on the right track!)</li>
    <li><strong>Practice Platform:</strong> Bolt.new - immediate results without setup</li>
    <li><strong>Concepts:</strong> "Code.org" for basic programming concepts</li>
    <li><strong>Community:</strong> Join the Vibe Coding Discord for support and inspiration</li>
</ol>

<p><strong>First Project Idea:</strong> Build a personal portfolio website or a simple to-do list app</p>

<h4>Intermediate Learners</h4>
<p>If you understand basics and want to build more complex projects:</p>

<ol>
    <li><strong>Tool Upgrade:</strong> Move to Replit or Cursor for more control</li>
    <li><strong>Learn:</strong> "The Odin Project" for web development fundamentals</li>
    <li><strong>Practice:</strong> "Frontend Mentor" challenges using AI assistance</li>
    <li><strong>Deep Dive:</strong> "Web Dev Simplified" YouTube channel</li>
</ol>

<p><strong>Project Ideas:</strong> E-commerce site, blog platform, or API-connected dashboard</p>

<h4>Advanced Practitioners</h4>
<p>If you''re building production applications:</p>

<ol>
    <li><strong>Professional Tools:</strong> Cursor + GitHub Copilot</li>
    <li><strong>Architecture:</strong> "System Design Primer" on GitHub</li>
    <li><strong>Best Practices:</strong> "Refactoring UI" for design, "Clean Code" for architecture</li>
    <li><strong>Scaling:</strong> "AWS Well-Architected Framework" or equivalent</li>
</ol>

<h3>Essential Learning Paths</h3>

<h4>Path 1: Frontend Development</h4>
<p>For building user interfaces and web applications:</p>

<ol>
    <li>HTML/CSS fundamentals (use AI to explain as you build)</li>
    <li>JavaScript basics (focus on concepts, not syntax memorization)</li>
    <li>React or Vue.js (let AI generate components while you learn patterns)</li>
    <li>Responsive design and accessibility</li>
    <li>Modern tooling (Vite, Tailwind CSS)</li>
</ol>

<p><strong>Recommended Tools:</strong> Bolt.new → v0 → Cursor</p>

<h4>Path 2: Full-Stack Development</h4>
<p>For building complete applications with backend:</p>

<ol>
    <li>Frontend fundamentals (see Path 1)</li>
    <li>Backend concepts (APIs, databases, authentication)</li>
    <li>Database design (SQL basics, data modeling)</li>
    <li>Deployment and hosting</li>
    <li>API integration and third-party services</li>
</ol>

<p><strong>Recommended Tools:</strong> Replit → Supabase → Cursor + Vercel</p>

<h4>Path 3: No-Code to Low-Code</h4>
<p>For building without writing code directly:</p>

<ol>
    <li>Visual builders (Webflow, Framer)</li>
    <li>Backend services (Airtable, Supabase)</li>
    <li>Automation (Zapier, Make)</li>
    <li>AI enhancement (using ChatGPT to customize)</li>
</ol>

<p><strong>Recommended Tools:</strong> Framer + Supabase + ChatGPT for customization</p>

<h3>Community and Support Resources</h3>

<h4>Where to Get Help</h4>
<ul>
    <li><strong>Stack Overflow:</strong> Still valuable for specific technical questions</li>
    <li><strong>Reddit r/learnprogramming:</strong> Beginner-friendly community</li>
    <li><strong>Discord Communities:</strong> Real-time help from other learners</li>
    <li><strong>Twitter/X:</strong> Follow #VibeCoding and #BuildInPublic for inspiration</li>
</ul>

<h4>People to Follow</h4>
<p>These creators share valuable Vibe Coding insights:</p>
<ul>
    <li><strong>Pieter Levels (@levelsio):</strong> Building products solo with AI</li>
    <li><strong>Danny Thompson (@DThompsonDev):</strong> Career advice and learning resources</li>
    <li><strong>Shawn Wang (@swyx):</strong> AI and developer tools insights</li>
    <li><strong>Simon Willison (@simonw):</strong> AI and practical applications</li>
</ul>

<h3>Staying Current in a Fast-Moving Field</h3>
<p>The Vibe Coding ecosystem evolves rapidly. Here''s how to stay updated:</p>

<ol>
    <li><strong>Weekly:</strong> Check "AI Breakfast" newsletter for tool updates</li>
    <li><strong>Monthly:</strong> Review new features in your primary tools</li>
    <li><strong>Quarterly:</strong> Evaluate if new tools better fit your workflow</li>
    <li><strong>Annually:</strong> Reassess your entire toolchain and learning path</li>
</ol>

<h3>Building Your Personal Toolkit</h3>
<p>Don''t try to learn everything at once. Build your toolkit progressively:</p>

<p><strong>Starter Kit (Week 1):</strong></p>
<ul>
    <li>ChatGPT or Claude for learning</li>
    <li>Bolt.new for building</li>
    <li>This course for guidance</li>
</ul>

<p><strong>Intermediate Kit (Month 2-3):</strong></p>
<ul>
    <li>Replit or Cursor for more control</li>
    <li>Supabase for backend needs</li>
    <li>Vercel for deployment</li>
    <li>Figma for design</li>
</ul>

<p><strong>Advanced Kit (Month 6+):</strong></p>
<ul>
    <li>Cursor as primary IDE</li>
    <li>GitHub Copilot for code completion</li>
    <li>Specialized tools for your niche</li>
    <li>Custom AI workflows</li>
</ul>

<h3>Free vs. Paid Resources</h3>
<p>You can learn Vibe Coding entirely with free resources, but paid tools offer advantages:</p>

<p><strong>Excellent Free Resources:</strong></p>
<ul>
    <li>ChatGPT (free tier)</li>
    <li>Bolt.new (limited free usage)</li>
    <li>YouTube tutorials</li>
    <li>This course</li>
    <li>FreeCodeCamp</li>
    <li>The Odin Project</li>
</ul>

<p><strong>Worth Paying For:</strong></p>
<ul>
    <li>ChatGPT Plus ($20/month) - faster, more capable model</li>
    <li>GitHub Copilot ($10/month) - significant productivity boost</li>
    <li>Cursor Pro ($20/month) - for serious projects</li>
    <li>Specialized courses for deep dives</li>
</ul>

<h3>Recommended Project-Based Learning</h3>
<p>The best way to learn is by building. Here''s a progressive project sequence:</p>

<ol>
    <li><strong>Week 1:</strong> Personal portfolio website</li>
    <li><strong>Week 2:</strong> To-do list with local storage</li>
    <li><strong>Week 3:</strong> Weather app using an API</li>
    <li><strong>Week 4:</strong> Blog with authentication</li>
    <li><strong>Month 2:</strong> E-commerce product page</li>
    <li><strong>Month 3:</strong> Full CRUD application</li>
    <li><strong>Month 4+:</strong> Your own product idea</li>
</ol>

<h3>Documentation and Reference</h3>
<p>Essential documentation to bookmark:</p>

<ul>
    <li><strong>MDN Web Docs:</strong> Comprehensive web development reference</li>
    <li><strong>React Docs:</strong> If building with React</li>
    <li><strong>Supabase Docs:</strong> For backend services</li>
    <li><strong>Tailwind CSS Docs:</strong> For styling</li>
</ul>

<p><strong>Pro Tip:</strong> Don''t memorize documentation. Use AI to search and explain it for you.</p>

<h3>Avoiding Common Pitfalls</h3>

<p><strong>Pitfall 1: Tool Hopping</strong><br>
Don''t constantly switch tools. Master one before exploring alternatives.</p>

<p><strong>Pitfall 2: Tutorial Hell</strong><br>
Don''t just watch tutorials. Build projects to apply what you learn.</p>

<p><strong>Pitfall 3: Perfectionism</strong><br>
Don''t wait for perfect understanding. Build, break things, and learn from mistakes.</p>

<p><strong>Pitfall 4: Isolation</strong><br>
Don''t learn alone. Join communities, share your work, and ask questions.</p>

<h3>Your Next Steps</h3>
<p>Based on where you are now:</p>

<p><strong>If you''re just starting:</strong></p>
<ol>
    <li>Complete this course</li>
    <li>Build 3 simple projects with Bolt.new</li>
    <li>Join one community for support</li>
    <li>Share your progress publicly</li>
</ol>

<p><strong>If you''re intermediate:</strong></p>
<ol>
    <li>Choose a more complex project</li>
    <li>Learn one new tool deeply</li>
    <li>Contribute to open source</li>
    <li>Help beginners in communities</li>
</ol>

<p><strong>If you''re advanced:</strong></p>
<ol>
    <li>Build a product for real users</li>
    <li>Optimize your AI workflow</li>
    <li>Create content to teach others</li>
    <li>Explore cutting-edge tools</li>
</ol>

<h3>Key Takeaways</h3>
<ul>
    <li>The Vibe Coding ecosystem has <strong>four main tool categories</strong>: AI assistants, full-stack builders, AI-enhanced IDEs, and specialized tools</li>
    <li><strong>Start simple</strong> and progressively build your toolkit as you grow</li>
    <li><strong>Project-based learning</strong> is more effective than passive consumption</li>
    <li><strong>Communities and support</strong> accelerate your learning significantly</li>
    <li>You can learn with <strong>free resources</strong>, but some paid tools offer major productivity gains</li>
    <li><strong>Stay current</strong> but don''t chase every new tool—master fundamentals first</li>
</ul>

<p>You''ve now completed Module 1: Foundations of Vibe Coding. You understand the philosophy, the mindset shift, and the ecosystem. In Module 2, we''ll dive deep into how AI actually builds software—understanding the mechanics will make you a much more effective Vibe Coder.</p>'
    WHERE module_id = v_module_id AND ordering = 4;
    
    RAISE NOTICE '✅ Lesson 4 expanded';
    
    RAISE NOTICE '🎉 Module 1 complete expansion finished!';
    
END $$;

-- Verify all Module 1 lessons
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
WHERE c.title ILIKE '%Vibe Coding%' AND m.ordering = 1
ORDER BY l.ordering;
