-- FIX LESSON 1: Update video URL and ensure quizzes work
-- New video: https://youtu.be/BZrio_G_1Cs

DO $$
DECLARE
    foundation_id UUID;
    mod1_id UUID;
    lesson1_id UUID;
BEGIN
    -- Get IDs
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod1_id FROM modules WHERE course_id = foundation_id AND ordering = 1;
    SELECT id INTO lesson1_id FROM lessons WHERE module_id = mod1_id AND ordering = 1;
    
    RAISE NOTICE 'Updating Lesson 1 video URL...';
    
    -- Update video URL to new YouTube link
    UPDATE lessons
    SET video_url = 'https://www.youtube.com/watch?v=BZrio_G_1Cs'
    WHERE id = lesson1_id;
    
    RAISE NOTICE 'Video URL updated successfully';
    
END $$;

-- Verify lesson and quizzes
SELECT 
    'Lesson Info' as type,
    l.title,
    l.video_url,
    LENGTH(l.content) as content_length,
    (SELECT COUNT(*) FROM quiz_questions WHERE lesson_id = l.id) as quiz_count
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation' AND m.ordering = 1 AND l.ordering = 1

UNION ALL

SELECT 
    'Quiz ' || ROW_NUMBER() OVER (ORDER BY q.id) as type,
    LEFT(q.question, 50) as title,
    q.correct_answer::text as video_url,
    NULL as content_length,
    NULL as quiz_count
FROM quiz_questions q
JOIN lessons l ON q.lesson_id = l.id
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation' AND m.ordering = 1 AND l.ordering = 1;
