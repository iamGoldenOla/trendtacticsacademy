-- COMPLETE DATABASE BACKUP FOR LOCKDOWN
-- Creates a complete snapshot of Facebook Ads Foundation course

-- Export this data to preserve your stable course state

-- 1. EXPORT COURSE STRUCTURE
SELECT 
    'COURSE' as type,
    id,
    title,
    description,
    thumbnail,
    created_at
FROM courses 
WHERE title = 'Facebook Ads Foundation';

-- 2. EXPORT ALL MODULES
SELECT 
    'MODULE' as type,
    m.id,
    m.course_id,
    m.title,
    m.description,
    m.ordering,
    m.created_at
FROM modules m
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation'
ORDER BY m.ordering;

-- 3. EXPORT ALL LESSONS
SELECT 
    'LESSON' as type,
    l.id,
    l.module_id,
    l.title,
    l.content,
    l.video_url,
    l.duration,
    l.ordering,
    l.created_at
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation'
ORDER BY m.ordering, l.ordering;

-- 4. EXPORT ALL QUIZZES
SELECT 
    'QUIZ' as type,
    qq.id,
    qq.lesson_id,
    qq.question,
    qq.options,
    qq.correct_answer,
    qq.explanation,
    qq.created_at
FROM quiz_questions qq
JOIN lessons l ON qq.lesson_id = l.id
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation'
ORDER BY m.ordering, l.ordering, qq.id;

-- 5. FINAL STATISTICS
SELECT 
    'STATISTICS' as type,
    (SELECT COUNT(*) FROM modules WHERE course_id = (SELECT id FROM courses WHERE title = 'Facebook Ads Foundation')) as total_modules,
    (SELECT COUNT(*) FROM lessons WHERE module_id IN (SELECT id FROM modules WHERE course_id = (SELECT id FROM courses WHERE title = 'Facebook Ads Foundation'))) as total_lessons,
    (SELECT COUNT(*) FROM quiz_questions WHERE lesson_id IN (SELECT id FROM lessons WHERE module_id IN (SELECT id FROM modules WHERE course_id = (SELECT id FROM courses WHERE title = 'Facebook Ads Foundation')))) as total_quizzes,
    NOW() as backup_timestamp;
