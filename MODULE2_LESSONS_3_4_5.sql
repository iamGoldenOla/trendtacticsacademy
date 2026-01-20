-- MODULE 2 - LESSONS 3, 4, 5 COMPLETE
-- Final three lessons for Module 2

DO $$
DECLARE
    foundation_id UUID;
    mod2_id UUID;
    lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod2_id FROM modules WHERE course_id = foundation_id AND ordering = 2;
    
    RAISE NOTICE 'Creating Module 2 Lessons 3-5...';
    
    -- =====================================================
    -- LESSON 3: Geo, Demographic & Behavioral Targeting
    -- =====================================================
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod2_id,
        'Geo, Demographic & Behavioral Targeting',
        3,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Master geographic targeting for local and global campaigns</li>
<li>Understand demographic targeting options and best practices</li>
<li>Learn to use behavioral targeting effectively</li>
<li>Understand how to layer targeting criteria</li>
<li>Learn to avoid common targeting mistakes</li>
</ul>

<h2>Geographic Targeting Strategies</h2>

<p>Geographic targeting allows you to reach people based on their location, but Facebook offers more nuance than simply selecting a country or city. You can target people who live in a location, people currently in a location, people who recently traveled to a location, or people traveling to a location. Each option serves different business needs.</p>

<p>For local businesses, targeting people who live in your area makes sense. A restaurant in Lagos should target people who live within 10-15 kilometers, not tourists passing through. However, a hotel should target people traveling to Lagos, not residents. Understanding these distinctions prevents wasted spend on irrelevant audiences.</p>

<p>Radius targeting allows you to target people within a specific distance of an address. This is powerful for local businesses, events, or location-specific offers. You can target multiple locations simultaneously, useful for businesses with multiple locations or events in different cities.</p>

<h2>Demographic Targeting Options</h2>

<p>Age and gender targeting are straightforward but powerful. Different age groups and genders respond to different messaging, creative styles, and offers. A product appealing to 25-year-olds requires different advertising than one for 55-year-olds. Test different age ranges to find your sweet spot rather than targeting all ages broadly.</p>

<p>Education level targeting helps reach people based on their educational background. You can target people with high school education, college degrees, or graduate degrees. You can even target people who attended specific schools or studied specific fields. This is valuable for educational products, professional services, or products that appeal to specific education levels.</p>

<p>Job title and employer targeting allows you to reach professionals in specific roles or companies. You can target CEOs, marketing managers, teachers, or employees of specific companies. This is powerful for B2B advertising or products that serve specific professional roles.</p>

<p>Life events targeting reaches people experiencing major life changes like getting engaged, getting married, moving, starting a new job, or having a baby. These moments create needs for specific products and services, making life event targeting highly effective for relevant businesses.</p>

<h2>Behavioral Targeting Capabilities</h2>

<p>Purchase behavior targeting uses data about people''s buying patterns. You can target people who have purchased specific types of products, shop at specific retailers, or exhibit specific purchase behaviors. This data comes from Facebook activity and third-party data partnerships.</p>

<p>Device usage targeting allows you to reach people based on the devices they use. You can target people who use specific devices, operating systems, or network connections. This is useful for app advertisers, tech products, or campaigns that perform differently on different devices.</p>

<p>Travel behavior targeting reaches people based on their travel patterns. You can target frequent travelers, people who travel for business, or people who have traveled to specific locations. This is valuable for travel-related businesses, hotels, airlines, or products that appeal to travelers.</p>

<p>Digital activity targeting uses data about how people use Facebook and the internet. You can target people who engage heavily with Facebook, use Facebook Marketplace, play games, or exhibit other digital behaviors. This helps you reach people whose online behavior aligns with your product.</p>

<h2>Layering Targeting Criteria</h2>

<p>The power of Facebook targeting comes from layering multiple criteria to create highly specific audiences. Instead of targeting all women aged 25-45, you might target women aged 25-45 in Lagos who are interested in fitness and have purchased health products in the past 30 days. This layered approach creates smaller but more relevant audiences.</p>

