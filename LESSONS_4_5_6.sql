-- FACEBOOK ADS FOUNDATION - LESSONS 4, 5, 6
-- Final three lessons for Module 1

DO $$
DECLARE
    foundation_id UUID;
    mod1_id UUID;
    lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod1_id FROM modules WHERE course_id = foundation_id AND ordering = 1;
    
    RAISE NOTICE 'Creating Lessons 4-6...';
    
    -- =====================================================
    -- LESSON 4: Understanding the Facebook Ads Ecosystem
    -- =====================================================
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod1_id,
        'Understanding the Facebook Ads Ecosystem',
        4,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Understand the full scope of Meta''s advertising platforms</li>
<li>Learn the unique characteristics of each placement option</li>
<li>Master how to choose the right placements for your goals</li>
<li>Understand audience behavior across different platforms</li>
<li>Learn how to leverage the Audience Network effectively</li>
</ul>

<h2>The Multi-Platform Advertising Ecosystem</h2>

<p>When you create an ad through Meta Ads Manager, you are not just advertising on Facebook. You gain access to a vast ecosystem that includes Facebook, Instagram, Messenger, WhatsApp (in select markets), and the Audience Network - a collection of thousands of third-party apps and websites. This multi-platform reach is one of Meta''s most powerful advantages, allowing you to connect with your audience across their entire digital journey.</p>

<p>Each platform within the ecosystem serves different user needs and creates different advertising opportunities. Facebook remains the largest platform with the broadest demographic reach, particularly strong among users aged 25-65. Instagram skews younger and more visual, with exceptional engagement rates among 18-34 year olds. Messenger enables direct conversation and customer service integration. The Audience Network extends your reach beyond Meta''s owned properties to capture attention across the broader mobile ecosystem.</p>

<h2>Facebook Placement Options</h2>

<p>Facebook offers multiple placement options, each with distinct characteristics and performance profiles. The Facebook News Feed remains the most prominent placement, appearing directly in users'' content streams as they scroll. These ads blend seamlessly with organic content, achieving high visibility and engagement. Feed ads support all ad formats including images, videos, carousels, and collections, making them versatile for various campaign objectives.</p>

<p>Facebook Stories provide a full-screen, immersive experience that captures complete attention. Stories ads appear between organic Stories from friends and Pages users follow. The vertical, full-screen format is ideal for mobile-first creative and works particularly well for brand awareness and engagement objectives. Stories have higher completion rates than feed ads because users actively swipe through them rather than passively scrolling.</p>

<p>The right column on desktop Facebook displays smaller ads that are less intrusive but also less engaging than feed placements. These ads work well for retargeting and direct response campaigns where you are reaching people already familiar with your brand. While right column ads typically have lower click-through rates than feed ads, they also cost less, making them efficient for certain objectives.</p>

<h2>Instagram Advertising Opportunities</h2>

<p>Instagram Feed ads appear in users'' main content streams, similar to Facebook Feed ads but in Instagram''s more visual, curated environment. The platform''s emphasis on high-quality imagery and aesthetics means your creative needs to meet higher visual standards to perform well. Instagram users expect beautiful, inspiring content, and ads that look like advertisements rather than organic posts tend to underperform.</p>

<p>Instagram Stories have become one of the most effective ad placements across the entire Meta ecosystem. The full-screen, vertical format creates an immersive experience, and the ephemeral nature of Stories creates urgency. Users engage with Stories actively, swiping through content rather than passively scrolling, which leads to higher attention and engagement rates. Stories work exceptionally well for time-sensitive offers, product launches, and behind-the-scenes content.</p>

<p>Instagram Reels, the platform''s short-form video feature, offers access to highly engaged audiences consuming entertaining content. Reels ads appear between organic Reels as users swipe through the feed. The format favors authentic, entertaining content over polished advertisements. Brands that succeed with Reels ads create content that feels native to the platform - quick, engaging, and valuable rather than overtly promotional.</p>

<h2>Messenger and Audience Network</h2>

