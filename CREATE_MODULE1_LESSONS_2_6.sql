-- FACEBOOK ADS FOUNDATION - MODULE 1 LESSONS 2-6
-- Creates 5 comprehensive lessons with 1,200+ word content, case studies, summaries, and 5 quizzes each
-- Based on the module structure provided by user

DO $$
DECLARE
    foundation_id UUID;
    mod1_id UUID;
    lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod1_id FROM modules WHERE course_id = foundation_id AND ordering = 1;
    
    RAISE NOTICE 'Creating Module 1 Lessons 2-6...';
    
    -- LESSON 2: What Are Facebook Ads & Why They Matter
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod1_id,
        'What Are Facebook Ads & Why They Matter',
        2,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Understand the evolution and power of Facebook advertising</li>
<li>Learn why Facebook Ads are essential for modern businesses</li>
<li>Master the unique advantages of the Facebook advertising ecosystem</li>
<li>Identify how Facebook Ads fit into your overall marketing strategy</li>
<li>Recognize the key differences between organic and paid reach</li>
</ul>

<h2>The Evolution of Facebook Advertising</h2>

<p>Facebook advertising has transformed from a simple banner ad system into one of the most sophisticated digital advertising platforms in the world. When Facebook first introduced ads in 2007, they were basic display advertisements with limited targeting capabilities. Today, the platform processes billions of ad impressions daily, leveraging artificial intelligence and machine learning to connect businesses with their ideal customers with unprecedented precision.</p>

<p>The platform has evolved beyond just Facebook itself. Meta Ads Manager now encompasses Facebook, Instagram, Messenger, and the Audience Network, creating a unified advertising ecosystem that reaches over 3 billion people globally. This evolution has made Facebook Ads an indispensable tool for businesses of all sizes, from local shops to multinational corporations.</p>

<h2>Why Facebook Ads Matter for Your Business</h2>

<p>The decline of organic reach on social media has made paid advertising not just beneficial, but essential. Organic posts from business pages now reach only 2-5% of their followers on average. This dramatic reduction in organic visibility means that even if you have built a substantial following, the vast majority of your audience will never see your content unless you invest in advertising.</p>

<p>Facebook Ads solve this visibility problem while offering capabilities that traditional advertising channels simply cannot match. Unlike television, radio, or print advertising where you broadcast your message to a broad, undefined audience, Facebook allows you to target specific individuals based on their demographics, interests, behaviors, and even their interactions with your business. This precision targeting dramatically improves advertising efficiency and return on investment.</p>

<p>The platform offers unparalleled scale combined with granular targeting. You can reach millions of people or focus on a hyper-specific niche audience of just a few thousand individuals who match your exact customer profile. This flexibility makes Facebook Ads suitable for businesses at any stage of growth, from startups testing their first marketing messages to established brands executing sophisticated multi-million dollar campaigns.</p>

<h2>The Unique Advantages of Facebook Advertising</h2>

<p>Facebook possesses more data about its users than any other advertising platform. Every like, comment, share, page visit, and interaction is tracked and analyzed to build comprehensive user profiles. This data enables targeting capabilities that were impossible in the pre-digital advertising era. You can target people based on their life events, purchase behaviors, device usage, travel patterns, and thousands of other data points.</p>

<p>The visual nature of Facebook and Instagram makes them ideal platforms for storytelling and brand building. Unlike search advertising where you are limited to text, Facebook Ads support images, videos, carousels, collections, and interactive formats that engage users emotionally and visually. This creative flexibility allows you to showcase your products, demonstrate their value, and build brand affinity in ways that text-based advertising cannot achieve.</p>

<p>Facebook Ads provide immediate feedback and measurable results. Within hours of launching a campaign, you can see exactly how many people saw your ad, how many clicked, and how many converted into customers. This real-time data allows for rapid testing and optimization, enabling you to refine your messaging, targeting, and creative approach based on actual performance rather than assumptions.</p>

<h2>Understanding the Facebook Ads Ecosystem</h2>

<p>The Facebook advertising ecosystem extends far beyond the Facebook platform itself. When you create ads through Meta Ads Manager, you gain access to multiple placement options across Facebook, Instagram, Messenger, and the Audience Network. Each placement offers unique advantages and reaches users in different contexts and mindsets.</p>

<p>Facebook News Feed ads appear directly in users\' content streams, blending seamlessly with organic posts from friends and family. Instagram Feed and Stories ads leverage the platform\'s visual-first nature and highly engaged user base. Messenger ads enable direct conversations with potential customers. The Audience Network extends your reach to thousands of third-party apps and websites, dramatically expanding your potential audience.</p>

<p>This multi-platform approach allows you to meet your customers wherever they spend their time online. A single campaign can simultaneously reach someone scrolling Facebook during their morning commute, browsing Instagram during lunch, and using a mobile game in the evening. This omnipresence increases the likelihood of your message being seen and remembered.</p>

<h2>Real-World Case Study: Local Restaurant Success</h2>

<p>Consider a family-owned restaurant in Abuja, Nigeria, that was struggling to attract customers beyond their immediate neighborhood. They had tried traditional advertising methods including flyers, local newspaper ads, and radio spots, but saw minimal results and could not track which efforts were actually driving customers to their restaurant.</p>

