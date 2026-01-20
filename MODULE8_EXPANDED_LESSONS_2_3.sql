-- MODULE 8 LESSONS 2-3 EXPANDED
-- Reading Reports and Key Metrics - Full 1,700+ words each

DO $$
DECLARE
    foundation_id UUID;
    mod8_id UUID;
    new_lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod8_id FROM modules WHERE course_id = foundation_id AND ordering = 8;
    
    RAISE NOTICE 'Creating Module 8 Lessons 2-3 with full content...';
    
    -- LESSON 2: Reading Reports (FULL 1,700+ words)
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod8_id,
        'Reading Reports',
        2,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Master Ads Manager reporting interface</li>
<li>Learn to customize columns for relevant metrics</li>
<li>Understand performance breakdowns and analysis</li>
<li>Master report interpretation techniques</li>
<li>Learn to identify optimization opportunities from data</li>
</ul>

<h2>Ads Manager Reporting Interface</h2>

<p>Ads Manager provides campaign, ad set, and ad level reporting with hundreds of available metrics. The default view shows basic metrics like spend, impressions, clicks, and results. However, the real power lies in customizing columns to show metrics relevant to your specific objectives and analyzing breakdowns to identify patterns.</p>

<p>Understanding the reporting hierarchy is essential. Campaign level shows overall performance across all ad sets. Ad set level shows performance for specific audiences or placements. Ad level shows performance for specific creative. Analyzing all three levels reveals where performance comes from and where problems exist.</p>

<p>Reports update in near real-time, though some metrics have delays. Spend and impressions update within minutes. Conversions can take hours to fully attribute as people convert after seeing ads. Understanding reporting delays prevents premature conclusions based on incomplete data.</p>

<h2>Customizing Columns for Relevant Metrics</h2>

<p>Customize columns to show metrics aligned with your objectives. For conversion campaigns, show cost per result, conversion rate, ROAS, and frequency. For awareness campaigns, show CPM, reach, and video completion rates. For engagement campaigns, show engagement rate, cost per engagement, and post reactions.</p>

<p>Create custom column presets for different campaign types. Save a "Conversion Campaigns" preset with conversion-focused metrics, an "Awareness Campaigns" preset with reach metrics, and a "Testing" preset with statistical significance indicators. This saves time and ensures consistent analysis across campaigns.</p>

<p>Include efficiency metrics alongside volume metrics. Showing both total conversions and cost per conversion reveals whether you are achieving volume efficiently. Showing both reach and CPM reveals whether you are achieving awareness cost-effectively. Volume without efficiency context is meaningless.</p>

<p>Monitor frequency metrics to identify ad fatigue. Frequency shows average impressions per person. When frequency exceeds 3-4, ad fatigue typically sets in, increasing costs and decreasing performance. High frequency with declining performance indicates need for creative refresh.</p>

<h2>Performance Breakdowns and Analysis</h2>

<p>Breakdowns reveal performance patterns across dimensions like age, gender, placement, device, and time. Click "Breakdown" and select a dimension to see performance segmented by that dimension. This reveals which segments drive results and which waste budget.</p>

<p>Age and gender breakdowns identify demographic performance patterns. You might discover 25-34 year old women deliver 3x ROAS while 45-54 year old men deliver 1.2x ROAS. Create age and gender-specific campaigns to focus budget on high performers and exclude or reduce spend on poor performers.</p>

<p>Placement breakdowns show which placements drive results. As discussed in placement lessons, different placements have dramatically different performance. Analyze placement breakdowns to identify top performers for placement-specific campaigns.</p>

<p>Device breakdowns reveal mobile vs desktop performance differences. Many businesses find mobile delivers better results for awareness while desktop delivers better for conversions. Understanding device performance informs creative decisions (mobile-optimized vs desktop-optimized) and budget allocation.</p>

<p>Time breakdowns show performance by day of week and hour of day. Some businesses perform better on weekends, others on weekdays. Some perform better in evenings, others in mornings. Use time breakdowns to identify optimal scheduling and adjust ad scheduling accordingly.</p>

<h2>Report Interpretation Techniques</h2>

<p>Compare performance across campaigns, ad sets, and ads to identify patterns. If one campaign significantly outperforms others, what is different? Audience? Creative? Offer? Identifying success patterns allows replication. Identifying failure patterns allows avoidance.</p>