<p>Messenger ads appear in the Chats tab of the Messenger app, creating opportunities for direct conversation with potential customers. These ads can drive users to initiate conversations with your business, making them powerful for customer service, lead generation, and relationship building. Messenger ads work particularly well for businesses that can provide immediate value through conversation, such as booking services, customer support, or personalized recommendations.</p>

<p>The Audience Network extends your campaigns to thousands of third-party mobile apps and websites. This dramatically expands your potential reach beyond Meta''s owned properties. Audience Network placements include banner ads, interstitials, native ads, and rewarded video ads in mobile games and apps. While these placements typically have lower engagement rates than Facebook or Instagram, they significantly increase reach and can be cost-effective for awareness campaigns.</p>

<h2>Choosing the Right Placements</h2>

<p>Meta''s automatic placements option uses machine learning to show your ads in the placements most likely to achieve your objective at the lowest cost. For most advertisers, especially beginners, automatic placements deliver better results than manual selection because the algorithm can optimize across all available options. The system learns which placements work best for your specific audience and creative, then allocates budget accordingly.</p>

<p>However, manual placement selection makes sense in specific scenarios. If you have creative designed specifically for one format (like vertical video for Stories), you might want to limit placements to ensure your creative displays properly. If you are running a brand awareness campaign and want to ensure your ads appear only in premium environments, you might exclude Audience Network. If you have data showing certain placements consistently underperform for your business, you can exclude them.</p>

<h2>Real-World Case Study: E-Commerce Multi-Platform Success</h2>

<p>An online fashion retailer in Nigeria was running all their ads exclusively in Facebook Feed, achieving moderate results with a 2.5x ROAS. They decided to test a multi-platform approach, creating platform-specific creative for Facebook Feed, Instagram Feed, Instagram Stories, and Reels.</p>

<p>They discovered that while Facebook Feed drove the highest volume of purchases, Instagram Stories had the highest conversion rate and lowest cost per purchase. Reels drove massive reach and brand awareness but lower immediate conversions. Instagram Feed performed best with carousel ads showcasing multiple products, while Stories performed best with single-product video ads featuring customer testimonials.</p>

<p>By optimizing their creative for each placement and allocating budget based on performance, they increased their overall ROAS to 4.2x while doubling their total sales volume. They learned that different placements served different roles in their customer journey - Reels for discovery, Stories for consideration, and Feed for conversion. This multi-platform strategy allowed them to reach customers at every stage of their buying journey.</p>

<h2>Comprehensive Summary</h2>

<p>The Meta advertising ecosystem encompasses far more than just Facebook. With placements across Facebook, Instagram, Messenger, and the Audience Network, you can reach your audience throughout their digital day across multiple contexts and mindsets. Understanding the unique characteristics of each platform and placement allows you to create more effective campaigns and allocate your budget more efficiently.</p>

<p>Each placement serves different user needs and creates different advertising opportunities. Facebook Feed offers broad reach and versatile ad formats. Instagram Feed demands higher visual quality but delivers engaged, younger audiences. Stories across both platforms create immersive, full-screen experiences with high completion rates. Reels tap into the growing demand for short-form video content. Messenger enables direct conversation. The Audience Network extends reach beyond Meta''s properties.</p>

<p>Automatic placements work well for most advertisers because Meta''s algorithms can optimize across all options to find the best performance. However, understanding each placement''s characteristics allows you to make informed decisions about when to use manual placement selection. Platform-specific creative that respects each environment''s unique characteristics and user expectations typically outperforms generic creative used across all placements.</p>

<p>Success in the Meta advertising ecosystem requires thinking beyond individual placements to consider how they work together in your customer journey. Different placements can serve different roles - some for awareness, others for consideration, and others for conversion. A sophisticated advertising strategy leverages multiple placements strategically rather than treating them as interchangeable options.</p>

