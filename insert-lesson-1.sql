-- Insert Lesson 1 for Vibe Coding Course
-- Simple version without ON CONFLICT
-- Run this in your Supabase SQL Editor

INSERT INTO lessons (
    id,
    module_id,
    title,
    order_index,
    content,
    lesson_json
) 
SELECT 
    gen_random_uuid(),
    m.id,
    'What Is Vibe Coding?',
    1,
    'Introduction to Vibe Coding - focusing on ideas and creativity over syntax.',
    '{
      "course_title": "Vibe Coding",
      "module_title": "Understanding Vibe Coding",
      "lesson_number": 1,
      "lesson_title": "What Is Vibe Coding?",
      "introduction": "Welcome to your first lesson in Vibe Coding. You are about to discover a completely new way of creating digital things—one that focuses on your ideas and creativity, not on memorizing complicated rules. Think of this as learning to express yourself through technology, the same way you might express yourself through drawing or writing.",
      "big_idea": "Vibe Coding is about creating digital products by focusing on what you want to make and why you want to make it, rather than worrying about technical details. It is like having a conversation with a helpful friend who knows how to build things—you describe your vision, and together you bring it to life.",
      "visuals": "Imagine three circles: The first circle shows a lightbulb labeled Your Idea. The second circle shows two hands shaking, labeled You + AI Partner. The third circle shows a completed project, labeled Your Creation. Arrows connect them in order, showing the flow from idea to creation with AI as your partner.",
      "steps": [
        "Start with a clear idea of what you want to create. It does not have to be perfect—just a simple thought like I want to make a website that helps people find recipes.",
        "Describe your idea in plain, everyday language. Pretend you are explaining it to a friend who will help you build it.",
        "Work with AI tools that understand your description and help turn it into reality. The AI acts like a skilled assistant who knows the technical stuff.",
        "Review what gets created, make adjustments, and keep refining until it matches your vision.",
        "Celebrate your creation. You have just built something digital without needing to memorize complex code."
      ],
      "example": "Let us say you want to create a simple to-do list app. In traditional coding, you would need to learn programming languages, understand databases, and write hundreds of lines of code. With Vibe Coding, you would simply describe: I want an app where I can add tasks, check them off when done, and see my progress. An AI partner helps translate that into a working app, asking you questions along the way to make sure it matches your vision.",
      "playground_activity": "Think of something simple you would like to create—maybe a personal website, a quiz, or a tool to organize your thoughts. Write down in 2-3 sentences what it would do and who it would help. Do not worry about how it would work technically. Just focus on the idea and the purpose.",
      "reflection_question": "What is one thing you have always wanted to create digitally but felt it was too complicated? How does knowing about Vibe Coding change how you feel about that idea?",
      "quiz": {
        "questions": [
          "What is the main focus of Vibe Coding?",
          "In Vibe Coding, what role does AI play?",
          "True or False: Vibe Coding requires you to memorize programming syntax.",
          "What should you start with when using Vibe Coding?",
          "How is Vibe Coding different from traditional coding?"
        ],
        "answers": [
          "Vibe Coding focuses on your ideas and intentions, not on memorizing technical rules or syntax.",
          "AI acts as a creative partner and helpful assistant that understands your descriptions and helps turn them into working digital products.",
          "False. Vibe Coding is specifically designed so you do not need to memorize syntax—you describe what you want in plain language.",
          "You should start with a clear idea of what you want to create and why, even if it is simple.",
          "Traditional coding requires learning programming languages and syntax. Vibe Coding focuses on expressing ideas clearly and working with AI to handle the technical implementation."
        ]
      },
      "resources": {
        "video": {
          "title": "What is AI and How Does it Work? (Simple Explanation)",
          "creator": "CrashCourse",
          "url": "https://www.youtube.com/watch?v=mJeNghZXtMo",
          "embed": true,
          "reason": "This video provides a beginner-friendly explanation of AI, which is central to understanding Vibe Coding."
        },
        "extra_reading": [
          {
            "title": "The Future of Coding: Natural Language Programming",
            "url": "https://stackoverflow.blog/2023/01/09/beyond-git-the-other-version-control-systems-developers-use/",
            "description": "Optional reading about how coding is evolving to be more accessible."
          }
        ]
      },
      "summary": "Vibe Coding is a beginner-friendly approach to creating digital products. Instead of memorizing code, you focus on your ideas and work with AI as a creative partner. You describe what you want in plain language, and the AI helps turn it into reality. This approach emphasizes understanding concepts, building confidence, and exploring possibilities without fear of making mistakes. In the next lesson, you will learn why Vibe Coding exists and how it is helping more people become creators."
    }'::jsonb
FROM modules m
WHERE m.course_id = 'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d'
AND m.title = 'Understanding Vibe Coding';

-- Verify it was inserted
SELECT l.id, l.title, m.title as module_title
FROM lessons l
JOIN modules m ON l.module_id = m.id
WHERE l.title = 'What Is Vibe Coding?';
