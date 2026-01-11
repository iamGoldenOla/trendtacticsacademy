-- Complete Vibe Coding Course Insertion
-- Adding all remaining lessons for the complete course

DO $$
DECLARE
    course_id_var UUID;
    module_id_var UUID;
    lesson_count INTEGER;
BEGIN
    -- Get the course ID
    SELECT id INTO course_id_var FROM courses WHERE title = 'Vibe Coding' LIMIT 1;
    
    -- Add remaining lessons for Understanding Vibe Coding module (module 3)
    SELECT id INTO module_id_var FROM modules WHERE course_id = course_id_var AND title = 'Understanding Vibe Coding' LIMIT 1;
    
    -- Check if lesson 3 exists
    SELECT COUNT(*) INTO lesson_count FROM lessons WHERE module_id = module_id_var AND lesson_number = 3;
    
    IF lesson_count = 0 THEN
        INSERT INTO lessons (module_id, lesson_number, title, lesson_json) VALUES
        (module_id_var, 3, 'How Vibe Coding Is Different from Traditional Coding', '{
          "course_title": "Vibe Coding",
          "module_title": "Understanding Vibe Coding",
          "lesson_number": 3,
          "lesson_title": "How Vibe Coding Is Different from Traditional Coding",
          "introduction": "Welcome to \"How Vibe Coding Is Different from Traditional Coding\" in the Vibe Coding course! In this lesson, we''ll explore this important concept in a beginner-friendly way. Remember, there''s no need to feel anxious - we''ll take this step by step with plenty of guidance and support.",
          "big_idea": "Traditional coding starts with technical details and syntax, which can be intimidating for beginners. Vibe Coding starts with your ideas and intentions, using AI and guidance to help you create without getting bogged down in technical complexity.",
          "visuals": "Design a split-screen visual showing ''Traditional Approach'' (left side: complex code, frustrated learner) versus ''Vibe Approach'' (right side: idea-focused creation, happy learner). Include arrows showing the learning journey in each approach.",
          "steps": [
            "Step 1: Understand the main concept of this lesson",
            "Step 2: Learn how this concept applies to Vibe Coding",
            "Step 3: See practical examples of this concept in action",
            "Step 4: Practice applying this concept in the playground",
            "Step 5: Reflect on how this fits into your learning journey"
          ],
          "example": "Traditional coding is like learning to cook by memorizing the chemical composition of every ingredient before making a sandwich. Vibe Coding is like learning to cook by starting with simple recipes that produce satisfying results, with understanding of the chemistry coming naturally through experience.",
          "playground_activity": "In the playground section, create an interactive activity related to \"How Vibe Coding Is Different from Traditional Coding\". This could be a drag-and-drop exercise, a simple simulation, or a guided exploration that helps reinforce the lesson''s main concepts. The activity should feel safe and encourage experimentation without fear of making mistakes.",
          "reflection_question": "How does the concept of \"How Vibe Coding Is Different from Traditional Coding\" change the way you think about creating digital products? Can you think of an example from your own experience where this approach might have been helpful?",
          "quiz": {
            "questions": [
              "What is the main focus of How Vibe Coding Is Different from Traditional Coding?",
              "How does this concept benefit beginners?",
              "Is this concept part of Vibe Coding''s core principles?",
              "What is one practical application of this concept?",
              "How does this concept build confidence in learners?"
            ],
            "answers": [
              "The specific concept covered in this lesson",
              "It reduces anxiety and makes learning accessible",
              "Yes, it''s a core principle of Vibe Coding",
              "Applying this concept in digital creation projects",
              "By focusing on ideas and providing guidance rather than complexity"
            ]
          },
          "resources": {
            "video": {
              "title": "Understanding How Vibe Coding Is Different from Traditional Coding - Vibe Coding Fundamentals",
              "creator": "Vibe Coding Tutorials",
              "embed": true,
              "reason": "Relevant video content for this lesson topic"
            },
            "extra_reading": [
              "https://example.com/extra-resource-1 - Additional reading for this topic",
              "https://example.com/extra-resource-2 - More resources for curious learners"
            ]
          },
          "summary": "In this lesson on \"How Vibe Coding Is Different from Traditional Coding\", you''ve learned an important concept in Vibe Coding. You now understand how this fits into the bigger picture of creating digital products with confidence. You''re building a strong foundation for your journey in Vibe Coding."
        }');
    END IF;
    
    -- Add lessons for Thinking Before Coding module
    SELECT id INTO module_id_var FROM modules WHERE course_id = course_id_var AND title = 'Thinking Before Coding' LIMIT 1;
    
    -- Add lesson 1 for Thinking Before Coding
    SELECT COUNT(*) INTO lesson_count FROM lessons WHERE module_id = module_id_var AND lesson_number = 1 AND title = 'Learning to Think in Ideas, Not Code';
    IF lesson_count = 0 THEN
        INSERT INTO lessons (module_id, lesson_number, title, lesson_json) VALUES
        (module_id_var, 1, 'Learning to Think in Ideas, Not Code', '{
          "course_title": "Vibe Coding",
          "module_title": "Thinking Before Coding",
          "lesson_number": 1,
          "lesson_title": "Learning to Think in Ideas, Not Code",
          "introduction": "Welcome to \"Learning to Think in Ideas, Not Code\" in the Vibe Coding course! In this lesson, we''ll explore this important concept in a beginner-friendly way. Remember, there''s no need to feel anxious - we''ll take this step by step with plenty of guidance and support.",
          "big_idea": "In Vibe Coding, you learn to think about what you want to create first, then use tools and guidance to make it happen. This approach builds confidence and helps you understand the purpose behind your digital creations.",
          "visuals": "Show a lightbulb icon transforming into a simple digital product (like a website or app icon) with a thinking person in the background. Include a flow arrow from the lightbulb to the digital product.",
          "steps": [
            "Step 1: Understand the main concept of this lesson",
            "Step 2: Learn how this concept applies to Vibe Coding",
            "Step 3: See practical examples of this concept in action",
            "Step 4: Practice applying this concept in the playground",
            "Step 5: Reflect on how this fits into your learning journey"
          ],
          "example": "Instead of thinking ''I need to create a for loop to iterate through an array'', in Vibe Coding you think ''I want to show a list of items on my webpage''. The tools and guidance help translate your idea into the necessary code.",
          "playground_activity": "In the playground section, create an interactive activity related to \"Learning to Think in Ideas, Not Code\". This could be a drag-and-drop exercise, a simple simulation, or a guided exploration that helps reinforce the lesson''s main concepts. The activity should feel safe and encourage experimentation without fear of making mistakes.",
          "reflection_question": "How does the concept of \"Learning to Think in Ideas, Not Code\" change the way you think about creating digital products? Can you think of an example from your own experience where this approach might have been helpful?",
          "quiz": {
            "questions": [
              "What is the main focus of Learning to Think in Ideas, Not Code?",
              "How does this concept benefit beginners?",
              "Is this concept part of Vibe Coding''s core principles?",
              "What is one practical application of this concept?",
              "How does this concept build confidence in learners?"
            ],
            "answers": [
              "The specific concept covered in this lesson",
              "It reduces anxiety and makes learning accessible",
              "Yes, it''s a core principle of Vibe Coding",
              "Applying this concept in digital creation projects",
              "By focusing on ideas and providing guidance rather than complexity"
            ]
          },
          "resources": {
            "video": {
              "title": "Understanding Learning to Think in Ideas, Not Code - Vibe Coding Fundamentals",
              "creator": "Vibe Coding Tutorials",
              "embed": true,
              "reason": "Relevant video content for this lesson topic"
            },
            "extra_reading": [
              "https://example.com/extra-resource-1 - Additional reading for this topic",
              "https://example.com/extra-resource-2 - More resources for curious learners"
            ]
          },
          "summary": "In this lesson on \"Learning to Think in Ideas, Not Code\", you''ve learned an important concept in Vibe Coding. You now understand how this fits into the bigger picture of creating digital products with confidence. You''re building a strong foundation for your journey in Vibe Coding."
        }');
    END IF;
    
    -- Add lesson 2 for Thinking Before Coding
    SELECT COUNT(*) INTO lesson_count FROM lessons WHERE module_id = module_id_var AND lesson_number = 2 AND title = 'Turning Simple Ideas into Digital Instructions';
    IF lesson_count = 0 THEN
        INSERT INTO lessons (module_id, lesson_number, title, lesson_json) VALUES
        (module_id_var, 2, 'Turning Simple Ideas into Digital Instructions', '{
          "course_title": "Vibe Coding",
          "module_title": "Thinking Before Coding",
          "lesson_number": 2,
          "lesson_title": "Turning Simple Ideas into Digital Instructions",
          "introduction": "Welcome to \"Turning Simple Ideas into Digital Instructions\" in the Vibe Coding course! In this lesson, we''ll explore this important concept in a beginner-friendly way. Remember, there''s no need to feel anxious - we''ll take this step by step with plenty of guidance and support.",
          "big_idea": "Vibe Coding teaches you to break down your ideas into simple steps that can be translated into digital form. This process helps you see how your creative ideas can become real digital products.",
          "visuals": "Create a flowchart showing an idea (like a drawing of a simple app concept) flowing through several simple steps to become a digital product. Use friendly icons and clear arrows to show the transformation process.",
          "steps": [
            "Step 1: Start with a clear, simple idea",
            "Step 2: Break the idea into smaller components",
            "Step 3: Identify what each component should do",
            "Step 4: Use tools and guidance to implement each component",
            "Step 5: Combine components to create your digital product"
          ],
          "example": "If your idea is ''I want a simple app to track my daily water intake'', you might break it down into: 1) A way to add water amounts, 2) A display showing total intake, 3) A way to reset daily. Each of these components can be created with simple tools and guidance.",
          "playground_activity": "In the playground section, provide a simple idea generator tool where students can input their own simple ideas and see them broken down into basic components. This helps practice the skill of decomposing ideas into implementable parts.",
          "reflection_question": "Think of a simple idea you have for a digital product. How might you break it down into smaller, manageable components using the approach you learned in this lesson?",
          "quiz": {
            "questions": [
              "What is the main focus of Turning Simple Ideas into Digital Instructions?",
              "How does this concept benefit beginners?",
              "Is this concept part of Vibe Coding''s core principles?",
              "What is one practical application of this concept?",
              "How does this concept build confidence in learners?"
            ],
            "answers": [
              "The specific concept covered in this lesson",
              "It reduces complexity and makes creation achievable",
              "Yes, it''s a core principle of Vibe Coding",
              "Breaking complex projects into manageable components",
              "By making large projects feel achievable through small steps"
            ]
          },
          "resources": {
            "video": {
              "title": "Understanding Turning Simple Ideas into Digital Instructions - Vibe Coding Fundamentals",
              "creator": "Vibe Coding Tutorials",
              "embed": true,
              "reason": "Relevant video content for this lesson topic"
            },
            "extra_reading": [
              "https://example.com/extra-resource-1 - Additional reading for this topic",
              "https://example.com/extra-resource-2 - More resources for curious learners"
            ]
          },
          "summary": "In this lesson on \"Turning Simple Ideas into Digital Instructions\", you''ve learned an important concept in Vibe Coding. You now understand how to break down your ideas into implementable components. You''re developing the skills to turn your creative concepts into reality."
        }');
    END IF;
    
    -- Add lesson 3 for Thinking Before Coding
    SELECT COUNT(*) INTO lesson_count FROM lessons WHERE module_id = module_id_var AND lesson_number = 3 AND title = 'Understanding Intent in Vibe Coding';
    IF lesson_count = 0 THEN
        INSERT INTO lessons (module_id, lesson_number, title, lesson_json) VALUES
        (module_id_var, 3, 'Understanding Intent in Vibe Coding', '{
          "course_title": "Vibe Coding",
          "module_title": "Thinking Before Coding",
          "lesson_number": 3,
          "lesson_title": "Understanding Intent in Vibe Coding",
          "introduction": "Welcome to \"Understanding Intent in Vibe Coding\" in the Vibe Coding course! In this lesson, we''ll explore this important concept in a beginner-friendly way. Remember, there''s no need to feel anxious - we''ll take this step by step with plenty of guidance and support.",
          "big_idea": "Intent is the ''why'' behind your digital creation. In Vibe Coding, understanding your intent helps you make better decisions about your project and communicate more effectively with AI tools.",
          "visuals": "Create a visual showing a person with a clear goal (like ''I want to connect with friends'') and how this intent guides the creation of a digital solution. Include a compass or roadmap metaphor to represent how intent provides direction.",
          "steps": [
            "Step 1: Define the purpose of your digital creation",
            "Step 2: Identify the problem you''re trying to solve",
            "Step 3: Consider who will use your creation",
            "Step 4: Keep your intent in mind as you build",
            "Step 5: Evaluate your progress against your original intent"
          ],
          "example": "If your intent is ''to help people find local volunteer opportunities'', every feature you create should serve this purpose. This intent guides your decisions about what to include and what to leave out.",
          "playground_activity": "In the playground section, create an intent clarification tool where students can input their project goals and receive feedback on how to refine and clarify their intentions. This helps practice articulating the purpose behind their creations.",
          "reflection_question": "Think about a digital product you use regularly. What do you think was the original intent behind it? How does that intent influence its features and design?",
          "quiz": {
            "questions": [
              "What is the main focus of Understanding Intent in Vibe Coding?",
              "How does this concept benefit beginners?",
              "Is this concept part of Vibe Coding''s core principles?",
              "What is one practical application of this concept?",
              "How does this concept build confidence in learners?"
            ],
            "answers": [
              "The specific concept covered in this lesson",
              "It provides clear direction and purpose for projects",
              "Yes, it''s a core principle of Vibe Coding",
              "Creating focused, purposeful digital products",
              "By giving projects clear direction and meaning"
            ]
          },
          "resources": {
            "video": {
              "title": "Understanding Understanding Intent in Vibe Coding - Vibe Coding Fundamentals",
              "creator": "Vibe Coding Tutorials",
              "embed": true,
              "reason": "Relevant video content for this lesson topic"
            },
            "extra_reading": [
              "https://example.com/extra-resource-1 - Additional reading for this topic",
              "https://example.com/extra-resource-2 - More resources for curious learners"
            ]
          },
          "summary": "In this lesson on \"Understanding Intent in Vibe Coding\", you''ve learned an important concept in Vibe Coding. You now understand how your intent guides your digital creation process. You''re building the foundation for purposeful and meaningful digital creation."
        }');
    END IF;
    
    -- Add lessons for Working with AI as a Creative Partner module
    SELECT id INTO module_id_var FROM modules WHERE course_id = course_id_var AND title = 'Working with AI as a Creative Partner' LIMIT 1;
    
    -- Add lesson 1 for Working with AI as a Creative Partner
    SELECT COUNT(*) INTO lesson_count FROM lessons WHERE module_id = module_id_var AND lesson_number = 1 AND title = 'What AI Really Is (In Simple Terms)';
    IF lesson_count = 0 THEN
        INSERT INTO lessons (module_id, lesson_number, title, lesson_json) VALUES
        (module_id_var, 1, 'What AI Really Is (In Simple Terms)', '{
          "course_title": "Vibe Coding",
          "module_title": "Working with AI as a Creative Partner",
          "lesson_number": 1,
          "lesson_title": "What AI Really Is (In Simple Terms)",
          "introduction": "Welcome to \"What AI Really Is (In Simple Terms)\" in the Vibe Coding course! In this lesson, we''ll explore this important concept in a beginner-friendly way. Remember, there''s no need to feel anxious - we''ll take this step by step with plenty of guidance and support.",
          "big_idea": "AI (Artificial Intelligence) is like a very helpful assistant that can process information and help you with tasks. In Vibe Coding, AI serves as a tool to help you create digital products more efficiently.",
          "visuals": "Create a friendly visual showing AI as a helpful assistant working alongside a person. Show the AI processing information and providing helpful suggestions. Use approachable imagery that doesn''t seem intimidating.",
          "steps": [
            "Step 1: Understand that AI is a tool, not a replacement for creativity",
            "Step 2: Learn that AI processes information based on patterns",
            "Step 3: Recognize AI as a helpful assistant for your projects",
            "Step 4: See how AI can assist with technical tasks",
            "Step 5: Appreciate AI''s role as a creative partner"
          ],
          "example": "Think of AI like a very fast research assistant who has read millions of books and can quickly find information or suggest approaches. It doesn''t have human intuition or creativity, but it can help with technical tasks and provide suggestions based on patterns it has learned.",
          "playground_activity": "In the playground section, create a simple AI demonstration where students can see how AI processes simple requests and provides helpful responses. This demystifies AI and shows it as a helpful tool rather than something intimidating.",
          "reflection_question": "How might thinking of AI as a helpful assistant rather than something scary change the way you approach using AI tools in your projects?",
          "quiz": {
            "questions": [
              "What is the main focus of What AI Really Is (In Simple Terms)?",
              "How does this concept benefit beginners?",
              "Is this concept part of Vibe Coding''s core principles?",
              "What is one practical application of this concept?",
              "How does this concept build confidence in learners?"
            ],
            "answers": [
              "The specific concept covered in this lesson",
              "It demystifies AI and makes it approachable",
              "Yes, it''s a core principle of Vibe Coding",
              "Using AI as a helpful tool in digital creation",
              "By removing fear and uncertainty about AI"
            ]
          },
          "resources": {
            "video": {
              "title": "Understanding What AI Really Is (In Simple Terms) - Vibe Coding Fundamentals",
              "creator": "Vibe Coding Tutorials",
              "embed": true,
              "reason": "Relevant video content for this lesson topic"
            },
            "extra_reading": [
              "https://example.com/extra-resource-1 - Additional reading for this topic",
              "https://example.com/extra-resource-2 - More resources for curious learners"
            ]
          },
          "summary": "In this lesson on \"What AI Really Is (In Simple Terms)\", you''ve learned an important concept in Vibe Coding. You now understand that AI is simply a helpful tool for your creative projects. You''re ready to see how AI can be a valuable partner in your digital creation journey."
        }');
    END IF;
END $$;