</div>',
        22,
        'https://www.youtube.com/watch?v=JRnB1OJrqzk'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'Which platforms are included in the Meta advertising ecosystem?',
     '["Facebook, Instagram, Messenger, Audience Network", "Facebook and Instagram only", "Facebook, Instagram, Twitter, LinkedIn", "Only Facebook"]'::jsonb,
     0,
     'Meta Ads Manager provides access to Facebook, Instagram, Messenger, and the Audience Network'),
    
    (lesson_id,
     'What is a key characteristic of Instagram Stories ads?',
     '["Full-screen, immersive vertical format", "Appears in right column", "Text-only format", "Desktop-only placement"]'::jsonb,
     0,
     'Stories ads use a full-screen vertical format that creates an immersive mobile experience'),
    
    (lesson_id,
     'What is the Audience Network?',
     '["Thousands of third-party apps and websites where your ads can appear", "A Facebook group for advertisers", "Instagram influencers who promote products", "A list of your website visitors"]'::jsonb,
     0,
     'The Audience Network extends your reach to thousands of mobile apps and websites beyond Meta''s platforms'),
    
    (lesson_id,
     'When should you use automatic placements?',
     '["For most campaigns, as algorithms optimize across all options", "Never, always choose manually", "Only for small budgets", "Only for video ads"]'::jsonb,
     0,
     'Automatic placements typically deliver better results because algorithms optimize across all available options'),
    
    (lesson_id,
     'What type of content performs best on Instagram Reels?',
     '["Authentic, entertaining content that feels native to the platform", "Polished, professional advertisements", "Long-form educational content", "Text-heavy promotional posts"]'::jsonb,
     0,
     'Reels favors authentic, entertaining content over polished advertisements');
    
    RAISE NOTICE 'Lesson 4 created with 5 quizzes';
    
    -- =====================================================
    -- LESSON 5: Navigating Meta Ads Manager
    -- =====================================================
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod1_id,
        'Navigating Meta Ads Manager',
        5,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Master the Meta Ads Manager interface and navigation</li>
<li>Understand how to use filters and columns effectively</li>
<li>Learn to create and save custom views</li>
<li>Master the campaign creation workflow</li>
<li>Understand how to efficiently manage multiple campaigns</li>
</ul>

<h2>The Ads Manager Interface Overview</h2>

<p>Meta Ads Manager is your central dashboard for creating, managing, and analyzing advertising campaigns. The interface is organized into three main tabs - Campaigns, Ad Sets, and Ads - reflecting the three-tier campaign structure. Understanding how to navigate efficiently between these levels and customize your view is essential for effective campaign management, especially as your account grows to include dozens or hundreds of campaigns.</p>

<p>The main dashboard displays your campaigns in a table format with customizable columns showing key metrics. Above the table, you will find the date range selector, which controls what time period your data reflects. The account dropdown allows you to switch between different ad accounts if you manage multiple. The search bar enables quick location of specific campaigns, ad sets, or ads by name or ID.</p>

<h2>Customizing Columns and Views</h2>

<p>The default column view shows basic metrics like results, reach, and amount spent, but Ads Manager offers dozens of additional metrics you can display. Click "Columns" and select "Customize Columns" to access the full list. You can add metrics for delivery, engagement, video performance, conversion tracking, and more. Creating custom column sets for different purposes - one for performance analysis, another for creative testing, another for budget monitoring - streamlines your workflow.</p>

<p>Save your custom column configurations by clicking "Columns," then "Customize Columns," making your selections, and clicking "Save as Preset." Name your preset descriptively so you can quickly switch between different views. For example, you might create presets called "Performance Overview," "Creative Analysis," "Budget Monitoring," and "Conversion Tracking." This saves time and ensures you are always looking at the right metrics for your current task.</p>

<h2>Using Filters Effectively</h2>

<p>Filters allow you to narrow down what campaigns, ad sets, or ads you are viewing based on specific criteria. Click "Filters" to access options including delivery status, objective, creation date, and more. You can combine multiple filters to create very specific views. For example, you might filter to show only active campaigns created in the last 30 days with the conversion objective.</p>

<p>Like column configurations, you can save frequently used filter combinations. This is particularly valuable if you manage many campaigns and regularly need to view specific subsets. For instance, you might create saved filters for "Active Conversion Campaigns," "Paused Campaigns Needing Review," "New Campaigns This Month," or "High-Spending Campaigns." Saved filters appear in your Filters dropdown for quick access.</p>

