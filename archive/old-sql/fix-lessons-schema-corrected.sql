-- Fix for Lessons Table Schema - Corrected Version
-- This script ensures the lessons table has the correct structure
-- Uses proper JSON escaping to avoid syntax errors

-- Check if lesson_number column exists, if not, add it
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'lesson_number'
  ) THEN
    ALTER TABLE lessons ADD COLUMN lesson_number INTEGER;
  END IF;
END $$;

-- Update the existing lessons table to map the order_index column to lesson_number if needed
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'order_index' AND column_name != 'lesson_number'
  ) AND NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'lesson_number'
  ) THEN
    ALTER TABLE lessons RENAME COLUMN order_index TO lesson_number;
  END IF;
END $$;

-- Ensure the lesson_json column exists
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'lessons' AND column_name = 'lesson_json'
  ) THEN
    ALTER TABLE lessons ADD COLUMN lesson_json JSONB;
  END IF;
END $$;

-- Insert the Vibe Coding course if it doesn't already exist
INSERT INTO courses (title, description) 
SELECT 'Vibe Coding', 'A beginner-friendly approach to creating digital products by focusing on ideas, intention, creativity, and guidance with AI assistance'
WHERE NOT EXISTS (SELECT 1 FROM courses WHERE title = 'Vibe Coding');

-- Insert modules for Vibe Coding course if they don't already exist
DO $$
DECLARE
    course_id_var UUID;
BEGIN
    SELECT id INTO course_id_var FROM courses WHERE title = 'Vibe Coding' LIMIT 1;
    
    -- Insert modules only if they don't already exist
    INSERT INTO modules (course_id, title, order_index) 
    SELECT course_id_var, 'Understanding Vibe Coding', 1
    WHERE NOT EXISTS (SELECT 1 FROM modules WHERE title = 'Understanding Vibe Coding');
    
    INSERT INTO modules (course_id, title, order_index) 
    SELECT course_id_var, 'Thinking Before Coding', 2
    WHERE NOT EXISTS (SELECT 1 FROM modules WHERE title = 'Thinking Before Coding');
    
    INSERT INTO modules (course_id, title, order_index) 
    SELECT course_id_var, 'Working with AI as a Creative Partner', 3
    WHERE NOT EXISTS (SELECT 1 FROM modules WHERE title = 'Working with AI as a Creative Partner');
    
    INSERT INTO modules (course_id, title, order_index) 
    SELECT course_id_var, 'Vibe Coding in Real Life', 4
    WHERE NOT EXISTS (SELECT 1 FROM modules WHERE title = 'Vibe Coding in Real Life');
    
    INSERT INTO modules (course_id, title, order_index) 
    SELECT course_id_var, 'Exploring and Building with Confidence', 5
    WHERE NOT EXISTS (SELECT 1 FROM modules WHERE title = 'Exploring and Building with Confidence');
END $$;

-- Insert the Vibe Coding lessons using proper JSON escaping
DO $$
DECLARE
    course_id_var UUID;
    module_id_var UUID;
    lesson_count INTEGER;
