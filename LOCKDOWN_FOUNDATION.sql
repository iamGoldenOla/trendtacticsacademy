-- LOCKDOWN FACEBOOK ADS FOUNDATION - FINAL FIX
-- Completely resets Foundation course to ONLY have Module 1 with Lesson 1
-- This prevents any future content swaps

DO $$
DECLARE
    foundation_id UUID;
    mod1_id UUID;
    lesson1_id UUID;
BEGIN
    -- Get Foundation course ID
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    
    IF foundation_id IS NULL THEN
        RAISE EXCEPTION 'Facebook Ads Foundation course not found!';
    END IF;
    
    RAISE NOTICE 'Foundation Course ID: %', foundation_id;
    
    -- DELETE ALL EXISTING CONTENT (clean slate)
    RAISE NOTICE 'Deleting all existing modules and lessons...';
    DELETE FROM quiz_questions WHERE lesson_id IN (
        SELECT l.id FROM lessons l
        JOIN modules m ON l.module_id = m.id
        WHERE m.course_id = foundation_id
    );
    DELETE FROM lessons WHERE module_id IN (
        SELECT id FROM modules WHERE course_id = foundation_id
    );
    DELETE FROM modules WHERE course_id = foundation_id;
    
    RAISE NOTICE 'All old content deleted';
    
    -- CREATE MODULE 1: FOUNDATIONS OF FACEBOOK ADVERTISING
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (
        foundation_id,
        'Foundations of Facebook Advertising',
        'Master the fundamentals of Facebook Ads Manager and campaign structure',
        1
    )
    RETURNING id INTO mod1_id;
    
    RAISE NOTICE 'Module 1 created: %', mod1_id;
    
    -- CREATE LESSON 1: META ADS MANAGER SIMULATOR
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod1_id,
        'Meta Ads Manager Simulator',
        1,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Master the three-tier campaign structure (Campaigns, Ad Sets, Ads)</li>
<li>Navigate Meta Ads Manager interface confidently</li>
<li>Understand essential advertising metrics (CPM, CPC, CTR, ROAS)</li>
<li>Practice with Meta Ads Manager in a risk-free environment</li>
<li>Apply structured advertising strategies to real business scenarios</li>
</ul>

<h2>Introduction to Meta Ads Manager</h2>

<p>Meta Ads Manager is the central command center for all Facebook and Instagram advertising campaigns. Whether you are running a small local business or managing enterprise-level advertising budgets, understanding how to navigate and utilize this platform effectively is fundamental to your success in digital marketing.</p>

<p>The platform has evolved significantly over the years, transforming from a simple ad creation tool into a sophisticated marketing ecosystem that leverages artificial intelligence, machine learning, and vast amounts of user data to help advertisers reach their target audiences with unprecedented precision.</p>

<h2>Interactive Meta Ads Manager Simulator</h2>

<div style="background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%); padding: 2rem; border-radius: 12px; margin: 2rem 0;">
    <h3 style="color: white; margin-bottom: 1rem;">Practice Creating a Campaign</h3>
    <p style="color: rgba(255,255,255,0.9); margin-bottom: 1.5rem;">
        Launch the interactive simulator to practice creating a Facebook Ads campaign. Walk through all 5 steps: Objective, Audience, Budget, Creative, and Review.
    </p>
    
    <div style="background: white; padding: 1.5rem; border-radius: 8px; margin-bottom: 1rem;">
        <h4 style="color: #1e3a8a; margin-bottom: 0.5rem;">What You Will Practice:</h4>
        <ul style="color: #374151; margin-left: 1.5rem;">
            <li>Selecting campaign objectives (Awareness, Traffic, Engagement, Leads, Sales)</li>
            <li>Defining target audiences (location, age, gender, interests)</li>
            <li>Setting budgets and viewing estimated reach</li>
            <li>Creating ad copy, headlines, and calls-to-action</li>
            <li>Reviewing campaign summary and simulated metrics</li>
        </ul>
    </div>
    
    <a href="/meta-ads-simulator.html" target="_blank" 
       style="display: inline-block; background: white; color: #1e3a8a; padding: 1rem 2rem; border-radius: 8px; text-decoration: none; font-weight: bold; font-size: 1.1rem; box-shadow: 0 4px 6px rgba(0,0,0,0.1); transition: transform 0.2s;">
        Launch Simulator →
    </a>
    
    <p style="color: rgba(255,255,255,0.7); font-size: 0.875rem; margin-top: 1rem;">
        Opens in a new tab. This is a practice environment - no real money will be spent!
    </p>