<h2>The Campaign Creation Workflow</h2>

<p>Creating a new campaign begins with clicking the green "Create" button. You will immediately be asked to choose your campaign objective - the single most important decision in the campaign creation process. Your objective tells Facebook what action you want people to take, which determines how your ads are optimized and what bidding options are available. Choose carefully based on your actual business goal, not what you think might cost less.</p>

<p>After selecting your objective, you name your campaign and decide whether to use Campaign Budget Optimization (CBO). CBO allows Facebook to automatically distribute your budget across ad sets to maximize results, while manual budgeting gives you control over how much each ad set spends. For beginners, CBO typically delivers better results because the algorithm can optimize budget allocation in real-time based on performance.</p>

<p>Moving to the ad set level, you define your audience, placements, budget, and schedule. The audience section is where you specify who will see your ads based on location, demographics, interests, and behaviors. The placements section determines where your ads appear across Meta''s platforms. Budget and schedule control how much you spend and when your ads run. Each decision at the ad set level significantly impacts your campaign''s performance and cost.</p>

<h2>Managing Multiple Campaigns</h2>

<p>As your advertising scales, you will manage multiple campaigns simultaneously. Ads Manager provides several tools to make this manageable. The bulk editing feature allows you to modify multiple campaigns, ad sets, or ads at once. Select the items you want to edit using the checkboxes, then click "Edit" to change settings like budget, schedule, or targeting across all selected items simultaneously.</p>

<p>The duplicate function creates copies of existing campaigns, ad sets, or ads, saving time when you want to test variations or scale successful campaigns. Right-click any campaign, ad set, or ad and select "Duplicate" to create a copy. You can then modify the copy as needed. This is much faster than creating everything from scratch and ensures consistency across your campaigns.</p>

<h2>Real-World Case Study: Agency Efficiency Gains</h2>

<p>A social media agency managing 50+ client accounts was spending hours each day navigating Ads Manager, searching for specific campaigns, and switching between different metric views. Their team members each had their own way of organizing and viewing campaigns, making collaboration difficult and handoffs between team members time-consuming.</p>

<p>They implemented a standardized system of custom columns and saved filters. They created five standard column presets that everyone used: Daily Overview, Weekly Performance, Creative Analysis, Audience Insights, and Budget Monitoring. They created saved filters for each client and for different campaign types. They established naming conventions for all campaigns, ad sets, and ads that made searching and sorting efficient.</p>

<p>The results were dramatic. Time spent navigating Ads Manager decreased by 40%. Team collaboration improved because everyone was looking at the same metrics in the same way. Client reporting became faster because they could quickly pull up exactly the data they needed. New team members could be productive immediately because the standardized system was easy to learn. The agency scaled from 50 to 100 clients without proportionally increasing their team size because their systems made everyone more efficient.</p>

<h2>Comprehensive Summary</h2>

<p>Mastering Meta Ads Manager navigation is not just about knowing where to click - it is about developing efficient workflows that allow you to manage campaigns effectively as your advertising scales. The interface offers extensive customization options for columns, filters, and views that can dramatically improve your productivity when configured thoughtfully.</p>

<p>Custom column configurations allow you to focus on the metrics that matter for your current task without being overwhelmed by irrelevant data. Creating and saving multiple column presets for different purposes - performance analysis, creative testing, budget monitoring - means you are always looking at the right information. This focused approach leads to better decision-making and faster campaign optimization.</p>

<p>Filters and saved filter combinations enable you to quickly find specific campaigns, ad sets, or ads even when managing hundreds of items. Rather than scrolling through endless lists or using the search function repeatedly, saved filters give you instant access to exactly what you need to review. This becomes increasingly valuable as your account grows and campaign management becomes more complex.</p>

<p>Understanding the campaign creation workflow and using tools like bulk editing and duplication makes campaign management scalable. You can efficiently create new campaigns, test variations, and manage multiple campaigns simultaneously without getting overwhelmed. These efficiency gains compound over time, allowing you to manage more campaigns with the same time investment.</p>

