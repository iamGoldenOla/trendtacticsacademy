-- Fix Facebook Ads Foundation Course Content
-- Problem: Foundation has advanced "AI Era" modules (1-5) instead of beginner content
-- Solution: Delete wrong modules 1-5, keep correct modules 6-10, create proper beginner modules 1-5

DO $$
DECLARE
    foundation_course_id UUID;
    mod1_id UUID;
    mod2_id UUID;
    mod3_id UUID;
    mod4_id UUID;
    mod5_id UUID;
BEGIN
    -- Get Foundation course ID
    SELECT id INTO foundation_course_id FROM courses WHERE title = 'Facebook Ads Foundation';
    RAISE NOTICE 'Foundation Course ID: %', foundation_course_id;
    
    -- Step 1: Delete the wrong modules 1-5 (AI Era content) from Foundation
    RAISE NOTICE 'Deleting wrong modules 1-5 from Foundation...';
    
    -- Delete lessons first, then modules
    DELETE FROM lessons WHERE module_id IN (
        SELECT id FROM modules 
        WHERE course_id = foundation_course_id 
        AND ordering IN (1, 2, 3, 4, 5)
    );
    
    DELETE FROM modules 
    WHERE course_id = foundation_course_id 
    AND ordering IN (1, 2, 3, 4, 5);
    
    RAISE NOTICE 'Deleted wrong modules 1-5';
    
    -- Step 2: Create correct beginner modules 1-5
    RAISE NOTICE 'Creating correct beginner modules...';
    
    -- Module 1: Foundations of Facebook Advertising
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (foundation_course_id, 'Module 1: Foundations of Facebook Advertising', 'Learn the fundamentals of Facebook advertising', 1)
    RETURNING id INTO mod1_id;
    
    INSERT INTO lessons (module_id, title, ordering, content, duration) VALUES
    (mod1_id, 'Meta Ads Manager Simulator', 1, '<p>Interactive simulator for Meta Ads Manager</p><iframe width="560" height="315" src="https://www.youtube.com/embed/8rABwKRsec4" frameborder="0" allowfullscreen></iframe>', 15),
    (mod1_id, 'What Are Facebook Ads & Why They Matter', 2, '<p>Understanding Facebook Ads ecosystem</p><iframe width="560" height="315" src="https://www.youtube.com/embed/006V3t__xkc" frameborder="0" allowfullscreen></iframe>', 10),
    (mod1_id, 'Setting Up a Business Manager Account', 3, '<p>Step-by-step Business Manager setup</p><iframe width="560" height="315" src="https://www.youtube.com/embed/JXhQyYwYw5k" frameborder="0" allowfullscreen></iframe>', 12),
    (mod1_id, 'Understanding the Facebook Ads Ecosystem', 4, '<p>Complete ecosystem overview</p><iframe width="560" height="315" src="https://www.youtube.com/embed/smIMGQbvVDY" frameborder="0" allowfullscreen></iframe>', 15),
    (mod1_id, 'Navigating Meta Ads Manager', 5, '<p>Ads Manager walkthrough</p><iframe width="560" height="315" src="https://www.youtube.com/embed/qaZC3XSAeR8" frameborder="0" allowfullscreen></iframe>', 10),
    (mod1_id, 'Key Terminology (CPM, CTR, ROAS, Pixel)', 6, '<p>Essential Facebook Ads metrics</p><iframe width="560" height="315" src="https://www.youtube.com/embed/R9JNM36iPug" frameborder="0" allowfullscreen></iframe>', 12);
    
    -- Module 2: Audience & Targeting Mastery
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (foundation_course_id, 'Module 2: Audience & Targeting Mastery', 'Master audience targeting strategies', 2)
    RETURNING id INTO mod2_id;
    
    INSERT INTO lessons (module_id, title, ordering, content, duration) VALUES
    (mod2_id, 'Types of Audiences: Core, Custom, Lookalike', 1, '<p>Understanding audience types</p><iframe width="560" height="315" src="https://www.youtube.com/embed/dwVLcMTRNHI" frameborder="0" allowfullscreen></iframe>', 15),
    (mod2_id, 'Building Buyer Personas', 2, '<p>Create detailed buyer personas</p><iframe width="560" height="315" src="https://www.youtube.com/embed/lpQugp7AXEU" frameborder="0" allowfullscreen></iframe>', 12),
    (mod2_id, 'Geo, Demographic & Behavioral Targeting', 3, '<p>Advanced targeting options</p><iframe width="560" height="315" src="https://www.youtube.com/embed/F8Bu8tgWHyc" frameborder="0" allowfullscreen></iframe>', 15),
    (mod2_id, 'Retargeting Strategies', 4, '<p>Effective retargeting techniques</p><iframe width="560" height="315" src="https://www.youtube.com/embed/TPnqxl82Rw4" frameborder="0" allowfullscreen></iframe>', 12),
    (mod2_id, 'Audience Layering for Precision', 5, '<p>Layer audiences for better results</p><iframe width="560" height="315" src="https://www.youtube.com/embed/wPlAalud2Hg" frameborder="0" allowfullscreen></iframe>', 10);
    
    -- Module 3: Campaign Strategy & Objectives
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (foundation_course_id, 'Module 3: Campaign Strategy & Objectives', 'Learn campaign planning and objectives', 3)
    RETURNING id INTO mod3_id;
    
    INSERT INTO lessons (module_id, title, ordering, content, duration) VALUES
    (mod3_id, 'Choosing the Right Campaign Objective', 1, '<p>Select the best objective</p><iframe width="560" height="315" src="https://www.youtube.com/embed/DaON4AlfGR8" frameborder="0" allowfullscreen></iframe>', 12),
    (mod3_id, 'Awareness vs. Consideration vs. Conversion', 2, '<p>Understanding funnel stages</p><iframe width="560" height="315" src="https://www.youtube.com/embed/nlVuhml4R6E" frameborder="0" allowfullscreen></iframe>', 15),
    (mod3_id, 'Funnel Mapping with Facebook Ads', 3, '<p>Map your sales funnel</p><iframe width="560" height="315" src="https://www.youtube.com/embed/-jw5Uu2LaQQ" frameborder="0" allowfullscreen></iframe>', 12),
    (mod3_id, 'Budgeting: Daily vs. Lifetime', 4, '<p>Budget strategies explained</p><iframe width="560" height="315" src="https://www.youtube.com/embed/wKDeZWnVA9c" frameborder="0" allowfullscreen></iframe>', 10),
    (mod3_id, 'Bidding Strategies & Optimization', 5, '<p>Optimize your bidding</p><iframe width="560" height="315" src="https://www.youtube.com/embed/b_6jaNayDag" frameborder="0" allowfullscreen></iframe>', 12);
    
    -- Module 4: Creative That Converts
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (foundation_course_id, 'Module 4: Creative That Converts', 'Create high-converting ad creatives', 4)
    RETURNING id INTO mod4_id;
    
    INSERT INTO lessons (module_id, title, ordering, content, duration) VALUES
    (mod4_id, 'Ad Formats: Image, Video, Carousel, Collection', 1, '<p>Explore ad formats</p><iframe width="560" height="315" src="https://www.youtube.com/embed/HzAGUY9zHSw" frameborder="0" allowfullscreen></iframe>', 15),
    (mod4_id, 'Writing High-Converting Ad Copy', 2, '<p>Copywriting for ads</p><iframe width="560" height="315" src="https://www.youtube.com/embed/Jlum3q1aRes" frameborder="0" allowfullscreen></iframe>', 12),
    (mod4_id, 'Visual Psychology & Design Principles', 3, '<p>Design principles for ads</p><iframe width="560" height="315" src="https://www.youtube.com/embed/LMh-BAJtbFE" frameborder="0" allowfullscreen></iframe>', 12),
    (mod4_id, 'A/B Testing Creatives', 4, '<p>Test your ad creatives</p><iframe width="560" height="315" src="https://www.youtube.com/embed/MaNKao9jYwI" frameborder="0" allowfullscreen></iframe>', 10),
    (mod4_id, 'Using Dynamic Creative Optimization', 5, '<p>DCO tutorial</p><iframe width="560" height="315" src="https://www.youtube.com/embed/KtQzxXQMkpo" frameborder="0" allowfullscreen></iframe>', 12);
    
    -- Module 5: Pixel, Events & Tracking
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (foundation_course_id, 'Module 5: Pixel, Events & Tracking', 'Master Facebook Pixel and tracking', 5)
    RETURNING id INTO mod5_id;
    
    INSERT INTO lessons (module_id, title, ordering, content, duration) VALUES
    (mod5_id, 'Installing the Facebook Pixel', 1, '<p>Install Facebook Pixel</p><iframe width="560" height="315" src="https://www.youtube.com/embed/cBs_6DyovXc" frameborder="0" allowfullscreen></iframe>', 15),
    (mod5_id, 'Standard vs. Custom Events', 2, '<p>Understanding events</p><iframe width="560" height="315" src="https://www.youtube.com/embed/7Q17ubqLfaM" frameborder="0" allowfullscreen></iframe>', 12),
    (mod5_id, 'Conversion Tracking & Attribution', 3, '<p>Track conversions</p><iframe width="560" height="315" src="https://www.youtube.com/embed/CA3f0vJTv28" frameborder="0" allowfullscreen></iframe>', 12),
    (mod5_id, 'Offline Conversions & CRM Integration', 4, '<p>Offline conversion setup</p><iframe width="560" height="315" src="https://www.youtube.com/embed/sd-zrXdBRTU" frameborder="0" allowfullscreen></iframe>', 10),
    (mod5_id, 'Troubleshooting Pixel Issues', 5, '<p>Fix pixel problems</p><iframe width="560" height="315" src="https://www.youtube.com/embed/YXNaN7SdEzc" frameborder="0" allowfullscreen></iframe>', 10);
    
    RAISE NOTICE 'Created all 5 beginner modules with lessons';
    RAISE NOTICE 'Foundation course now has correct content!';
END $$;

-- Verify the fix
SELECT 
    c.title as course_name,
    m.ordering as module_order,
    m.title as module_title,
    (SELECT COUNT(*) FROM lessons WHERE module_id = m.id) as lesson_count
FROM courses c
JOIN modules m ON c.id = m.course_id
WHERE c.title = 'Facebook Ads Foundation'
ORDER BY m.ordering;
