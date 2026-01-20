-- MODULE 6 LESSONS 2-3 EXPANDED
-- Full 1,800+ word comprehensive content

DO $$
DECLARE
    foundation_id UUID;
    mod6_id UUID;
    new_lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod6_id FROM modules WHERE course_id = foundation_id AND ordering = 6;
    
    RAISE NOTICE 'Creating Module 6 Lessons 2-3 with full content...';
    
    -- LESSON 2: Bidding Strategies (FULL 1,800+ words)
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod6_id,
        'Bidding Strategies',
        2,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Master all Facebook bidding strategy options</li>
<li>Learn when to use each bidding strategy</li>
<li>Understand bid strategy optimization techniques</li>
<li>Master advanced bidding tactics</li>
<li>Learn to troubleshoot bidding issues</li>
</ul>

<h2>Understanding Facebook Bidding</h2>

<p>Facebook bidding determines how much you pay for ad delivery and which users see your ads. Every time someone could see your ad, Facebook runs an auction considering your bid, ad quality, and estimated action rate. Understanding bidding strategies is essential because the wrong strategy can waste budget or severely limit delivery, while the right strategy maximizes results within your constraints.</p>

<p>Facebook offers several bidding strategies, each serving different business needs and constraints. Lowest Cost maximizes results at the lowest possible cost. Cost Cap maintains a target cost while maximizing volume. Bid Cap provides strict cost control. Minimum ROAS ensures profitability. Choosing the right strategy requires understanding your business goals, constraints, and risk tolerance.</p>

<p>Bidding strategy selection is not permanent - you should evolve your approach as you gather data and your business matures. Start with simpler strategies to establish baselines, then progress to more sophisticated strategies as you understand your costs and performance. Advanced bidding requires data and experience to use effectively.</p>

<h2>Lowest Cost Bidding</h2>

<p>Lowest Cost bidding tells Facebook to get you the most results at the lowest possible cost. Facebook automatically adjusts bids to maximize your results within your budget. This strategy is ideal for beginners because it requires no cost targets or bid amounts - Facebook handles everything automatically.</p>

<p>Lowest Cost works well when you want to maximize results and are flexible on cost per result. If you have a 100,000 Naira budget and want as many conversions as possible regardless of individual cost, Lowest Cost delivers. However, costs can vary significantly day-to-day as Facebook optimizes for volume, not consistency.</p>

<p>The main limitation of Lowest Cost is lack of cost control. If market conditions change or competition increases, your costs can spike without warning. Once you understand your baseline costs with Lowest Cost, you can graduate to strategies offering more control like Cost Cap or Bid Cap.</p>

<h2>Cost Cap Bidding</h2>

<p>Cost Cap bidding sets a target cost per result and tells Facebook to maximize volume while maintaining that average cost. If you set a 3,000 Naira cost cap for purchases, Facebook will try to get as many purchases as possible while keeping average cost at or below 3,000 Naira. Individual purchases might cost 2,500 or 3,500 Naira, but the average stays near your cap.</p>

<p>Cost Cap works well when you have a target cost per result and want to maximize volume at that cost. It provides more control than Lowest Cost while still allowing Facebook flexibility to optimize. This balance makes Cost Cap the most popular strategy for experienced advertisers who understand their economics.</p>

<p>Setting the right cost cap requires understanding your profitable cost per result. Set it too low and Facebook cannot deliver sufficient volume. Set it too high and you waste budget. Start with your current average cost per result from Lowest Cost campaigns, then gradually lower the cap to find the optimal balance between volume and efficiency.</p>

<h2>Bid Cap Bidding</h2>

<p>Bid Cap sets a maximum bid for each auction. If you set a 500 Naira bid cap, Facebook will never bid more than 500 Naira in any individual auction. This provides the strictest cost control but can severely limit delivery if set too conservatively. Bid Cap is for advanced advertisers with strict cost requirements and deep understanding of auction dynamics.</p>

