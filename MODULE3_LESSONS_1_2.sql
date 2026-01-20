-- MODULE 3 - LESSONS 1-2
-- Campaign objectives and awareness/consideration/conversion

DO $$
DECLARE
    foundation_id UUID;
    mod3_id UUID;
    lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod3_id FROM modules WHERE course_id = foundation_id AND ordering = 3;
    
    RAISE NOTICE 'Creating Module 3 Lessons 1-2...';
    
    -- LESSON 1: Choosing the Right Campaign Objective
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod3_id,
        'Choosing the Right Campaign Objective',
        1,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Understand all Facebook campaign objectives and when to use them</li>
<li>Learn how objectives affect ad delivery and optimization</li>
<li>Master matching objectives to business goals</li>
<li>Understand the impact of objective choice on costs and results</li>
<li>Learn to test and optimize objective selection</li>
</ul>

<h2>Why Campaign Objectives Matter</h2>

<p>Your campaign objective is the single most important decision you make when creating a Facebook ad campaign. It tells Facebook what action you want people to take, which determines how your ads are delivered, who sees them, and what you pay for. Choosing the wrong objective can make your campaign 3-5x more expensive or completely ineffective, even if everything else is perfect.</p>

<p>Facebook optimizes your campaign to achieve your stated objective. If you choose the Traffic objective, Facebook shows your ads to people likely to click. If you choose the Conversions objective, Facebook shows your ads to people likely to convert. The algorithm learns from billions of data points to predict who will take your desired action, but it can only optimize for what you tell it to optimize for.</p>

<h2>Awareness Objectives</h2>

<p>Brand Awareness campaigns maximize the number of people who will remember your ads. Facebook shows your ads to people most likely to recall them, using estimated ad recall as the optimization metric. This objective works well for new brands building recognition or established brands launching new products. However, awareness campaigns typically have the lowest direct response rates because they prioritize reach over action.</p>

<p>Reach campaigns maximize the number of unique people who see your ads. Unlike Brand Awareness which optimizes for memorability, Reach simply shows your ads to as many different people as possible within your target audience. This is useful for local businesses, events, or time-sensitive announcements where you need to reach your entire audience quickly.</p>

<h2>Consideration Objectives</h2>

<p>Traffic campaigns drive people to a destination - your website, app, or Messenger. Facebook optimizes for link clicks, showing your ads to people most likely to click through. This objective is cost-effective for driving website visits but does not optimize for what happens after the click. Use Traffic when you want visitors and have a strong website that converts them.</p>

<p>Engagement campaigns maximize likes, comments, shares, event responses, or offer claims. Facebook shows your ads to people most likely to engage with your content. This builds social proof and organic reach but does not directly drive conversions. Use Engagement when you want to build community, increase visibility, or create social proof for retargeting.</p>

<p>App Installs campaigns drive people to install your mobile app. Facebook optimizes for app installs, showing your ads to people most likely to download your app. This is essential for app-based businesses and typically delivers lower cost per install than other objectives because Facebook can optimize specifically for this action.</p>

<p>Video Views campaigns maximize the number of people who watch your videos. Facebook optimizes for video views, showing your ads to people most likely to watch. Use this objective to build awareness, tell your brand story, or create warm audiences of video viewers for retargeting. Video Views are typically cheaper than other objectives but do not directly drive conversions.</p>

<p>Lead Generation campaigns collect contact information through Facebook lead forms without requiring people to leave Facebook. This reduces friction and typically increases conversion rates compared to sending people to external landing pages. Use Lead Generation when you want to collect leads efficiently and have a follow-up system to convert them.</p>

<p>Messages campaigns start conversations in Messenger, Instagram, or WhatsApp. Facebook optimizes for message opens, showing your ads to people most likely to start a conversation. This is powerful for businesses that can provide value through conversation - customer service, bookings, consultations, or personalized recommendations.</p>

<h2>Conversion Objectives</h2>

<p>Conversions campaigns drive specific actions on your website or app - purchases, registrations, add to cart, or any custom event you track with the Facebook Pixel. Facebook optimizes for conversions, showing your ads to people most likely to complete your desired action. This is the most powerful objective for direct response marketing but requires sufficient conversion data for Facebook to optimize effectively.</p>

<p>Catalog Sales campaigns promote products from your product catalog to people most likely to purchase. Facebook automatically shows relevant products to each person based on their interests and behaviors. This is essential for e-commerce businesses with large product catalogs and works exceptionally well for retargeting people who viewed specific products.</p>

<p>Store Traffic campaigns drive people to visit your physical store locations. Facebook uses location data to show your ads to people near your stores and optimizes for store visits. This is valuable for businesses with physical locations who want to drive foot traffic.</p>

