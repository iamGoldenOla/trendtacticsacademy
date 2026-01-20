-- ============================================================================
-- NUCLEAR OPTION: Force Delete Facebook Ads Module
-- ============================================================================
-- This will forcefully remove the Facebook Ads module and all its lessons
-- ============================================================================

-- Step 1: Get the IDs we need
DO $$
DECLARE
    v_course_id UUID := '123e4567-e89b-12d3-a456-426614174001';
    v_facebook_mod_id UUID;
    v_correct_mod1_id UUID;
    v_deleted_count INT;
BEGIN
    -- Find Facebook Ads module
    SELECT id INTO v_facebook_mod_id 
    FROM modules 
    WHERE course_id = v_course_id 
    AND title = 'Module 1: Facebook Ads Foundations';

    -- Find correct Module 1
    SELECT id INTO v_correct_mod1_id
    FROM modules
    WHERE course_id = v_course_id
    AND title = 'Module 1: Foundations & Behavior Architecture';

    IF v_facebook_mod_id IS NOT NULL THEN
        -- Delete lessons from Facebook module
        DELETE FROM lessons WHERE module_id = v_facebook_mod_id;
        GET DIAGNOSTICS v_deleted_count = ROW_COUNT;
        RAISE NOTICE 'Deleted % lessons from Facebook Ads module', v_deleted_count;
        
        -- Delete the Facebook module
        DELETE FROM modules WHERE id = v_facebook_mod_id;
        RAISE NOTICE 'Deleted Facebook Ads module ✅';
    ELSE
        RAISE NOTICE 'Facebook Ads module not found';
    END IF;

    -- Update Module 1 ordering to 1 (in case it's wrong)
    IF v_correct_mod1_id IS NOT NULL THEN
        UPDATE modules SET ordering = 1 WHERE id = v_correct_mod1_id;
        RAISE NOTICE 'Fixed Module 1 ordering ✅';
    END IF;
END $$;

-- Verify deletion
SELECT 
    'After cleanup' as status,
    COUNT(*) as total_modules
FROM modules
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001';

-- Show remaining modules
SELECT 
    m.ordering,
    m.title,
    m.id,
    COUNT(l.id) as lessons
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id = '123e4567-e89b-12d3-a456-426614174001'
GROUP BY m.id, m.ordering, m.title
ORDER BY m.ordering;

-- Final lesson list
SELECT 
    m.title as module,
    l.title as lesson
FROM lessons l
JOIN modules m ON l.module_id = m.id
WHERE l.course_id = '123e4567-e89b-12d3-a456-426614174001'
ORDER BY m.ordering, l.order_index;
