-- ============================================================================
-- PROMPT ENGINEERING - UPDATE EXISTING MODULES
-- ============================================================================
-- This updates your existing modules to have the correct names
-- ============================================================================

DO $$
DECLARE
    v_course_id UUID;
    v_module1_id UUID;
    v_module2_id UUID;
    v_module3_id UUID;
    v_module4_id UUID;
BEGIN
    -- Get Prompt Engineering course ID
    SELECT id INTO v_course_id FROM courses WHERE title ILIKE '%Prompt Engineering%' LIMIT 1;
    
    IF v_course_id IS NULL THEN
        RAISE EXCEPTION 'Prompt Engineering course not found!';
    END IF;

    RAISE NOTICE 'Found Prompt Engineering course: %', v_course_id;

    -- Get existing modules by ordering (they already exist, just need to rename them)
    SELECT id INTO v_module1_id FROM modules WHERE course_id = v_course_id AND ordering = 1;
    SELECT id INTO v_module2_id FROM modules WHERE course_id = v_course_id AND ordering = 2;
    SELECT id INTO v_module3_id FROM modules WHERE course_id = v_course_id AND ordering = 3;
    SELECT id INTO v_module4_id FROM modules WHERE course_id = v_course_id AND ordering = 4;

    -- Update module names to match what the SQL expects
    IF v_module1_id IS NOT NULL THEN
        UPDATE modules SET title = 'Foundations', updated_at = NOW() WHERE id = v_module1_id;
        RAISE NOTICE 'Updated Module 1 to: Foundations';
    END IF;

    IF v_module2_id IS NOT NULL THEN
        UPDATE modules SET title = 'Core Techniques', updated_at = NOW() WHERE id = v_module2_id;
        RAISE NOTICE 'Updated Module 2 to: Core Techniques';
    END IF;

    IF v_module3_id IS NOT NULL THEN
        UPDATE modules SET title = 'Advanced Workflows', updated_at = NOW() WHERE id = v_module3_id;
        RAISE NOTICE 'Updated Module 3 to: Advanced Workflows';
    END IF;

    IF v_module4_id IS NOT NULL THEN
        UPDATE modules SET title = 'Professional Mastery', updated_at = NOW() WHERE id = v_module4_id;
        RAISE NOTICE 'Updated Module 4 to: Professional Mastery';
    END IF;

    RAISE NOTICE '✅ All modules renamed successfully!';
END $$;

-- Verify the changes
SELECT m.id, m.title, m.ordering, COUNT(l.id) as lesson_count
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id IN (SELECT id FROM courses WHERE title ILIKE '%Prompt Engineering%')
GROUP BY m.id, m.title, m.ordering
ORDER BY m.ordering;
