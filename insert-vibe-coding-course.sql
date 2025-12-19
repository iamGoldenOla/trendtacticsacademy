-- Insert Vibe Coding course into the database
-- This script creates a complete Vibe Coding course with all modules and lessons

-- First, insert the main course
INSERT INTO courses (
    id,
    title,
    description,
    category,
    level,
    duration,
    price,
    is_published,
    created_at,
    updated_at
) VALUES (
    'vibe-coding-course-id-001',
    'Vibe Coding',
    'Learn to create digital products by focusing on ideas, intention, creativity, and guidance — often with the help of AI — instead of memorizing code syntax or complex technical rules.',
    'Programming',
    'beginner',
    '3 weeks',
    0,
    true,
    NOW(),
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    updated_at = NOW();

-- Insert modules for the course
INSERT INTO modules (
    id,
    course_id,
    title,
    description,
    ordering,
    created_at,
    updated_at
) VALUES 
(
    'vibe-coding-module-1',
    'vibe-coding-course-id-001',
    'Understanding Vibe Coding',
    'Learn the foundational concepts of Vibe Coding and why it exists',
    1,
    NOW(),
    NOW()
),
(
    'vibe-coding-module-2',
    'vibe-coding-course-id-001',
    'Thinking Before Coding',
    'Develop the skill of expressing ideas clearly before implementation',
    2,
    NOW(),
    NOW()
),
(
    'vibe-coding-module-3',
    'vibe-coding-course-id-001',
    'Working with AI as a Creative Partner',
    'Learn how to collaborate effectively with AI tools',
    3,
    NOW(),
    NOW()
),
(
    'vibe-coding-module-4',
    'vibe-coding-course-id-001',
    'Vibe Coding in Real Life',
    'See how Vibe Coding works in practical scenarios',
    4,
    NOW(),
    NOW()
),
(
    'vibe-coding-module-5',
    'vibe-coding-course-id-001',
    'Exploring and Building with Confidence',
    'Use safe environments to experiment and build complete projects',
    5,
    NOW(),
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    ordering = EXCLUDED.ordering,
    updated_at = NOW();

-- Insert lessons for Module 1: Understanding Vibe Coding
INSERT INTO lessons (
    id,
    module_id,
    title,
    content,
    ordering,
    duration,
    created_at,
    updated_at
) VALUES 
(
    'vibe-coding-lesson-1-1',
    'vibe-coding-module-1',
    'What Is Vibe Coding?',
    '{"course_title": "Vibe Coding", "module_title": "Understanding Vibe Coding", "lesson_number": 1, "lesson_title": "What Is Vibe Coding?", "introduction": "Welcome to Vibe Coding! You''re about to discover a completely new way to create digital things without feeling overwhelmed or confused. This isn''t like traditional coding where you memorize complex rules. Instead, we''ll focus on ideas, creativity, and gentle guidance.", "big_idea": "Vibe Coding is about expressing your ideas digitally by working with AI as a creative partner, rather than struggling with complicated technical rules.", "visuals": "Imagine a friendly conversation between you and a helpful assistant. You share your idea, and the assistant helps bring it to life. Visualize speech bubbles with simple ideas on one side and digital creations on the other, connected by a bridge labeled ''Vibe Coding''.", "steps": ["Think of something you''d like to create digitally", "Describe your idea in simple words", "Work with AI to turn your idea into reality", "Experiment and improve without fear of breaking things"], "example": "Instead of learning complex code to make a website, you might say ''I want a website for my lemonade stand with a bright, cheerful design.'' Then you work with AI to make that vision real.", "playground_activity": "In your own words, describe something you''d like to create digitally. It could be a website, an app, a game, or anything else. Don''t worry about technical details - just focus on what you want to achieve.", "reflection_question": "How does the idea of creating digital things through conversation and collaboration feel compared to traditional coding?", "quiz": {"questions": ["What is the main focus of Vibe Coding?", "Who is your creative partner in Vibe Coding?", "What should you focus on before diving into technical details?"], "answers": ["Ideas and creativity over memorizing complex rules", "Artificial Intelligence (AI)", "Understanding what you want to create"]}, "resources": {"video": {"title": "What is Artificial Intelligence (AI)?", "creator": "CrashCourse", "embed": true, "reason": "Gentle introduction to AI concepts without technical intimidation"}, "extra_reading": ["Creative Technology: A Different Approach to Learning Programming", "The Future of Human-AI Collaboration in Creative Work"]}, "summary": "Vibe Coding is a beginner-friendly approach that focuses on turning your ideas into digital reality through collaboration with AI, without needing to memorize complex technical rules."}',
    1,
    '30 minutes',
    NOW(),
    NOW()
),
(
    'vibe-coding-lesson-1-2',
    'vibe-coding-module-1',
    'Why Vibe Coding Exists',
    '{"course_title": "Vibe Coding", "module_title": "Understanding Vibe Coding", "lesson_number": 2, "lesson_title": "Why Vibe Coding Exists", "introduction": "Traditional coding can feel intimidating and confusing, especially for beginners. Many people give up before they even start because they think they need to memorize thousands of complex rules. Vibe Coding was created to change that story.", "big_idea": "Vibe Coding exists to make digital creation accessible, enjoyable, and stress-free for everyone, regardless of their technical background.", "visuals": "Picture two paths: one dark and winding with signs pointing to complex technical terms, and another bright and clear with friendly guides helping you express your ideas. Vibe Coding is the bright, welcoming path.", "steps": ["Recognize that traditional coding approaches can be overwhelming", "Understand that creativity matters more than memorization", "See how AI can be your supportive partner rather than something to fear", "Embrace experimentation as a natural part of learning"], "example": "Instead of spending months trying to learn every programming language syntax, you can start creating digital projects immediately by focusing on what you want to build and working with AI to make it happen.", "playground_activity": "Think of a time when you felt intimidated by technology. How might Vibe Coding change that experience? Write down one thing you''d like to create that previously seemed impossible.", "reflection_question": "What would change in your life if creating digital things felt easy and enjoyable instead of stressful and confusing?", "quiz": {"questions": ["What is the main problem Vibe Coding solves?", "What matters more in Vibe Coding than memorization?", "How should you view experimentation in Vibe Coding?"], "answers": ["Making digital creation accessible to everyone", "Creativity and clear thinking", "A natural and encouraged part of learning"]}, "resources": {"video": {"title": "The Future of No-Code and Low-Code Development", "creator": "Tech Insider", "embed": true, "reason": "Shows how technology is evolving to be more accessible to non-programmers"}, "extra_reading": ["Democratizing Technology: Making Digital Tools Accessible to Everyone", "Why Creativity Matters More Than Code in Modern Development"]}, "summary": "Vibe Coding exists to remove the barriers that prevent creative people from bringing their digital ideas to life, focusing on collaboration and creativity over complex technical rules."}',
    2,
    '30 minutes',
    NOW(),
    NOW()
),
(
    'vibe-coding-lesson-1-3',
    'vibe-coding-module-1',
    'How Vibe Coding Is Different from Traditional Coding',
    '{"course_title": "Vibe Coding", "module_title": "Understanding Vibe Coding", "lesson_number": 3, "lesson_title": "How Vibe Coding Is Different from Traditional Coding", "introduction": "You might wonder how Vibe Coding differs from traditional coding approaches you''ve heard about. The differences are significant and designed to make your learning journey smoother and more enjoyable.", "big_idea": "Unlike traditional coding that emphasizes memorizing syntax and technical rules, Vibe Coding focuses on clear thinking, creativity, and collaborative problem-solving with AI.", "visuals": "Visualize two classrooms: one with students frantically writing complex symbols on chalkboards looking stressed, and another with people having friendly conversations with AI assistants while smiling and creating digital projects.", "steps": ["Focus on what you want to create rather than how to write it", "Use natural language to communicate with AI tools", "Iterate and improve based on feedback rather than debugging complex code", "Build confidence through small wins rather than tackling everything at once"], "example": "Instead of debugging why a semicolon is missing in hundreds of lines of code, you might simply tell an AI ''I want my website header to be blue instead of red'' and watch it happen instantly.", "playground_activity": "List three things that stress you out about technology or learning new skills. Then write how Vibe Coding might address each concern differently.", "reflection_question": "Which approach to digital creation sounds more appealing to you: memorizing technical rules or having conversations with AI helpers?", "quiz": {"questions": ["What does Vibe Coding emphasize instead of memorizing syntax?", "How does Vibe Coding handle problems differently than traditional coding?", "What kind of feedback loop does Vibe Coding promote?"], "answers": ["Clear thinking and creativity", "Collaborative problem-solving with AI", "Iteration and improvement based on feedback"]}, "resources": {"video": {"title": "No-Code vs Traditional Coding: When to Use Each Approach", "creator": "Makerpad", "embed": true, "reason": "Clear comparison showing the benefits of no-code and AI-assisted approaches"}, "extra_reading": ["The Psychology of Learning: Why Stress Blocks Creativity", "Human-Centered Design in Digital Creation Tools"]}, "summary": "Vibe Coding transforms digital creation from a solitary, stressful activity into a collaborative, creative process where your ideas matter more than technical memorization."}',
    3,
    '30 minutes',
    NOW(),
    NOW()
);

-- Insert lessons for Module 2: Thinking Before Coding
INSERT INTO lessons (
    id,
    module_id,
    title,
    content,
    ordering,
    duration,
    created_at,
    updated_at
) VALUES 
(
    'vibe-coding-lesson-2-1',
    'vibe-coding-module-2',
    'Learning to Think in Ideas, Not Code',
    '{"course_title": "Vibe Coding", "module_title": "Thinking Before Coding", "lesson_number": 4, "lesson_title": "Learning to Think in Ideas, Not Code", "introduction": "One of the biggest mindset shifts in Vibe Coding is learning to think in ideas rather than technical implementation details. This approach unlocks your creativity and reduces frustration.", "big_idea": "Effective Vibe Coding starts with clear ideas expressed in plain language, not with worrying about how those ideas will be technically implemented.", "visuals": "Picture a funnel: wide at the top representing big, creative ideas in simple language, narrowing down to focused goals, and finally to specific digital implementations assisted by AI.", "steps": ["Start with a general concept or problem you want to solve", "Describe it in everyday language without technical terms", "Focus on the outcome you want rather than the process", "Let AI help translate your clear intentions into digital reality"], "example": "Instead of thinking ''I need to create a database with user authentication using React and Node.js,'' think ''I want visitors to be able to create accounts and save their favorite recipes.''", "playground_activity": "Describe a project you''d like to create without using any technical terms. Focus entirely on what you want people to be able to do when they use it.", "reflection_question": "How does focusing on outcomes rather than technical implementation change how you approach digital creation?", "quiz": {"questions": ["What should you focus on first when starting a Vibe Coding project?", "What language should you use to describe your ideas?", "What comes after clearly defining your idea?"], "answers": ["The outcome you want to achieve", "Everyday language without technical terms", "Working with AI to bring your idea to life"]}, "resources": {"video": {"title": "Design Thinking for Beginners", "creator": "Stanford d.school", "embed": true, "reason": "Teaches how to think about problems and solutions from a human-centered perspective"}, "extra_reading": ["From Ideas to Implementation: A Beginner''s Guide to Clear Thinking", "The Power of Plain Language in Digital Creation"]}, "summary": "Thinking in ideas rather than code allows you to tap into your creativity and clearly communicate your vision to AI partners who can help make it real."}',
    1,
    '30 minutes',
    NOW(),
    NOW()
),
(
    'vibe-coding-lesson-2-2',
    'vibe-coding-module-2',
    'Turning Simple Ideas into Digital Instructions',
    '{"course_title": "Vibe Coding", "module_title": "Thinking Before Coding", "lesson_number": 5, "lesson_title": "Turning Simple Ideas into Digital Instructions", "introduction": "Now that you understand the importance of clear ideas, let''s explore how to transform those ideas into instructions that AI can understand and act upon.", "big_idea": "The bridge between your creative ideas and digital reality is formed by translating your thoughts into clear, actionable instructions for AI helpers.", "visuals": "Imagine a translation bridge with your creative idea written in colorful marker on one side and clear, structured instructions in neat print on the other side, with AI as the helpful translator in the middle.", "steps": ["Break down your big idea into smaller, manageable parts", "Describe each part using simple, specific language", "Organize your instructions in a logical sequence", "Add details about how you want things to look or behave"], "example": "Instead of saying ''make a blog,'' you might say ''create a website where I can write articles with titles, dates, and categories, and visitors can read them in chronological order.''", "playground_activity": "Take one idea you wrote about earlier and break it down into 3-5 specific features. Describe each feature clearly without using technical jargon.", "reflection_question": "How does breaking big ideas into smaller parts make digital creation feel more approachable?", "quiz": {"questions": ["What is the first step in turning ideas into digital instructions?", "How should you describe each part of your idea?", "Why is organizing instructions in sequence important?"], "answers": ["Break down your big idea into smaller, manageable parts", "Using simple, specific language", "It helps AI understand the logical flow of your project"]}, "resources": {"video": {"title": "How to Give Clear Instructions to AI Tools", "creator": "AI Explained", "embed": true, "reason": "Practical tips for communicating effectively with AI assistants"}, "extra_reading": ["The Art of Clear Communication with Technology", "Breaking Down Big Projects Into Manageable Steps"]}, "summary": "Transforming ideas into clear digital instructions is a skill that improves with practice, and it''s the key to successful collaboration with AI in Vibe Coding."}',
    2,
    '30 minutes',
    NOW(),
    NOW()
),
(
    'vibe-coding-lesson-2-3',
    'vibe-coding-module-2',
    'Understanding ''Intent'' in Vibe Coding',
    '{"course_title": "Vibe Coding", "module_title": "Thinking Before Coding", "lesson_number": 6, "lesson_title": "Understanding ''Intent'' in Vibe Coding", "introduction": "In Vibe Coding, ''intent'' refers to your clear purpose and desired outcome for any digital project. Understanding and communicating your intent is crucial for successful AI collaboration.", "big_idea": "Your intent is the invisible thread that connects your creative vision to its digital implementation, guiding AI helpers to create exactly what you want.", "visuals": "Visualize a lighthouse (representing your intent) guiding a ship (your AI helper) safely to harbor (your completed project) through foggy waters (technical complexities).", "steps": ["Define your core purpose before starting any project", "Communicate your intent clearly and consistently", "Check that each feature aligns with your overall intent", "Adjust your intent as you learn and grow"], "example": "If your intent is to help busy parents organize family activities, every feature you add should serve that purpose - whether it''s a shared calendar, reminder system, or meal planner.", "playground_activity": "Write down the core intent for one project you''d like to create. Then list 3-5 features that would clearly support that intent.", "reflection_question": "How does having a clear intent make decision-making easier when creating digital projects?", "quiz": {"questions": ["What does ''intent'' represent in Vibe Coding?", "Why is communicating intent clearly important?", "What should you do if a feature doesn''t align with your intent?"], "answers": ["Your clear purpose and desired outcome for a digital project", "It guides AI helpers to create exactly what you want", "Consider removing it or rethinking how it serves your purpose"]}, "resources": {"video": {"title": "Finding Your Why: The Power of Purpose in Creative Work", "creator": "Creative Boom", "embed": true, "reason": "Explores how having clear purpose drives better creative outcomes"}, "extra_reading": ["The Role of Intent in Successful Project Management", "How Clear Purpose Guides Better Decision Making"]}, "summary": "Understanding and maintaining clear intent throughout your Vibe Coding projects ensures that every feature and decision serves your ultimate goal, resulting in more cohesive and valuable digital creations."}',
    3,
    '30 minutes',
    NOW(),
    NOW()
);

-- Insert lessons for Module 3: Working with AI as a Creative Partner
INSERT INTO lessons (
    id,
    module_id,
    title,
    content,
    ordering,
    duration,
    created_at,
    updated_at
) VALUES 
(
    'vibe-coding-lesson-3-1',
    'vibe-coding-module-3',
    'What AI Really Is (In Simple Terms)',
    '{"course_title": "Vibe Coding", "module_title": "Working with AI as a Creative Partner", "lesson_number": 7, "lesson_title": "What AI Really Is (In Simple Terms)", "introduction": "Many people have misconceptions about AI, imagining it as either magical or threatening. Let''s demystify what AI really is and how it can be your helpful creative partner.", "big_idea": "AI is essentially a very sophisticated pattern recognition tool that can understand and respond to human language, making it an ideal collaborative partner for digital creation.", "visuals": "Picture AI as a highly knowledgeable but eager-to-help assistant who excels at understanding patterns and following instructions, but still needs your creative direction and judgment.", "steps": ["Think of AI as an incredibly knowledgeable assistant", "Understand that AI recognizes patterns in vast amounts of information", "Recognize that AI needs clear instructions to be helpful", "See AI as a tool that amplifies your creativity rather than replacing it"], "example": "Just as a skilled intern might research topics, draft documents, and organize information based on your instructions, AI can help you research, brainstorm, and create digital projects based on your clear directions.", "playground_activity": "List three tasks you do regularly that involve recognizing patterns or following instructions. How might AI help with these tasks?", "reflection_question": "How does thinking of AI as a knowledgeable assistant rather than a replacement change how you might work with it?", "quiz": {"questions": ["What is AI fundamentally good at?", "What does AI need from you to be helpful?", "How should you view AI in relation to your creativity?"], "answers": ["Recognizing patterns and understanding language", "Clear instructions and creative direction", "A tool that amplifies rather than replaces your creativity"]}, "resources": {"video": {"title": "AI Explained: What Is Artificial Intelligence?", "creator": "BBC Click", "embed": true, "reason": "Accessible explanation of AI concepts without technical intimidation"}, "extra_reading": ["Demystifying AI: A Beginner''s Guide to Understanding Machine Intelligence", "The Human-AI Partnership: Why AI Needs You as Much as You Need It"]}, "summary": "Understanding AI as a sophisticated pattern-recognition tool that excels at following clear instructions helps you collaborate more effectively while maintaining your essential creative role."}',
    1,
    '30 minutes',
    NOW(),
    NOW()
),
(
    'vibe-coding-lesson-3-2',
    'vibe-coding-module-3',
    'How AI Helps in Vibe Coding',
    '{"course_title": "Vibe Coding", "module_title": "Working with AI as a Creative Partner", "lesson_number": 8, "lesson_title": "How AI Helps in Vibe Coding", "introduction": "Now that you understand what AI is, let''s explore the specific ways it acts as your creative partner throughout the Vibe Coding process.", "big_idea": "AI serves as your tireless creative collaborator, helping with ideation, implementation, refinement, and problem-solving while you maintain creative control.", "visuals": "Imagine a creative studio where you''re the visionary director and AI is your versatile production team, handling research, drafting, prototyping, and revision while you guide the artistic direction.", "steps": ["Brainstorming ideas and exploring possibilities", "Translating your clear instructions into digital implementations", "Creating prototypes and mockups for quick feedback", "Handling repetitive tasks so you can focus on creativity"], "example": "When you say ''I want a landing page for my photography business,'' AI might quickly generate several layout options, suggest color schemes, and even draft compelling text while you choose what feels right.", "playground_activity": "Think of a project you''d like to create. List 3-5 specific ways AI could help you bring this project to life, from initial concept to finished product.", "reflection_question": "Which aspect of AI assistance excites you most: ideation, implementation, refinement, or handling repetitive tasks?", "quiz": {"questions": ["What role does AI play in Vibe Coding?", "What can AI help you avoid spending time on?", "What should you still maintain control over when working with AI?"], "answers": ["A tireless creative collaborator", "Repetitive tasks and technical implementation details", "The creative direction and final decisions"]}, "resources": {"video": {"title": "How AI Can Be Your Creative Partner, Not Your Replacement", "creator": "Adobe", "embed": true, "reason": "Shows practical examples of AI enhancing human creativity rather than replacing it"}, "extra_reading": ["The Collaborative Creativity Revolution: Humans and AI Working Together", "Why AI Amplifies Rather Than Replaces Human Creativity"]}, "summary": "AI''s role as a creative partner in Vibe Coding allows you to focus on what you do best - envisioning, directing, and refining - while AI handles the heavy lifting of implementation."}',
    2,
    '30 minutes',
    NOW(),
    NOW()
),
(
    'vibe-coding-lesson-3-3',
    'vibe-coding-module-3',
    'Talking to AI Clearly and Effectively',
    '{"course_title": "Vibe Coding", "module_title": "Working with AI as a Creative Partner", "lesson_number": 9, "lesson_title": "Talking to AI Clearly and Effectively", "introduction": "The quality of your results in Vibe Coding depends heavily on how clearly and effectively you communicate with AI. Let''s explore the art of AI communication.", "big_idea": "Clear, specific communication with AI leads to better results, while vague or ambiguous instructions often produce confusing or irrelevant outputs.", "visuals": "Picture a two-way radio conversation: when both parties speak clearly and listen carefully, communication succeeds. When messages are garbled or unclear, misunderstanding occurs.", "steps": ["Be specific about what you want, not just what you don''t want", "Provide context and examples when helpful", "Break complex requests into smaller, sequential steps", "Give feedback and refinements to guide improvement"], "example": "Instead of saying ''make it look better,'' you might say ''use a calming color palette with blues and greens, increase the font size for better readability, and add more white space around the main content area.''", "playground_activity": "Practice giving clear instructions for a simple task. For example, describe exactly how you''d like your ideal morning coffee prepared, including specific details about temperature, strength, and additions.", "reflection_question": "How might being more specific and detailed in your communication improve your results when working with AI?", "quiz": {"questions": ["What is the key to getting good results from AI?", "What should you provide instead of just saying what you don''t want?", "Why is breaking complex requests into smaller steps helpful?"], "answers": ["Clear, specific communication", "Specific details about what you do want", "It makes it easier for AI to understand and execute each part correctly"]}, "resources": {"video": {"title": "Prompt Engineering: How to Talk to AI Effectively", "creator": "Matt Schlicht", "embed": true, "reason": "Practical techniques for communicating more effectively with AI tools"}, "extra_reading": ["The Art of Clear Communication: A Guide for Digital Creators", "From Vague to Specific: Transforming Your Instructions for Better Results"]}, "summary": "Mastering the skill of clear communication with AI is essential for successful Vibe Coding, as it directly impacts the quality and relevance of the assistance you receive."}',
    3,
    '30 minutes',
    NOW(),
    NOW()
);

-- Insert lessons for Module 4: Vibe Coding in Real Life
INSERT INTO lessons (
    id,
    module_id,
    title,
    content,
    ordering,
    duration,
    created_at,
    updated_at
) VALUES 
(
    'vibe-coding-lesson-4-1',
    'vibe-coding-module-4',
    'Real Examples of Vibe Coding',
    '{"course_title": "Vibe Coding", "module_title": "Vibe Coding in Real Life", "lesson_number": 10, "lesson_title": "Real Examples of Vibe Coding", "introduction": "Let''s look at concrete examples of how Vibe Coding works in real situations to help you understand how to apply these principles to your own projects.", "big_idea": "Real-world Vibe Coding examples demonstrate how combining clear intent, creative thinking, and AI collaboration produces tangible digital results.", "visuals": "Picture a gallery of before-and-after examples: on one side, someone with an idea described in simple terms, and on the other side, the digital creation brought to life with AI assistance.", "steps": ["Identify a clear need or opportunity", "Express the idea in simple, specific language", "Work with AI to explore options and create solutions", "Refine and improve based on feedback and testing"], "example": "A parent wanting to organize family schedules might say ''I need a simple way to coordinate activities for our family of four with different schedules.'' Through Vibe Coding, they could create a shared digital calendar with color-coded events, reminders, and a weekly overview.", "playground_activity": "Choose one of the examples mentioned or think of your own scenario. Write out how you would describe this project using Vibe Coding principles, focusing on clear intent and specific features.", "reflection_question": "Which real example resonates most with your own needs or interests? How might you adapt that approach for your projects?", "quiz": {"questions": ["What is the first step in any Vibe Coding project?", "How should you express your ideas to AI?", "What happens after the initial creation in Vibe Coding?"], "answers": ["Identify a clear need or opportunity", "In simple, specific language", "Refine and improve based on feedback and testing"]}, "resources": {"video": {"title": "Real People Creating Real Things with AI Assistance", "creator": "No Code Camp", "embed": true, "reason": "Showcases authentic examples of people using AI tools to solve real problems"}, "extra_reading": ["Case Studies in Human-AI Collaboration for Creative Projects", "From Idea to Implementation: Real Stories of Digital Creation"]}, "summary": "Examining real examples of Vibe Coding in action helps you understand how to apply these principles to your own projects, turning abstract concepts into concrete results."}',
    1,
    '30 minutes',
    NOW(),
    NOW()
),
(
    'vibe-coding-lesson-4-2',
    'vibe-coding-module-4',
    'Building Simple Things Without Fear',
    '{"course_title": "Vibe Coding", "module_title": "Vibe Coding in Real Life", "lesson_number": 11, "lesson_title": "Building Simple Things Without Fear", "introduction": "One of the beautiful aspects of Vibe Coding is that it removes the fear often associated with creating digital things. Let''s explore how to build with confidence.", "big_idea": "Vibe Coding creates a safe environment for experimentation where mistakes become learning opportunities rather than failures, enabling fearless creation.", "visuals": "Imagine a playground with soft surfaces and gentle slopes where children can climb, slide, and explore without fear of serious injury. Vibe Coding provides a similar safe space for digital experimentation.", "steps": ["Start with small, manageable projects to build confidence", "Remember that iteration and refinement are normal parts of creation", "View unexpected results as discoveries rather than failures", "Celebrate small wins and progress along the way"], "example": "Instead of attempting to build a complex social media platform as your first project, you might start by creating a simple personal website to share your hobbies, then gradually add features like a photo gallery or contact form.", "playground_activity": "Identify one small digital project you could realistically complete in a week. Describe what success would look like for this project and why it''s an appropriate starting point.", "reflection_question": "How does approaching digital creation as a series of small experiments rather than perfect executions change how you feel about starting?", "quiz": {"questions": ["What should you start with to build confidence in Vibe Coding?", "How should you view unexpected results in Vibe Coding?", "Why is celebrating small wins important?"], "answers": ["Small, manageable projects", "As discoveries rather than failures", "It builds momentum and motivation for continued learning"]}, "resources": {"video": {"title": "The Growth Mindset: How to Turn Mistakes Into Learning Opportunities", "creator": "Khan Academy", "embed": true, "reason": "Explores how reframing mistakes as learning opportunities builds confidence and resilience"}, "extra_reading": ["Fearless Creation: A Beginner''s Guide to Experimentation", "The Psychology of Safe Learning Environments"]}, "summary": "Building simple things without fear is fundamental to Vibe Coding success, as it allows you to develop skills and confidence gradually while maintaining a positive relationship with the creative process."}',
    2,
    '30 minutes',
    NOW(),
    NOW()
),
(
    'vibe-coding-lesson-4-3',
    'vibe-coding-module-4',
    'Common Beginner Mistakes and How to Avoid Them',
    '{"course_title": "Vibe Coding", "module_title": "Vibe Coding in Real Life", "lesson_number": 12, "lesson_title": "Common Beginner Mistakes and How to Avoid Them", "introduction": "Even with the supportive environment Vibe Coding provides, beginners tend to make certain predictable mistakes. Recognizing these can help you avoid them.", "big_idea": "Understanding common beginner mistakes in Vibe Coding allows you to sidestep them, saving time and reducing frustration in your learning journey.", "visuals": "Picture a roadmap with clearly marked detours around common pitfalls, showing the smooth path to success when you avoid these obstacles.", "steps": ["Trying to do too much too soon instead of starting small", "Being vague in instructions instead of being specific and clear", "Not iterating and refining based on feedback", "Expecting perfection on the first attempt"], "example": "A common mistake is saying ''Make me a website for my business'' without specifying the industry, target audience, or key features. A better approach is ''Create a website for my yoga studio targeting busy professionals, with class schedules, online booking, and a blog about wellness.''", "playground_activity": "Reflect on a time when you tried to learn something new and felt frustrated. Could any of these common mistakes have contributed to that frustration? How might Vibe Coding principles have helped?", "reflection_question": "Which of these beginner mistakes do you think you might be most prone to, and what specific strategy will you use to avoid it?", "quiz": {"questions": ["What is one common mistake beginners make in Vibe Coding?", "Why is being specific important when working with AI?", "What should you expect instead of perfection on the first attempt?"], "answers": ["Trying to do too much too soon", "Vague instructions often lead to irrelevant or confusing results", "An iterative process of gradual improvement"]}, "resources": {"video": {"title": "7 Common Mistakes Beginners Make When Learning New Skills", "creator": "Thomas Frank", "embed": true, "reason": "Identifies typical beginner pitfalls and strategies for avoiding them"}, "extra_reading": ["The Beginner''s Journey: Navigating Common Obstacles", "From Mistakes to Mastery: Learning Through Iteration"]}, "summary": "Recognizing and avoiding common beginner mistakes accelerates your Vibe Coding journey, helping you build confidence and skills more efficiently while maintaining a positive learning experience."}',
    3,
    '30 minutes',
    NOW(),
    NOW()
);

-- Insert lessons for Module 5: Exploring and Building with Confidence
INSERT INTO lessons (
    id,
    module_id,
    title,
    content,
    ordering,
    duration,
    created_at,
    updated_at
) VALUES 
(
    'vibe-coding-lesson-5-1',
    'vibe-coding-module-5',
    'Using a Playground to Experiment Safely',
    '{"course_title": "Vibe Coding", "module_title": "Exploring and Building with Confidence", "lesson_number": 13, "lesson_title": "Using a Playground to Experiment Safely", "introduction": "The playground environment in Vibe Coding provides a risk-free space where you can experiment, test ideas, and learn without worrying about breaking anything important.", "big_idea": "A safe experimentation environment encourages bold creativity and rapid learning by eliminating the fear of costly mistakes or irreversible damage.", "visuals": "Imagine a creative laboratory with unlimited supplies where you can build, test, modify, and rebuild without consequence. The playground is your digital version of this ideal learning space.", "steps": ["Use the playground for initial experiments and proof-of-concepts", "Test different approaches to see what works best", "Modify and iterate without worrying about breaking anything", "Apply successful experiments to your main projects"], "example": "Before implementing a new navigation system on your live website, you might experiment with different layouts, colors, and interactions in the playground to see what feels right and works well.", "playground_activity": "Think of one feature you''d like to add to a project. Describe how you might experiment with different approaches to that feature in a safe playground environment before implementing it in your main project.", "reflection_question": "How does having a safe space for experimentation change your willingness to try bold or unconventional ideas?", "quiz": {"questions": ["What is the primary benefit of a playground environment?", "What should you use the playground for?", "What happens to successful playground experiments?"], "answers": ["Eliminating the fear of costly mistakes", "Initial experiments and proof-of-concepts", "They can be applied to main projects"]}, "resources": {"video": {"title": "The Importance of Safe Spaces for Learning and Experimentation", "creator": "CrashCourse Kids", "embed": true, "reason": "Explores how safe environments accelerate learning through experimentation"}, "extra_reading": ["Psychological Safety in Creative Work Environments", "The Role of Playgrounds in Skill Development"]}, "summary": "The playground environment is essential to Vibe Coding success, as it provides the psychological safety needed for bold experimentation and rapid skill development."}',
    1,
    '30 minutes',
    NOW(),
    NOW()
),
(
    'vibe-coding-lesson-5-2',
    'vibe-coding-module-5',
    'Improving Your Ideas Step by Step',
    '{"course_title": "Vibe Coding", "module_title": "Exploring and Building with Confidence", "lesson_number": 14, "lesson_title": "Improving Your Ideas Step by Step", "introduction": "Great digital creations rarely emerge fully formed. They evolve through continuous improvement, with each iteration building on lessons learned from the previous version.", "big_idea": "Incremental improvement through regular feedback and refinement produces better results than attempting to create perfection from the start.", "visuals": "Picture a staircase where each step represents a small improvement to your project. Climbing many small steps is easier and safer than trying to leap to the top in one giant jump.", "steps": ["Start with a basic version that captures your core idea", "Gather feedback from yourself and others", "Identify specific areas for improvement", "Make targeted enhancements one at a time", "Repeat the process continuously"], "example": "Instead of trying to create the perfect e-commerce site immediately, you might start with a simple product showcase, then add shopping cart functionality, then payment processing, then user accounts, gradually building toward your complete vision.", "playground_activity": "Think of a simple project you could create in one sitting. Describe how you would improve it step by step over the course of a week, adding one enhancement each day.", "reflection_question": "How does the step-by-step improvement approach reduce overwhelm while still moving you toward your ultimate vision?", "quiz": {"questions": ["Why shouldn''t you try to create perfection from the start?", "What should you do after creating a basic version?", "Why is making enhancements one at a time beneficial?"], "answers": ["It''s rarely achievable and creates unnecessary pressure", "Gather feedback to identify areas for improvement", "It makes it easier to understand what''s working and what isn''t"]}, "resources": {"video": {"title": "The Agile Approach: Building Better Products Through Iteration", "creator": "Google Developers", "embed": true, "reason": "Explains how iterative development produces better results than trying to get everything right the first time"}, "extra_reading": ["Continuous Improvement: A Framework for Better Results", "From Good to Great: The Power of Incremental Enhancement"]}, "summary": "Improving your ideas step by step through regular feedback and targeted enhancements leads to better outcomes than attempting to achieve perfection immediately, while keeping the process manageable and enjoyable."}',
    2,
    '30 minutes',
    NOW(),
    NOW()
),
(
    'vibe-coding-lesson-5-3',
    'vibe-coding-module-5',
    'Your First Complete Vibe-Coded Project',
    '{"course_title": "Vibe Coding", "module_title": "Exploring and Building with Confidence", "lesson_number": 15, "lesson_title": "Your First Complete Vibe-Coded Project", "introduction": "Congratulations! You''ve reached the culmination of this Vibe Coding course. Now it''s time to apply everything you''ve learned to create your first complete project.", "big_idea": "Your first complete Vibe-Coded project demonstrates your ability to combine clear thinking, creative vision, and AI collaboration to bring a digital idea to life.", "visuals": "Picture a graduation cap transforming into a trophy, symbolizing your transition from learner to creator. Behind you is the path you''ve traveled, and ahead is the exciting world of projects you can now create.", "steps": ["Choose a project that''s challenging but achievable", "Define your clear intent and desired outcomes", "Break the project into manageable steps", "Work with AI to implement each step", "Test, refine, and celebrate your accomplishment"], "example": "You might create a personal portfolio website to showcase your photography, starting with your intent to attract potential clients, then working through steps like choosing a layout, selecting images, writing descriptions, and adding contact information.", "playground_activity": "Plan your first complete Vibe-Coded project. Write down your intent, list 3-5 key features, and outline the steps you''ll take to bring it to life. Be specific about how you''ll work with AI at each stage.", "reflection_question": "What excites you most about creating your first complete Vibe-Coded project, and what support systems will help you stay motivated through the process?", "quiz": {"questions": ["What should you consider when choosing your first project?", "What is the foundation of any successful Vibe Coding project?", "What should you do after implementing each step?"], "answers": ["It should be challenging but achievable", "A clear definition of your intent and desired outcomes", "Test and refine before moving to the next step"]}, "resources": {"video": {"title": "From Zero to Hero: Real People Completing Their First Digital Projects", "creator": "Creative Portfolio Show", "embed": true, "reason": "Features inspiring stories of people successfully completing their first major digital projects"}, "extra_reading": ["The Journey from Learner to Creator: A Personal Transformation", "Celebrating Milestones While Building Toward Big Goals"]}, "summary": "Your first complete Vibe-Coded project represents the successful integration of all course concepts, demonstrating your readiness to continue creating digital solutions with confidence and creativity."}',
    3,
    '45 minutes',
    NOW(),
    NOW()
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_courses_published ON courses(is_published);
CREATE INDEX IF NOT EXISTS idx_modules_course_id ON modules(course_id);
CREATE INDEX IF NOT EXISTS idx_lessons_module_id ON lessons(module_id);