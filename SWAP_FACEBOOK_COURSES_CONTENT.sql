-- Swap Content Between Facebook Ads Foundation and Facebook Ads Mastery
-- Foundation should have beginner content (Modules 1-10 with basics)
-- Mastery should have advanced AI content (AI Era, Advantage+, etc.)

-- Step 1: Get the course IDs
DO $$
DECLARE
    foundation_course_id UUID;
    mastery_course_id UUID;
    temp_course_id UUID := '00000000-0000-0000-0000-000000000000'; -- Temporary placeholder
BEGIN
    -- Get course IDs
    SELECT id INTO foundation_course_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mastery_course_id FROM courses WHERE title = 'Facebook Ads Mastery';
    
    RAISE NOTICE 'Foundation Course ID: %', foundation_course_id;
    RAISE NOTICE 'Mastery Course ID: %', mastery_course_id;
    
    -- Step 2: Move Foundation's modules to temp
    UPDATE modules SET course_id = temp_course_id WHERE course_id = foundation_course_id;
    RAISE NOTICE 'Moved Foundation modules to temp';
    
    -- Step 3: Move Mastery's modules to Foundation
    UPDATE modules SET course_id = foundation_course_id WHERE course_id = mastery_course_id;
    RAISE NOTICE 'Moved Mastery modules to Foundation';
    
    -- Step 4: Move temp modules to Mastery
    UPDATE modules SET course_id = mastery_course_id WHERE course_id = temp_course_id;
    RAISE NOTICE 'Moved temp modules to Mastery';
    
    RAISE NOTICE 'Content swap completed successfully!';
END $$;

-- Step 5: Verify the swap
SELECT 
    c.title as course,
    COUNT(m.id) as module_count,
    STRING_AGG(m.title, ' | ' ORDER BY m.ordering) as first_3_modules
FROM courses c
LEFT JOIN modules m ON c.id = m.course_id
WHERE c.title IN ('Facebook Ads Foundation', 'Facebook Ads Mastery')
GROUP BY c.id, c.title
ORDER BY c.title;

-- Expected result:
-- Facebook Ads Foundation should now have: Module 1: Foundations, Module 2: Audience & Targeting, etc.
-- Facebook Ads Mastery should now have: Facebook Ads in 2026: The AI Era, Next-Gen Campaign Setup, etc.