<h2>Matching Objectives to Business Goals</h2>

<p>If your goal is brand awareness, use Brand Awareness or Reach objectives. If your goal is website traffic, use Traffic. If your goal is engagement, use Engagement. If your goal is sales, use Conversions. This seems obvious, but many advertisers choose objectives based on cost rather than goal, which leads to poor results.</p>

<p>Consider your funnel stage. Top of funnel (awareness) might use Brand Awareness or Video Views. Middle of funnel (consideration) might use Traffic or Engagement. Bottom of funnel (conversion) should use Conversions or Catalog Sales. Different objectives serve different funnel stages.</p>

<p>Consider your tracking capability. Conversion objectives require the Facebook Pixel and sufficient conversion data. If you cannot track conversions properly, you cannot use conversion optimization effectively. In this case, Traffic or Engagement might be better choices until you have proper tracking in place.</p>

<h2>Real-World Case Study: E-Commerce Store</h2>

<p>An online fashion store was using the Traffic objective to drive sales, paying 50 Naira per click but only converting 1% of visitors, resulting in a 5,000 Naira cost per purchase. They were getting clicks but not sales because Facebook was optimizing for clicks, not purchases.</p>

<p>They switched to the Conversions objective optimized for purchases. Initially, their cost per click increased to 120 Naira, which worried them. However, their conversion rate jumped to 3.5% because Facebook was now showing ads to people likely to purchase, not just click. Their cost per purchase dropped to 3,400 Naira despite higher click costs.</p>

<p>They learned that the cheapest clicks do not equal the cheapest conversions. The Conversions objective cost more per click but delivered better overall results because it optimized for their actual goal. They scaled their Conversions campaigns while maintaining their Traffic campaigns for building awareness and retargeting audiences.</p>

<h2>Comprehensive Summary</h2>

<p>Campaign objectives determine how Facebook delivers and optimizes your ads. Choosing the right objective is more important than any other campaign decision because it fundamentally affects who sees your ads and what you pay for. The wrong objective can make even perfect targeting and creative ineffective.</p>

<p>Awareness objectives (Brand Awareness, Reach) maximize exposure and memorability. Consideration objectives (Traffic, Engagement, App Installs, Video Views, Lead Generation, Messages) drive specific actions that indicate interest. Conversion objectives (Conversions, Catalog Sales, Store Traffic) drive bottom-funnel actions that directly impact business results.</p>

<p>Match your objective to your actual business goal, not to what seems cheapest. Cheap clicks mean nothing if they do not convert. Expensive clicks that convert are valuable. The Conversions objective typically delivers the best results for direct response marketing but requires proper tracking and sufficient conversion data to work effectively.</p>

<p>Different objectives serve different funnel stages. Use awareness objectives for cold audiences, consideration objectives for warm audiences, and conversion objectives for hot audiences. A complete advertising strategy uses multiple objectives strategically rather than relying on a single objective for all campaigns.</p>

</div>',
        28,
        'https://www.youtube.com/watch?v=JRnB1OJrqzk'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'Why is campaign objective the most important decision?',
     '["It determines how Facebook optimizes and delivers your ads", "It affects your ad creative", "It changes your targeting options", "It determines your budget"]'::jsonb,
     0,
     'Campaign objective tells Facebook what action you want, which determines optimization and delivery'),
    
    (lesson_id,
     'What does the Conversions objective optimize for?',
     '["Specific actions like purchases or registrations", "Link clicks", "Video views", "Post engagement"]'::jsonb,
     0,
     'Conversions objective optimizes for specific actions you track with the Facebook Pixel'),
    
    (lesson_id,
     'When should you use the Traffic objective?',
     '["When you want website visits and have a strong converting website", "When you want purchases", "When you want video views", "When you want app installs"]'::jsonb,
     0,
     'Traffic objective drives clicks to your website but does not optimize for conversions'),
    
    (lesson_id,
     'What is required to use the Conversions objective effectively?',
     '["Facebook Pixel and sufficient conversion data", "Large budget only", "Video ads only", "Lookalike audiences"]'::jsonb,
     0,
     'Conversions objective requires tracking with the Pixel and enough conversion data for optimization'),
    
    (lesson_id,
     'Why might the Conversions objective have higher cost per click than Traffic?',
     '["It targets people more likely to convert, not just click", "Facebook charges more for it", "It requires better creative", "It has smaller audiences"]'::jsonb,
     0,
     'Conversions objective targets quality over quantity, resulting in higher click costs but better conversion rates');
    
    RAISE NOTICE 'Lesson 1 created';
    
    -- LESSON 2: Awareness vs Consideration vs Conversion
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod3_id,
        'Awareness vs. Consideration vs. Conversion',
        2,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Understand the three stages of the marketing funnel</li>
