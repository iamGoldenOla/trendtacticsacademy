-- FIX KNOWLEDGE ASSESSMENT QUIZ COUNT
-- Remove duplicate quiz if exists (should be 36, not 37)

DO $$
DECLARE
    foundation_id UUID;
    knowledge_lesson_id UUID;
    quiz_count INT;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    
    -- Get knowledge assessment lesson
    SELECT id INTO knowledge_lesson_id FROM lessons
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 10)
    AND title = 'Course Knowledge Assessment';
    
    -- Count quizzes
    SELECT COUNT(*) INTO quiz_count FROM quiz_questions WHERE lesson_id = knowledge_lesson_id;
    
    RAISE NOTICE 'Knowledge Assessment currently has % quizzes', quiz_count;
    
    -- If more than 36, remove duplicates
    IF quiz_count > 36 THEN
        DELETE FROM quiz_questions 
        WHERE id IN (
            SELECT id FROM quiz_questions 
            WHERE lesson_id = knowledge_lesson_id
            ORDER BY id DESC
            LIMIT (quiz_count - 36)
        );
        RAISE NOTICE 'Removed % duplicate quiz(zes)', (quiz_count - 36);
    END IF;
    
    -- Verify final count
    SELECT COUNT(*) INTO quiz_count FROM quiz_questions WHERE lesson_id = knowledge_lesson_id;
    RAISE NOTICE 'Knowledge Assessment now has % quizzes', quiz_count;
    
END $$;