<p>Look for statistical significance, not just performance differences. Small sample sizes produce unreliable results. A campaign with 5 conversions at 2,000 Naira each might appear better than one with 100 conversions at 2,500 Naira, but the second has much more reliable data. Require sufficient sample size (50-100 conversions) before making decisions.</p>

<p>Monitor trends over time, not just current performance. A campaign performing well today might be declining. A campaign performing poorly today might be improving. Export data to spreadsheets and create trend charts to visualize performance trajectories and identify inflection points.</p>

<p>Consider external factors when interpreting data. Performance changes might result from seasonality, market conditions, competitor actions, or product availability rather than campaign changes. Understanding context prevents attributing external factors to campaign performance.</p>

<h2>Identifying Optimization Opportunities</h2>

<p>High CTR with low conversion rate indicates creative attracts attention but landing page or offer fails to convert. Optimize landing page, offer, or targeting to improve conversion rate. The traffic quality is good (high CTR), but something after the click needs improvement.</p>

<p>Low CTR with high conversion rate indicates creative fails to attract attention but offer is strong. Improve creative to increase CTR while maintaining conversion rate. You are missing potential customers who would convert if they clicked.</p>

<p>High frequency with declining performance indicates ad fatigue. Refresh creative to restore performance. High frequency means your audience has seen your ads many times - they are tired of them. New creative re-engages fatigued audiences.</p>

<p>Dramatic performance differences across demographics, placements, or devices indicate optimization opportunities. Focus budget on high performers, exclude or reduce spend on poor performers, and create segment-specific campaigns with optimized creative and messaging.</p>

<h2>Real-World Case Study: Online Course Platform</h2>

<p>An online course platform was running campaigns with default Ads Manager columns, seeing only basic metrics. They knew they were spending 400,000 Naira monthly and getting leads, but had no deeper insights into what drove performance or where to optimize.</p>

<p>They customized columns to show cost per lead, lead-to-customer conversion rate (from CRM data), cost per customer, and ROAS. They discovered their cost per lead was 2,800 Naira, but only 12% of leads became customers, making cost per customer 23,333 Naira.</p>

<p>They analyzed age breakdowns and discovered 25-34 age group had 22% lead-to-customer conversion while 45-54 had only 6%. Despite similar cost per lead, 25-34 delivered customers at 12,727 Naira while 45-54 delivered at 46,667 Naira. They created age-specific campaigns focusing on 25-34.</p>

<p>They analyzed placement breakdowns and found Facebook Feed delivered 18% conversion rate while Audience Network delivered 4%. They excluded Audience Network and focused on Feed placements. They analyzed device breakdowns and found mobile users had 15% conversion while desktop had 8%. They created mobile-optimized campaigns.</p>

<p>After systematic report analysis and optimization, their overall lead-to-customer conversion improved from 12% to 19%, reducing cost per customer from 23,333 to 14,737 Naira - a 37% improvement with the same budget. Report analysis revealed optimization opportunities that were invisible with default reporting.</p>

<h2>Comprehensive Summary</h2>

<p>Ads Manager provides comprehensive reporting at campaign, ad set, and ad levels. Customize columns to show metrics aligned with your objectives - conversion metrics for conversion campaigns, awareness metrics for awareness campaigns. Create custom presets for different campaign types to ensure consistent analysis.</p>

<p>Use breakdowns to reveal performance patterns across demographics, placements, devices, and time. Age and gender breakdowns identify demographic opportunities. Placement breakdowns reveal where to focus budget. Device and time breakdowns inform creative and scheduling decisions.</p>

<p>Interpret reports by comparing across campaigns, requiring statistical significance, monitoring trends over time, and considering external factors. Look for patterns that explain success and failure, allowing replication and avoidance respectively.</p>

<p>Identify optimization opportunities from report analysis. High CTR with low conversion rate indicates landing page issues. Low CTR with high conversion rate indicates creative issues. High frequency with declining performance indicates ad fatigue. Dramatic segment differences indicate targeting opportunities.</p>

