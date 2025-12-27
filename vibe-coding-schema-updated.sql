-- Supabase Schema for Vibe Coding Course (Idempotent Version)
-- This schema implements the required data model for the self-driving learning system
-- Uses IF NOT EXISTS to prevent errors when tables already exist

-- Create courses table if it doesn't exist
CREATE TABLE IF NOT EXISTS courses (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create modules table if it doesn't exist
CREATE TABLE IF NOT EXISTS modules (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    order_index INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create lessons table if it doesn't exist
CREATE TABLE IF NOT EXISTS lessons (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    module_id UUID REFERENCES modules(id) ON DELETE CASCADE,
    lesson_number INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    lesson_json JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create student_progress table if it doesn't exist
CREATE TABLE IF NOT EXISTS student_progress (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    student_id UUID NOT NULL,
    lesson_id UUID REFERENCES lessons(id) ON DELETE CASCADE,
    completed BOOLEAN DEFAULT FALSE,
    unlocked_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for performance if they don't exist
CREATE INDEX IF NOT EXISTS idx_modules_course_id ON modules(course_id);
CREATE INDEX IF NOT EXISTS idx_lessons_module_id ON lessons(module_id);
CREATE INDEX IF NOT EXISTS idx_lessons_lesson_number ON lessons(module_id, lesson_number);
CREATE INDEX IF NOT EXISTS idx_student_progress_student_id ON student_progress(student_id);
CREATE INDEX IF NOT EXISTS idx_student_progress_lesson_id ON student_progress(lesson_id);

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

-- Insert the generated lessons if they don't already exist
DO $$
DECLARE
    course_id_var UUID;
    module_id_var UUID;
    lesson_count INTEGER;
BEGIN
    SELECT id INTO course_id_var FROM courses WHERE title = 'Vibe Coding' LIMIT 1;
    
    -- Insert Understanding Vibe Coding module lessons if they don't exist
    SELECT id INTO module_id_var FROM modules WHERE course_id = course_id_var AND title = 'Understanding Vibe Coding' LIMIT 1;
    
    -- Check if lessons already exist for this module
    SELECT COUNT(*) INTO lesson_count FROM lessons WHERE module_id = module_id_var;
    
    IF lesson_count = 0 THEN
        INSERT INTO lessons (module_id, lesson_number, title, lesson_json) VALUES
        (module_id_var, 1, 'What Is Vibe Coding?', '{
          "course_title": "Vibe Coding",
          "module_title": "Understanding Vibe Coding",
          "lesson_number": 1,
          "lesson_title": "What Is Vibe Coding?",
          "introduction": "Welcome to your first lesson in Vibe Coding! Don\'t worry if you\'ve never coded before - this is completely normal. In this lesson, we\'ll explore what Vibe Coding is and why it\'s different from traditional approaches. By the end of this lesson, you\'ll have a clear understanding of what makes Vibe Coding special and why it\'s perfect for beginners.",
          "big_idea": "Vibe Coding is a beginner-friendly way of creating digital products by focusing on ideas, intention, creativity, and guidance — often with the help of AI — instead of memorizing syntax or complex technical rules. It\'s about understanding concepts first, then building with confidence.",
          "visuals": "Create a large, friendly card with a light blue background showing a person having an idea (lightbulb icon) next to a computer screen with simple, colorful shapes being created. Include a connecting arrow showing the idea flowing into the digital creation. Add a smaller card below with two columns: one labeled \'Traditional Coding\' (showing complex code symbols and a stressed face) and another labeled \'Vibe Coding\' (showing simple icons and a smiling face).",
          "steps": [
            "Step 1: Understand that coding is simply a way to tell computers what to do",
            "Step 2: Recognize that Vibe Coding focuses on ideas before technical details",
            "Step 3: Learn that Vibe Coding uses AI and guidance to make creation easier",
            "Step 4: See that Vibe Coding avoids complex syntax and technical rules initially",
            "Step 5: Appreciate that Vibe Coding builds confidence before complexity"
          ],
          "example": "Think of Vibe Coding like cooking with a recipe app that guides you step by step. Instead of memorizing all the cooking techniques first, the app tells you exactly what to do at each moment. Similarly, Vibe Coding uses AI and guidance to help you create digital products without needing to memorize all the technical rules upfront.",
          "playground_activity": "In the playground section, create a simple drag-and-drop activity where students can move idea cards (like \'I want a website to show my photos\' or \'I need an app to track my tasks\') to a \'Digital Creation\' box. As they move each idea, a simple visual representation appears showing how that idea could become a real digital product. No code required - just visual representation of the connection between ideas and digital creation.",
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
              "Yes, it\'s specifically designed for beginners",
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
          "summary": "In this lesson, you learned that Vibe Coding is a beginner-friendly approach that focuses on ideas and creativity before technical details. You now understand that Vibe Coding uses AI and guidance to make digital creation accessible, and that it builds confidence before complexity. You\'re ready to continue exploring how Vibe Coding works in the next lesson."
        }'),
        (module_id_var, 2, 'Why Vibe Coding Exists', '{
          "course_title": "Vibe Coding",
          "module_title": "Understanding Vibe Coding",
          "lesson_number": 2,
          "lesson_title": "Why Vibe Coding Exists",
          "introduction": "Welcome to \"Why Vibe Coding Exists\" in the Vibe Coding course! In this lesson, we\'ll explore this important concept in a beginner-friendly way. Remember, there\'s no need to feel anxious - we\'ll take this step by step with plenty of guidance and support.",
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
          "playground_activity": "In the playground section, create an interactive activity related to \"Why Vibe Coding Exists\". This could be a drag-and-drop exercise, a simple simulation, or a guided exploration that helps reinforce the lesson\'s main concepts. The activity should feel safe and encourage experimentation without fear of making mistakes.",
          "reflection_question": "How does the concept of \"Why Vibe Coding Exists\" change the way you think about creating digital products? Can you think of an example from your own experience where this approach might have been helpful?",
          "quiz": {
            "questions": [
              "What is the main focus of Why Vibe Coding Exists?",
              "How does this concept benefit beginners?",
              "Is this concept part of Vibe Coding\'s core principles?",
              "What is one practical application of this concept?",
              "How does this concept build confidence in learners?"
            ],
            "answers": [
              "The specific concept covered in this lesson",
              "It reduces anxiety and makes learning accessible",
              "Yes, it\'s a core principle of Vibe Coding",
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
          "summary": "In this lesson on \"Why Vibe Coding Exists\", you\'ve learned an important concept in Vibe Coding. You now understand how this fits into the bigger picture of creating digital products with confidence. You\'re building a strong foundation for your journey in Vibe Coding."
        }'),
        (module_id_var, 3, 'How Vibe Coding Is Different from Traditional Coding', '{
          "course_title": "Vibe Coding",
          "module_title": "Understanding Vibe Coding",
          "lesson_number": 3,
          "lesson_title": "How Vibe Coding Is Different from Traditional Coding",
          "introduction": "Welcome to \"How Vibe Coding Is Different from Traditional Coding\" in the Vibe Coding course! In this lesson, we\'ll explore this important concept in a beginner-friendly way. Remember, there\'s no need to feel anxious - we\'ll take this step by step with plenty of guidance and support.",
          "big_idea": "Traditional coding starts with technical details and syntax, which can be intimidating for beginners. Vibe Coding starts with your ideas and intentions, using AI and guidance to help you create without getting bogged down in technical complexity.",
          "visuals": "Design a split-screen visual showing \'Traditional Approach\' (left side: complex code, frustrated learner) versus \'Vibe Approach\' (right side: idea-focused creation, happy learner). Include arrows showing the learning journey in each approach.",
          "steps": [
            "Step 1: Understand the main concept of this lesson",
            "Step 2: Learn how this concept applies to Vibe Coding",
            "Step 3: See practical examples of this concept in action",
            "Step 4: Practice applying this concept in the playground",
            "Step 5: Reflect on how this fits into your learning journey"
          ],
          "example": "Traditional coding is like learning to cook by memorizing the chemical composition of every ingredient before making a sandwich. Vibe Coding is like learning to cook by starting with simple recipes that produce satisfying results, with understanding of the chemistry coming naturally through experience.",
          "playground_activity": "In the playground section, create an interactive activity related to \"How Vibe Coding Is Different from Traditional Coding\". This could be a drag-and-drop exercise, a simple simulation, or a guided exploration that helps reinforce the lesson\'s main concepts. The activity should feel safe and encourage experimentation without fear of making mistakes.",
          "reflection_question": "How does the concept of \"How Vibe Coding Is Different from Traditional Coding\" change the way you think about creating digital products? Can you think of an example from your own experience where this approach might have been helpful?",
          "quiz": {
            "questions": [
              "What is the main focus of How Vibe Coding Is Different from Traditional Coding?",
              "How does this concept benefit beginners?",
              "Is this concept part of Vibe Coding\'s core principles?",
              "What is one practical application of this concept?",
              "How does this concept build confidence in learners?"
            ],
            "answers": [
              "The specific concept covered in this lesson",
              "It reduces anxiety and makes learning accessible",
              "Yes, it\'s a core principle of Vibe Coding",
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
          "summary": "In this lesson on \"How Vibe Coding Is Different from Traditional Coding\", you\'ve learned an important concept in Vibe Coding. You now understand how this fits into the bigger picture of creating digital products with confidence. You\'re building a strong foundation for your journey in Vibe Coding."
        }');
    END IF;
    
    -- Insert Thinking Before Coding module lessons if they don't exist
    SELECT id INTO module_id_var FROM modules WHERE course_id = course_id_var AND title = 'Thinking Before Coding' LIMIT 1;
    
    -- Check if lessons already exist for this module
    SELECT COUNT(*) INTO lesson_count FROM lessons WHERE module_id = module_id_var AND module_id IN (
        SELECT id FROM modules WHERE title = 'Thinking Before Coding'
    );
    
    IF lesson_count = 0 THEN
        INSERT INTO lessons (module_id, lesson_number, title, lesson_json) VALUES
        (module_id_var, 1, 'Learning to Think in Ideas, Not Code', '{
          "course_title": "Vibe Coding",
          "module_title": "Thinking Before Coding",
          "lesson_number": 1,
          "lesson_title": "Learning to Think in Ideas, Not Code",
          "introduction": "Welcome to \"Learning to Think in Ideas, Not Code\" in the Vibe Coding course! In this lesson, we\'ll explore this important concept in a beginner-friendly way. Remember, there\'s no need to feel anxious - we\'ll take this step by step with plenty of guidance and support.",
          "big_idea": "In Vibe Coding, you learn to think about what you want to create first, then use tools and guidance to make it happen. This approach builds confidence and helps you understand the purpose behind your digital creations.",
          "visuals": "Show a lightbulb icon transforming into a simple digital product (like a website or app icon) with a thinking person in the background. Include a flow arrow from the lightbulb to the digital product.",
          "steps": [
            "Step 1: Understand the main concept of this lesson",
            "Step 2: Learn how this concept applies to Vibe Coding",
            "Step 3: See practical examples of this concept in action",
            "Step 4: Practice applying this concept in the playground",
            "Step 5: Reflect on how this fits into your learning journey"
          ],
          "example": "Instead of thinking \'I need to create a for loop to iterate through an array\', in Vibe Coding you think \'I want to show a list of items on my webpage\'. The tools and guidance help translate your idea into the necessary code.",
          "playground_activity": "In the playground section, create an interactive activity related to \"Learning to Think in Ideas, Not Code\". This could be a drag-and-drop exercise, a simple simulation, or a guided exploration that helps reinforce the lesson\'s main concepts. The activity should feel safe and encourage experimentation without fear of making mistakes.",
          "reflection_question": "How does the concept of \"Learning to Think in Ideas, Not Code\" change the way you think about creating digital products? Can you think of an example from your own experience where this approach might have been helpful?",
          "quiz": {
            "questions": [
              "What is the main focus of Learning to Think in Ideas, Not Code?",
              "How does this concept benefit beginners?",
              "Is this concept part of Vibe Coding\'s core principles?",
              "What is one practical application of this concept?",
              "How does this concept build confidence in learners?"
            ],
            "answers": [
              "The specific concept covered in this lesson",
              "It reduces anxiety and makes learning accessible",
              "Yes, it\'s a core principle of Vibe Coding",
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
          "summary": "In this lesson on \"Learning to Think in Ideas, Not Code\", you\'ve learned an important concept in Vibe Coding. You now understand how this fits into the bigger picture of creating digital products with confidence. You\'re building a strong foundation for your journey in Vibe Coding."
        }');
    END IF;
END $$;

-- Enable Row Level Security (RLS) for security if not already enabled
DO $$
BEGIN
  -- Check if RLS is already enabled on the tables, if not, enable it
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.table_constraints 
    WHERE constraint_name = 'courses_row_level_security_enabled'
  ) THEN
    ALTER TABLE courses ENABLE ROW LEVEL SECURITY;
    ALTER TABLE modules ENABLE ROW LEVEL SECURITY;
    ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;
    ALTER TABLE student_progress ENABLE ROW LEVEL SECURITY;
  END IF;
END $$;

-- Create policies for RLS if they don't exist
DO $$
BEGIN
  -- Check if policies exist before creating them
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'courses_select_policy') THEN
    CREATE POLICY "Courses are viewable by everyone" ON courses FOR SELECT USING (true);
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'modules_select_policy') THEN
    CREATE POLICY "Modules are viewable by everyone" ON modules FOR SELECT USING (true);
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'lessons_select_policy') THEN
    CREATE POLICY "Lessons are viewable by everyone" ON lessons FOR SELECT USING (true);
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'student_progress_select_policy') THEN
    CREATE POLICY "Students can view their own progress" ON student_progress FOR SELECT USING (auth.uid() = student_id);
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'student_progress_insert_policy') THEN
    CREATE POLICY "Students can insert their own progress" ON student_progress FOR INSERT WITH CHECK (auth.uid() = student_id);
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'student_progress_update_policy') THEN
    CREATE POLICY "Students can update their own progress" ON student_progress FOR UPDATE USING (auth.uid() = student_id);
  END IF;
END $$;

-- Grant necessary permissions if not already granted
DO $$
BEGIN
  -- Check if grants exist before granting them
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.role_table_grants 
    WHERE table_name = 'courses' AND privilege_type = 'SELECT' AND grantee = 'authenticated'
  ) THEN
    GRANT SELECT, INSERT, UPDATE, DELETE ON courses TO authenticated;
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.role_table_grants 
    WHERE table_name = 'modules' AND privilege_type = 'SELECT' AND grantee = 'authenticated'
  ) THEN
    GRANT SELECT, INSERT, UPDATE, DELETE ON modules TO authenticated;
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.role_table_grants 
    WHERE table_name = 'lessons' AND privilege_type = 'SELECT' AND grantee = 'authenticated'
  ) THEN
    GRANT SELECT, INSERT, UPDATE, DELETE ON lessons TO authenticated;
  END IF;
  
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.role_table_grants 
    WHERE table_name = 'student_progress' AND privilege_type = 'SELECT' AND grantee = 'authenticated'
  ) THEN
    GRANT SELECT, INSERT, UPDATE, DELETE ON student_progress TO authenticated;
  END IF;
END $$;