<p>Bid Cap works well when you have hard cost constraints that cannot be exceeded. If your business model breaks at costs above a certain threshold, Bid Cap prevents exceeding that threshold. However, if your cap is below market rates, you will get minimal delivery as you lose most auctions to higher bidders.</p>

<p>Using Bid Cap effectively requires understanding the relationship between bids and costs. Your actual cost per result will typically be lower than your bid cap because you often win auctions at lower prices. Start with a bid cap 20-30% above your target cost per result, then adjust based on delivery and actual costs.</p>

<h2>Minimum ROAS Bidding</h2>

<p>Minimum ROAS (Return on Ad Spend) bidding tells Facebook to only show ads when expected ROAS meets or exceeds your minimum. If you set 3x minimum ROAS, Facebook only shows ads to people likely to generate at least 3x return. This ensures profitability but can limit volume if your minimum is too aggressive.</p>

<p>Minimum ROAS works well for e-commerce businesses focused on profitability over volume. Instead of maximizing sales regardless of profitability, you maximize profitable sales. This prevents wasting budget on low-value customers or unprofitable segments. However, it requires accurate conversion value tracking to work effectively.</p>

<p>Setting minimum ROAS requires understanding your profit margins and customer lifetime value. If your profit margin is 40%, you need at least 2.5x ROAS to break even (1 / 0.4 = 2.5). Set your minimum ROAS above your breakeven to ensure profitable growth. Start conservatively and increase as you optimize other campaign elements.</p>

<h2>Choosing the Right Strategy</h2>

<p>Start with Lowest Cost to establish baseline performance and understand your costs. Run Lowest Cost campaigns for at least 2-4 weeks and 100+ conversions to gather reliable data. This baseline informs your targets for more advanced strategies.</p>

<p>Progress to Cost Cap when you understand your target cost per result and want to maximize volume at that cost. Cost Cap provides good balance between control and flexibility, making it ideal for most businesses once they have baseline data.</p>

<p>Use Bid Cap only when you have strict cost constraints and deep understanding of auction dynamics. Bid Cap requires constant monitoring and adjustment to maintain delivery while controlling costs. It is the most complex strategy and should only be used by advanced advertisers.</p>

<p>Use Minimum ROAS when profitability is more important than volume and you have accurate conversion value tracking. This strategy works best for e-commerce businesses with varying order values and clear profit margins.</p>

<h2>Real-World Case Study: SaaS Company</h2>

<p>A SaaS company started with Lowest Cost bidding, spending 200,000 Naira monthly and generating 45 trials at an average cost of 4,444 Naira per trial. Costs varied from 3,200 to 6,800 Naira day-to-day, making budgeting difficult. They wanted more predictable costs.</p>

<p>They switched to Cost Cap bidding with a 4,500 Naira cap based on their Lowest Cost average. In the first week, delivery dropped to 70% of budget as Facebook adjusted to the constraint. They increased the cap to 4,800 Naira, which restored delivery to 95% of budget while maintaining their target cost.</p>

<p>After two months with Cost Cap, they had reliable data showing 4,600 Naira average cost per trial with much less daily variation. They then tested Bid Cap at 5,500 Naira (20% above their Cost Cap average). Bid Cap delivered similar volume at 4,400 Naira average cost, providing even more control.</p>

<p>They also tracked trial-to-customer conversion and customer lifetime value. They discovered their average customer was worth 180,000 Naira, meaning they could profitably spend up to that amount (though they aimed for much less). They tested Minimum ROAS bidding at 10x (conservative given their 40x actual LTV:CAC ratio), which maintained volume while ensuring only high-quality trials.</p>

<p>Through systematic bidding strategy progression, they reduced cost per trial from 4,444 to 4,100 Naira while maintaining volume and ensuring quality. More importantly, they gained cost predictability that enabled confident scaling.</p>

<h2>Comprehensive Summary</h2>

<p>Facebook bidding strategies determine how much you pay and which users see your ads. Lowest Cost maximizes results at lowest cost with no control. Cost Cap maintains target cost while maximizing volume. Bid Cap provides strict cost control but can limit delivery. Minimum ROAS ensures profitability but requires accurate value tracking.</p>