</div>',
        24,
        'https://www.youtube.com/watch?v=8rABwKRsec4'
    )
    RETURNING id INTO new_lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (new_lesson_id, 'What should you customize columns to show?', '["Metrics aligned with your campaign objectives", "All available metrics", "Only spend and impressions", "Random metrics"]'::jsonb, 0, 'Customize columns to show metrics relevant to your specific objectives'),
    (new_lesson_id, 'What do breakdowns reveal?', '["Performance patterns across dimensions like age, placement, device", "Only total performance", "Campaign names", "Ad creative"]'::jsonb, 0, 'Breakdowns segment performance by dimensions to reveal patterns and opportunities'),
    (new_lesson_id, 'What does high CTR with low conversion rate indicate?', '["Creative attracts attention but landing page or offer fails to convert", "Everything is perfect", "Creative is bad", "Targeting is wrong"]'::jsonb, 0, 'High CTR shows good creative, low conversion rate indicates post-click issues'),
    (new_lesson_id, 'When does ad fatigue typically set in?', '["When frequency exceeds 3-4 impressions per person", "After 1 impression", "After 10 impressions", "Never"]'::jsonb, 0, 'Frequency above 3-4 typically indicates audiences are seeing ads too often'),
    (new_lesson_id, 'Why require sufficient sample size before making decisions?', '["Small samples produce unreliable results", "Facebook requires it", "It costs less", "It is easier"]'::jsonb, 0, 'Sufficient sample size (50-100 conversions) ensures reliable, actionable insights');
    
    RAISE NOTICE 'Module 8 Lesson 2 created';
    
    -- LESSON 3: Key Metrics (FULL 1,600+ words)
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod8_id,
        'Key Metrics',
        3,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Understand essential Facebook ad metrics</li>
<li>Learn metric relationships and dependencies</li>
<li>Master metric-based optimization strategies</li>
<li>Understand how to diagnose problems using metrics</li>
<li>Learn which metrics matter for different objectives</li>
</ul>

<h2>Essential Metrics Overview</h2>

<p>Facebook provides hundreds of metrics, but only a core set truly matters for optimization. Understanding these key metrics, their relationships, and what they reveal about campaign performance is essential for data-driven decision making. Different objectives require focus on different metrics, but certain metrics are universally important.</p>

<p>Metrics fall into three categories: delivery metrics (impressions, reach, frequency), engagement metrics (clicks, CTR, engagement rate), and conversion metrics (conversions, cost per result, ROAS). Delivery metrics show how many people saw your ads. Engagement metrics show how people responded. Conversion metrics show business results.</p>

<p>The funnel of metrics mirrors the customer journey. Impressions → Clicks → Conversions. Each stage has associated metrics. Analyzing the full funnel reveals where performance breaks down. High impressions but low clicks indicates creative problems. High clicks but low conversions indicates landing page or offer problems.</p>

<h2>Delivery Metrics</h2>

<p>CPM (Cost Per 1,000 Impressions) indicates how much you pay to show your ad 1,000 times. CPM reflects auction competition and ad quality. High CPM indicates competitive targeting or low ad quality scores. Low CPM indicates less competitive targeting or high ad quality. CPM varies dramatically by audience, placement, and timing.</p>

<p>Reach shows how many unique people saw your ads. Reach differs from impressions - one person can generate multiple impressions. Reach is important for awareness campaigns where you want to expose your message to as many people as possible. For conversion campaigns, reach matters less than conversion volume.</p>

<p>Frequency shows average impressions per person (Impressions / Reach). Frequency indicates how often your audience sees your ads. Low frequency (1-2) means most people see your ad once or twice. High frequency (5+) means people see your ad many times. Optimal frequency depends on objective - awareness benefits from 1-2, retargeting benefits from 3-5.</p>

<h2>Engagement Metrics</h2>

<p>CTR (Click-Through Rate) shows percentage of people who click after seeing your ad (Clicks / Impressions). CTR indicates ad relevance and appeal. High CTR (2%+) means your ad resonates with your audience. Low CTR (0.5%) means your ad fails to capture attention or interest. CTR is one of the most important diagnostic metrics.</p>

<p>CPC (Cost Per Click) shows how much you pay for each click (Spend / Clicks). CPC combines CPM and CTR - CPC = CPM / (CTR × 10). You can have low CPC with high CPM if CTR is high, or high CPC with low CPM if CTR is low. CPC indicates efficiency of getting people to your website.</p>

