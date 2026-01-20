-- MODULE 2 - LESSON 1: Types of Audiences
-- Execute MODULE2_STRUCTURE.sql first, then this file

DO $$
DECLARE
    foundation_id UUID;
    mod2_id UUID;
    lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod2_id FROM modules WHERE course_id = foundation_id AND ordering = 2;
    
    IF mod2_id IS NULL THEN
        RAISE EXCEPTION 'Module 2 not found. Execute MODULE2_STRUCTURE.sql first';
    END IF;
    
    -- Lesson 1: Types of Audiences
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod2_id,
        'Types of Audiences: Core, Custom, Lookalike',
        1,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Understand the three main audience types in Facebook Ads</li>
<li>Master how to create and use Core Audiences</li>
<li>Learn to build powerful Custom Audiences from your data</li>
<li>Understand Lookalike Audiences and when to use them</li>
<li>Learn how to combine audience types strategically</li>
</ul>

<h2>Introduction to Facebook Audience Types</h2>

<p>Facebook offers three primary audience types, each serving different purposes in your advertising strategy. Core Audiences allow you to target people based on demographics, interests, and behaviors. Custom Audiences let you reach people who have already interacted with your business. Lookalike Audiences help you find new people similar to your best customers. Understanding when and how to use each type is fundamental to Facebook advertising success.</p>

<p>The power of Facebook advertising lies not in any single audience type, but in how you combine and layer them strategically. A sophisticated advertising strategy uses all three audience types at different stages of the customer journey, creating a comprehensive funnel that moves people from awareness to consideration to conversion.</p>

<h2>Core Audiences: Reaching New People</h2>

<p>Core Audiences are built using Facebook''s vast database of user information. You can target people based on location, age, gender, language, detailed demographics, interests, and behaviors. This is typically where you start when launching a new campaign or reaching cold audiences who have never heard of your business.</p>

<p>Location targeting allows you to reach people in specific countries, states, cities, or even within a radius of a specific address. You can target people who live in a location, people currently in a location, or people who have recently traveled to a location. This flexibility is powerful for local businesses, events, or location-specific offers.</p>

<p>Demographic targeting includes age, gender, education level, job title, relationship status, and life events. You can target new parents, people who recently moved, engaged couples, or people with specific job titles. These demographic filters help you reach people at moments when they are most likely to need your product or service.</p>

<p>Interest targeting leverages the pages people like, content they engage with, and activities they participate in on Facebook. You can target people interested in specific topics, hobbies, brands, or activities. For example, you could target people interested in fitness, vegan cooking, entrepreneurship, or specific brands like Nike or Apple.</p>

<p>Behavior targeting uses data about purchase behaviors, device usage, travel patterns, and other activities. You can target people who have recently purchased specific types of products, use specific devices, travel frequently, or engage in specific activities. This data comes from both Facebook activity and third-party data partnerships.</p>

<h2>Custom Audiences: Retargeting Your Warm Traffic</h2>

<p>Custom Audiences allow you to upload your own customer data or target people who have interacted with your business on Facebook, Instagram, or your website. These are your warmest audiences - people who already know your brand and have shown some level of interest.</p>

<p>Website Custom Audiences use the Facebook Pixel to target people who visited your website. You can create audiences based on specific pages visited, time spent on site, or actions taken. For example, you could target people who viewed a product page but did not purchase, or people who added items to cart but did not complete checkout.</p>

<p>Customer List Custom Audiences allow you to upload email addresses, phone numbers, or other customer data. Facebook matches this data to user profiles, allowing you to target your existing customers or leads. This is powerful for promoting new products to existing customers, re-engaging inactive customers, or excluding existing customers from acquisition campaigns.</p>

<p>Engagement Custom Audiences target people who have interacted with your content on Facebook or Instagram. You can create audiences of people who watched your videos, engaged with your posts, visited your profile, or interacted with your Instagram business profile. These audiences are valuable because they have already shown interest in your content.</p>

<h2>Lookalike Audiences: Finding Your Next Best Customers</h2>

<p>Lookalike Audiences use Facebook''s algorithm to find people similar to your existing customers or audiences. You provide a source audience (like your customer list or website visitors), and Facebook finds people who share similar characteristics, behaviors, and interests. This is one of Facebook''s most powerful features for scaling successful campaigns.</p>

<p>Lookalike percentages range from 1% to 10%, with 1% being most similar to your source audience and 10% being broader. A 1% Lookalike of 1 million people in Nigeria would be the 10,000 people most similar to your source audience. A 10% Lookalike would be the 100,000 people most similar. Smaller percentages are more precise but reach fewer people, while larger percentages reach more people but with less similarity.</p>

<p>The quality of your Lookalike Audience depends entirely on the quality of your source audience. A Lookalike based on your best customers will perform better than one based on all website visitors. Many advertisers create Lookalikes based on purchasers, high-value customers, or engaged email subscribers rather than all customers or all website visitors.</p>

<h2>Strategic Audience Combinations</h2>

<p>The real power comes from combining audience types strategically. You might use Core Audiences to reach cold traffic, Custom Audiences to retarget warm traffic, and Lookalike Audiences to scale what works. A typical funnel might look like: Core Audiences for awareness, Custom Audiences (website visitors) for consideration, and Custom Audiences (cart abandoners) for conversion.</p>

