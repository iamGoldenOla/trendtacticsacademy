-- MODULE 5: PIXEL, EVENTS & TRACKING - STRUCTURE
-- Creates module for pixel and tracking lessons

DO $$
DECLARE
    foundation_id UUID;
    mod5_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    
    -- Create Module 5
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (
        foundation_id,
        'Module 5: Pixel, Events & Tracking',
        'Master Facebook Pixel installation, event tracking, conversion attribution, and troubleshooting',
        5
    )
    ON CONFLICT DO NOTHING
    RETURNING id INTO mod5_id;
    
    IF mod5_id IS NULL THEN
        SELECT id INTO mod5_id FROM modules 
        WHERE course_id = foundation_id AND ordering = 5;
    END IF;
    
    RAISE NOTICE 'Module 5 created: %', mod5_id;
    
END $$;