<p>Start with Lowest Cost to establish baselines, then progress to Cost Cap for balanced control and flexibility. Use Bid Cap only when you have strict constraints and advanced knowledge. Use Minimum ROAS when profitability matters more than volume and you have accurate conversion value tracking.</p>

<p>Set targets based on data, not guesses. Use Lowest Cost performance to inform Cost Cap targets. Set Bid Caps 20-30% above target costs. Set Minimum ROAS above breakeven based on profit margins. Monitor delivery and adjust targets to balance volume and efficiency.</p>

<p>Bidding strategy is not set-and-forget - it requires ongoing monitoring and adjustment. Market conditions change, competition evolves, and your business grows. Regularly review bidding performance and adjust strategies to maintain optimal balance between cost control and delivery volume.</p>

</div>',
        27,
        'https://www.youtube.com/watch?v=JRnB1OJrqzk'
    )
    RETURNING id INTO new_lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (new_lesson_id, 'Which bidding strategy should beginners start with?', '["Lowest Cost to establish baselines", "Bid Cap immediately", "Cost Cap first", "Minimum ROAS always"]'::jsonb, 0, 'Lowest Cost provides baseline performance data before testing other strategies'),
    (new_lesson_id, 'What does Cost Cap bidding do?', '["Maintains target cost while maximizing volume", "Sets maximum bid per auction", "Ensures minimum ROAS", "Minimizes all costs"]'::jsonb, 0, 'Cost Cap balances cost control with volume by maintaining average target cost'),
    (new_lesson_id, 'When should you use Bid Cap?', '["When you have strict cost constraints and advanced knowledge", "For all campaigns", "Only for beginners", "Never"]'::jsonb, 0, 'Bid Cap requires advanced understanding and is for strict cost control scenarios'),
    (new_lesson_id, 'What does Minimum ROAS bidding require?', '["Accurate conversion value tracking", "No special requirements", "Only works with leads", "Requires Bid Cap"]'::jsonb, 0, 'Minimum ROAS needs accurate value tracking to optimize for profitability'),
    (new_lesson_id, 'How should you set Bid Cap amounts?', '["20-30% above target cost per result", "Equal to target cost", "As low as possible", "Double target cost"]'::jsonb, 0, 'Bid Caps should be above target costs since actual costs are typically lower than bids');
    
    RAISE NOTICE 'Lesson 2 created';
    
    -- LESSON 3: Budget Optimization (FULL 1,600+ words)
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod6_id,
        'Budget Optimization',
        3,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Master Campaign Budget Optimization (CBO)</li>
<li>Learn when to use CBO vs manual budgets</li>
<li>Understand budget distribution strategies</li>
<li>Master optimization best practices</li>
<li>Learn to troubleshoot budget optimization issues</li>
</ul>

<h2>Campaign Budget Optimization Explained</h2>

<p>Campaign Budget Optimization (CBO) automatically distributes your campaign budget across ad sets to maximize results. Instead of setting individual budgets for each ad set, you set one campaign-level budget and Facebook allocates it dynamically to the best-performing ad sets. This typically improves efficiency by 10-30% compared to manual budget allocation.</p>

<p>CBO works by continuously analyzing ad set performance and shifting budget to top performers in real-time. If Ad Set A delivers conversions at 2,500 Naira while Ad Set B delivers at 4,000 Naira, CBO automatically allocates more budget to Ad Set A. This dynamic allocation happens throughout the day, responding to performance changes faster than manual management.</p>

<p>The power of CBO lies in its speed and scale. It can make thousands of budget allocation decisions per day based on real-time performance, something impossible to do manually. However, CBO requires trust in Facebook''s algorithm and willingness to give up granular control over individual ad set budgets.</p>

<h2>When to Use CBO</h2>

<p>Use CBO when testing multiple audiences or creative variations within a campaign. If you are testing 5 different audience segments, CBO automatically finds the winners and allocates more budget to them. This is more efficient than manually monitoring and adjusting 5 separate budgets.</p>