<p>Use AND logic to narrow audiences by requiring multiple criteria. Use OR logic to expand audiences by including people who match any of several criteria. Understanding how to combine criteria strategically allows you to create audiences that precisely match your ideal customer profile.</p>

<p>However, avoid over-narrowing your audience. If your audience is too small (under 1,000 people), Facebook cannot optimize effectively. Find the balance between specificity and scale. Start specific, then broaden if your audience is too small or performance is poor.</p>

<h2>Common Targeting Mistakes</h2>

<p>Targeting too broadly is the most common mistake. "All people in Nigeria aged 18-65" is not a target audience - it is everyone. Broad targeting works for massive brands with universal appeal, but most businesses need more specific targeting to achieve efficient results.</p>

<p>Targeting too narrowly creates the opposite problem. If your audience is too small, Facebook cannot gather enough data to optimize, and your costs will be high. Additionally, you might be excluding potential customers who do not fit your narrow criteria perfectly.</p>

<p>Ignoring exclusions wastes budget. If you are running an acquisition campaign, exclude existing customers. If you are targeting a specific product, exclude people who already purchased it. Strategic exclusions improve efficiency and prevent ad fatigue.</p>

<h2>Real-World Case Study: Real Estate Agency</h2>

<p>A real estate agency in Abuja was targeting "all people in Abuja aged 25-65 interested in real estate." Their cost per lead was 4,500 Naira, and lead quality was poor - many leads could not afford their properties or were not serious buyers.</p>

<p>They refined their targeting using layered criteria. They targeted people aged 30-50 (prime home-buying age) in Abuja and surrounding areas, with household income above a certain threshold (using wealth indicators), interested in real estate AND home improvement AND luxury goods, who had engaged with real estate content in the past 90 days.</p>

<p>They also created separate campaigns for different property types. Luxury apartments targeted high-income professionals with interests in luxury brands. Family homes targeted married people with children interested in family activities and education. Each campaign had tailored messaging and creative.</p>

<p>Results improved dramatically. Cost per lead dropped to 2,200 Naira, but more importantly, lead quality increased significantly. Their sales team reported that 40% of leads from the new targeting were qualified buyers, compared to 8% from the broad targeting. By understanding and using layered targeting, they found their ideal customers efficiently.</p>

<h2>Comprehensive Summary</h2>

<p>Geographic, demographic, and behavioral targeting provide the building blocks for reaching your ideal customers on Facebook. Geographic targeting goes beyond simple location selection to include options for residents, visitors, and travelers. Demographic targeting encompasses age, gender, education, job titles, and life events. Behavioral targeting leverages purchase patterns, device usage, travel behavior, and digital activity.</p>

<p>The real power comes from layering these criteria strategically to create audiences that closely match your ideal customer profile. Rather than using single targeting criteria broadly, combine multiple criteria to narrow your audience to people most likely to be interested in your offer. This layered approach creates smaller but more relevant audiences with better performance.</p>

<p>Avoid the extremes of targeting too broadly or too narrowly. Broad targeting wastes budget on irrelevant people, while overly narrow targeting prevents Facebook from optimizing effectively. Find the balance that gives you a specific enough audience to be relevant while maintaining sufficient scale for optimization.</p>

<p>Strategic exclusions are as important as inclusions. Excluding existing customers, previous purchasers, or low-quality audiences improves efficiency and prevents wasting budget on people who should not see your ads. Regular audience refinement based on performance data ensures your targeting remains effective as your business and market evolve.</p>

