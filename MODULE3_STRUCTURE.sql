-- MODULE 3: CAMPAIGN STRATEGY & OBJECTIVES - STRUCTURE
-- Creates module and prepares for lessons

DO $$
DECLARE
    foundation_id UUID;
    mod3_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    
    -- Create Module 3
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (
        foundation_id,
        'Module 3: Campaign Strategy & Objectives',
        'Master campaign objectives, funnel strategies, budgeting, and bidding for optimal results',
        3
    )
    ON CONFLICT DO NOTHING
    RETURNING id INTO mod3_id;
    
    IF mod3_id IS NULL THEN
        SELECT id INTO mod3_id FROM modules 
        WHERE course_id = foundation_id AND ordering = 3;
    END IF;
    
    RAISE NOTICE 'Module 3 created: %', mod3_id;
    
END $$;

-- Verify
SELECT ordering, title FROM modules 
WHERE course_id = (SELECT id FROM courses WHERE title = 'Facebook Ads Foundation')
ORDER BY ordering;