</div>

<h2>Understanding the Three-Tier Campaign Structure</h2>

<p>At the heart of Meta Ads Manager lies a hierarchical structure that organizes your advertising efforts into three distinct levels: Campaigns, Ad Sets, and Ads. This structure is designed to give you granular control over every aspect of your advertising while maintaining organizational clarity as your campaigns scale.</p>

<p>The Campaign level is where you define your overarching marketing objective. Are you trying to increase brand awareness? Drive traffic to your website? Generate leads? Boost conversions? Each objective tells Facebook''s algorithm what actions you want people to take, which in turn influences how and where your ads are shown.</p>

<p>The Ad Set level is where the real targeting magic happens. Here, you define who will see your ads by selecting demographics, interests, behaviors, and custom audiences. You also set your budget and schedule at this level, determining how much you are willing to spend and when your ads will run.</p>

<p>The Ad level is where creativity meets strategy. This is where you design the actual advertisements that users will see in their feeds, stories, or other placements. You can create multiple ad variations within a single ad set, testing different images, videos, headlines, and calls-to-action.</p>

<h2>Essential Metrics and What They Mean</h2>

<p>Understanding the metrics displayed in Meta Ads Manager is crucial for making informed optimization decisions. Reach tells you how many unique individuals saw your ad at least once. Impressions count the total number of times your ad was displayed. The relationship between these two metrics reveals your frequency.</p>

<p>Click-through rate (CTR) is calculated by dividing clicks by impressions and multiplying by 100. It is a key indicator of how compelling your ad creative and messaging are. Cost per click (CPC) and cost per thousand impressions (CPM) are fundamental cost metrics that help you understand the efficiency of your ad delivery.</p>

<p>Return on ad spend (ROAS) is perhaps the most important metric for performance marketers. It is calculated by dividing the revenue generated by your ads by the amount spent on those ads. A ROAS of 3.0 means you are generating three dollars in revenue for every dollar spent on advertising.</p>

<h2>Real-World Case Study: E-Commerce Success Story</h2>

<p>Consider the case of a mid-sized fashion retailer based in Lagos, Nigeria, that was struggling with inefficient advertising spend. Before implementing a structured approach to Meta Ads Manager, they were spending approximately 500,000 Naira monthly on Facebook ads with minimal tracking and no clear understanding of which campaigns were driving actual sales.</p>

<p>After investing time in learning Meta Ads Manager properly, they restructured their entire advertising strategy. They created separate campaigns for different objectives: one for brand awareness targeting cold audiences, another for consideration targeting people who had visited their website, and a third for conversions targeting their warmest prospects.</p>

<p>The results were transformative. By properly utilizing the three-tier structure and monitoring the right metrics, they reduced their cost per purchase by 65% while simultaneously increasing their total sales volume by 240%. Their ROAS improved from a barely profitable 1.8x to a healthy 5.2x.</p>

<h2>Comprehensive Summary</h2>

<p>Meta Ads Manager represents a paradigm shift in how businesses approach digital advertising. Unlike traditional advertising channels where you broadcast your message to a broad, undefined audience, Meta Ads Manager gives you surgical precision in targeting exactly who sees your ads, when they see them, and how much you pay for that exposure.</p>

<p>The three-tier campaign structure is the foundation upon which all successful Meta advertising is built. Understanding this hierarchy is not just about knowing where to click in the interface; it is about developing a strategic mindset that separates objectives from targeting from creative execution.</p>