</div>',
        24,
        'https://www.youtube.com/watch?v=006V3t__xkc'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'What is the difference between targeting people who "live in" vs "recently in" a location?',
     '["Live in targets residents, recently in targets visitors/travelers", "No difference, they are the same", "Recently in is more expensive", "Live in only works for cities"]'::jsonb,
     0,
     'Live in targets residents while recently in targets people who visited or traveled to the location'),
    
    (lesson_id,
     'What is life events targeting useful for?',
     '["Reaching people experiencing major life changes that create needs", "Targeting older demographics", "Reducing advertising costs", "Improving ad quality score"]'::jsonb,
     0,
     'Life events like getting married or having a baby create specific needs, making this targeting highly effective'),
    
    (lesson_id,
     'What does layering targeting criteria mean?',
     '["Combining multiple targeting options to create specific audiences", "Using only one targeting criterion", "Targeting everyone broadly", "Excluding all audiences"]'::jsonb,
     0,
     'Layering combines multiple criteria (demographics + interests + behaviors) to create highly specific audiences'),
    
    (lesson_id,
     'What is a common problem with targeting too broadly?',
     '["Wasting budget on irrelevant people", "Audience too small for optimization", "Facebook rejects the campaign", "Ads do not deliver"]'::jsonb,
     0,
     'Broad targeting reaches many irrelevant people, wasting budget on those unlikely to convert'),
    
    (lesson_id,
     'Why should you use exclusions in your targeting?',
     '["To prevent wasting budget on people who should not see your ads", "Facebook requires it", "It improves ad creative", "It reduces CPM"]'::jsonb,
     0,
     'Excluding existing customers, previous purchasers, or irrelevant audiences improves efficiency');
    
    RAISE NOTICE 'Lesson 3 created';
    
    -- =====================================================
    -- LESSON 4: Retargeting Strategies
    -- =====================================================
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod2_id,
        'Retargeting Strategies',
        4,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Understand why retargeting is essential for conversion</li>
<li>Master different types of retargeting audiences</li>
<li>Learn to create effective retargeting funnels</li>
<li>Understand retargeting frequency and timing</li>
<li>Learn to avoid retargeting fatigue</li>
</ul>

<h2>Why Retargeting Matters</h2>

<p>Most people do not buy on their first interaction with your brand. They need multiple touchpoints before making a purchase decision. Retargeting allows you to stay in front of people who have shown interest but have not yet converted, dramatically improving your conversion rates and return on ad spend.</p>

<p>Website visitors who see retargeting ads are 70% more likely to convert than those who do not. This is because retargeting reaches people who already know your brand and have demonstrated interest by visiting your website. They are much warmer than cold traffic and require less convincing to convert.</p>

<p>Retargeting also allows you to address specific objections or concerns that prevented conversion. If someone viewed a product but did not purchase, you can retarget them with customer testimonials, discount offers, or additional product information to overcome their hesitation.</p>

<h2>Types of Retargeting Audiences</h2>

<p>All website visitors is the broadest retargeting audience. Anyone who visited your website in the past 30, 60, or 180 days can be retargeted. This audience is valuable but not very specific - it includes people who visited once and left immediately alongside people who browsed extensively.</p>

<p>Page-specific audiences target people who visited specific pages. You might retarget people who viewed product pages, pricing pages, or blog posts. This allows you to show relevant ads based on what they were interested in. Someone who viewed a specific product should see ads for that product, not generic brand ads.</p>

<p>Cart abandoners are one of the highest-value retargeting audiences. These people added products to their cart but did not complete purchase. They showed strong intent and are close to converting. Retargeting cart abandoners with reminder ads, discount offers, or urgency messaging typically generates excellent returns.</p>

<p>Time-based audiences segment people by how recently they visited. Someone who visited yesterday is warmer than someone who visited 60 days ago. You might show different messaging or offers based on recency - recent visitors might need a gentle reminder, while older visitors might need a stronger incentive.</p>

<p>Engagement audiences retarget people who engaged with your Facebook or Instagram content. People who watched your videos, engaged with your posts, or visited your profile have shown interest and are more likely to convert than cold audiences. These audiences work well for building awareness before driving conversions.</p>

<h2>Creating Effective Retargeting Funnels</h2>

<p>A retargeting funnel moves people from awareness to consideration to conversion through a series of touchpoints. The first touchpoint might be a brand awareness ad to cold traffic. People who engage become a retargeting audience for consideration content. People who visit your website become a retargeting audience for conversion ads.</p>

