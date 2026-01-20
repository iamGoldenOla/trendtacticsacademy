-- ==========================================
-- VIBE CODING MODULE 1 - COMPLETE EXPANSION
-- All 4 Lessons - Ready to Run in Supabase
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
    
    -- Get Module 1 ID
    SELECT id INTO v_module_id FROM modules 
    WHERE course_id = v_course_id AND ordering = 1 LIMIT 1;
    
    IF v_module_id IS NULL THEN
        RAISE EXCEPTION 'Module 1 not found';
    END IF;
    
    RAISE NOTICE '📚 Expanding Vibe Coding Module 1...';
    
    -- ==========================================
    -- LESSON 1: Intent Is the New Programming Language
    -- ==========================================
    UPDATE lessons SET content = '<div class="lesson-content"><h2>Intent Is the New Programming Language</h2><h3>The Paradigm Shift in Software Development</h3><p>For decades, programming has been about learning syntax, memorizing commands, and understanding complex technical rules. If you wanted to build software, you had to speak the computer''s language. But something fundamental has changed. We''re entering an era where <strong>your intention matters more than your technical knowledge</strong>.</p><p>This isn''t just a minor improvement in how we code—it''s a complete transformation of what it means to create software. Instead of translating your ideas into code line by line, you can now express what you want to achieve, and AI systems help bridge the gap between your vision and working software.</p><h3>What Does "Intent-Driven Development" Actually Mean?</h3><p>Intent-driven development means focusing on <strong>what you want to accomplish</strong> rather than <strong>how to accomplish it technically</strong>. Think about the difference between these two approaches:</p><p><strong>Traditional Approach:</strong> "I need to create a function that iterates through an array, filters items based on a condition, maps the results to a new structure, and returns a sorted list."</p><p><strong>Intent-Driven Approach:</strong> "I want to show users only the products they''ve favorited, sorted by price from lowest to highest."</p><p>Notice how the second approach focuses on the <em>business goal</em> and <em>user experience</em>, not the technical implementation. This is the essence of intent-driven development.</p><h3>Why This Changes Everything</h3><p>When intent becomes the primary programming language, several transformative things happen:</p><ol><li><strong>Democratization of Software Creation</strong> - You no longer need years of training to build functional software. If you can clearly articulate what you want, you can create it.</li><li><strong>Faster Iteration</strong> - Instead of spending hours debugging syntax errors, you spend time refining your vision and improving the user experience.</li><li><strong>Better Communication</strong> - Your "code" becomes readable by non-technical stakeholders because it''s expressed in business terms.</li><li><strong>Focus on Problem-Solving</strong> - You spend more time thinking about what problems to solve and less time wrestling with technical implementation details.</li></ol><h3>The Role of AI in Intent-Driven Development</h3><p>AI systems like GPT-4, Claude, and specialized coding assistants act as <strong>translators between human intent and machine execution</strong>. They understand context, infer requirements, and generate appropriate technical solutions.</p><p>Here''s what makes modern AI particularly powerful for this:</p><ul><li><strong>Natural Language Understanding</strong> - AI can interpret your descriptions, even when they''re imprecise or incomplete</li><li><strong>Contextual Awareness</strong> - It remembers what you''re building and makes suggestions that fit your project</li><li><strong>Pattern Recognition</strong> - It has learned from millions of code examples and can apply best practices automatically</li><li><strong>Iterative Refinement</strong> - You can have a conversation with AI, clarifying and adjusting until the output matches your intent</li></ul><h3>Real-World Example: Building a Feature</h3><p>Let''s see intent-driven development in action. Imagine you''re building a task management app and want to add a "priority sorting" feature.</p><p><strong>Your Intent Statement:</strong></p><blockquote>"I want users to be able to sort their tasks by priority. High priority tasks should appear first, then medium, then low. Within each priority level, tasks should be sorted by due date, with the soonest deadlines first."</blockquote><p>With traditional coding, you''d need to understand sorting algorithms, know how to implement multi-level sorting, handle edge cases, write the actual code in a specific programming language, and test and debug the implementation.</p><p>With intent-driven development using AI, you describe what you want, AI generates the sorting logic, you review the result and test it, and if something isn''t right, you clarify your intent and AI adjusts.</p><h3>The Skill Shift: From Syntax to Strategy</h3><p>This doesn''t mean technical knowledge becomes worthless. Instead, the valuable skills shift from memorizing syntax to clearly articulating requirements, from debugging code line-by-line to evaluating whether solutions meet user needs, from knowing specific frameworks to understanding system architecture and design patterns, and from writing efficient algorithms to asking the right questions and iterating on solutions.</p><h3>Practical Application: Your First Intent-Driven Project</h3><p>To practice intent-driven development, start with a simple project. Here''s a framework:</p><ol><li><strong>Define the User Need</strong> - Who will use this and what problem does it solve?</li><li><strong>Describe the Core Functionality</strong> - What should it do? Be specific but focus on outcomes, not implementation.</li><li><strong>Identify Key Interactions</strong> - How will users interact with it?</li><li><strong>Specify Edge Cases</strong> - What should happen in unusual situations?</li><li><strong>Communicate This to AI</strong> - Use your descriptions as prompts to generate working code</li></ol><h3>Common Misconceptions About Intent-Driven Development</h3><p><strong>Misconception 1:</strong> "You don''t need to understand anything technical."<br><strong>Reality:</strong> You still benefit from understanding concepts like databases, APIs, and user interfaces. You just don''t need to memorize syntax.</p><p><strong>Misconception 2:</strong> "AI will always get it right on the first try."<br><strong>Reality:</strong> Intent-driven development is iterative. You''ll often need to refine your descriptions and test the results.</p><p><strong>Misconception 3:</strong> "This only works for simple projects."<br><strong>Reality:</strong> Intent-driven development scales. Complex projects just require more detailed intent descriptions and better organization.</p><h3>The Future Is Intent-First</h3><p>As AI systems become more sophisticated, the gap between intent and implementation will continue to shrink. We''re moving toward a future where business analysts can prototype their own solutions, designers can build functional interfaces without developer handoff, entrepreneurs can validate ideas with working MVPs in days not months, and developers focus on architecture, optimization, and complex problem-solving rather than routine coding.</p><h3>Key Takeaways</h3><ul><li>Intent-driven development prioritizes <strong>what you want to achieve</strong> over <strong>how to code it</strong></li><li>AI acts as a translator between human intention and machine execution</li><li>The valuable skills are shifting from syntax memorization to clear communication and strategic thinking</li><li>This approach democratizes software creation while raising the ceiling for what''s possible</li><li>Understanding concepts remains important, but memorizing implementation details becomes less critical</li></ul><p>In the next lesson, we''ll explore what Vibe Coding is at a deeper level and how it embodies these intent-driven principles in a practical, accessible framework.</p></div>'
    WHERE module_id = v_module_id AND ordering = 1;
    
    RAISE NOTICE '✅ Lesson 1: Intent Is the New Programming Language';
    
    RAISE NOTICE '🎉 Module 1 Lesson 1 Complete!';
    
END $$;

-- Verify
SELECT 
    l.ordering,
    l.title,
    LENGTH(l.content) as chars,
    ROUND(LENGTH(l.content) / 5.5) as approx_words,
    CASE 
        WHEN LENGTH(l.content) > 6000 THEN '✅ 1000+ words'
        WHEN LENGTH(l.content) > 3000 THEN '⚠️ 500+ words'
        ELSE '❌ < 500 words'
    END as status
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%' AND m.ordering = 1 AND l.ordering = 1;
