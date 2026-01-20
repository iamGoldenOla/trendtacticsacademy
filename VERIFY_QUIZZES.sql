-- VERIFY QUIZZES AND COURSE INTEGRITY
-- Diagnostic query to check all course data

DO $$
DECLARE
    foundation_id UUID;
    total_modules INT;
    total_lessons INT;
    total_quizzes INT;
    lessons_without_quizzes INT;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    
    -- Count modules
    SELECT COUNT(*) INTO total_modules FROM modules WHERE course_id = foundation_id;
    
    -- Count lessons
    SELECT COUNT(*) INTO total_lessons FROM lessons 
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id);
    
    -- Count quizzes
    SELECT COUNT(*) INTO total_quizzes FROM quiz_questions
    WHERE lesson_id IN (
        SELECT id FROM lessons 
        WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id)
    );
    
    -- Count lessons without quizzes
    SELECT COUNT(*) INTO lessons_without_quizzes FROM lessons
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id)
    AND id NOT IN (SELECT DISTINCT lesson_id FROM quiz_questions);
    
    RAISE NOTICE '======================';
    RAISE NOTICE 'COURSE INTEGRITY CHECK';
    RAISE NOTICE '======================';
    RAISE NOTICE 'Course: Facebook Ads Foundation';
    RAISE NOTICE 'Total Modules: %', total_modules;
    RAISE NOTICE 'Total Lessons: %', total_lessons;
    RAISE NOTICE 'Total Quizzes: %', total_quizzes;
    RAISE NOTICE 'Lessons WITHOUT Quizzes: %', lessons_without_quizzes;
    RAISE NOTICE '======================';
    
    -- Show lessons without quizzes
    IF lessons_without_quizzes > 0 THEN
        RAISE NOTICE 'Lessons missing quizzes:';
        FOR rec IN 
            SELECT l.id, l.title, m.title as module_title
            FROM lessons l
            JOIN modules m ON l.module_id = m.id
            WHERE m.course_id = foundation_id
            AND l.id NOT IN (SELECT DISTINCT lesson_id FROM quiz_questions)
            ORDER BY m.ordering, l.ordering
        LOOP
            RAISE NOTICE '  - % (Module: %)', rec.title, rec.module_title;
        END LOOP;
    END IF;
    
    -- Show quiz distribution
    RAISE NOTICE '======================';
    RAISE NOTICE 'QUIZ DISTRIBUTION BY MODULE:';
    FOR rec IN
        SELECT m.ordering, m.title, COUNT(qq.id) as quiz_count
        FROM modules m
        LEFT JOIN lessons l ON l.module_id = m.id
        LEFT JOIN quiz_questions qq ON qq.lesson_id = l.id
        WHERE m.course_id = foundation_id
        GROUP BY m.id, m.ordering, m.title
        ORDER BY m.ordering
    LOOP
        RAISE NOTICE 'Module %: % - % quizzes', rec.ordering, rec.title, rec.quiz_count;
    END LOOP;
    
END $$;

-- Also run a SELECT query to see sample data
SELECT 
    m.ordering as module_num,
    m.title as module_title,
    l.ordering as lesson_num,
    l.title as lesson_title,
    COUNT(qq.id) as quiz_count
FROM modules m
JOIN lessons l ON l.module_id = m.id
LEFT JOIN quiz_questions qq ON qq.lesson_id = l.id
WHERE m.course_id = (SELECT id FROM courses WHERE title = 'Facebook Ads Foundation')
GROUP BY m.id, m.ordering, m.title, l.id, l.ordering, l.title
ORDER BY m.ordering, l.ordering;