<p>Segment your retargeting audiences by engagement level. Create different campaigns for people who visited once versus people who visited multiple times. Create different campaigns for people who spent 10 seconds on your site versus people who spent 5 minutes. Higher engagement indicates higher intent and warrants different messaging.</p>

<p>Exclude converters from retargeting campaigns. If someone already purchased, they should not continue seeing ads encouraging them to purchase. Create a Custom Audience of purchasers and exclude it from your retargeting campaigns. This prevents wasting budget and annoying customers.</p>

<h2>Retargeting Frequency and Timing</h2>

<p>Frequency caps prevent showing the same ad too many times to the same person. While Facebook does not offer direct frequency caps, you can control frequency by limiting your retargeting audience size, budget, and campaign duration. Seeing the same ad 20 times in a week creates negative brand perception and wastes budget.</p>

<p>Retargeting windows should match your sales cycle. Products with short consideration periods (impulse purchases, low-cost items) might use 7-14 day retargeting windows. Products with longer consideration periods (high-cost items, complex purchases) might use 30-90 day windows. Match your retargeting duration to how long people typically take to make purchase decisions.</p>

<p>Sequential messaging tells a story across multiple touchpoints. The first retargeting ad might address awareness, the second might provide social proof, the third might offer a discount. This sequential approach guides people through the decision-making process rather than showing the same message repeatedly.</p>

<h2>Avoiding Retargeting Fatigue</h2>

<p>Ad fatigue occurs when people see the same ad too many times and stop engaging. Monitor your frequency metric - if it exceeds 3-4 impressions per person per week, you are likely experiencing fatigue. Refresh your creative regularly, rotate multiple ad variations, or reduce your budget to lower frequency.</p>

<p>Creative variety prevents fatigue. Instead of showing the same ad repeatedly, create 3-5 variations with different images, headlines, or messaging. Facebook will automatically show the best-performing variations more frequently while maintaining variety.</p>

<p>Exclude recent converters and engaged users from certain retargeting campaigns. If someone purchased yesterday, they should not see acquisition ads today. If someone engaged heavily with your content this week, they might not need aggressive retargeting. Strategic exclusions keep your retargeting relevant and non-intrusive.</p>

<h2>Real-World Case Study: Online Course Platform</h2>

<p>An online course platform was running basic retargeting to all website visitors with the same "Enroll now" message. Their retargeting ROAS was 2.1x, decent but not exceptional. They were spending 150,000 Naira monthly on retargeting.</p>

<p>They implemented a segmented retargeting funnel. They created separate audiences for people who viewed course pages, people who visited the pricing page, people who started but did not complete enrollment, and people who watched course preview videos. Each audience received tailored messaging.</p>

<p>Course page viewers saw social proof ads with student testimonials. Pricing page visitors saw value-focused ads highlighting course outcomes. Enrollment abandoners received urgency-based ads with limited-time discounts. Video watchers saw ads featuring the instructor and course highlights.</p>

<p>They also implemented sequential messaging, showing different ads based on how many times someone had been retargeted. First touchpoint focused on value, second on social proof, third on urgency. They excluded recent purchasers and capped frequency at 3 impressions per week.</p>

<p>Results exceeded expectations. Retargeting ROAS increased to 4.8x while maintaining the same budget. Enrollment from retargeting doubled. Most importantly, customer feedback improved - people appreciated the relevant, non-intrusive ads rather than feeling bombarded. Strategic retargeting transformed their most valuable audience into their most profitable channel.</p>

<h2>Comprehensive Summary</h2>

<p>Retargeting is essential because most people need multiple touchpoints before converting. Website visitors who see retargeting ads are significantly more likely to purchase than those who do not. Retargeting allows you to stay in front of interested people, address objections, and guide them toward conversion.</p>

