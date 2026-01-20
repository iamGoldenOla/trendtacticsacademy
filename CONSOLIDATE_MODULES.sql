-- ============================================================================
-- CLEAN UP DUPLICATE MODULES & CONSOLIDATE LESSONS
-- ============================================================================
-- This will:
-- 1. Move lessons from duplicate modules to the correct ones
-- 2. Delete the duplicate modules
-- 3. Keep all your professional content
-- ============================================================================

DO $$
DECLARE
    v_course_id UUID;
    v_old_module1_id UUID;
    v_old_module2_id UUID;
    v_old_module3_id UUID;
    v_old_module4_id UUID;
    v_new_module1_id UUID;
    v_new_module2_id UUID;
    v_new_module3_id UUID;
    v_new_module4_id UUID;
BEGIN
    -- Get course ID
    SELECT id INTO v_course_id FROM courses WHERE title ILIKE '%Prompt Engineering%' LIMIT 1;

    -- Identify the ORIGINAL modules (the ones you want to keep)
    SELECT id INTO v_old_module1_id FROM modules 
    WHERE course_id = v_course_id AND ordering = 1 
    AND title != 'Foundations' LIMIT 1;

    SELECT id INTO v_old_module2_id FROM modules 
    WHERE course_id = v_course_id AND ordering = 2 
    AND title != 'Core Techniques' LIMIT 1;

    SELECT id INTO v_old_module3_id FROM modules 
    WHERE course_id = v_course_id AND ordering = 3 
    AND title != 'Advanced Workflows' LIMIT 1;

    SELECT id INTO v_old_module4_id FROM modules 
    WHERE course_id = v_course_id AND ordering = 4 
    AND title != 'Professional Mastery' LIMIT 1;

    -- Identify the NEW duplicate modules (the ones to delete)
    SELECT id INTO v_new_module1_id FROM modules 
    WHERE course_id = v_course_id AND title = 'Foundations' LIMIT 1;

    SELECT id INTO v_new_module2_id FROM modules 
    WHERE course_id = v_course_id AND title = 'Core Techniques' LIMIT 1;

    SELECT id INTO v_new_module3_id FROM modules 
    WHERE course_id = v_course_id AND title = 'Advanced Workflows' LIMIT 1;

    SELECT id INTO v_new_module4_id FROM modules 
    WHERE course_id = v_course_id AND title = 'Professional Mastery' LIMIT 1;

    -- Move lessons from new modules to old modules
    IF v_new_module1_id IS NOT NULL AND v_old_module1_id IS NOT NULL THEN
        UPDATE lessons SET module_id = v_old_module1_id WHERE module_id = v_new_module1_id;
        RAISE NOTICE 'Moved lessons from Foundations to original Module 1';
    END IF;

    IF v_new_module2_id IS NOT NULL AND v_old_module2_id IS NOT NULL THEN
        UPDATE lessons SET module_id = v_old_module2_id WHERE module_id = v_new_module2_id;
        RAISE NOTICE 'Moved lessons from Core Techniques to original Module 2';
    END IF;

    IF v_new_module3_id IS NOT NULL AND v_old_module3_id IS NOT NULL THEN
        UPDATE lessons SET module_id = v_old_module3_id WHERE module_id = v_new_module3_id;
        RAISE NOTICE 'Moved lessons from Advanced Workflows to original Module 3';
    END IF;

    IF v_new_module4_id IS NOT NULL AND v_old_module4_id IS NOT NULL THEN
        UPDATE lessons SET module_id = v_old_module4_id WHERE module_id = v_new_module4_id;
        RAISE NOTICE 'Moved lessons from Professional Mastery to original Module 4';
    END IF;

    -- Delete the duplicate modules
    DELETE FROM modules WHERE id IN (v_new_module1_id, v_new_module2_id, v_new_module3_id, v_new_module4_id);
    RAISE NOTICE 'Deleted duplicate modules';

    -- Rename the original modules to have better names
    UPDATE modules SET title = 'Module 1: Foundations & Multi-Agent Systems' WHERE id = v_old_module1_id;
    UPDATE modules SET title = 'Module 2: Core Techniques & Orchestration' WHERE id = v_old_module2_id;
    UPDATE modules SET title = 'Module 3: Advanced Workflows & Meta-Prompting' WHERE id = v_old_module3_id;
    UPDATE modules SET title = 'Module 4: Professional Mastery & Ethics' WHERE id = v_old_module4_id;

    RAISE NOTICE '✅ Cleanup complete!';
END $$;

-- Verify the final structure
SELECT m.id, m.title, m.ordering, COUNT(l.id) as lesson_count
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id IN (SELECT id FROM courses WHERE title ILIKE '%Prompt Engineering%')
GROUP BY m.id, m.title, m.ordering
ORDER BY m.ordering;