<li>Learn which objectives serve each funnel stage</li>
<li>Master creating campaigns for each stage</li>
<li>Understand how stages work together</li>
<li>Learn to allocate budget across funnel stages</li>
</ul>

<h2>The Marketing Funnel Framework</h2>

<p>The marketing funnel represents the customer journey from first awareness of your brand to final purchase and beyond. Understanding this journey is essential for creating effective advertising strategies. Most advertisers fail because they try to drive conversions from cold audiences who are not ready to buy, or waste budget on awareness for audiences already familiar with their brand.</p>

<p>The funnel has three main stages: Awareness (top of funnel), Consideration (middle of funnel), and Conversion (bottom of funnel). Each stage serves a specific purpose, requires different messaging and objectives, and attracts audiences at different levels of purchase readiness. Successful advertising strategies address all three stages rather than focusing exclusively on one.</p>

<h2>Awareness Stage: Building Recognition</h2>

<p>Awareness campaigns introduce your brand to cold audiences who have never heard of you. The goal is not immediate conversion but recognition and interest. People cannot buy from you if they do not know you exist. Awareness campaigns create the foundation for future consideration and conversion.</p>

<p>Use Brand Awareness, Reach, or Video Views objectives for awareness campaigns. These objectives maximize exposure and memorability rather than driving immediate action. Your messaging should focus on introducing your brand, explaining what you do, and creating interest rather than pushing for immediate purchase.</p>

<p>Awareness campaigns typically have the lowest direct ROI because they do not drive immediate conversions. However, they are essential for building the audience pool that your consideration and conversion campaigns will target. Without awareness campaigns, you have no warm audiences to retarget.</p>

<p>Target cold audiences with awareness campaigns - people who match your customer profile but have never interacted with your brand. Use broad targeting to maximize reach while maintaining relevance. The goal is to get your brand in front of as many relevant people as possible.</p>

<h2>Consideration Stage: Building Interest</h2>

<p>Consideration campaigns target warm audiences who know your brand and are evaluating whether to purchase. These people are past the awareness stage but not yet ready to convert. They need more information, social proof, or convincing before making a purchase decision.</p>

<p>Use Traffic, Engagement, Video Views, or Lead Generation objectives for consideration campaigns. These objectives drive actions that indicate interest without requiring immediate purchase. Your messaging should provide value, address objections, showcase benefits, and build trust.</p>

<p>Consideration campaigns bridge the gap between awareness and conversion. They warm up cold audiences and prepare them for conversion campaigns. People who engage with consideration content are much more likely to convert than those who only saw awareness ads.</p>

<p>Target warm audiences with consideration campaigns - website visitors, video viewers, post engagers, or people who interacted with your awareness campaigns. These audiences have shown interest and are more receptive to detailed information about your products or services.</p>

<h2>Conversion Stage: Driving Action</h2>

<p>Conversion campaigns target hot audiences ready to purchase. These people know your brand, understand your value proposition, and are evaluating whether to buy now. Your goal is to drive immediate action through compelling offers, urgency, or removing final objections.</p>

<p>Use Conversions, Catalog Sales, or Store Traffic objectives for conversion campaigns. These objectives optimize for bottom-funnel actions that directly impact revenue. Your messaging should be direct and action-oriented, focusing on offers, benefits, and clear calls to action.</p>

<p>Conversion campaigns typically have the highest ROI because they target people ready to buy. However, they require warm audiences created by awareness and consideration campaigns. You cannot run conversion campaigns effectively without first building awareness and consideration.</p>

<p>Target hot audiences with conversion campaigns - cart abandoners, product page viewers, pricing page visitors, or people who engaged heavily with consideration content. These audiences have demonstrated strong purchase intent and need a final push to convert.</p>

<h2>How Stages Work Together</h2>

<p>The three stages are not independent - they work together as a system. Awareness campaigns create audiences for consideration campaigns. Consideration campaigns create audiences for conversion campaigns. Conversion campaigns generate customers who can be targeted with retention and upsell campaigns.</p>

<p>A complete funnel strategy runs campaigns at all three stages simultaneously. Cold traffic flows into awareness campaigns, engaged users flow into consideration campaigns, and interested prospects flow into conversion campaigns. This creates a continuous pipeline of prospects at different stages of readiness.</p>

<p>Exclude audiences from inappropriate stages. Exclude converters from awareness and consideration campaigns. Exclude heavy engagers from basic awareness campaigns. Exclude cold audiences from aggressive conversion campaigns. This prevents waste and ensures each campaign targets the right people.</p>

<h2>Budget Allocation Across Stages</h2>

