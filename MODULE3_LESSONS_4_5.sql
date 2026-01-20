-- MODULE 3 - LESSONS 4-5 COMPLETE
-- Budgeting and Bidding Strategies

DO $$
DECLARE
    foundation_id UUID;
    mod3_id UUID;
    lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod3_id FROM modules WHERE course_id = foundation_id AND ordering = 3;
    
    RAISE NOTICE 'Creating Module 3 final lessons...';
    
    -- LESSON 4: Budgeting - Daily vs Lifetime
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod3_id,
        'Budgeting: Daily vs. Lifetime',
        4,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Understand daily vs lifetime budget options</li>
<li>Learn when to use each budget type</li>
<li>Master Campaign Budget Optimization (CBO)</li>
<li>Understand budget pacing and delivery</li>
<li>Learn to scale budgets effectively</li>
</ul>

<h2>Daily vs Lifetime Budgets</h2>

<p>Daily budgets set the maximum amount you will spend per day. Facebook distributes this budget throughout the day, spending more during high-performance periods and less during low-performance periods. Daily budgets provide consistent daily spend and are ideal for ongoing campaigns without specific end dates.</p>

<p>Lifetime budgets set the total amount you will spend over the entire campaign duration. Facebook distributes this budget across your campaign dates, spending more on high-performing days and less on low-performing days. Lifetime budgets are ideal for campaigns with specific start and end dates, like promotions or events.</p>

<p>The key difference is flexibility. Daily budgets give you predictable daily spend but less optimization flexibility. Lifetime budgets give Facebook more flexibility to optimize spending across time but less predictable daily spend. Neither is inherently better - the right choice depends on your campaign goals and constraints.</p>

<h2>When to Use Daily Budgets</h2>

<p>Use daily budgets for ongoing campaigns without specific end dates. If you are running evergreen campaigns that should continue indefinitely, daily budgets ensure consistent daily investment. This is common for e-commerce stores, service businesses, or any business with continuous customer acquisition needs.</p>

<p>Use daily budgets when you need predictable daily spend for cash flow management. If you have strict daily budget constraints or need to manage cash flow carefully, daily budgets prevent unexpected spending spikes. You know exactly what you will spend each day.</p>

<p>Use daily budgets when testing new campaigns. Daily budgets allow you to test campaigns without committing to a long-term budget. You can run a campaign for a few days, evaluate performance, and adjust or stop without wasting a large lifetime budget.</p>

<h2>When to Use Lifetime Budgets</h2>

<p>Use lifetime budgets for campaigns with specific start and end dates. Promotions, sales events, product launches, or seasonal campaigns have defined timeframes. Lifetime budgets allow Facebook to optimize spending across the entire period, spending more on high-performing days.</p>

<p>Use lifetime budgets when you want maximum optimization flexibility. Lifetime budgets give Facebook freedom to spend more on days when performance is strong and less on days when performance is weak. This flexibility can improve overall campaign efficiency.</p>

<p>Use lifetime budgets with ad scheduling. If you only want ads to run during specific hours or days, lifetime budgets work better than daily budgets. You can set your campaign to run only during business hours or weekends while maintaining a total budget cap.</p>

<h2>Campaign Budget Optimization (CBO)</h2>

<p>CBO automatically distributes your campaign budget across ad sets to maximize results. Instead of setting budgets for each ad set manually, you set one campaign-level budget and Facebook allocates it to the best-performing ad sets. This typically improves efficiency because Facebook can shift budget to what works in real-time.</p>

<p>CBO works with both daily and lifetime budgets. You can set a daily campaign budget and let Facebook distribute it across ad sets, or set a lifetime campaign budget for the entire campaign duration. The optimization happens at the campaign level regardless of budget type.</p>

<p>CBO is particularly powerful when testing multiple audiences or creative variations. Instead of splitting budget equally across ad sets (which wastes money on poor performers), CBO automatically allocates more budget to winning ad sets. This accelerates learning and improves overall performance.</p>

<p>However, CBO can be problematic if you have specific budget requirements for different ad sets. If you need to ensure each audience gets equal exposure regardless of performance, manual ad set budgets work better. CBO prioritizes efficiency over equal distribution.</p>

<h2>Budget Pacing and Delivery</h2>

<p>Facebook paces your budget throughout the day or campaign period to maximize results. Standard delivery spreads your budget evenly, while accelerated delivery spends your budget as quickly as possible. Most campaigns should use standard delivery for better optimization.</p>

<p>Budget pacing affects when your ads show. With standard delivery, Facebook shows your ads throughout the day when they are most likely to perform well. With accelerated delivery, Facebook shows your ads immediately, which can be useful for time-sensitive campaigns but typically costs more.</p>