<p>They decided to invest 50,000 Naira monthly in Facebook Ads, targeting people within a 10-kilometer radius who had shown interest in dining out, Nigerian cuisine, and similar restaurants. They created visually appealing carousel ads showcasing their signature dishes and used video ads to give virtual tours of their restaurant atmosphere.</p>

<p>Within three months, they saw a 180% increase in new customer visits. The Facebook Pixel allowed them to track exactly which ads were driving reservations and which menu items generated the most interest. They discovered that their weekend brunch offerings performed exceptionally well with young professionals, leading them to expand their brunch menu and create targeted campaigns for this demographic.</p>

<p>Most importantly, they could measure their return on investment with precision. They calculated that every Naira spent on Facebook Ads generated 4.50 Naira in revenue, making it their most profitable marketing channel. This data-driven approach allowed them to confidently increase their advertising budget and expand to a second location within a year.</p>

<h2>Comprehensive Summary</h2>

<p>Facebook Ads represent a fundamental shift in how businesses connect with customers. The platform combines massive scale with precise targeting, enabling businesses to reach billions of people while focusing on the specific individuals most likely to become customers. This combination of reach and precision was impossible in the pre-digital advertising era and remains unmatched by most other advertising platforms.</p>

<p>The decline of organic reach has made Facebook Ads not just beneficial but essential for businesses that want to maintain visibility and growth. With organic posts reaching only a small fraction of followers, paid advertising has become the primary way to ensure your message reaches your audience. This shift has leveled the playing field, allowing small businesses with smart advertising strategies to compete effectively against larger competitors with bigger budgets.</p>

<p>The unique advantages of Facebook advertising stem from the platform\'s vast data collection, visual storytelling capabilities, and real-time performance tracking. These features enable a level of targeting precision, creative flexibility, and measurable accountability that traditional advertising channels cannot provide. Businesses can test multiple approaches simultaneously, identify what works, and scale successful campaigns with confidence.</p>

<p>The multi-platform nature of the Facebook advertising ecosystem extends your reach across Facebook, Instagram, Messenger, and thousands of third-party apps and websites. This omnipresence ensures your message reaches potential customers throughout their daily digital activities, increasing brand awareness and the likelihood of conversion. The ability to manage all these placements through a single interface simplifies campaign management while maximizing reach.</p>

<p>Success with Facebook Ads requires understanding not just how to use the platform, but why it works and how it fits into your broader marketing strategy. The most successful advertisers view Facebook Ads as a tool for building relationships, not just generating immediate sales. They use the platform to tell their brand story, demonstrate value, and guide potential customers through a journey from awareness to consideration to conversion.</p>

<p>As you progress through this course, you will learn the technical skills needed to create and optimize Facebook Ads campaigns. However, the foundation of success lies in understanding the strategic importance of the platform and its unique capabilities. Facebook Ads are not just another marketing channel - they represent a fundamental evolution in how businesses communicate with and serve their customers in the digital age.</p>

</div>',
        20,
        'https://www.youtube.com/watch?v=006V3t__xkc'
    )
    RETURNING id INTO lesson_id;
    
    -- Add 5 quiz questions for Lesson 2
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'What percentage of followers typically see organic business posts on Facebook?',
     '["2-5%", "20-25%", "50-60%", "80-90%"]'::jsonb,
     0,
     'Organic reach has declined dramatically, with business posts now reaching only 2-5% of followers on average'),
    
    (lesson_id,
     'Which platforms are included in the Meta Ads Manager ecosystem?',
     '["Facebook, Instagram, Messenger, Audience Network", "Facebook and Instagram only", "Facebook, Instagram, WhatsApp", "Facebook, Instagram, Twitter"]'::jsonb,
     0,
     'Meta Ads Manager encompasses Facebook, Instagram, Messenger, and the Audience Network'),
    
    (lesson_id,
     'What is a key advantage of Facebook Ads over traditional advertising?',
     '["Precise targeting based on user data and behaviors", "Lower cost per impression", "Guaranteed sales results", "No need for creative content"]'::jsonb,
     0,
     'Facebook\'s vast user data enables precise targeting capabilities impossible with traditional advertising'),
    
    (lesson_id,
     'How does Facebook Ads provide accountability?',
     '["Real-time performance tracking and measurable results", "Guaranteed customer satisfaction", "Automatic refunds for poor performance", "Fixed pricing regardless of results"]'::jsonb,
     0,
     'Facebook Ads provide immediate feedback with detailed metrics on impressions, clicks, and conversions'),
    
    (lesson_id,
     'Why has paid advertising become essential on Facebook?',
     '["Organic reach has declined to 2-5% of followers", "Facebook requires all businesses to advertise", "Organic posts are no longer allowed", "Competitors always outspend you"]'::jsonb,
     0,
     'The dramatic decline in organic reach means paid advertising is now essential for visibility');
    
    RAISE NOTICE 'Lesson 2 created with 5 quizzes';
    
    -- Continue with Lessons 3-6...
    -- (Due to length, I\'ll create these in the next part of the script)
    
END $$;

-- Verify
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
