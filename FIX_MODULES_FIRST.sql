-- ============================================================================
-- PROMPT ENGINEERING - MODULE SETUP (Fixed Version)
-- ============================================================================
-- This version doesn't use ON CONFLICT, so it works without unique constraints
-- ============================================================================

DO $$
DECLARE
    v_course_id UUID;
    v_module_id UUID;
BEGIN
    -- Get Prompt Engineering course ID
    SELECT id INTO v_course_id FROM courses WHERE title ILIKE '%Prompt Engineering%' LIMIT 1;
    
    IF v_course_id IS NULL THEN
        RAISE EXCEPTION 'Prompt Engineering course not found! Please create the course first.';
    END IF;

    RAISE NOTICE 'Found Prompt Engineering course: %', v_course_id;

    -- Module 1: Foundations
    SELECT id INTO v_module_id FROM modules WHERE course_id = v_course_id AND title = 'Foundations';
    IF v_module_id IS NULL THEN
        INSERT INTO modules (course_id, title, ordering, created_at, updated_at)
        VALUES (v_course_id, 'Foundations', 1, NOW(), NOW());
        RAISE NOTICE 'Created module: Foundations';
    ELSE
        UPDATE modules SET ordering = 1, updated_at = NOW() WHERE id = v_module_id;
        RAISE NOTICE 'Updated module: Foundations';
    END IF;

    -- Module 2: Core Techniques
    SELECT id INTO v_module_id FROM modules WHERE course_id = v_course_id AND title = 'Core Techniques';
    IF v_module_id IS NULL THEN
        INSERT INTO modules (course_id, title, ordering, created_at, updated_at)
        VALUES (v_course_id, 'Core Techniques', 2, NOW(), NOW());
        RAISE NOTICE 'Created module: Core Techniques';
    ELSE
        UPDATE modules SET ordering = 2, updated_at = NOW() WHERE id = v_module_id;
        RAISE NOTICE 'Updated module: Core Techniques';
    END IF;

    -- Module 3: Advanced Workflows
    SELECT id INTO v_module_id FROM modules WHERE course_id = v_course_id AND title = 'Advanced Workflows';
    IF v_module_id IS NULL THEN
        INSERT INTO modules (course_id, title, ordering, created_at, updated_at)
        VALUES (v_course_id, 'Advanced Workflows', 3, NOW(), NOW());
        RAISE NOTICE 'Created module: Advanced Workflows';
    ELSE
        UPDATE modules SET ordering = 3, updated_at = NOW() WHERE id = v_module_id;
        RAISE NOTICE 'Updated module: Advanced Workflows';
    END IF;

    -- Module 4: Professional Mastery
    SELECT id INTO v_module_id FROM modules WHERE course_id = v_course_id AND title = 'Professional Mastery';
    IF v_module_id IS NULL THEN
        INSERT INTO modules (course_id, title, ordering, created_at, updated_at)
        VALUES (v_course_id, 'Professional Mastery', 4, NOW(), NOW());
        RAISE NOTICE 'Created module: Professional Mastery';
    ELSE
        UPDATE modules SET ordering = 4, updated_at = NOW() WHERE id = v_module_id;
        RAISE NOTICE 'Updated module: Professional Mastery';
    END IF;

    RAISE NOTICE '✅ All modules created/updated successfully!';
END $$;

-- Verify modules were created
SELECT m.id, m.title, m.ordering, COUNT(l.id) as lesson_count
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id IN (SELECT id FROM courses WHERE title ILIKE '%Prompt Engineering%')
GROUP BY m.id, m.title, m.ordering
ORDER BY m.ordering;