<p>Monitor your budget utilization. If you are consistently spending your full daily budget, you might be limiting your results - increasing budget could improve performance. If you are not spending your full budget, your targeting might be too narrow, your bids might be too low, or your creative might not be competitive.</p>

<h2>Scaling Budgets Effectively</h2>

<p>When scaling budgets, increase gradually rather than dramatically. Doubling your budget overnight can disrupt Facebook''s optimization and reset the learning phase. Increase budgets by 20-30% every 3-4 days to maintain stability while scaling.</p>

<p>Monitor performance when scaling. Increased budget does not guarantee proportional results. Your cost per result might increase as you scale because you are reaching less qualified audiences. Track your efficiency metrics and be prepared to reduce budget if performance degrades significantly.</p>

<p>Consider horizontal scaling instead of vertical scaling. Rather than increasing budget on existing campaigns, duplicate successful campaigns with new audiences. This maintains the performance of your original campaigns while expanding reach through new campaigns.</p>

<h2>Real-World Case Study: Service Business</h2>

<p>A consulting business was using daily budgets of 10,000 Naira per ad set across 5 ad sets (50,000 Naira daily total). They were spending their full budget but getting inconsistent results - some ad sets performed well, others poorly, but all received equal budget.</p>

<p>They switched to CBO with a 50,000 Naira daily campaign budget. Facebook automatically allocated more budget to high-performing ad sets and less to poor performers. Within one week, their cost per lead dropped from 2,500 Naira to 1,800 Naira while maintaining the same total spend.</p>

<p>They then tested lifetime budgets for a 2-week promotion. Instead of 10,000 Naira daily, they set a 140,000 Naira lifetime budget for 14 days. Facebook spent more on weekends when engagement was higher and less on weekdays when engagement was lower. This flexible pacing improved their promotion ROAS by 35% compared to their previous fixed daily budget approach.</p>

<h2>Comprehensive Summary</h2>

<p>Daily budgets provide predictable daily spend and work well for ongoing campaigns without specific end dates. Lifetime budgets provide optimization flexibility and work well for campaigns with defined timeframes. Neither is inherently better - choose based on your campaign goals and constraints.</p>

<p>Campaign Budget Optimization automatically distributes budget across ad sets to maximize results. CBO typically improves efficiency by allocating more budget to winning ad sets and less to poor performers. However, it requires trusting Facebook''s optimization and may not work well if you need equal budget distribution across ad sets.</p>

<p>Budget pacing determines how Facebook spends your budget over time. Standard delivery spreads budget for optimization, while accelerated delivery spends quickly. Monitor budget utilization to identify opportunities for scaling or signals that your targeting or creative needs improvement.</p>

<p>Scale budgets gradually (20-30% every 3-4 days) to maintain optimization stability. Monitor performance when scaling and be prepared to reduce budget if efficiency degrades. Consider horizontal scaling through campaign duplication rather than only vertical scaling through budget increases.</p>

</div>',
        24,
        'https://www.youtube.com/watch?v=8rABwKRsec4'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'What is the main difference between daily and lifetime budgets?',
     '["Daily budgets set max per day, lifetime budgets set total for campaign duration", "Daily budgets are cheaper", "Lifetime budgets perform better", "No significant difference"]'::jsonb,
     0,
     'Daily budgets cap daily spend while lifetime budgets cap total spend across the campaign period'),
    
    (lesson_id,
     'When should you use lifetime budgets?',
     '["For campaigns with specific start and end dates", "For all campaigns always", "Only for small budgets", "Only for conversion campaigns"]'::jsonb,
     0,
     'Lifetime budgets work best for campaigns with defined timeframes like promotions or events'),
    
    (lesson_id,
     'What is Campaign Budget Optimization (CBO)?',
     '["Automatically distributes budget across ad sets to maximize results", "A manual budgeting tool", "A bidding strategy", "A targeting option"]'::jsonb,
     0,
     'CBO automatically allocates campaign budget to the best-performing ad sets'),
    
    (lesson_id,
     'How much should you increase budget when scaling?',
     '["20-30% every 3-4 days", "Double it immediately", "10% per day", "50% per week"]'::jsonb,
     0,
     'Gradual 20-30% increases every 3-4 days maintain optimization stability while scaling'),
    
    (lesson_id,
     'What does it mean if you are not spending your full daily budget?',
     '["Targeting too narrow, bids too low, or creative not competitive", "Campaign is performing well", "Budget is too high", "Facebook is saving money"]'::jsonb,
     0,
     'Underspending indicates targeting, bidding, or creative issues preventing full budget utilization');
    
    RAISE NOTICE 'Lesson 4 created';
    
    -- LESSON 5: Bidding Strategies & Optimization
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod3_id,
        'Bidding Strategies & Optimization',
        5,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Understand Facebook bidding strategies</li>
