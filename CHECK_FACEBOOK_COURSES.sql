-- CHECK CURRENT STATE OF FACEBOOK ADS COURSES
-- This will show us what modules are assigned to which course

-- Show all Facebook Ads courses
SELECT 
    'COURSES' as type,
    id,
    title,
    is_published,
    is_featured
FROM courses 
WHERE title ILIKE '%Facebook Ads%'
ORDER BY title;

-- Show modules for Foundation
SELECT 
    'FOUNDATION MODULES' as type,
    m.ordering,
    m.title,
    m.id
FROM modules m
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation'
ORDER BY m.ordering;

-- Show modules for Mastery  
SELECT 
    'MASTERY MODULES' as type,
    m.ordering,
    m.title,
    m.id
FROM modules m
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Mastery'
ORDER BY m.ordering;

-- Count lessons in Module 1 of Foundation
SELECT 
    'MODULE 1 LESSONS' as type,
    COUNT(*) as lesson_count,
    STRING_AGG(l.title, ', ' ORDER BY l.ordering) as lesson_titles
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation' AND m.ordering = 1;