</div>',
        20,
        'https://www.youtube.com/watch?v=8rABwKRsec4'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'What are the three main tabs in Meta Ads Manager?',
     '["Campaigns, Ad Sets, Ads", "Overview, Reports, Settings", "Create, Manage, Analyze", "Budget, Targeting, Creative"]'::jsonb,
     0,
     'The three main tabs reflect the three-tier campaign structure: Campaigns, Ad Sets, and Ads'),
    
    (lesson_id,
     'Why should you create custom column configurations?',
     '["To focus on relevant metrics for different tasks", "To make the interface look better", "Facebook requires it", "To access hidden features"]'::jsonb,
     0,
     'Custom columns allow you to view the specific metrics relevant to your current task'),
    
    (lesson_id,
     'What is the benefit of saved filters?',
     '["Quick access to specific campaign subsets", "Lower advertising costs", "Better ad performance", "Automatic optimization"]'::jsonb,
     0,
     'Saved filters provide instant access to specific groups of campaigns without manual searching'),
    
    (lesson_id,
     'What is Campaign Budget Optimization (CBO)?',
     '["Facebook automatically distributes budget across ad sets", "You manually set budget for each ad", "A tool for reducing costs", "A reporting feature"]'::jsonb,
     0,
     'CBO allows Facebook to automatically allocate budget across ad sets to maximize results'),
    
    (lesson_id,
     'What is the bulk editing feature used for?',
     '["Modifying multiple campaigns, ad sets, or ads simultaneously", "Creating new campaigns faster", "Improving ad performance", "Reducing advertising costs"]'::jsonb,
     0,
     'Bulk editing allows you to change settings across multiple items at once, saving time');
    
    RAISE NOTICE 'Lesson 5 created with 5 quizzes';
    
    -- =====================================================
    -- LESSON 6: Key Terminology (CPM, CTR, ROAS, Pixel)
    -- =====================================================
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod1_id,
        'Key Terminology (CPM, CTR, ROAS, Pixel)',
        6,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Master essential Facebook Ads terminology and metrics</li>
<li>Understand how to calculate and interpret key performance indicators</li>
<li>Learn what metrics matter for different campaign objectives</li>
<li>Understand the Facebook Pixel and its importance</li>
<li>Learn how to use metrics to make optimization decisions</li>
</ul>

<h2>Cost Per Thousand Impressions (CPM)</h2>

<p>CPM, which stands for Cost Per Mille (mille is Latin for thousand), measures how much you pay for 1,000 ad impressions. An impression occurs each time your ad is displayed on someone''s screen, regardless of whether they interact with it. CPM is calculated by dividing your total spend by impressions, then multiplying by 1,000. For example, if you spent 10,000 Naira and received 50,000 impressions, your CPM would be 200 Naira.</p>

<p>CPM varies significantly based on your target audience, ad quality, competition, and timing. Highly competitive audiences (like business owners or high-income professionals) typically have higher CPMs because many advertisers want to reach them. Ad quality affects CPM because Facebook rewards ads that users engage with by showing them more frequently at lower costs. Seasonal factors also impact CPM - costs typically increase during major shopping periods like Black Friday or Christmas.</p>

<p>Understanding your CPM helps you evaluate the efficiency of your ad delivery. If your CPM suddenly increases, it might indicate increased competition, declining ad quality, or audience fatigue. If your CPM is consistently higher than industry benchmarks for your niche, you might need to improve your creative, refine your targeting, or adjust your bidding strategy.</p>

<h2>Click-Through Rate (CTR)</h2>

<p>Click-Through Rate measures the percentage of people who clicked your ad after seeing it. CTR is calculated by dividing clicks by impressions and multiplying by 100. For example, if your ad received 100 clicks from 10,000 impressions, your CTR would be 1%. CTR is one of the most important indicators of ad relevance and appeal - it tells you how compelling your ad is to your target audience.</p>