BEGIN
    SELECT id INTO course_id_var FROM courses WHERE title = 'Vibe Coding' LIMIT 1;
    
    -- Get the Understanding Vibe Coding module
    SELECT id INTO module_id_var FROM modules WHERE course_id = course_id_var AND title = 'Understanding Vibe Coding' LIMIT 1;
    
    -- Check if lessons already exist for this module
    SELECT COUNT(*) INTO lesson_count FROM lessons WHERE module_id = module_id_var AND title = 'What Is Vibe Coding?';
    
    -- Insert the lesson only if it doesn't exist
    IF lesson_count = 0 THEN
        INSERT INTO lessons (module_id, lesson_number, title, lesson_json) VALUES
        (module_id_var, 1, 'What Is Vibe Coding?', '{
          "course_title": "Vibe Coding",
          "module_title": "Understanding Vibe Coding",
          "lesson_number": 1,
          "lesson_title": "What Is Vibe Coding?",
          "introduction": "Welcome to your first lesson in Vibe Coding! Don''t worry if you''ve never coded before - this is completely normal. In this lesson, we''ll explore what Vibe Coding is and why it''s different from traditional approaches. By the end of this lesson, you''ll have a clear understanding of what makes Vibe Coding special and why it''s perfect for beginners.",
          "big_idea": "Vibe Coding is a beginner-friendly way of creating digital products by focusing on ideas, intention, creativity, and guidance — often with the help of AI — instead of memorizing syntax or complex technical rules. It''s about understanding concepts first, then building with confidence.",
          "visuals": "Create a large, friendly card with a light blue background showing a person having an idea (lightbulb icon) next to a computer screen with simple, colorful shapes being created. Include a connecting arrow showing the idea flowing into the digital creation. Add a smaller card below with two columns: one labeled ''Traditional Coding'' (showing complex code symbols and a stressed face) and another labeled ''Vibe Coding'' (showing simple icons and a smiling face).",
          "steps": [
            "Step 1: Understand that coding is simply a way to tell computers what to do",
            "Step 2: Recognize that Vibe Coding focuses on ideas before technical details",
            "Step 3: Learn that Vibe Coding uses AI and guidance to make creation easier",
            "Step 4: See that Vibe Coding avoids complex syntax and technical rules initially",
            "Step 5: Appreciate that Vibe Coding builds confidence before complexity"
          ],
          "example": "Think of Vibe Coding like cooking with a recipe app that guides you step by step. Instead of memorizing all the cooking techniques first, the app tells you exactly what to do at each moment. Similarly, Vibe Coding uses AI and guidance to help you create digital products without needing to memorize all the technical rules upfront.",
          "playground_activity": "In the playground section, create a simple drag-and-drop activity where students can move idea cards (like ''I want a website to show my photos'' or ''I need an app to track my tasks'') to a ''Digital Creation'' box. As they move each idea, a simple visual representation appears showing how that idea could become a real digital product. No code required - just visual representation of the connection between ideas and digital creation.",
          "reflection_question": "Think about a digital product you use every day (like a weather app, social media, or a game). How might someone have created this using Vibe Coding principles - focusing on the main idea first rather than complex technical details?",
          "quiz": {
            "questions": [
              "What does Vibe Coding focus on first?",
              "Is Vibe Coding designed for beginners?",
              "Does Vibe Coding emphasize memorizing syntax first?",
              "What does Vibe Coding use to make creation easier?",
              "What is the main goal of Vibe Coding?"
            ],
            "answers": [
              "Ideas, intention, creativity, and guidance",
              "Yes, it''s specifically designed for beginners",
              "No, it avoids complex syntax initially",
              "AI and guidance",
              "To make digital creation accessible and confidence-building for beginners"
            ]
          },
          "resources": {
            "video": {
              "title": "What is Creative Coding? (Beginner Friendly)",
              "creator": "CodeNewbie",
              "embed": true,
              "reason": "Simple explanation of creative approaches to coding that aligns with Vibe Coding principles"
            },
            "extra_reading": [
              "https://example.com/creative-coding-intro - Introduction to Creative Approaches to Programming",
              "https://example.com/beginner-programming-mindset - Building Confidence in Programming"
            ]
          },
          "summary": "In this lesson, you learned that Vibe Coding is a beginner-friendly approach that focuses on ideas and creativity before technical details. You now understand that Vibe Coding uses AI and guidance to make digital creation accessible, and that it builds confidence before complexity. You''re ready to continue exploring how Vibe Coding works in the next lesson."
        }');
    END IF;
    
    -- Check if the second lesson exists
    SELECT COUNT(*) INTO lesson_count FROM lessons WHERE module_id = module_id_var AND title = 'Why Vibe Coding Exists';
    
    -- Insert the second lesson only if it doesn't exist
    IF lesson_count = 0 THEN
        INSERT INTO lessons (module_id, lesson_number, title, lesson_json) VALUES
        (module_id_var, 2, 'Why Vibe Coding Exists', '{
          "course_title": "Vibe Coding",
          "module_title": "Understanding Vibe Coding",
          "lesson_number": 2,
          "lesson_title": "Why Vibe Coding Exists",
          "introduction": "Welcome to \"Why Vibe Coding Exists\" in the Vibe Coding course! In this lesson, we''ll explore this important concept in a beginner-friendly way. Remember, there''s no need to feel anxious - we''ll take this step by step with plenty of guidance and support.",
          "big_idea": "Vibe Coding exists because traditional coding approaches often overwhelm beginners with complex syntax and technical rules before they understand the core concepts. Vibe Coding flips this approach by focusing on ideas and creativity first, making digital creation accessible to everyone.",
          "visuals": "Create a comparison diagram showing two paths: one with a person looking overwhelmed by complex code symbols, and another with the same person smiling while creating with simple, intuitive tools. Include a bridge showing how Vibe Coding connects these experiences.",
          "steps": [
            "Step 1: Recognize the challenges beginners face with traditional coding",
            "Step 2: Understand how focusing on ideas first reduces anxiety",
            "Step 3: Learn about the benefits of guided learning approaches",
            "Step 4: See how Vibe Coding addresses these challenges",
            "Step 5: Appreciate the importance of confidence-building in learning"
          ],
          "example": "Think about learning to drive. Would you start by memorizing every technical detail about the engine, transmission, and electronics? No! You start with the basic goal of getting from point A to point B safely. Vibe Coding works the same way - it focuses on your goals and intentions first, then provides the tools to achieve them.",
          "playground_activity": "In the playground section, create an interactive activity related to \"Why Vibe Coding Exists\". This could be a drag-and-drop exercise, a simple simulation, or a guided exploration that helps reinforce the lesson''s main concepts. The activity should feel safe and encourage experimentation without fear of making mistakes.",
          "reflection_question": "How does the concept of \"Why Vibe Coding Exists\" change the way you think about creating digital products? Can you think of an example from your own experience where this approach might have been helpful?",
          "quiz": {
            "questions": [
              "What is the main focus of Why Vibe Coding Exists?",
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
              "title": "Understanding Why Vibe Coding Exists - Vibe Coding Fundamentals",
              "creator": "Vibe Coding Tutorials",
              "embed": true,
              "reason": "Relevant video content for this lesson topic"
            },
            "extra_reading": [
              "https://example.com/extra-resource-1 - Additional reading for this topic",
              "https://example.com/extra-resource-2 - More resources for curious learners"
            ]
          },
          "summary": "In this lesson on \"Why Vibe Coding Exists\", you''ve learned an important concept in Vibe Coding. You now understand how this fits into the bigger picture of creating digital products with confidence. You''re building a strong foundation for your journey in Vibe Coding."
        }');
    END IF;
END $$;