-- MODULE 4: CREATIVE THAT CONVERTS - STRUCTURE
-- Creates module for creative lessons

DO $$
DECLARE
    foundation_id UUID;
    mod4_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    
    -- Create Module 4
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (
        foundation_id,
        'Module 4: Creative That Converts',
        'Master ad formats, copywriting, visual design, testing, and optimization for maximum conversions',
        4
    )
    ON CONFLICT DO NOTHING
    RETURNING id INTO mod4_id;
    
    IF mod4_id IS NULL THEN
        SELECT id INTO mod4_id FROM modules 
        WHERE course_id = foundation_id AND ordering = 4;
    END IF;
    
    RAISE NOTICE 'Module 4 created: %', mod4_id;
    
END $$;
