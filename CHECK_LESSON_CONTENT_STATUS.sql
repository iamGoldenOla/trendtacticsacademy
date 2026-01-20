
WITH vibe_course AS (
    SELECT id FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1
)
SELECT 
    l.title,
    length(l.content) as content_len,
    length(l.playground_prompt) as playground_len,
    substring(l.playground_prompt from 1 for 50) as playground_snippet,
    l.quiz_questions IS NOT NULL as has_quiz,
    length(l.quiz_questions::text) as quiz_len
FROM lessons l
JOIN modules m ON l.module_id = m.id
WHERE m.course_id = (SELECT id FROM vibe_course)
ORDER BY m.ordering, l.ordering;