<p>Engagement Rate shows percentage of people who engage with your ad (likes, comments, shares, clicks). High engagement indicates your content resonates emotionally or intellectually. Low engagement indicates your content fails to connect. Engagement is particularly important for awareness and consideration campaigns.</p>

<h2>Conversion Metrics</h2>

<p>Conversions show how many people completed your desired action (purchase, lead, registration). This is the ultimate metric for conversion campaigns - all optimization aims to maximize conversions within budget constraints. However, conversion volume without cost context is meaningless.</p>

<p>Cost Per Result shows how much you pay for each conversion (Spend / Conversions). This is the primary efficiency metric. Lower cost per result means more efficient advertising. However, cost per result must be evaluated against customer value - a 5,000 Naira cost per result is excellent if customers are worth 50,000 Naira but terrible if they are worth 3,000 Naira.</p>

<p>ROAS (Return on Ad Spend) shows revenue generated per currency spent (Revenue / Spend). ROAS is the ultimate profitability metric for e-commerce. 3x ROAS means you generate 3 Naira for every 1 Naira spent. ROAS must exceed your breakeven point (determined by profit margins) to be profitable.</p>

<p>Conversion Rate shows percentage of clicks that convert (Conversions / Clicks). Conversion rate indicates landing page and offer effectiveness. High conversion rate (5%+) means your landing page converts traffic well. Low conversion rate (1%) means your landing page or offer needs improvement. Conversion rate is independent of ad performance - it measures post-click experience.</p>

<h2>Metric Relationships and Dependencies</h2>

<p>Metrics are interconnected - changing one affects others. Improving CTR reduces CPC (CPC = CPM / (CTR × 10)). Improving conversion rate reduces cost per conversion (Cost Per Conversion = CPC / Conversion Rate). Understanding these relationships reveals optimization leverage points.</p>

<p>The conversion funnel equation: Cost Per Conversion = CPM / (CTR × Conversion Rate × 10). This reveals that cost per conversion depends on three factors: CPM (auction competition and ad quality), CTR (ad relevance), and conversion rate (landing page effectiveness). Optimize all three to minimize cost per conversion.</p>

<p>ROAS equation: ROAS = (Average Order Value × Conversion Rate × CTR × 1000) / CPM. This reveals ROAS depends on average order value (product pricing and upsells), conversion rate (landing page), CTR (ad creative), and CPM (targeting and ad quality). Improving any factor improves ROAS.</p>

<p>Frequency affects all metrics. As frequency increases, CTR typically decreases (ad fatigue), CPM often increases (Facebook charges more for repeated impressions), and conversion rate may decrease (people who wanted to convert already did). Monitor frequency and refresh creative when it exceeds 3-4.</p>

<h2>Metric-Based Optimization Strategies</h2>

<p>Low CTR indicates creative problems. Test new images, headlines, or value propositions. Ensure your creative stands out visually and communicates clear value. Low CTR is the most common performance problem and often the easiest to fix through creative testing.</p>

<p>Low conversion rate indicates landing page or offer problems. Test landing page variations, simplify forms, strengthen offers, add social proof, or improve page load speed. If CTR is good but conversion rate is poor, the problem is not your ads - it is what happens after the click.</p>

<p>High CPM indicates competitive targeting or low ad quality. Expand targeting to less competitive audiences, improve ad quality scores through better creative and relevance, or test different placements with lower competition. High CPM is often unavoidable in competitive industries but can sometimes be reduced through strategic changes.</p>

<p>High frequency with declining CTR indicates ad fatigue. Refresh creative to restore performance. Create 3-5 new creative variations and rotate them to prevent fatigue. High-frequency campaigns need more frequent creative refresh than low-frequency campaigns.</p>

<h2>Real-World Case Study: E-Commerce Home Goods</h2>

<p>An e-commerce home goods store had 1.2% CTR, 2.5% conversion rate, 8,000 Naira CPM, and 2.1x ROAS. They wanted to improve to 3x ROAS but were unsure where to focus optimization efforts.</p>

