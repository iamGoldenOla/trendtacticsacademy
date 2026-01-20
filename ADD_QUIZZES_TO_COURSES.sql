-- ==========================================
-- ADD QUIZZES TO ALL VIBE CODING LESSONS
-- Comprehensive quiz questions for each lesson
-- ==========================================

-- This script adds quiz questions to all Vibe Coding 3.0 lessons
-- Each lesson gets 5 multiple-choice questions

-- Note: You need to run this in Supabase SQL Editor
-- Make sure you have a 'quizzes' table with columns:
-- - id (uuid, primary key)
-- - lesson_id (uuid, foreign key to lessons)
-- - question (text)
-- - options (jsonb) - array of answer options
-- - correct_answer (text)
-- - explanation (text, optional)
-- - created_at (timestamp)

-- Example structure for one quiz:
-- INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation)
-- VALUES (
--   'lesson-uuid-here',
--   'What is Vibe Coding?',
--   '["Option A", "Option B", "Option C", "Option D"]'::jsonb,
--   'Option A',
--   'Explanation of why this is correct'
-- );

-- ==========================================
-- IMPORTANT: First, check if quizzes table exists
-- ==========================================

-- Run this query first to check:
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name = 'quizzes';

-- If the table doesn't exist, create it:
CREATE TABLE IF NOT EXISTS quizzes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lesson_id UUID REFERENCES lessons(id) ON DELETE CASCADE,
    question TEXT NOT NULL,
    options JSONB NOT NULL,
    correct_answer TEXT NOT NULL,
    explanation TEXT,
    ordering INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_quizzes_lesson_id ON quizzes(lesson_id);

-- ==========================================
-- SAMPLE QUIZZES FOR VIBE CODING LESSONS
-- ==========================================
-- You'll need to replace 'LESSON_ID_HERE' with actual lesson IDs from your database

-- Example for Module 1, Lesson 1: "What is Vibe Coding?"
-- First, get the lesson ID:
-- SELECT id, title FROM lessons WHERE title LIKE '%What is Vibe Coding%';

-- Then insert quizzes (replace the UUID with actual lesson ID):
/*
INSERT INTO quizzes (lesson_id, question, options, correct_answer, explanation, ordering) VALUES
('LESSON_ID_HERE', 'What is the main philosophy of Vibe Coding?', 
 '["Writing code manually", "Using AI to build software through natural language", "Traditional programming only", "Avoiding AI tools"]'::jsonb,
 'Using AI to build software through natural language',
 'Vibe Coding is about leveraging AI to build software by describing what you want in natural language.',
 1),
 
('LESSON_ID_HERE', 'Which tool is commonly used for Vibe Coding?',
 '["Notepad", "Cursor IDE", "Microsoft Word", "Excel"]'::jsonb,
 'Cursor IDE',
 'Cursor is an AI-powered IDE specifically designed for Vibe Coding workflows.',
 2),
 
('LESSON_ID_HERE', 'What is the key difference between traditional coding and Vibe Coding?',
 '["Vibe Coding uses only Python", "Vibe Coding relies on AI assistance", "Traditional coding is faster", "There is no difference"]'::jsonb,
 'Vibe Coding relies on AI assistance',
 'Vibe Coding leverages AI to accelerate development, while traditional coding is purely manual.',
 3),
 
('LESSON_ID_HERE', 'What skill is most important in Vibe Coding?',
 '["Memorizing syntax", "Writing clear prompts", "Typing speed", "Using shortcuts"]'::jsonb,
 'Writing clear prompts',
 'The ability to communicate clearly with AI through well-crafted prompts is essential in Vibe Coding.',
 4),
 
('LESSON_ID_HERE', 'Can Vibe Coding completely replace traditional programming?',
 '["Yes, always", "No, it complements traditional skills", "Only for web development", "Only for beginners"]'::jsonb,
 'No, it complements traditional skills',
 'Vibe Coding is a powerful tool that works best when combined with traditional programming knowledge.',
 5);
*/

-- ==========================================
-- INSTRUCTIONS TO ADD QUIZZES TO YOUR COURSES
-- ==========================================

-- Step 1: Get all lesson IDs for Vibe Coding course
SELECT l.id, l.title, m.title as module_title
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title LIKE '%Vibe Coding%'
ORDER BY m.ordering, l.ordering;

-- Step 2: For each lesson, create 5 quiz questions using the INSERT pattern above
-- Step 3: Verify quizzes were added:
SELECT 
    c.title as course,
    m.title as module,
    l.title as lesson,
    COUNT(q.id) as quiz_count
FROM courses c
JOIN modules m ON m.course_id = c.id
JOIN lessons l ON l.module_id = m.id
LEFT JOIN quizzes q ON q.lesson_id = l.id
WHERE c.title LIKE '%Vibe Coding%'
GROUP BY c.title, m.title, l.title, m.ordering, l.ordering
ORDER BY m.ordering, l.ordering;

-- ==========================================
-- NOTES
-- ==========================================
-- 1. This is a template - you need to fill in actual lesson IDs
-- 2. Create 5 questions per lesson for consistency
-- 3. Make questions relevant to lesson content
-- 4. Provide clear explanations for correct answers
-- 5. Use the ordering field to control question sequence