<li>Learn when to use each bidding option</li>
<li>Master bid caps and cost caps</li>
<li>Understand how bidding affects delivery and costs</li>
<li>Learn to optimize bids for better performance</li>
</ul>

<h2>How Facebook Bidding Works</h2>

<p>Facebook uses an auction system to determine which ads to show. Every time there is an opportunity to show an ad, Facebook runs an auction among all advertisers targeting that person. The winner is not necessarily the highest bidder - Facebook considers bid amount, estimated action rate, and ad quality to determine the winner.</p>

<p>Your bid represents how much you are willing to pay for your desired result. However, you typically pay less than your bid - you pay just enough to win the auction. This is called a second-price auction. If you bid 100 Naira and the next highest bidder bid 80 Naira, you might pay 81 Naira, not 100 Naira.</p>

<p>Facebook''s goal is to maximize value for both advertisers and users. Advertisers want results at the lowest cost, users want to see relevant ads. The auction system balances these goals by rewarding relevant, high-quality ads with lower costs and better delivery.</p>

<h2>Bidding Strategy Options</h2>

<p>Lowest Cost bidding (automatic bidding) lets Facebook bid automatically to get the most results at the lowest cost. This is the default and recommended option for most advertisers. Facebook uses machine learning to bid optimally in each auction, adjusting bids based on likelihood of conversion.</p>

<p>Cost Cap bidding sets a maximum average cost per result you want to achieve. Facebook will bid to maintain this average cost while maximizing volume. This is useful when you have a specific target cost per result and want to maximize volume at that cost. However, it may limit delivery if your cap is too low.</p>

<p>Bid Cap bidding sets a maximum bid for each auction. Facebook will never bid more than your cap, which gives you control but may significantly limit delivery. Use bid caps when you have strict cost controls or when testing to understand the true cost of reaching your audience.</p>

<p>Minimum ROAS bidding sets a minimum return on ad spend you want to achieve. Facebook will bid to maintain this ROAS while maximizing conversion value. This is useful for e-commerce when you have specific profitability requirements. However, it requires conversion value tracking and may limit delivery.</p>

<h2>When to Use Each Strategy</h2>

<p>Use Lowest Cost for most campaigns, especially when starting. It gives Facebook maximum flexibility to optimize and typically delivers the best results. Once you understand your costs and performance, you can consider other strategies for more control.</p>

<p>Use Cost Cap when you have a specific target cost per result and want to maximize volume at that cost. For example, if you can profitably acquire customers at 5,000 Naira and want to maximize customer acquisition at that cost, Cost Cap works well. Set your cap slightly above your target to allow optimization room.</p>

<p>Use Bid Cap when you need strict cost control or are testing to understand costs. Bid caps give you maximum control but can severely limit delivery if set too low. Start with higher caps and gradually lower them while monitoring delivery to find the optimal balance.</p>

<p>Use Minimum ROAS for e-commerce when you have specific profitability requirements. If you need at least 3x ROAS to be profitable, set that as your minimum. However, this requires accurate conversion value tracking and may limit delivery, especially when starting.</p>

<h2>How Bidding Affects Delivery and Costs</h2>

<p>Higher bids generally mean more delivery and faster spending. If you bid aggressively, you win more auctions and your ads show more frequently. However, higher bids also mean higher costs, so you need to balance delivery with efficiency.</p>

<p>Lower bids mean less delivery but potentially better efficiency. If you bid conservatively, you only win auctions when costs are low, which can improve your cost per result. However, you might not spend your full budget or reach your volume goals.</p>

<p>Ad quality affects your effective bid. High-quality, relevant ads get a boost in the auction, allowing you to win with lower bids. Poor-quality ads get penalized, requiring higher bids to compete. Improving ad quality is often more effective than increasing bids.</p>

<h2>Optimizing Bids for Better Performance</h2>

<p>Start with automatic bidding (Lowest Cost) to establish baseline performance. Let Facebook optimize for at least 7 days and 50 conversions before making bid strategy changes. This gives the algorithm time to learn and optimize.</p>

<p>Monitor your cost per result and delivery. If you are spending your full budget and getting good results, you might increase budget rather than changing bidding. If you are not spending your full budget, you might need to increase bids or improve creative.</p>

<p>Test bid strategies systematically. Create duplicate ad sets with different bid strategies and compare performance. One ad set with Lowest Cost, one with Cost Cap, one with Bid Cap. Run them simultaneously to see which delivers the best combination of volume and efficiency for your business.</p>