<p>The metrics available in Meta Ads Manager provide a wealth of information, but data without context is just noise. Successful advertisers understand what those metrics mean for their specific business model. They know their target cost per acquisition, their acceptable ROAS threshold, and their optimal frequency range.</p>

<p>Perhaps the most valuable aspect of Meta Ads Manager is its accessibility. You do not need a massive budget to get started - you can begin testing with as little as 1,000 Naira per day. What you do need is a willingness to learn, a commitment to testing and optimization, and the patience to let the data guide your decisions.</p>

<p>As you continue your journey with Meta Ads Manager, remember that mastery comes through practice. The simulator provided in this lesson gives you a risk-free environment to explore the interface, but real learning happens when you create actual campaigns, analyze real results, and make real optimization decisions.</p>

<p>The landscape of digital advertising is constantly evolving, with Meta regularly introducing new features, ad formats, and targeting capabilities. However, the fundamental principles covered in this lesson will serve you well regardless of how the platform evolves in the future.</p>

</div>',
        25,
        'https://www.youtube.com/watch?v=BZrio_G_1Cs'
    )
    RETURNING id INTO lesson1_id;
    
    RAISE NOTICE 'Lesson 1 created: %', lesson1_id;
    
    -- ADD 5 QUIZ QUESTIONS
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson1_id, 
     'What are the three hierarchical levels in Meta Ads Manager campaign structure?',
     '["Campaigns, Ad Sets, Ads", "Campaigns, Budgets, Creatives", "Objectives, Audiences, Placements", "Accounts, Campaigns, Ads"]'::jsonb,
     0,
     'The three-tier structure consists of Campaigns (objectives), Ad Sets (targeting and budget), and Ads (creative)'),
    
    (lesson1_id,
     'Which metric shows the percentage of people who clicked your ad after seeing it?',
     '["Click-Through Rate (CTR)", "Cost Per Click (CPC)", "Cost Per Mille (CPM)", "Return on Ad Spend (ROAS)"]'::jsonb,
     0,
     'CTR is calculated as (Clicks ÷ Impressions) × 100 and indicates ad engagement'),
    
    (lesson1_id,
     'At which level do you define your target audience in Meta Ads Manager?',
     '["Ad Set Level", "Campaign Level", "Ad Level", "Account Level"]'::jsonb,
     0,
     'Audience targeting, budget, and schedule are all defined at the Ad Set level'),
    
    (lesson1_id,
     'What does ROAS measure in advertising performance?',
     '["Revenue generated per dollar spent on ads", "Total ad impressions", "Click-through rate", "Cost per thousand impressions"]'::jsonb,
     0,
     'ROAS (Return on Ad Spend) = Revenue ÷ Ad Spend, showing profitability'),
    
    (lesson1_id,
     'Why is the three-tier campaign structure important for advertisers?',
     '["It provides granular control while maintaining organizational clarity", "It is required by Facebook", "It reduces advertising costs", "It automatically optimizes campaigns"]'::jsonb,
     0,
     'The structure separates objectives, targeting, and creative for better organization and testing');
    
    RAISE NOTICE '5 quiz questions added';
    RAISE NOTICE '======================';
    RAISE NOTICE 'LOCKDOWN COMPLETE!';
    RAISE NOTICE 'Foundation now has ONLY Module 1 with Lesson 1';
    RAISE NOTICE '======================';
    
END $$;

-- VERIFY FINAL STATE
SELECT 
    m.ordering as module_num,
    m.title as module_title,
    COUNT(DISTINCT l.id) as lesson_count
FROM modules m
LEFT JOIN lessons l ON m.id = l.module_id
WHERE m.course_id = (SELECT id FROM courses WHERE title = 'Facebook Ads Foundation')
GROUP BY m.ordering, m.title
ORDER BY m.ordering;

-- Check quiz count
SELECT 
    'Quiz Count' as check_type,
    COUNT(*) as total_quizzes
FROM quiz_questions q
JOIN lessons l ON q.lesson_id = l.id
JOIN modules m ON l.module_id = m.id
WHERE m.course_id = (SELECT id FROM courses WHERE title = 'Facebook Ads Foundation');