<p>Different retargeting audiences serve different purposes. All website visitors provide broad reach, page-specific audiences enable relevant messaging, cart abandoners represent high intent, time-based audiences allow recency targeting, and engagement audiences capture social media interest. Using multiple audience types creates a comprehensive retargeting strategy.</p>

<p>Effective retargeting funnels segment audiences by engagement level and guide people through awareness, consideration, and conversion with sequential messaging. Excluding converters prevents waste and annoyance. Matching retargeting windows to your sales cycle ensures you reach people when they are ready to buy.</p>

<p>Avoiding retargeting fatigue requires monitoring frequency, rotating creative, and using strategic exclusions. Ad fatigue damages brand perception and wastes budget. Fresh creative, reasonable frequency, and relevant messaging keep retargeting effective and welcomed rather than intrusive and annoying.</p>

</div>',
        23,
        'https://www.youtube.com/watch?v=8rABwKRsec4'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'Why is retargeting more effective than cold traffic advertising?',
     '["People already know your brand and have shown interest", "It costs less per impression", "Facebook prioritizes retargeting ads", "It requires less creative work"]'::jsonb,
     0,
     'Retargeting reaches warm audiences who already know your brand, making them more likely to convert'),
    
    (lesson_id,
     'What is a cart abandoner audience?',
     '["People who added products to cart but did not purchase", "People who visited your homepage", "People who viewed product pages", "People who purchased previously"]'::jsonb,
     0,
     'Cart abandoners showed strong purchase intent by adding items but did not complete checkout'),
    
    (lesson_id,
     'Why should you exclude converters from retargeting campaigns?',
     '["To prevent wasting budget and annoying customers who already purchased", "Facebook requires it", "It improves ad quality", "It reduces CPM"]'::jsonb,
     0,
     'Excluding recent purchasers prevents showing them ads for products they already bought'),
    
    (lesson_id,
     'What is ad fatigue in retargeting?',
     '["When people see the same ad too many times and stop engaging", "When your budget runs out", "When your audience is too small", "When your creative is poor quality"]'::jsonb,
     0,
     'Ad fatigue occurs when excessive frequency causes people to ignore or react negatively to your ads'),
    
    (lesson_id,
     'What is sequential messaging in retargeting?',
     '["Showing different messages across multiple touchpoints to tell a story", "Showing the same ad repeatedly", "Targeting audiences in alphabetical order", "Running campaigns one at a time"]'::jsonb,
     0,
     'Sequential messaging guides people through the decision process with different messages at each touchpoint');
    
    RAISE NOTICE 'Lesson 4 created';
    
    -- =====================================================
    -- LESSON 5: Audience Layering for Precision
    -- =====================================================
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod2_id,
        'Audience Layering for Precision',
        5,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Master advanced audience layering techniques</li>
<li>Understand AND vs OR logic in audience building</li>
<li>Learn to create hyper-targeted audiences</li>
<li>Understand when to layer and when to keep audiences broad</li>
<li>Learn to test and optimize layered audiences</li>
</ul>

<h2>Understanding Audience Layering</h2>

<p>Audience layering combines multiple targeting criteria to create highly specific audiences that closely match your ideal customer profile. Instead of targeting all people interested in fitness, you layer criteria to target women aged 25-35 in urban areas interested in yoga AND healthy eating who have purchased fitness products in the past 30 days. This layered approach dramatically improves relevance and performance.</p>

<p>Layering is not just about narrowing your audience - it is about precision. A smaller, highly relevant audience typically outperforms a larger, less relevant audience. While you reach fewer people, those you do reach are much more likely to engage and convert, resulting in better overall results and lower costs.</p>

<h2>AND vs OR Logic</h2>

<p>AND logic requires people to match all specified criteria. If you target people interested in "entrepreneurship" AND "digital marketing" AND "online courses," only people interested in all three will be included. This narrows your audience significantly but increases relevance.</p>

<p>OR logic includes people who match any of the specified criteria. If you target people interested in "yoga" OR "pilates" OR "meditation," anyone interested in at least one will be included. This expands your audience while maintaining some level of relevance.</p>

