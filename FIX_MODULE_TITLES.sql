-- FIX MODULE TITLES - Add Module Numbers
-- This ensures modules display as "Module 1:", "Module 2:" etc.

DO $$
BEGIN
    -- Update Module 1 title
    UPDATE modules
    SET title = 'Module 1: Foundations of Facebook Advertising'
    WHERE course_id = (SELECT id FROM courses WHERE title = 'Facebook Ads Foundation')
    AND ordering = 1;
    
    -- Update Module 2 title
    UPDATE modules
    SET title = 'Module 2: Audience & Targeting Mastery'
    WHERE course_id = (SELECT id FROM courses WHERE title = 'Facebook Ads Foundation')
    AND ordering = 2;
    
    RAISE NOTICE 'Module titles updated with numbers';
    
END $$;

-- Verify all modules and lessons
SELECT 
    m.ordering as module_num,
    m.title as module_title,
    COUNT(l.id) as lesson_count,
    STRING_AGG(l.title, ' | ' ORDER BY l.ordering) as lessons
FROM modules m
LEFT JOIN lessons l ON m.id = l.module_id
WHERE m.course_id = (SELECT id FROM courses WHERE title = 'Facebook Ads Foundation')
GROUP BY m.ordering, m.title
ORDER BY m.ordering;