<p>Budget allocation depends on your business maturity and goals. New businesses might allocate 50% to awareness, 30% to consideration, and 20% to conversion to build their audience. Established businesses might allocate 20% to awareness, 30% to consideration, and 50% to conversion to maximize immediate returns.</p>

<p>Monitor how audiences flow through your funnel. If your awareness campaigns create large audiences but few convert, you need stronger consideration campaigns. If your consideration campaigns engage people but few convert, you need better conversion campaigns or offers. The funnel reveals where your strategy needs improvement.</p>

<p>Test different allocations to find your optimal mix. Some businesses need heavy awareness investment, others can focus primarily on conversion. Your optimal allocation depends on your industry, competition, product, and existing brand recognition.</p>

<h2>Real-World Case Study: SaaS Company</h2>

<p>A project management SaaS company was spending 100% of their 300,000 Naira monthly budget on conversion campaigns targeting cold audiences. Their cost per trial was 8,500 Naira and trial-to-paid conversion was only 6% because they were pushing for trials from people who did not know or trust their brand.</p>

<p>They restructured their strategy across all three funnel stages. They allocated 30% to awareness (video campaigns introducing their platform), 40% to consideration (traffic campaigns to blog content and case studies), and 30% to conversion (conversion campaigns targeting engaged audiences).</p>

<p>The awareness campaigns built audiences of video viewers and blog readers. The consideration campaigns retargeted these audiences with detailed content about features and benefits. The conversion campaigns retargeted people who engaged with consideration content, offering free trials.</p>

<p>Results transformed their business. Cost per trial dropped to 3,200 Naira, but more importantly, trial-to-paid conversion increased to 22% because they were attracting qualified, educated prospects who understood and valued their platform. Their effective customer acquisition cost dropped by 70% by building a proper funnel rather than pushing for immediate conversions from cold audiences.</p>

<h2>Comprehensive Summary</h2>

<p>The marketing funnel framework divides the customer journey into awareness, consideration, and conversion stages. Each stage serves a specific purpose and requires different objectives, messaging, and targeting. Understanding these stages is essential for creating effective advertising strategies that guide prospects from first awareness to final purchase.</p>

<p>Awareness campaigns introduce your brand to cold audiences, creating the foundation for future consideration and conversion. Consideration campaigns provide information and build trust with warm audiences who know your brand but are not yet ready to buy. Conversion campaigns drive action from hot audiences ready to purchase.</p>

<p>The three stages work together as a system, not independently. Awareness creates audiences for consideration, consideration creates audiences for conversion, and conversion generates customers for retention. A complete strategy addresses all three stages simultaneously, creating a continuous pipeline of prospects at different readiness levels.</p>

<p>Budget allocation across stages depends on your business maturity and goals. New businesses need heavy awareness investment to build audiences, while established businesses can focus more on conversion. Monitor how audiences flow through your funnel to identify where your strategy needs improvement and test different allocations to find your optimal mix.</p>

</div>',
        26,
        'https://www.youtube.com/watch?v=2xfMQDxaG_w'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'What are the three main stages of the marketing funnel?',
     '["Awareness, Consideration, Conversion", "Traffic, Engagement, Sales", "Cold, Warm, Hot", "Top, Middle, Bottom"]'::jsonb,
     0,
     'The three funnel stages are Awareness (top), Consideration (middle), and Conversion (bottom)'),
    
    (lesson_id,
     'What is the goal of awareness campaigns?',
     '["Introduce your brand to cold audiences and create recognition", "Drive immediate sales", "Collect email addresses", "Retarget existing customers"]'::jsonb,
     0,
     'Awareness campaigns build brand recognition with cold audiences, not immediate conversions'),
    
    (lesson_id,
     'Which objectives are best for consideration campaigns?',
     '["Traffic, Engagement, Video Views, Lead Generation", "Conversions and Catalog Sales only", "Brand Awareness and Reach only", "Store Traffic only"]'::jsonb,
     0,
     'Consideration objectives drive interest-indicating actions without requiring immediate purchase'),
    
    (lesson_id,
     'Why do the three funnel stages need to work together?',
     '["Awareness creates audiences for consideration, which creates audiences for conversion", "Facebook requires it", "It reduces advertising costs", "It improves ad quality"]'::jsonb,
     0,
     'The stages work as a system - each stage creates qualified audiences for the next stage'),
    
    (lesson_id,
     'How should a new business allocate budget across funnel stages?',
     '["More to awareness to build audiences, less to conversion", "All budget to conversion campaigns", "Equal allocation across all stages", "Only awareness campaigns"]'::jsonb,
     0,
     'New businesses need heavy awareness investment to build the audience pool for consideration and conversion');
    
    RAISE NOTICE 'Lesson 2 created';
    
END $$;