<p>Strategic use of AND and OR logic allows you to create precisely defined audiences. You might use OR logic within categories (yoga OR pilates OR meditation) and AND logic between categories (fitness interests AND healthy eating interests AND recent purchasers). This creates audiences that are specific but not overly narrow.</p>

<h2>Layering Strategies for Different Objectives</h2>

<p>For awareness campaigns, lighter layering works better. You want to reach a broader audience to maximize exposure. You might layer demographics with one or two interest categories, but avoid excessive narrowing. The goal is relevant reach, not precision targeting.</p>

<p>For consideration campaigns, moderate layering balances reach and relevance. You might layer demographics, interests, and behaviors to reach people likely to be interested while maintaining sufficient audience size for optimization. This is where most campaigns find their sweet spot.</p>

<p>For conversion campaigns, aggressive layering maximizes efficiency. You are targeting people ready to buy, so precision matters more than reach. Layer demographics, interests, behaviors, and Custom Audiences to create highly qualified audiences. Smaller audience size is acceptable if conversion rates are high.</p>

<h2>Advanced Layering Techniques</h2>

<p>Interest stacking layers multiple related interests to find people deeply engaged in a topic. Instead of targeting people interested in "fitness," target people interested in "fitness" AND "nutrition" AND "wellness" AND specific fitness brands. This finds people for whom fitness is a lifestyle, not a casual interest.</p>

<p>Behavior + interest layering combines what people do with what they like. Target people interested in travel AND who have traveled internationally in the past year. Target people interested in technology AND who are early technology adopters. This combination of stated interests and actual behaviors creates powerful audiences.</p>

<p>Demographic + psychographic layering combines who people are with how they think. Target young professionals (demographic) interested in career development and personal growth (psychographic). This creates audiences defined by both life stage and mindset.</p>

<p>Custom Audience layering adds your own data to Facebook targeting. Create a Lookalike Audience of your best customers, then layer it with interests and behaviors to find similar people with specific characteristics. This combines Facebook''s algorithm with your business knowledge.</p>

<h2>When to Layer and When to Keep Broad</h2>

<p>Layer when you have clear customer profiles and need precision. If you know exactly who your ideal customer is, layering helps you find them efficiently. If you are selling a specific product to a specific audience, layering improves relevance and reduces waste.</p>

<p>Keep broad when testing new markets or products. If you are unsure who your ideal customer is, start broad and let Facebook''s algorithm find patterns. If you are launching a new product, broad targeting with conversion optimization allows Facebook to discover your best audiences.</p>

<p>Keep broad when using Campaign Budget Optimization with conversion objectives. Facebook''s algorithm can find your ideal customers within a broad audience if you give it conversion data to optimize toward. Sometimes broad targeting with smart optimization outperforms narrow targeting with limited data.</p>

<h2>Testing and Optimizing Layered Audiences</h2>

<p>Test different layering combinations to find what works. Create multiple ad sets with different layering strategies - one with light layering, one with moderate layering, one with aggressive layering. Compare performance to identify the optimal level of specificity for your business.</p>

<p>Monitor audience size when layering. If your audience drops below 1,000 people, you have likely layered too aggressively. Facebook needs sufficient audience size to optimize effectively. If performance is poor despite high relevance, your audience might be too small.</p>

<p>Analyze performance by layering criteria. If you layered demographics, interests, and behaviors, analyze which criteria contribute most to performance. You might discover that certain interests or behaviors are essential while others add little value. Refine your layering based on these insights.</p>

<h2>Real-World Case Study: B2B Software Company</h2>

<p>A B2B project management software company was targeting "all business owners in Nigeria" with poor results. Their cost per trial signup was 6,500 Naira, and trial-to-paid conversion was only 8% because they were attracting unqualified leads.</p>

<p>They implemented aggressive audience layering based on their ideal customer profile. They targeted people aged 30-55 in major Nigerian cities with job titles including "CEO," "Founder," "Director," or "Manager" AND interests in "project management," "business software," and "productivity" AND behaviors indicating they are small business owners or decision makers.</p>