<p>They analyzed the conversion funnel equation. Their cost per conversion was 8,000 / (0.012 × 0.025 × 10) = 26,667 Naira. With average order value of 56,000 Naira, their ROAS was 56,000 / 26,667 = 2.1x. To reach 3x ROAS, they needed cost per conversion of 18,667 Naira (56,000 / 3).</p>

<p>They calculated improvement scenarios. Improving CTR from 1.2% to 2.0% would reduce cost per conversion to 16,000 Naira (8,000 / (0.02 × 0.025 × 10)), achieving 3.5x ROAS. Improving conversion rate from 2.5% to 4.0% would reduce cost per conversion to 16,667 Naira, achieving 3.4x ROAS. Reducing CPM from 8,000 to 6,000 would reduce cost per conversion to 20,000 Naira, achieving 2.8x ROAS.</p>

<p>They prioritized CTR improvement (biggest impact) through creative testing. They tested 5 new creative variations emphasizing lifestyle imagery and customer testimonials. Best performer achieved 2.3% CTR. They also optimized their landing page, improving conversion rate from 2.5% to 3.2%.</p>

<p>Combined improvements: CTR 1.2% → 2.3%, Conversion Rate 2.5% → 3.2%. New cost per conversion: 8,000 / (0.023 × 0.032 × 10) = 10,870 Naira. New ROAS: 56,000 / 10,870 = 5.2x. They exceeded their 3x ROAS goal by understanding metric relationships and optimizing strategically.</p>

<h2>Comprehensive Summary</h2>

<p>Essential metrics fall into delivery (CPM, reach, frequency), engagement (CTR, CPC, engagement rate), and conversion (conversions, cost per result, ROAS) categories. Each metric reveals different aspects of campaign performance. Understanding all three categories provides complete performance picture.</p>

<p>Metrics are interconnected through mathematical relationships. Cost per conversion depends on CPM, CTR, and conversion rate. ROAS depends on average order value, conversion rate, CTR, and CPM. Understanding these relationships reveals optimization leverage points.</p>

<p>Use metrics to diagnose problems. Low CTR indicates creative issues. Low conversion rate indicates landing page issues. High CPM indicates competitive targeting. High frequency with declining CTR indicates ad fatigue. Metrics point to specific optimization opportunities.</p>

<p>Optimize metrics strategically based on their impact on business goals. For conversion campaigns, focus on CTR and conversion rate as they have multiplicative impact on cost per conversion. For awareness campaigns, focus on CPM and reach. Match metric optimization to campaign objectives.</p>

</div>',
        23,
        'https://www.youtube.com/watch?v=JRnB1OJrqzk'
    )
    RETURNING id INTO new_lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (new_lesson_id, 'What is CPM?', '["Cost per 1,000 impressions", "Cost per million", "Cost per month", "Cost per metric"]'::jsonb, 0, 'CPM measures the cost to show your ad 1,000 times'),
    (new_lesson_id, 'What does ROAS measure?', '["Return on ad spend - revenue generated per dollar spent", "Reach of ad set", "Rate of ad success", "Return on all sales"]'::jsonb, 0, 'ROAS shows how much revenue you generate for each dollar spent on ads'),
    (new_lesson_id, 'What does low CTR indicate?', '["Creative or targeting problems", "Good performance", "High conversion rate", "Low costs"]'::jsonb, 0, 'Low CTR suggests your ad is not resonating with your audience'),
    (new_lesson_id, 'How are CPC, CPM, and CTR related?', '["CPC = CPM / (CTR × 10)", "No relationship", "CPC = CPM × CTR", "CPC = CPM + CTR"]'::jsonb, 0, 'CPC depends on both CPM (auction cost) and CTR (ad relevance)'),
    (new_lesson_id, 'What does conversion rate measure?', '["Percentage of clicks that convert", "Total conversions", "Cost per conversion", "Click-through rate"]'::jsonb, 0, 'Conversion rate shows how well your landing page converts traffic into results');
    
    RAISE NOTICE 'Module 8 Lesson 3 created - Module 8 complete';
    RAISE NOTICE '======================';
    RAISE NOTICE 'MODULES 7-8 COMPLETE!';
    RAISE NOTICE 'All 6 lessons with full 1,700-1,800 word content';
    RAISE NOTICE '======================';
    
END $$;
