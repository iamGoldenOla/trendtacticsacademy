-- ==========================================
-- GET FACEBOOK ADS MASTERY LESSON IDS
-- For content expansion to ~1200 words each
-- ==========================================

-- Get all lesson IDs for Facebook Ads Mastery course
SELECT 
    c.id as course_id,
    c.title as course_title,
    m.id as module_id,
    m.title as module_title,
    m.ordering as module_order,
    l.id as lesson_id,
    l.title as lesson_title,
    l.ordering as lesson_order,
    LENGTH(l.content) as current_content_length
FROM courses c
JOIN modules m ON m.course_id = c.id
JOIN lessons l ON l.module_id = m.id
WHERE c.title LIKE '%Facebook%Ads%'
ORDER BY m.ordering, l.ordering;

-- Count total lessons
SELECT 
    c.title as course,
    COUNT(l.id) as total_lessons,
    COUNT(m.id) as total_modules
FROM courses c
JOIN modules m ON m.course_id = c.id
JOIN lessons l ON l.module_id = m.id
WHERE c.title LIKE '%Facebook%Ads%'
GROUP BY c.title;

-- Check current content status
SELECT 
    m.title as module,
    l.title as lesson,
    CASE 
        WHEN LENGTH(l.content) < 500 THEN 'Needs Expansion'
        WHEN LENGTH(l.content) < 1000 THEN 'Partial Content'
        ELSE 'Good Length'
    END as status,
    LENGTH(l.content) as char_count
FROM courses c
JOIN modules m ON m.course_id = c.id
JOIN lessons l ON l.module_id = m.id
WHERE c.title LIKE '%Facebook%Ads%'
ORDER BY m.ordering, l.ordering;