<p>They further layered by excluding people interested in freelancing or solopreneurship (not their target market) and including people who engaged with business content or attended business events. The final audience was highly specific but still reached 45,000 people.</p>

<p>Results transformed their advertising. Cost per trial dropped to 2,800 Naira, but more importantly, trial-to-paid conversion jumped to 24% because they were attracting their ideal customers. The smaller, highly targeted audience outperformed the broad audience by every metric. They scaled by creating similar layered audiences in other markets rather than broadening their targeting.</p>

<h2>Comprehensive Summary</h2>

<p>Audience layering combines multiple targeting criteria to create highly specific audiences that closely match your ideal customer profile. This precision targeting improves relevance, engagement, and conversion rates while reducing wasted spend on irrelevant audiences. Layering is about quality over quantity - reaching the right people rather than the most people.</p>

<p>Understanding AND vs OR logic is fundamental to effective layering. AND logic narrows audiences by requiring all criteria, while OR logic expands audiences by including anyone matching any criteria. Strategic combination of both creates audiences that are specific but not overly narrow, balancing precision with scale.</p>

<p>Different campaign objectives require different layering strategies. Awareness campaigns benefit from lighter layering to maximize reach, consideration campaigns need moderate layering to balance reach and relevance, and conversion campaigns can use aggressive layering to maximize efficiency. Match your layering strategy to your campaign goal.</p>

<p>Advanced layering techniques like interest stacking, behavior + interest combinations, demographic + psychographic layering, and Custom Audience layering create sophisticated targeting strategies. However, know when to keep targeting broad - when testing new markets, using conversion optimization, or lacking clear customer profiles, broad targeting sometimes outperforms narrow targeting.</p>

<p>Testing and optimization are essential for layered audiences. Test different layering combinations, monitor audience size to avoid over-narrowing, and analyze which criteria contribute most to performance. Continuous refinement based on data ensures your layering strategy remains effective as your business and market evolve.</p>

</div>',
        26,
        'https://www.youtube.com/watch?v=JRnB1OJrqzk'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'What is audience layering?',
     '["Combining multiple targeting criteria to create specific audiences", "Targeting everyone broadly", "Using only one targeting criterion", "Excluding all audiences"]'::jsonb,
     0,
     'Layering combines multiple criteria (demographics + interests + behaviors) for precision targeting'),
    
    (lesson_id,
     'What is the difference between AND and OR logic?',
     '["AND requires all criteria, OR includes anyone matching any criteria", "They are the same", "AND is always better", "OR is always better"]'::jsonb,
     0,
     'AND logic narrows by requiring all criteria, OR logic expands by including anyone matching any criteria'),
    
    (lesson_id,
     'When should you use aggressive audience layering?',
     '["For conversion campaigns targeting people ready to buy", "For all campaigns always", "For awareness campaigns", "Never, always keep broad"]'::jsonb,
     0,
     'Conversion campaigns benefit from aggressive layering to reach highly qualified, ready-to-buy audiences'),
    
    (lesson_id,
     'What is a sign you have layered too aggressively?',
     '["Audience size below 1,000 people", "High conversion rates", "Low cost per result", "High engagement"]'::jsonb,
     0,
     'Audiences below 1,000 people are too small for Facebook to optimize effectively'),
    
    (lesson_id,
     'What is interest stacking?',
     '["Layering multiple related interests to find deeply engaged people", "Targeting only one interest", "Excluding all interests", "Using OR logic only"]'::jsonb,
     0,
     'Interest stacking layers multiple related interests to find people for whom a topic is a lifestyle, not casual interest');
    
    RAISE NOTICE 'Lesson 5 created';
    RAISE NOTICE '======================';
    RAISE NOTICE 'MODULE 2 COMPLETE!';
    RAISE NOTICE 'All 5 lessons created with comprehensive content and quizzes';
    RAISE NOTICE '======================';
    
END $$;

-- Final Verification
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