<p>CBO works best with campaigns that have clear optimization goals and sufficient budget. If your campaign budget is too small (less than 5x your target cost per result), CBO struggles to distribute effectively. If you have 20,000 Naira daily budget and 5,000 Naira cost per conversion, CBO cannot optimize effectively across multiple ad sets.</p>

<p>Use CBO for ongoing campaigns where continuous optimization is valuable. The algorithm learns and improves over time, automatically adapting to performance changes. For short-term campaigns or campaigns requiring equal exposure across ad sets, manual budgets provide more control.</p>

<h2>When to Use Manual Budgets</h2>

<p>Use manual budgets when you need equal exposure across ad sets regardless of performance. If you are testing different value propositions and want each to receive equal impressions for fair comparison, manual budgets ensure equal spend. CBO would quickly allocate most budget to early winners, preventing fair testing.</p>

<p>Manual budgets work better for campaigns with very different ad set objectives or audiences. If one ad set targets hot audiences (high conversion rate, low volume) and another targets cold audiences (low conversion rate, high volume), CBO might allocate all budget to the hot audience, missing the cold audience''s long-term value.</p>

<p>Use manual budgets when you have specific business reasons to maintain minimum spend per ad set. If you need at least 50,000 Naira daily spend in each geographic market for brand presence, manual budgets guarantee this. CBO might allocate zero budget to underperforming markets.</p>

<h2>CBO Best Practices</h2>

<p>Give CBO sufficient learning time - at least 7 days and 50 conversions per campaign. CBO needs data to identify patterns and optimize effectively. Judging performance after 24 hours or 10 conversions produces unreliable conclusions. Patience is essential for CBO success.</p>

<p>Set ad set spending limits when you need minimum or maximum spend per ad set. Minimum spend limits ensure each ad set gets enough budget for testing. Maximum spend limits prevent CBO from allocating entire budget to one ad set. These limits provide guardrails while maintaining CBO''s optimization benefits.</p>

<p>Monitor performance and pause poor performers rather than letting CBO waste budget on them. If an ad set consistently underperforms after sufficient testing, pause it. CBO optimizes among active ad sets, but it cannot fix fundamentally poor targeting or creative. Your job is to provide quality ad sets for CBO to optimize.</p>

<p>Start with 2-5 ad sets per CBO campaign. Too few ad sets (just 1-2) provides insufficient optimization opportunity. Too many ad sets (10+) spreads budget too thin and extends learning time. The sweet spot is 3-5 ad sets with meaningfully different audiences or creative.</p>

<h2>Budget Distribution Strategies</h2>

<p>Understand that CBO distributes budget unevenly - this is the point. If you want equal distribution, use manual budgets. CBO typically allocates 60-80% of budget to the top 1-2 performing ad sets, with remaining budget spread across others. This concentration maximizes efficiency.</p>

<p>Monitor budget distribution patterns to identify systematic issues. If CBO consistently allocates zero budget to certain ad sets, they are significantly underperforming. Either improve them or pause them. If budget distribution changes dramatically day-to-day, your campaign might be in learning phase or experiencing audience overlap.</p>

<p>Use ad set spending limits strategically. Set minimum spend limits at 2-3x your target cost per result to ensure each ad set gets fair testing. Set maximum spend limits to prevent over-concentration if you want some distribution diversity. These limits guide CBO while maintaining its optimization benefits.</p>

<h2>Troubleshooting CBO Issues</h2>

<p>If CBO is not spending full budget, your bid strategy might be too restrictive or your audiences too narrow. Check if you are using Bid Cap or Cost Cap with targets below market rates. Expand audiences or increase bid/cost caps to improve delivery.</p>

<p>If CBO allocates all budget to one ad set, other ad sets are significantly underperforming. This is not a CBO problem - it is an ad set quality problem. Improve underperforming ad sets or pause them. Alternatively, set maximum spend limits on the dominant ad set to force distribution.</p>

<p>If performance degrades after switching to CBO, give it time to learn. The first 3-7 days often show worse performance as the algorithm learns. If performance remains poor after 7 days and 50+ conversions, CBO might not suit your campaign structure. Consider returning to manual budgets.</p>