<p>A high CTR indicates that your ad resonates with your audience and motivates them to take action. A low CTR suggests that your ad is not compelling, your targeting is off, or there is a mismatch between your ad and your audience''s interests. Industry benchmarks vary, but generally, a CTR above 1% is considered good for Facebook ads, above 2% is very good, and above 3% is excellent.</p>

<p>However, CTR alone does not tell the complete story. You need to consider what happens after the click. An ad with a 5% CTR is not necessarily better than one with a 2% CTR if the 5% CTR ad attracts clicks from people who do not convert into customers. This is why you must evaluate CTR alongside conversion metrics to understand true performance.</p>

<h2>Cost Per Click (CPC) and Cost Per Action (CPA)</h2>

<p>Cost Per Click measures how much you pay each time someone clicks your ad. CPC is calculated by dividing total spend by total clicks. For example, if you spent 10,000 Naira and received 200 clicks, your CPC would be 50 Naira. CPC helps you understand the efficiency of driving traffic to your website or landing page.</p>

<p>Cost Per Action (also called Cost Per Conversion or Cost Per Result) measures how much you pay for each desired action - a purchase, lead, app install, or whatever your campaign objective is. CPA is calculated by dividing total spend by total conversions. For example, if you spent 50,000 Naira and generated 25 purchases, your CPA would be 2,000 Naira per purchase.</p>

<p>CPA is typically more important than CPC because it measures actual business results rather than just clicks. You might have a high CPC but low CPA if your landing page converts very well, or a low CPC but high CPA if your landing page converts poorly. Always optimize for the metric that matters to your business - usually conversions, not just clicks.</p>

<h2>Return on Ad Spend (ROAS)</h2>

<p>Return on Ad Spend is the ultimate performance metric for e-commerce and direct response campaigns. ROAS measures how much revenue you generate for every Naira spent on advertising. It is calculated by dividing revenue by ad spend. For example, if you spent 100,000 Naira on ads and generated 400,000 Naira in revenue, your ROAS would be 4.0x or 400%.</p>

<p>Understanding your break-even ROAS is crucial. This is the ROAS at which your advertising is neither profitable nor unprofitable after accounting for product costs, shipping, and other expenses. For example, if your products have a 50% profit margin, you need at least a 2.0x ROAS to break even. Anything above your break-even ROAS is profitable growth.</p>

<p>ROAS targets vary by business model and industry. E-commerce businesses might target 3-5x ROAS, while businesses with high customer lifetime value might accept lower initial ROAS knowing customers will make repeat purchases. The key is understanding your unit economics and setting ROAS targets that align with your business goals and profitability requirements.</p>

<h2>The Facebook Pixel</h2>

<p>The Facebook Pixel is a piece of code you install on your website that tracks visitor actions and sends that data back to Facebook. The Pixel enables conversion tracking, audience building, and campaign optimization. Without the Pixel, you cannot accurately measure conversions, create retargeting audiences, or optimize for specific actions beyond clicks.</p>

<p>The Pixel tracks standard events like page views, add to cart, initiate checkout, and purchase, as well as custom events you define. This data allows Facebook''s algorithm to optimize your campaigns for the actions you care about. For example, if you are running a conversion campaign optimized for purchases, the Pixel tells Facebook which users purchased after clicking your ad, allowing the algorithm to find more people likely to purchase.</p>

<p>Installing the Pixel correctly is non-negotiable for serious Facebook advertising. It is the foundation of conversion tracking, retargeting, and optimization. Even if you are not running conversion campaigns immediately, install the Pixel now so it can start collecting data. The Pixel becomes more powerful over time as it accumulates more data about your website visitors and their behaviors.</p>

<h2>Real-World Case Study: Metrics-Driven Optimization</h2>

<p>An online course creator was running Facebook ads with a 3% CTR, which seemed excellent. However, their CPA was 15,000 Naira for a course that sold for 25,000 Naira, leaving only 10,000 Naira to cover course delivery costs and profit. Their ROAS was barely 1.7x, well below their 3.0x target.</p>

