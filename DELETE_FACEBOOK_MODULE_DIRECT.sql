-- ============================================================================
-- DIRECT DELETE: Remove Facebook Ads Module by ID
-- ============================================================================

-- First, find the Facebook Ads module ID
DO $$
DECLARE
    v_facebook_module_id UUID;
BEGIN
    -- Get the Facebook Ads module ID
    SELECT id INTO v_facebook_module_id 
    FROM modules 
    WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
    AND title = 'Module 1: Facebook Ads Foundations';

    IF v_facebook_module_id IS NOT NULL THEN
        -- Delete all lessons in this module
        DELETE FROM lessons WHERE module_id = v_facebook_module_id;
        
        -- Delete the module itself
        DELETE FROM modules WHERE id = v_facebook_module_id;
        
        RAISE NOTICE 'Deleted Facebook Ads module and its lessons ✅';
    ELSE
        RAISE NOTICE 'Facebook Ads module not found (might already be deleted)';
    END IF;
END $$;

-- Verify: Show remaining modules and lesson counts
SELECT 
    m.ordering,
    m.title as module,
    COUNT(l.id) as lesson_count
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id = '123e4567-e89b-12d3-a456-426614174001'
GROUP BY m.id, m.ordering, m.title
ORDER BY m.ordering;

-- Show all remaining lessons
SELECT 
    m.ordering as mod_order,
    m.title as module,
    l.title as lesson
FROM lessons l
JOIN modules m ON l.module_id = m.id
WHERE l.course_id = '123e4567-e89b-12d3-a456-426614174001'
ORDER BY m.ordering, l.order_index;
