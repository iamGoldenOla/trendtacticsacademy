-- Remove Leftover Duplicate Facebook Course
-- ID: b2c3d4e5-f6a7-8901-bcde-f01234567891

DO $$
DECLARE
    v_duplicate_id UUID := 'b2c3d4e5-f6a7-8901-bcde-f01234567891';
BEGIN
    RAISE NOTICE 'Removing duplicate Facebook course: %', v_duplicate_id;

    -- Delete lessons
    DELETE FROM lessons 
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = v_duplicate_id);
    
    -- Delete modules
    DELETE FROM modules 
    WHERE course_id = v_duplicate_id;
    
    -- Delete course
    DELETE FROM courses 
    WHERE id = v_duplicate_id;

    RAISE NOTICE '✅ Duplicate course removed. Only Facebook Ads Mastery should remain.';
END $$;