<p>They analyzed their metrics and discovered that while their ad had a high CTR, their landing page had a poor conversion rate. People were clicking because the ad was compelling, but the landing page did not deliver on the ad''s promise. They redesigned their landing page to better match the ad''s messaging and added customer testimonials and a money-back guarantee.</p>

<p>After the landing page improvements, their CTR remained at 3%, but their conversion rate doubled. Their CPA dropped to 7,500 Naira, and their ROAS increased to 3.3x, exceeding their target. This case demonstrates why you must look beyond surface-level metrics like CTR to understand true performance. The real issue was not their ad (which had a great CTR) but what happened after the click.</p>

<h2>Comprehensive Summary</h2>

<p>Understanding Facebook Ads terminology and metrics is essential for making informed optimization decisions. Each metric tells you something different about your campaign performance, and you need to evaluate them together rather than in isolation. CPM tells you about delivery efficiency, CTR indicates ad relevance, CPC measures traffic cost, CPA reveals conversion efficiency, and ROAS shows overall profitability.</p>

<p>Different metrics matter for different campaign objectives. For awareness campaigns, you might focus on CPM and reach. For traffic campaigns, CTR and CPC are key. For conversion campaigns, CPA and ROAS are most important. Understanding which metrics align with your objectives prevents you from optimizing for the wrong things.</p>

<p>The Facebook Pixel is the foundation of effective conversion tracking and optimization. Without it, you are essentially flying blind, unable to measure true results or optimize for specific actions. Installing and properly configuring the Pixel should be one of your first steps when starting with Facebook advertising, even before running your first campaign.</p>

<p>Metrics-driven decision making separates successful advertisers from unsuccessful ones. Rather than making changes based on gut feelings or assumptions, successful advertisers let data guide their optimization decisions. They understand what their metrics mean, how they relate to business outcomes, and how to use them to improve campaign performance systematically.</p>

</div>',
        25,
        'https://www.youtube.com/watch?v=JRnB1OJrqzk'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'How is CPM calculated?',
     '["(Total Spend ÷ Impressions) × 1,000", "Total Spend ÷ Clicks", "Revenue ÷ Ad Spend", "Clicks ÷ Impressions"]'::jsonb,
     0,
     'CPM is calculated by dividing total spend by impressions, then multiplying by 1,000'),
    
    (lesson_id,
     'What does a high CTR indicate?',
     '["Your ad resonates with your audience and motivates action", "Your campaign is profitable", "Your landing page converts well", "Your CPM is low"]'::jsonb,
     0,
     'High CTR shows that your ad is compelling and relevant to your target audience'),
    
    (lesson_id,
     'What is ROAS?',
     '["Revenue generated per Naira spent on advertising", "Total ad impressions", "Click-through rate", "Cost per thousand impressions"]'::jsonb,
     0,
     'ROAS measures how much revenue you generate for every Naira spent on ads'),
    
    (lesson_id,
     'What is the Facebook Pixel?',
     '["Code installed on your website that tracks visitor actions", "A type of ad format", "A targeting option", "A bidding strategy"]'::jsonb,
     0,
     'The Pixel is code that tracks website visitor actions and sends data back to Facebook'),
    
    (lesson_id,
     'Why is CPA more important than CPC for most businesses?',
     '["CPA measures actual business results, not just clicks", "CPA is always lower than CPC", "Facebook recommends focusing on CPA", "CPA is easier to calculate"]'::jsonb,
     0,
     'CPA measures conversions (actual results) while CPC only measures clicks, which may not convert');
    
    RAISE NOTICE 'Lesson 6 created with 5 quizzes';
    RAISE NOTICE '======================';
    RAISE NOTICE 'MODULE 1 COMPLETE!';
    RAISE NOTICE 'All 6 lessons created with comprehensive content and quizzes';
    RAISE NOTICE '======================';
    
END $$;

-- Final Verification
SELECT 
    l.ordering,
    l.title,
    LENGTH(l.content) as content_chars,
    (SELECT COUNT(*) FROM quiz_questions WHERE lesson_id = l.id) as quiz_count
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation' AND m.ordering = 1
ORDER BY l.ordering;