<p>Exclusions are just as important as inclusions. You can exclude Custom Audiences from your Core Audience campaigns to avoid wasting budget on people who already know your brand. You can exclude purchasers from retargeting campaigns. You can exclude low-quality audiences from Lookalike campaigns. Strategic exclusions improve efficiency and reduce ad fatigue.</p>

<h2>Real-World Case Study: E-Learning Platform</h2>

<p>An online course platform in Nigeria was spending 200,000 Naira monthly on Facebook ads targeting a broad Core Audience interested in "online learning" and "professional development." Their cost per enrollment was 8,000 Naira, barely profitable given their 15,000 Naira course price.</p>

<p>They implemented a three-tier audience strategy. First, they created a Custom Audience of website visitors and excluded them from their Core Audience campaigns, reducing wasted spend. Second, they created separate retargeting campaigns for website visitors who did not enroll, achieving a 4,000 Naira cost per enrollment. Third, they created a 1% Lookalike Audience based on their enrolled students and targeted it with awareness campaigns.</p>

<p>The Lookalike Audience performed exceptionally well, with a 5,500 Naira cost per enrollment - better than their original broad targeting but reaching entirely new people. They scaled their Lookalike campaigns while maintaining retargeting campaigns for warm traffic. Within three months, they doubled their enrollments while reducing their average cost per enrollment to 5,200 Naira. The strategic use of all three audience types created a sustainable, scalable acquisition system.</p>

<h2>Comprehensive Summary</h2>

<p>Understanding Facebook''s three audience types - Core, Custom, and Lookalike - is fundamental to advertising success. Each type serves a specific purpose in your marketing funnel, and the most effective strategies use all three types strategically rather than relying on any single approach.</p>

<p>Core Audiences are your entry point for reaching new people who have never heard of your business. They leverage Facebook''s extensive user data to target people based on demographics, interests, and behaviors. While Core Audiences can be powerful, they are typically less efficient than Custom or Lookalike Audiences because you are reaching cold traffic with no prior connection to your brand.</p>

<p>Custom Audiences represent your warmest traffic - people who have already interacted with your business in some way. Whether through website visits, email lists, or social media engagement, these audiences have shown interest and are more likely to convert. Custom Audiences typically have lower costs per result and higher conversion rates than cold audiences, making them essential for efficient advertising.</p>

<p>Lookalike Audiences bridge the gap between cold and warm traffic, allowing you to find new people who share characteristics with your best customers. This Facebook-exclusive feature uses machine learning to identify patterns in your source audience and find similar people at scale. Lookalikes are often the key to scaling successful campaigns beyond your existing audience.</p>

<p>The most sophisticated advertisers do not choose between these audience types - they use all three strategically. Core Audiences for initial awareness, Custom Audiences for retargeting and conversion, and Lookalike Audiences for scaling what works. Combined with strategic exclusions to prevent overlap and waste, this multi-audience approach creates efficient, scalable advertising systems.</p>

</div>',
        25,
        'https://www.youtube.com/watch?v=JRnB1OJrqzk'
    )
    RETURNING id INTO lesson_id;
    
    -- Add 5 quizzes
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'What are the three main audience types in Facebook Ads?',
     '["Core, Custom, Lookalike", "Cold, Warm, Hot", "Demographic, Interest, Behavior", "Local, National, International"]'::jsonb,
     0,
     'The three primary audience types are Core Audiences, Custom Audiences, and Lookalike Audiences'),
    
    (lesson_id,
     'What is a Custom Audience?',
     '["People who have already interacted with your business", "People similar to your customers", "People based on demographics and interests", "People in a specific location"]'::jsonb,
     0,
     'Custom Audiences target people who have already interacted with your business through website visits, customer lists, or social engagement'),
    
    (lesson_id,
     'What does a 1% Lookalike Audience represent?',
     '["The people most similar to your source audience", "1% of the population", "The cheapest audience to target", "People who spent 1% of their income"]'::jsonb,
     0,
     'A 1% Lookalike represents the people most similar to your source audience, while 10% is broader but less similar'),
    
    (lesson_id,
     'Why should you exclude Custom Audiences from Core Audience campaigns?',
     '["To avoid wasting budget on people who already know your brand", "Facebook requires it", "It improves ad quality score", "It reduces CPM"]'::jsonb,
     0,
     'Excluding Custom Audiences prevents wasting budget retargeting people who already visited your site through cold traffic campaigns'),
    
    (lesson_id,
     'What makes a good source audience for Lookalike Audiences?',
     '["Your best customers or most engaged users", "All website visitors", "Your largest audience", "Your newest customers"]'::jsonb,
     0,
     'Lookalike quality depends on source quality - using your best customers creates better Lookalikes than using all visitors');
    
    RAISE NOTICE 'Module 2, Lesson 1 created successfully';
    
END $$;

-- Verify
SELECT 
    m.ordering as module,
    l.ordering as lesson,
    l.title,
    LENGTH(l.content) as chars,
    (SELECT COUNT(*) FROM quiz_questions WHERE lesson_id = l.id) as quizzes
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation' AND m.ordering = 2
ORDER BY l.ordering;
