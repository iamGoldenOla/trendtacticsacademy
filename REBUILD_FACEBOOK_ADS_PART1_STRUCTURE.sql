-- Rebuild Facebook Ads Mastery - Part 1: Structure & Cleanup

DO $$
DECLARE
    v_duplicate_course_id UUID := '123e4567-e89b-12d3-a456-426614174002'; -- The "Facebook Ads" course to delete
    v_mastery_course_id UUID := '0987fcde-4321-0987-6543-210987654321';   -- The "Facebook Ads Mastery" course to rebuild
BEGIN
    RAISE NOTICE 'Starting Facebook Ads Mastery Rebuild...';

    -- 1. DELETE DUPLICATE COURSE
    DELETE FROM lessons 
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = v_duplicate_course_id);
    
    DELETE FROM modules 
    WHERE course_id = v_duplicate_course_id;
    
    DELETE FROM courses 
    WHERE id = v_duplicate_course_id;

    RAISE NOTICE 'Deleted duplicate "Facebook Ads" course.';

    -- 2. CLEAR EXISTING MASTERY CONTENT
    -- We want a fresh start for the new curriculum
    DELETE FROM lessons 
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = v_mastery_course_id);
    
    DELETE FROM modules 
    WHERE course_id = v_mastery_course_id;

    RAISE NOTICE 'Cleared existing "Facebook Ads Mastery" content.';

    -- 3. CREATE NEW MODULES
    INSERT INTO modules (course_id, title, description, ordering) VALUES
    (v_mastery_course_id, 'Module 1: Foundations of Facebook Advertising', 'Master the core concepts of the Meta advertising ecosystem.', 1),
    (v_mastery_course_id, 'Module 2: Audience & Targeting Mastery', 'Learn to find and target your perfect ideal customers.', 2),
    (v_mastery_course_id, 'Module 3: Campaign Strategy & Objectives', 'Strategic planning for maximum ROI and campaign success.', 3),
    (v_mastery_course_id, 'Module 4: Creative That Converts', 'Designing high-performance visuals and writing persuasive copy.', 4),
    (v_mastery_course_id, 'Module 5: Pixel, Events & Tracking', 'Technical mastery of tracking, attribution, and data accuracy.', 5),
    (v_mastery_course_id, 'Module 6: Scaling & Optimization', 'Strategies to safely scale budgets and optimize for lower CPAs.', 6),
    (v_mastery_course_id, 'Module 7: Advanced Tactics & Automation', 'Leveraging AI, automation, and advanced retargeting flows.', 7),
    (v_mastery_course_id, 'Module 8: Compliance, Ethics & Troubleshooting', 'Navigating policies, avoiding bans, and ethical practices.', 8),
    (v_mastery_course_id, 'Module 9: Real-World Case Studies & Campaign Builds', 'Watch over-the-shoulder campaign builds for different industries.', 9),
    (v_mastery_course_id, 'Module 10: Career & Certification Path', 'Building a career or agency business with Facebook Ads skills.', 10);

    RAISE NOTICE 'Created 10 new modules for Facebook Ads Mastery.';
    
END $$;
