-- Get detailed info about both Facebook courses

-- 1. Get course IDs and basic info
SELECT 
    id,
    title,
    description,
    created_at
FROM courses
WHERE title ILIKE '%Facebook%'
ORDER BY title;

-- 2. Check module structure for the comprehensive course
SELECT 
    m.ordering,
    m.title as module_title,
    COUNT(l.id) as lesson_count
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id = (
    SELECT id FROM courses 
    WHERE title ILIKE '%Building Profitable%'
    LIMIT 1
)
GROUP BY m.id, m.ordering, m.title
ORDER BY m.ordering;

-- 3. Sample a few lessons to check if they have content
SELECT 
    l.title,
    l.video_url,
    LENGTH(l.content) as content_length,
    CASE 
        WHEN l.video_url IS NOT NULL THEN '✅'
        ELSE '❌'
    END as has_video,
    CASE 
        WHEN LENGTH(l.content) > 100 THEN '✅'
        ELSE '❌'
    END as has_content
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title ILIKE '%Building Profitable%'
ORDER BY m.ordering, l.ordering
LIMIT 10;