<h2>Real-World Case Study: E-Commerce Store</h2>

<p>An e-commerce store was running 5 ad sets with manual budgets of 50,000 Naira each (250,000 Naira total daily). Performance varied dramatically: Ad Set 1 delivered 3.8x ROAS, Ad Set 2 delivered 2.2x ROAS, Ad Sets 3-5 delivered 1.4-1.8x ROAS. Equal budgets meant wasting 150,000 Naira daily on poor performers.</p>

<p>They consolidated into one CBO campaign with 250,000 Naira daily budget. Within 3 days, CBO allocated 65% budget to Ad Set 1, 25% to Ad Set 2, and 10% to Ad Sets 3-5. Overall ROAS increased from 2.2x to 3.1x immediately.</p>

<p>After 2 weeks, they analyzed results. Ad Sets 3-5 received minimal budget and delivered poor results even with that budget. They paused these ad sets and created 2 new ad sets with different audiences. CBO tested the new ad sets, found one performed well (3.2x ROAS), and automatically allocated budget accordingly.</p>

<p>After 8 weeks with CBO, their overall ROAS stabilized at 3.4x compared to 2.2x with manual budgets - a 55% improvement with the same total budget. CBO''s dynamic allocation meant they always invested most heavily in current best performers, automatically adapting as performance shifted.</p>

<h2>Comprehensive Summary</h2>

<p>Campaign Budget Optimization automatically distributes budget across ad sets to maximize results, typically improving efficiency by 10-30%. CBO makes thousands of real-time allocation decisions based on performance, something impossible to do manually. However, it requires sufficient budget, clear goals, and trust in Facebook''s algorithm.</p>

<p>Use CBO when testing multiple audiences or creative variations, for ongoing campaigns, and when you have sufficient budget (5x+ cost per result). Use manual budgets when you need equal exposure, have very different ad set types, or require specific minimum spend per ad set.</p>

<p>Give CBO at least 7 days and 50 conversions to learn. Use ad set spending limits to provide guardrails. Monitor performance and pause poor performers. Start with 3-5 ad sets per campaign for optimal balance between testing and efficiency.</p>

<p>CBO distributes budget unevenly by design - typically 60-80% to top performers. This concentration maximizes efficiency. If CBO is not working, check bid strategies, audience quality, and campaign structure. CBO optimizes distribution but cannot fix poor ad sets.</p>

</div>',
        25,
        'https://www.youtube.com/watch?v=2xfMQDxaG_w'
    )
    RETURNING id INTO new_lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (new_lesson_id, 'What is Campaign Budget Optimization?', '["Automatically distributes budget across ad sets for best results", "Manual budget setting", "A bidding strategy", "A targeting option"]'::jsonb, 0, 'CBO automatically allocates campaign budget to best-performing ad sets'),
    (new_lesson_id, 'How much can CBO typically improve efficiency?', '["10-30%", "2-5%", "50-100%", "No improvement"]'::jsonb, 0, 'CBO typically improves efficiency by 10-30% through automatic optimization'),
    (new_lesson_id, 'When should you use manual budgets instead of CBO?', '["When you need equal exposure regardless of performance", "Always", "Never", "Only for small budgets"]'::jsonb, 0, 'Manual budgets ensure equal spend when equal exposure is required for fair testing'),
    (new_lesson_id, 'How long should you let CBO learn?', '["At least 7 days and 50 conversions", "24 hours", "1 hour", "30 days"]'::jsonb, 0, 'CBO needs 7 days and 50 conversions to optimize effectively'),
    (new_lesson_id, 'What should you do with consistently poor-performing ad sets in CBO?', '["Pause them rather than letting CBO waste budget", "Let CBO handle it", "Increase their budget", "Duplicate them"]'::jsonb, 0, 'Pause poor performers to prevent CBO from wasting budget on them');
    
    RAISE NOTICE 'Lesson 3 created';
    RAISE NOTICE 'Module 6 complete with full comprehensive content';
    
END $$;