<p>Adjust bids based on performance data, not assumptions. If your Cost Cap is limiting delivery and you are profitable at current costs, increase the cap. If your Bid Cap is spending full budget but costs are too high, lower the cap. Let data guide your decisions.</p>

<h2>Real-World Case Study: E-Commerce Store</h2>

<p>An e-commerce store was using Lowest Cost bidding and achieving a 3.5x ROAS with 2,800 Naira cost per purchase. They were profitable but wanted to scale while maintaining profitability. They needed at least 2.5x ROAS to remain profitable.</p>

<p>They tested three bidding strategies simultaneously: Lowest Cost (control), Cost Cap at 3,500 Naira, and Minimum ROAS at 2.5x. They ran all three for two weeks with equal budgets.</p>

<p>Results revealed important insights. Lowest Cost delivered 3.2x ROAS at 3,100 Naira per purchase with highest volume. Cost Cap delivered 2.9x ROAS at 3,400 Naira per purchase with 80% of Lowest Cost volume. Minimum ROAS delivered 2.6x ROAS at 3,800 Naira per purchase with only 40% of Lowest Cost volume.</p>

<p>They learned that Lowest Cost was optimal for their business. While Cost Cap and Minimum ROAS provided more control, they significantly limited volume without meaningfully improving efficiency. They scaled with Lowest Cost bidding, accepting some cost variability in exchange for maximum volume at profitable costs.</p>

<h2>Comprehensive Summary</h2>

<p>Facebook uses an auction system where bid amount, estimated action rate, and ad quality determine which ads show. Your bid represents your willingness to pay, but you typically pay less - just enough to win the auction. Understanding this system helps you bid strategically rather than simply bidding higher.</p>

<p>Lowest Cost bidding gives Facebook maximum optimization flexibility and works best for most campaigns. Cost Cap maintains average cost while maximizing volume. Bid Cap provides strict cost control but may limit delivery. Minimum ROAS maintains profitability but requires conversion value tracking and may limit delivery.</p>

<p>Bidding strategy affects both delivery and costs. Higher bids increase delivery but raise costs, lower bids improve efficiency but may limit volume. Ad quality affects your effective bid - improving creative is often more effective than increasing bids.</p>

<p>Optimize bids based on data, not assumptions. Start with Lowest Cost to establish baselines, test alternative strategies systematically, and adjust based on performance. The optimal bidding strategy balances volume and efficiency for your specific business goals and constraints.</p>

</div>',
        25,
        'https://www.youtube.com/watch?v=JRnB1OJrqzk'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'How does Facebook determine auction winners?',
     '["Bid amount, estimated action rate, and ad quality", "Highest bid only", "Ad quality only", "Random selection"]'::jsonb,
     0,
     'Facebook considers bid, estimated action rate, and ad quality - not just highest bid'),
    
    (lesson_id,
     'What is Lowest Cost bidding?',
     '["Facebook bids automatically to get most results at lowest cost", "You set the lowest possible bid", "Facebook charges the minimum", "A manual bidding strategy"]'::jsonb,
     0,
     'Lowest Cost is automatic bidding where Facebook optimizes to get maximum results at minimum cost'),
    
    (lesson_id,
     'When should you use Cost Cap bidding?',
     '["When you have a target cost per result and want to maximize volume", "For all campaigns always", "Only for small budgets", "When starting new campaigns"]'::jsonb,
     0,
     'Cost Cap works when you have a specific target cost and want maximum volume at that cost'),
    
    (lesson_id,
     'How does ad quality affect bidding?',
     '["High-quality ads get a boost, allowing lower bids to win", "Quality does not affect bidding", "Quality only affects creative", "Quality determines budget"]'::jsonb,
     0,
     'High-quality, relevant ads get an auction boost, winning with lower bids than poor-quality ads'),
    
    (lesson_id,
     'What should you do before changing bid strategies?',
     '["Let Facebook optimize for at least 7 days and 50 conversions", "Change immediately", "Wait 24 hours", "Get 10 conversions"]'::jsonb,
     0,
     'Allow sufficient learning time (7 days, 50 conversions) before evaluating or changing bid strategies');
    
    RAISE NOTICE 'Lesson 5 created';
    RAISE NOTICE '======================';
    RAISE NOTICE 'MODULE 3 COMPLETE!';
    RAISE NOTICE '======================';
    
END $$;

-- Verify Module 3
SELECT 
    m.ordering as module,
    l.ordering as lesson,
    l.title,
    LENGTH(l.content) as chars,
    (SELECT COUNT(*) FROM quiz_questions WHERE lesson_id = l.id) as quizzes
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation' AND m.ordering = 3
ORDER BY l.ordering;
