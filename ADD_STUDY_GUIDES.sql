-- ADD STUDY GUIDE RESOURCES TO ALL MODULES
-- Adds external YouTube study resources with disclaimer

DO $$
DECLARE
    foundation_id UUID;
    mod_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    
    RAISE NOTICE 'Adding study guide resources to all modules...';
    
    -- MODULE 1 STUDY GUIDE
    SELECT id INTO mod_id FROM modules WHERE course_id = foundation_id AND ordering = 1;
    UPDATE modules SET description = description || E'\n\n📚 **Additional Study Resources**\n\n*Disclaimer: The following YouTube resources are not owned by Trendtactics Digital. They are curated external resources to supplement your learning.*\n\n- [What Are Facebook Ads & Why They Matter](https://www.youtube.com/watch?v=006V3t__xkc)\n- [Setting Up a Business Manager Account](https://www.youtube.com/watch?v=8rABwKRsec4)\n- [Understanding the Facebook Ads Ecosystem](https://www.youtube.com/watch?v=JRnB1OJrqzk)\n- [Navigating Meta Ads Manager](https://www.youtube.com/watch?v=2xfMQDxaG_w)\n- [Key Terminology (CPM, CTR, ROAS, Pixel)](https://www.youtube.com/watch?v=006V3t__xkc)'
    WHERE id = mod_id;
    
    -- MODULE 2 STUDY GUIDE
    SELECT id INTO mod_id FROM modules WHERE course_id = foundation_id AND ordering = 2;
    UPDATE modules SET description = description || E'\n\n📚 **Additional Study Resources**\n\n*Disclaimer: The following YouTube resources are not owned by Trendtactics Digital. They are curated external resources to supplement your learning.*\n\n- [Types of Audiences: Core, Custom, Lookalike](https://www.youtube.com/watch?v=8rABwKRsec4)\n- [Building Buyer Personas](https://www.youtube.com/watch?v=JRnB1OJrqzk)\n- [Geo, Demographic & Behavioral Targeting](https://www.youtube.com/watch?v=U86iFV-ccmw)\n- [Retargeting Strategies](https://www.youtube.com/watch?v=kKZEJ3JoH6s)\n- [Audience Layering for Precision](https://www.youtube.com/watch?v=dzSl8r5H74I)'
    WHERE id = mod_id;
    
    -- MODULE 3 STUDY GUIDE
    SELECT id INTO mod_id FROM modules WHERE course_id = foundation_id AND ordering = 3;
    UPDATE modules SET description = description || E'\n\n📚 **Additional Study Resources**\n\n*Disclaimer: The following YouTube resources are not owned by Trendtactics Digital. They are curated external resources to supplement your learning.*\n\n- [Choosing the Right Campaign Objective](https://www.youtube.com/watch?v=7FTLhWj6e2E)\n- [Awareness vs. Consideration vs. Conversion](https://www.youtube.com/watch?v=nrpeVJj5pcw)\n- [Funnel Mapping with Facebook Ads](https://www.youtube.com/watch?v=maPEkV2JIgU)\n- [Budgeting: Daily vs. Lifetime](https://www.youtube.com/watch?v=yVrSnhWGAI8)\n- [Bidding Strategies & Optimization](https://www.youtube.com/watch?v=01fnv8F-r6U)'
    WHERE id = mod_id;
    
    -- MODULE 4 STUDY GUIDE
    SELECT id INTO mod_id FROM modules WHERE course_id = foundation_id AND ordering = 4;
    UPDATE modules SET description = description || E'\n\n📚 **Additional Study Resources**\n\n*Disclaimer: The following YouTube resources are not owned by Trendtactics Digital. They are curated external resources to supplement your learning.*\n\n- [Ad Formats: Image, Video, Carousel, Collection](https://www.youtube.com/watch?v=Pvr3Xoa-Lu4)\n- [Writing High-Converting Ad Copy](https://www.youtube.com/watch?v=fkZSqrqwjW0)\n- [Visual Psychology & Design Principles](https://www.youtube.com/watch?v=vMUp9XS5Xks)\n- [A/B Testing Creatives](https://www.youtube.com/watch?v=bFkjUrOTB4I)\n- [Using Dynamic Creative Optimization](https://www.youtube.com/watch?v=xOCqu3pqk-0)'
    WHERE id = mod_id;
    
    -- MODULE 5 STUDY GUIDE
    SELECT id INTO mod_id FROM modules WHERE course_id = foundation_id AND ordering = 5;
    UPDATE modules SET description = description || E'\n\n📚 **Additional Study Resources**\n\n*Disclaimer: The following YouTube resources are not owned by Trendtactics Digital. They are curated external resources to supplement your learning.*\n\n- [Installing the Facebook Pixel](https://www.youtube.com/watch?v=gRC1g04tZAc)\n- [Standard vs. Custom Events](https://www.youtube.com/watch?v=Pjf7yiLwnbA)\n- [Conversion Tracking & Attribution](https://www.youtube.com/watch?v=Zbxcg4zEA0g)\n- [Offline Conversions & CRM Integration](https://www.youtube.com/watch?v=lykYzyVP9pw)\n- [Troubleshooting Pixel Issues](https://www.youtube.com/watch?v=TFqDVALy0Ig)'
    WHERE id = mod_id;
    
    -- MODULE 6 STUDY GUIDE
    SELECT id INTO mod_id FROM modules WHERE course_id = foundation_id AND ordering = 6;
    UPDATE modules SET description = description || E'\n\n📚 **Additional Study Resources**\n\n*Disclaimer: The following YouTube resources are not owned by Trendtactics Digital. They are curated external resources to supplement your learning.*\n\n- [Setting Budget](https://www.youtube.com/watch?v=8p5Ht4kJEmY)\n- [Bidding Strategies](https://www.youtube.com/watch?v=Tet-SHMwAmE)\n- [Budget Optimization](https://www.youtube.com/watch?v=KDG5Sr-WQM4)'
    WHERE id = mod_id;
    
    -- MODULE 7 STUDY GUIDE
    SELECT id INTO mod_id FROM modules WHERE course_id = foundation_id AND ordering = 7;
    UPDATE modules SET description = description || E'\n\n📚 **Additional Study Resources**\n\n*Disclaimer: The following YouTube resources are not owned by Trendtactics Digital. They are curated external resources to supplement your learning.*\n\n- [Ad Placements](https://www.youtube.com/watch?v=-UsmX2cHXPg)\n- [Auto vs Manual Placement](https://www.youtube.com/watch?v=Olag3WrnS5o)\n- [Placement Optimization](https://www.youtube.com/watch?v=RLmkws-h8pM)'
    WHERE id = mod_id;
    
    -- MODULE 8 STUDY GUIDE
    SELECT id INTO mod_id FROM modules WHERE course_id = foundation_id AND ordering = 8;
    UPDATE modules SET description = description || E'\n\n📚 **Additional Study Resources**\n\n*Disclaimer: The following YouTube resources are not owned by Trendtactics Digital. They are curated external resources to supplement your learning.*\n\n- [Facebook Pixel Deep Dive](https://www.youtube.com/watch?v=y8KlbO6ckOo)'
    WHERE id = mod_id;
    
    -- MODULE 9 STUDY GUIDE
    SELECT id INTO mod_id FROM modules WHERE course_id = foundation_id AND ordering = 9;
    UPDATE modules SET description = description || E'\n\n📚 **Additional Study Resources**\n\n*Disclaimer: The following YouTube resources are not owned by Trendtactics Digital. They are curated external resources to supplement your learning.*\n\n- [When to Scale](https://www.youtube.com/watch?v=ljElFVNSJ9U)\n- [Scaling Methods](https://www.youtube.com/watch?v=6NVrI5xT4jY)\n- [Avoiding Mistakes](https://www.youtube.com/watch?v=hi-IDgMrWj4)'
    WHERE id = mod_id;
    
    -- MODULE 10 STUDY GUIDE
    SELECT id INTO mod_id FROM modules WHERE course_id = foundation_id AND ordering = 10;
    UPDATE modules SET description = description || E'\n\n📚 **Additional Study Resources**\n\n*Disclaimer: The following YouTube resources are not owned by Trendtactics Digital. They are curated external resources to supplement your learning.*\n\n- [Advanced Targeting](https://www.youtube.com/watch?v=VqZS6RbK8gE)\n- [Advanced Retargeting](https://www.youtube.com/watch?v=KwskHb77CLo)\n- [Advanced A/B Testing](https://www.youtube.com/watch?v=ICA8G4GzKU4)'
    WHERE id = mod_id;
    
    RAISE NOTICE '======================';
    RAISE NOTICE 'STUDY GUIDES ADDED TO ALL MODULES!';
    RAISE NOTICE 'Each module now has curated YouTube resources with disclaimer';
    RAISE NOTICE '======================';
    
END $$;
