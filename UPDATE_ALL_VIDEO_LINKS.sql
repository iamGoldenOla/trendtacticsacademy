-- UPDATE ALL VIDEO LINKS FOR MODULES 2-10
-- Replace placeholder videos with actual course-specific videos

DO $$
DECLARE
    foundation_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    
    RAISE NOTICE 'Updating video links for all modules...';
    
    -- MODULE 2 VIDEO UPDATES
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=U86iFV-ccmw'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 2)
    AND title = 'Geo, Demographic & Behavioral Targeting';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=kKZEJ3JoH6s'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 2)
    AND title = 'Retargeting Strategies';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=dzSl8r5H74I'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 2)
    AND title = 'Audience Layering for Precision';
    
    -- MODULE 3 VIDEO UPDATES
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=7FTLhWj6e2E'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 3)
    AND title = 'Choosing the Right Campaign Objective';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=nrpeVJj5pcw'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 3)
    AND title = 'Awareness vs Consideration vs Conversion';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=maPEkV2JIgU'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 3)
    AND title = 'Funnel Mapping with Facebook Ads';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=yVrSnhWGAI8'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 3)
    AND title = 'Budgeting: Daily vs Lifetime';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=01fnv8F-r6U'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 3)
    AND title = 'Bidding Strategies & Optimization';
    
    -- MODULE 4 VIDEO UPDATES
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=Pvr3Xoa-Lu4'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 4)
    AND title = 'Ad Formats: Image, Video, Carousel, Collection';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=fkZSqrqwjW0'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 4)
    AND title = 'Writing High-Converting Ad Copy';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=vMUp9XS5Xks'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 4)
    AND title = 'Visual Psychology & Design Principles';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=bFkjUrOTB4I'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 4)
    AND title = 'A/B Testing Creatives';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=xOCqu3pqk-0'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 4)
    AND title = 'Using Dynamic Creative Optimization';
    
    -- MODULE 5 VIDEO UPDATES
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=gRC1g04tZAc'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 5)
    AND title = 'Installing the Facebook Pixel';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=Pjf7yiLwnbA'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 5)
    AND title = 'Standard vs Custom Events';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=Zbxcg4zEA0g'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 5)
    AND title = 'Conversion Tracking & Attribution';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=lykYzyVP9pw'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 5)
    AND title = 'Offline Conversions & CRM Integration';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=TFqDVALy0Ig'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 5)
    AND title = 'Troubleshooting Pixel Issues';
    
    -- MODULE 6 VIDEO UPDATES
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=8p5Ht4kJEmY'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 6)
    AND title = 'Setting Budget';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=Tet-SHMwAmE'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 6)
    AND title = 'Bidding Strategies';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=KDG5Sr-WQM4'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 6)
    AND title = 'Budget Optimization';
    
    -- MODULE 7 VIDEO UPDATES
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=-UsmX2cHXPg'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 7)
    AND title = 'Ad Placements';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=Olag3WrnS5o'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 7)
    AND title = 'Auto vs Manual Placement';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=RLmkws-h8pM'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 7)
    AND title = 'Placement Optimization';
    
    -- MODULE 8 VIDEO UPDATES
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=y8KlbO6ckOo'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 8)
    AND title = 'Facebook Pixel Deep Dive';
    
    -- MODULE 9 VIDEO UPDATES
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=ljElFVNSJ9U'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 9)
    AND title = 'When to Scale';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=6NVrI5xT4jY'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 9)
    AND title = 'Scaling Methods';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=hi-IDgMrWj4'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 9)
    AND title = 'Avoiding Mistakes';
    
    -- MODULE 10 VIDEO UPDATES
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=VqZS6RbK8gE'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 10)
    AND title = 'Advanced Targeting';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=KwskHb77CLo'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 10)
    AND title = 'Advanced Retargeting';
    
    UPDATE lessons SET video_url = 'https://www.youtube.com/watch?v=ICA8G4GzKU4'
    WHERE module_id IN (SELECT id FROM modules WHERE course_id = foundation_id AND ordering = 10)
    AND title = 'Advanced A/B Testing';
    
    RAISE NOTICE '======================';
    RAISE NOTICE 'ALL VIDEO LINKS UPDATED!';
    RAISE NOTICE 'Modules 2-10 now have course-specific YouTube videos';
    RAISE NOTICE '======================';
    
END $$;
