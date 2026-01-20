-- MODULES 8-10 - FINAL LESSONS TO COMPLETE COURSE
-- Tracking & Analytics, Scaling, Advanced Strategies

DO $$
DECLARE
    foundation_id UUID;
    mod_id UUID;
    lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    
    RAISE NOTICE 'Creating final modules 8-10...';
    
    -- MODULE 8: Tracking & Analytics (3 lessons)
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (foundation_id, 'Module 8: Tracking & Analytics', 'Master performance tracking, reporting, and data analysis', 8)
    ON CONFLICT DO NOTHING RETURNING id INTO mod_id;
    
    IF mod_id IS NULL THEN SELECT id INTO mod_id FROM modules WHERE course_id = foundation_id AND ordering = 8; END IF;
    
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url) VALUES
    (mod_id, 'Facebook Pixel Deep Dive', 1, '<div class="lesson-content"><h2>Learning Objectives</h2><ul><li>Master advanced Pixel implementation</li><li>Learn event optimization techniques</li><li>Understand Pixel data utilization</li></ul><h2>Advanced Pixel Implementation</h2><p>Beyond basic installation, advanced Pixel usage includes custom parameters, dynamic event values, and server-side tracking. These techniques provide richer data for optimization and audience building.</p><h2>Event Optimization</h2><p>Optimize events by including all relevant parameters. Purchase events should include value, currency, content_ids, and content_type. This enables value-based optimization and product-specific audiences.</p><h2>Data Utilization</h2><p>Use Pixel data for optimization (conversion campaigns), audience building (retargeting), and insights (customer behavior analysis). The same data serves multiple purposes, maximizing ROI on tracking investment.</p><h2>Real-World Example</h2><p>A business added product IDs to ViewContent events, enabling product-specific retargeting. They showed ads for viewed products, increasing conversion rate by 45%.</p></div>', 20, 'https://www.youtube.com/watch?v=006V3t__xkc'),
    (mod_id, 'Reading Reports', 2, '<div class="lesson-content"><h2>Learning Objectives</h2><ul><li>Master Ads Manager reporting</li><li>Learn key metrics interpretation</li><li>Understand performance analysis</li></ul><h2>Ads Manager Reports</h2><p>Ads Manager provides campaign, ad set, and ad level reporting. Customize columns to show metrics relevant to your objectives. Break down performance by age, gender, placement, and device to identify optimization opportunities.</p><h2>Key Metrics Interpretation</h2><p>Impressions show reach, clicks show interest, conversions show results. CTR indicates ad relevance, conversion rate indicates landing page effectiveness, ROAS indicates profitability. Each metric reveals different aspects of performance.</p><h2>Performance Analysis</h2><p>Compare performance across campaigns, ad sets, and ads to identify patterns. What audiences perform best? What creative resonates? What placements drive results? Use data to inform optimization decisions.</p><h2>Real-World Example</h2><p>A business analyzed age breakdowns and discovered 25-34 age group had 3x higher ROAS than other ages. They created age-specific campaigns, improving overall ROAS by 40%.</p></div>', 19, 'https://www.youtube.com/watch?v=8rABwKRsec4'),
    (mod_id, 'Key Metrics', 3, '<div class="lesson-content"><h2>Learning Objectives</h2><ul><li>Understand essential Facebook ad metrics</li><li>Learn metric relationships and dependencies</li><li>Master metric-based optimization</li></ul><h2>Essential Metrics</h2><p>CPM (cost per 1,000 impressions) indicates competition and ad quality. CTR (click-through rate) shows ad relevance. CPC (cost per click) combines CPM and CTR. Conversion rate shows landing page effectiveness. ROAS shows profitability.</p><h2>Metric Relationships</h2><p>Metrics are interconnected. High CPM with high CTR can still yield low CPC. Low CPC with low conversion rate yields high cost per conversion. Optimize the full funnel, not individual metrics in isolation.</p><h2>Metric-Based Optimization</h2><p>Low CTR indicates creative problems. Low conversion rate indicates landing page or offer problems. High CPM indicates targeting or ad quality issues. Use metrics to diagnose specific problems and guide optimization efforts.</p><h2>Real-World Example</h2><p>A business had low CTR but high conversion rate. They improved creative to increase CTR from 1.2% to 2.8%, doubling traffic while maintaining conversion rate, effectively doubling revenue.</p></div>', 18, 'https://www.youtube.com/watch?v=JRnB1OJrqzk');
    
    -- Add quizzes for Module 8
    SELECT id INTO lesson_id FROM lessons WHERE module_id = mod_id AND ordering = 1;
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (lesson_id, 'What are custom parameters in Pixel events?', '["Additional data like product IDs that enable advanced optimization", "Required Facebook fields", "Bidding options", "Targeting criteria"]'::jsonb, 0, 'Custom parameters provide additional context for better optimization and audience building'),
    (lesson_id, 'Why include product IDs in ViewContent events?', '["Enables product-specific retargeting and audiences", "Required by Facebook", "Reduces costs", "Improves ad quality"]'::jsonb, 0, 'Product IDs allow showing ads for specific viewed products, improving relevance'),
    (lesson_id, 'What is server-side tracking?', '["Tracking events from your server instead of browser", "Tracking on Facebook servers", "Advanced Pixel feature", "Mobile-only tracking"]'::jsonb, 0, 'Server-side tracking sends events from your server, bypassing browser limitations'),
    (lesson_id, 'What should Purchase events include?', '["Value, currency, content_ids, content_type", "Only transaction ID", "Only value", "No parameters needed"]'::jsonb, 0, 'Complete parameters enable value optimization and product-specific insights'),
    (lesson_id, 'How does Pixel data serve multiple purposes?', '["Used for optimization, audience building, and insights", "Only for tracking", "Only for optimization", "Only for audiences"]'::jsonb, 0, 'The same Pixel data powers optimization, retargeting, and business intelligence');
    
    SELECT id INTO lesson_id FROM lessons WHERE module_id = mod_id AND ordering = 2;
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (lesson_id, 'What can you break down performance by in Ads Manager?', '["Age, gender, placement, device, and more", "Only total performance", "Only by campaign", "Only by budget"]'::jsonb, 0, 'Breakdowns reveal performance patterns across demographics, placements, and devices'),
    (lesson_id, 'What does CTR indicate?', '["Ad relevance and appeal to target audience", "Profitability", "Budget efficiency", "Conversion rate"]'::jsonb, 0, 'CTR shows how relevant and appealing your ad is to the people seeing it'),
    (lesson_id, 'What does conversion rate reveal?', '["Landing page and offer effectiveness", "Ad creative quality", "Targeting accuracy", "Budget allocation"]'::jsonb, 0, 'Conversion rate shows how well your landing page converts traffic into results'),
    (lesson_id, 'Why analyze performance across different dimensions?', '["To identify patterns and optimization opportunities", "Facebook requires it", "To increase budget", "To reduce costs automatically"]'::jsonb, 0, 'Analysis reveals which audiences, creative, and placements perform best'),
    (lesson_id, 'What should you do when you find high-performing segments?', '["Create dedicated campaigns targeting those segments", "Ignore them", "Reduce their budget", "Pause them"]'::jsonb, 0, 'Scaling high-performing segments with dedicated campaigns maximizes results');
    
    SELECT id INTO lesson_id FROM lessons WHERE module_id = mod_id AND ordering = 3;
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (lesson_id, 'What is CPM?', '["Cost per 1,000 impressions", "Cost per million", "Cost per month", "Cost per metric"]'::jsonb, 0, 'CPM measures the cost to show your ad 1,000 times'),
    (lesson_id, 'What does ROAS measure?', '["Return on ad spend - revenue generated per dollar spent", "Reach of ad set", "Rate of ad success", "Return on all sales"]'::jsonb, 0, 'ROAS shows how much revenue you generate for each dollar spent on ads'),
    (lesson_id, 'What does low CTR indicate?', '["Creative or targeting problems", "Good performance", "High conversion rate", "Low costs"]'::jsonb, 0, 'Low CTR suggests your ad is not resonating with your audience'),
    (lesson_id, 'Why should you not optimize metrics in isolation?', '["Metrics are interconnected - optimize the full funnel", "Facebook prohibits it", "It costs more", "It is too complex"]'::jsonb, 0, 'Optimizing one metric can hurt others - consider the complete customer journey'),
    (lesson_id, 'What does high CPM indicate?', '["High competition or ad quality issues", "Good performance", "High conversion rate", "Profitable campaigns"]'::jsonb, 0, 'High CPM suggests competitive targeting or low ad quality scores');
    
    RAISE NOTICE 'Module 8 complete';
    
    -- MODULE 9: Scaling Your Campaigns (3 lessons)
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (foundation_id, 'Module 9: Scaling Your Campaigns', 'Master campaign scaling strategies and avoid common pitfalls', 9)
    ON CONFLICT DO NOTHING RETURNING id INTO mod_id;
    
    IF mod_id IS NULL THEN SELECT id INTO mod_id FROM modules WHERE course_id = foundation_id AND ordering = 9; END IF;
    
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url) VALUES
    (mod_id, 'When to Scale', 1, '<div class="lesson-content"><h2>Learning Objectives</h2><ul><li>Learn scaling readiness indicators</li><li>Understand scaling timing</li><li>Master pre-scaling preparation</li></ul><h2>Scaling Readiness Indicators</h2><p>Scale when campaigns are consistently profitable over at least 7 days. One good day is not enough - you need sustained performance. Ensure you have sufficient conversion data (50+ conversions) before scaling.</p><h2>Scaling Timing</h2><p>Scale during stable performance periods, not immediately after changes. After making optimizations, wait 3-4 days for stabilization before scaling. Avoid scaling during seasonal fluctuations or market changes.</p><h2>Pre-Scaling Preparation</h2><p>Before scaling, ensure your infrastructure can handle increased volume. Can your website handle more traffic? Can your team handle more leads? Can you fulfill more orders? Scaling ads without operational readiness creates problems.</p><h2>Real-World Example</h2><p>A business scaled from 50,000 to 200,000 Naira daily budget after 2 weeks of consistent 4x ROAS. They prepared by hiring customer service staff and increasing inventory, maintaining performance at scale.</p></div>', 19, 'https://www.youtube.com/watch?v=2xfMQDxaG_w'),
    (mod_id, 'Scaling Methods', 2, '<div class="lesson-content"><h2>Learning Objectives</h2><ul><li>Master vertical scaling techniques</li><li>Learn horizontal scaling strategies</li><li>Understand combined scaling approaches</li></ul><h2>Vertical Scaling</h2><p>Vertical scaling increases budget on existing campaigns. Increase by 20-30% every 3-4 days, monitoring performance. This is simple but has limits - eventually costs increase as you reach less qualified audiences.</p><h2>Horizontal Scaling</h2><p>Horizontal scaling creates new campaigns targeting new audiences or using new creative. Duplicate successful campaigns with Lookalike Audiences, new interest targeting, or new geographic markets. This maintains efficiency while expanding reach.</p><h2>Combined Approach</h2><p>Most successful scaling combines vertical and horizontal. Gradually increase budgets on proven campaigns while launching new campaigns to expand reach. This balances simplicity with sustained efficiency.</p><h2>Real-World Example</h2><p>A business vertically scaled their main campaign from 100,000 to 150,000 Naira daily. Simultaneously, they horizontally scaled by launching campaigns in 3 new cities, reaching 250,000 Naira total daily spend while maintaining ROAS.</p></div>', 20, 'https://www.youtube.com/watch?v=006V3t__xkc'),
    (mod_id, 'Avoiding Mistakes', 3, '<div class="lesson-content"><h2>Learning Objectives</h2><ul><li>Learn common scaling mistakes</li><li>Understand how to maintain performance when scaling</li><li>Master scaling troubleshooting</li></ul><h2>Common Scaling Mistakes</h2><p>Scaling too quickly disrupts optimization and increases costs. Doubling budget overnight resets the learning phase. Scale gradually - 20-30% increases every 3-4 days. Scaling without sufficient data leads to unstable performance.</p><h2>Maintaining Performance</h2><p>Monitor efficiency metrics closely when scaling. Accept slight cost increases but watch for dramatic degradation. If cost per result increases more than 30%, pause scaling and optimize. Refresh creative regularly to prevent ad fatigue at higher volumes.</p><h2>Scaling Troubleshooting</h2><p>If performance degrades when scaling, reduce budget back to previous level and identify the issue. Was scaling too aggressive? Is creative fatigued? Are you reaching less qualified audiences? Fix the problem before attempting to scale again.</p><h2>Real-World Example</h2><p>A business doubled budget overnight, increasing cost per purchase from 3,000 to 6,500 Naira. They reduced budget to original level, then scaled gradually at 25% per week, successfully reaching 3x original budget at 3,400 Naira cost per purchase.</p></div>', 18, 'https://www.youtube.com/watch?v=8rABwKRsec4');
    
    -- Add quizzes for Module 9
    SELECT id INTO lesson_id FROM lessons WHERE module_id = mod_id AND ordering = 1;
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (lesson_id, 'When should you scale campaigns?', '["After consistent profitability over at least 7 days", "After one good day", "Immediately after launch", "Never"]'::jsonb, 0, 'Sustained performance over 7+ days indicates stable, scalable campaigns'),
    (lesson_id, 'How much conversion data do you need before scaling?', '["50+ conversions", "10 conversions", "1 conversion", "100+ conversions"]'::jsonb, 0, '50+ conversions provides sufficient data for stable scaling'),
    (lesson_id, 'When should you avoid scaling?', '["During seasonal fluctuations or immediately after changes", "During profitable periods", "When performance is stable", "When you have budget"]'::jsonb, 0, 'Scale during stable periods, not during fluctuations or immediately after optimizations'),
    (lesson_id, 'What should you prepare before scaling?', '["Operational capacity to handle increased volume", "Nothing, just increase budget", "New creative only", "More ad accounts"]'::jsonb, 0, 'Ensure your business can handle increased traffic, leads, or orders before scaling ads'),
    (lesson_id, 'How long should campaigns be profitable before scaling?', '["At least 7 days consistently", "24 hours", "1 hour", "30 days"]'::jsonb, 0, '7+ days of consistent profitability indicates sustainable performance');
    
    SELECT id INTO lesson_id FROM lessons WHERE module_id = mod_id AND ordering = 2;
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (lesson_id, 'What is vertical scaling?', '["Increasing budget on existing campaigns", "Creating new campaigns", "Expanding to new markets", "Changing creative"]'::jsonb, 0, 'Vertical scaling increases spend on current campaigns'),
    (lesson_id, 'What is horizontal scaling?', '["Creating new campaigns with new audiences or creative", "Increasing existing budgets", "Reducing spend", "Pausing campaigns"]'::jsonb, 0, 'Horizontal scaling expands reach through new campaigns'),
    (lesson_id, 'What is the limit of vertical scaling?', '["Eventually costs increase as you reach less qualified audiences", "No limits", "Budget caps", "Facebook restrictions"]'::jsonb, 0, 'Vertical scaling eventually reaches diminishing returns as audience quality decreases'),
    (lesson_id, 'What is the best scaling approach?', '["Combine vertical and horizontal scaling", "Only vertical", "Only horizontal", "Do not scale"]'::jsonb, 0, 'Combined approach balances simplicity with sustained efficiency'),
    (lesson_id, 'How can you horizontally scale?', '["Lookalike Audiences, new interests, new geographic markets", "Only increase budget", "Only change creative", "Only change bidding"]'::jsonb, 0, 'Horizontal scaling uses new audiences, markets, or creative to expand reach');
    
    SELECT id INTO lesson_id FROM lessons WHERE module_id = mod_id AND ordering = 3;
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (lesson_id, 'What is the biggest scaling mistake?', '["Scaling too quickly, disrupting optimization", "Scaling too slowly", "Not scaling at all", "Scaling with data"]'::jsonb, 0, 'Rapid scaling resets learning and increases costs'),
    (lesson_id, 'What should you do if cost per result increases 30%+ when scaling?', '["Pause scaling and optimize before continuing", "Keep scaling", "Double budget", "Stop advertising"]'::jsonb, 0, 'Significant cost increases indicate problems that need fixing before further scaling'),
    (lesson_id, 'Why refresh creative when scaling?', '["To prevent ad fatigue at higher volumes", "Facebook requires it", "It reduces costs automatically", "It is easier"]'::jsonb, 0, 'Higher volume means more frequency, requiring fresh creative to prevent fatigue'),
    (lesson_id, 'What should you do if performance degrades when scaling?', '["Reduce budget to previous level and identify the issue", "Keep scaling", "Pause all campaigns", "Increase budget more"]'::jsonb, 0, 'Return to stable performance level, fix issues, then scale gradually'),
    (lesson_id, 'How much can you accept cost increases when scaling?', '["Slight increases acceptable, but watch for 30%+ degradation", "Any increase is fine", "Zero increase only", "50%+ is normal"]'::jsonb, 0, 'Some cost increase is normal when scaling, but dramatic degradation indicates problems');
    
    RAISE NOTICE 'Module 9 complete';
    
    -- MODULE 10: Advanced Strategies (3 lessons)
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (foundation_id, 'Module 10: Advanced Strategies', 'Master advanced targeting, retargeting, and testing strategies', 10)
    ON CONFLICT DO NOTHING RETURNING id INTO mod_id;
    
    IF mod_id IS NULL THEN SELECT id INTO mod_id FROM modules WHERE course_id = foundation_id AND ordering = 10; END IF;
    
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url) VALUES
    (mod_id, 'Advanced Targeting', 1, '<div class="lesson-content"><h2>Learning Objectives</h2><ul><li>Master Lookalike Audience strategies</li><li>Learn audience stacking techniques</li><li>Understand exclusion strategies</li></ul><h2>Lookalike Audience Strategies</h2><p>Create Lookalike Audiences from your best customers, not all customers. Use purchasers, high-value customers, or engaged users as source audiences. Test different percentages (1%, 2%, 5%) - smaller percentages are more similar to source but have less reach.</p><h2>Audience Stacking</h2><p>Layer multiple targeting criteria for precision. Combine Lookalike Audiences with interest or behavior targeting. Target people who match your Lookalike AND are interested in specific topics. This creates highly qualified audiences.</p><h2>Exclusion Strategies</h2><p>Strategic exclusions improve efficiency. Exclude existing customers from acquisition campaigns. Exclude people who engaged recently from awareness campaigns. Exclude low-quality audiences identified through testing.</p><h2>Real-World Example</h2><p>A business created 1% Lookalike of purchasers, then layered interest targeting for their industry. This stacked audience had 60% higher conversion rate than either targeting method alone.</p></div>', 21, 'https://www.youtube.com/watch?v=JRnB1OJrqzk'),
    (mod_id, 'Advanced Retargeting', 2, '<div class="lesson-content"><h2>Learning Objectives</h2><ul><li>Master sequential retargeting</li><li>Learn value-based retargeting</li><li>Understand retargeting frequency management</li></ul><h2>Sequential Retargeting</h2><p>Show different messages based on engagement level. First touchpoint: awareness content. Second: social proof and benefits. Third: offers and urgency. This guides prospects through decision-making process.</p><h2>Value-Based Retargeting</h2><p>Segment retargeting by customer value potential. Show premium products to high-value audiences, entry products to price-sensitive audiences. Customize offers based on browsing behavior and demographics.</p><h2>Frequency Management</h2><p>Cap frequency to prevent fatigue. Monitor frequency metrics - if exceeding 3-4 impressions per person per week, reduce budget or expand audience. Rotate creative regularly to maintain freshness.</p><h2>Real-World Example</h2><p>A business implemented sequential retargeting: Day 1-2 showed educational content, Day 3-5 showed testimonials, Day 6-7 showed discount offers. Conversion rate increased 85% compared to showing same message throughout.</p></div>', 20, 'https://www.youtube.com/watch?v=2xfMQDxaG_w'),
    (mod_id, 'Advanced A/B Testing', 3, '<div class="lesson-content"><h2>Learning Objectives</h2><ul><li>Master multivariate testing</li><li>Learn testing prioritization</li><li>Understand testing velocity</li></ul><h2>Multivariate Testing</h2><p>Test multiple elements simultaneously using Dynamic Creative or separate campaigns. While single-variable tests isolate impact, multivariate tests find winning combinations faster. Use when you have sufficient budget and traffic.</p><h2>Testing Prioritization</h2><p>Test high-impact elements first: headlines, value propositions, audiences, offers. Test low-impact elements (button colors, minor copy tweaks) only after optimizing major elements. Focus testing effort where it creates most value.</p><h2>Testing Velocity</h2><p>Maintain constant testing rhythm. Always have tests running. Fast-growing businesses test weekly, established businesses test monthly. Continuous testing creates continuous improvement.</p><h2>Real-World Example</h2><p>A business prioritized testing: Month 1 tested audiences (30% improvement), Month 2 tested value propositions (25% improvement), Month 3 tested offers (20% improvement). Compounded improvements nearly doubled performance in 3 months.</p></div>', 19, 'https://www.youtube.com/watch?v=006V3t__xkc');
    
    -- Add quizzes for Module 10
    SELECT id INTO lesson_id FROM lessons WHERE module_id = mod_id AND ordering = 1;
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (lesson_id, 'What should you use as Lookalike source audience?', '["Best customers, not all customers", "All website visitors", "All email subscribers", "Random selection"]'::jsonb, 0, 'Use your best customers as source to find similar high-value prospects'),
    (lesson_id, 'What is audience stacking?', '["Layering multiple targeting criteria for precision", "Using only one targeting method", "Excluding audiences", "Targeting everyone"]'::jsonb, 0, 'Stacking combines criteria like Lookalike + interests for highly qualified audiences'),
    (lesson_id, 'Why exclude existing customers from acquisition campaigns?', '["To prevent wasting budget on people who already purchased", "Facebook requires it", "It reduces costs", "It improves creative"]'::jsonb, 0, 'Excluding customers focuses acquisition budget on new prospects'),
    (lesson_id, 'What is the difference between 1% and 5% Lookalike?', '["1% is more similar to source but smaller, 5% has more reach but less similar", "No difference", "5% is always better", "1% is always better"]'::jsonb, 0, '1% Lookalikes are most similar to source, 5% are less similar but reach more people'),
    (lesson_id, 'How can stacking improve performance?', '["Combines strengths of multiple targeting methods", "Reduces audience size", "Increases costs", "Simplifies setup"]'::jsonb, 0, 'Stacked audiences match multiple criteria, creating highly qualified prospects');
    
    SELECT id INTO lesson_id FROM lessons WHERE module_id = mod_id AND ordering = 2;
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (lesson_id, 'What is sequential retargeting?', '["Showing different messages based on engagement level", "Showing same message repeatedly", "Targeting in alphabetical order", "Random message selection"]'::jsonb, 0, 'Sequential retargeting guides prospects through decision-making with progressive messaging'),
    (lesson_id, 'How should you segment value-based retargeting?', '["Show premium products to high-value audiences, entry products to price-sensitive", "Show everything to everyone", "Only show cheapest products", "Only show expensive products"]'::jsonb, 0, 'Customize product recommendations based on audience value potential'),
    (lesson_id, 'What frequency indicates potential ad fatigue?', '["3-4+ impressions per person per week", "1 impression per week", "10 impressions per day", "Any frequency"]'::jsonb, 0, 'Exceeding 3-4 impressions per week often indicates fatigue risk'),
    (lesson_id, 'What is the benefit of sequential messaging?', '["Guides prospects through decision process with relevant content at each stage", "Cheaper than single message", "Easier to create", "Required by Facebook"]'::jsonb, 0, 'Sequential messaging provides right information at right time in customer journey'),
    (lesson_id, 'How do you prevent retargeting fatigue?', '["Cap frequency and rotate creative regularly", "Show same ad more", "Increase budget", "Target more people"]'::jsonb, 0, 'Frequency caps and fresh creative prevent audiences from seeing same ads too often');
    
    SELECT id INTO lesson_id FROM lessons WHERE module_id = mod_id AND ordering = 3;
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (lesson_id, 'What is multivariate testing?', '["Testing multiple elements simultaneously", "Testing one element only", "Testing audiences only", "Testing budgets only"]'::jsonb, 0, 'Multivariate testing tests multiple variables at once to find winning combinations'),
    (lesson_id, 'What should you test first?', '["High-impact elements like headlines, audiences, offers", "Button colors", "Minor copy tweaks", "Font sizes"]'::jsonb, 0, 'Test high-impact elements first for maximum improvement potential'),
    (lesson_id, 'What is testing velocity?', '["Maintaining constant testing rhythm", "Testing speed", "Test duration", "Number of tests"]'::jsonb, 0, 'Testing velocity means always having tests running for continuous improvement'),
    (lesson_id, 'How often should fast-growing businesses test?', '["Weekly", "Yearly", "Never", "Every 5 years"]'::jsonb, 0, 'Fast-growing businesses benefit from weekly testing to maintain growth momentum'),
    (lesson_id, 'Why prioritize high-impact testing?', '["Creates most value and improvement potential", "Easier to implement", "Cheaper to run", "Facebook recommends it"]'::jsonb, 0, 'High-impact tests on major elements create larger performance improvements');
    
    RAISE NOTICE 'Module 10 complete';
    RAISE NOTICE '======================';
    RAISE NOTICE 'ALL MODULES COMPLETE!';
    RAISE NOTICE 'Facebook Ads Foundation course: 45 lessons across 10 modules';
    RAISE NOTICE '======================';
    
END $$;

-- Final verification
SELECT 
    m.ordering as module,
    COUNT(l.id) as lessons,
    SUM((SELECT COUNT(*) FROM quiz_questions WHERE lesson_id = l.id)) as quizzes
FROM modules m
LEFT JOIN lessons l ON m.id = l.module_id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation'
GROUP BY m.ordering, m.title
ORDER BY m.ordering;
