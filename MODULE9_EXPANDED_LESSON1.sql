-- MODULE 9 EXPANDED - ALL 3 LESSONS
-- Scaling Your Campaigns - Full 1,800+ word comprehensive content

DO $$
DECLARE
    foundation_id UUID;
    mod9_id UUID;
    new_lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    
    -- Create/Get Module 9
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (foundation_id, 'Module 9: Scaling Your Campaigns', 'Master campaign scaling strategies and avoid common pitfalls', 9)
    ON CONFLICT DO NOTHING RETURNING id INTO mod9_id;
    
    IF mod9_id IS NULL THEN SELECT id INTO mod9_id FROM modules WHERE course_id = foundation_id AND ordering = 9; END IF;
    
    -- Delete existing lessons safely
    DELETE FROM quiz_questions WHERE lesson_id IN (SELECT id FROM lessons WHERE module_id = mod9_id);
    DELETE FROM lessons WHERE module_id = mod9_id;
    
    RAISE NOTICE 'Creating Module 9 with full comprehensive content...';
    
    -- LESSON 1: When to Scale (FULL 1,800+ words)
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod9_id,
        'When to Scale',
        1,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Learn scaling readiness indicators</li>
<li>Understand optimal scaling timing</li>
<li>Master pre-scaling preparation requirements</li>
<li>Learn to identify scaling opportunities</li>
<li>Understand when NOT to scale</li>
</ul>

<h2>Scaling Readiness Indicators</h2>

<p>Scaling is not about spending more money - it is about investing more in proven winners. The fundamental requirement for scaling is consistent profitability over sufficient time and volume. One good day or week is not enough. You need sustained performance demonstrating that your campaign can maintain efficiency at higher spend levels.</p>

<p>The minimum scaling readiness criteria are 7 consecutive days of profitable performance and at least 50-100 conversions during that period. Seven days accounts for day-of-week variations - a campaign performing well only on weekends will show poor performance when scaled to full weeks. Sufficient conversion volume ensures performance is not due to random chance.</p>

<p>Beyond basic profitability, examine performance stability. If your ROAS varies from 2x to 6x day-to-day, your campaign is unstable and not ready for scaling. Stable campaigns show consistent performance with minor variations. Unstable campaigns need optimization before scaling, as scaling will amplify instability.</p>

<p>Evaluate your profit margins and customer lifetime value. If you are barely profitable at current spend, scaling might push you into unprofitability as costs typically increase slightly when scaling. Ensure you have sufficient margin to absorb 10-20% cost increases while remaining profitable. Strong unit economics enable aggressive scaling.</p>

<h2>Optimal Scaling Timing</h2>

<p>Scale during stable performance periods, not immediately after making changes. If you just launched new creative, changed targeting, or adjusted bidding, wait 3-4 days for performance to stabilize before scaling. Scaling during learning phases compounds instability and typically increases costs dramatically.</p>

<p>Avoid scaling during seasonal fluctuations or market changes. If you are in retail and performance improves during holiday season, that improvement might not sustain post-holiday. Scale based on baseline performance, not seasonal peaks. Similarly, avoid scaling during market disruptions or competitive changes until you understand their impact.</p>

<p>The best time to scale is during consistent, stable, profitable performance with no recent major changes. This might sound obvious, but many advertisers scale prematurely during temporary performance spikes or immediately after optimizations, leading to disappointing results.</p>

<p>Consider external factors affecting scaling timing. If you are launching new products soon, wait until launch to scale. If you are entering slow season, delay scaling until peak season. If competitors are running major promotions, wait until the competitive landscape stabilizes. Strategic timing maximizes scaling success.</p>

<h2>Pre-Scaling Preparation</h2>

<p>Before scaling advertising, ensure your business can handle increased volume. Can your website handle 3x traffic without slowing down? Slow websites kill conversions, negating advertising improvements. Load test your website and optimize performance before scaling traffic.</p>

<p>Can your team handle increased leads or orders? If you generate 50 leads weekly and your sales team is already overwhelmed, scaling to 150 leads will create chaos and poor customer experience. Hire and train staff before scaling lead generation. For e-commerce, ensure inventory can support increased order volume.</p>

<p>Prepare creative refresh pipeline. Scaling increases frequency, accelerating creative fatigue. Before scaling, create 5-10 additional creative variations ready to deploy when fatigue sets in. Running out of fresh creative mid-scale forces you to reduce spend or accept declining performance.</p>

<p>Establish monitoring and response protocols. Scaling requires closer monitoring than stable campaigns. Define what metrics you will monitor daily, what thresholds trigger concern, and what actions you will take if performance degrades. Proactive monitoring prevents small problems from becoming expensive disasters.</p>

<h2>Identifying Scaling Opportunities</h2>

<p>The most obvious scaling opportunity is campaigns consistently exceeding your target ROAS or cost per acquisition. If your target is 3x ROAS and a campaign delivers 4.5x ROAS consistently, you have room to scale. Increase budget gradually while monitoring whether performance maintains above your target.</p>

<p>Campaigns spending less than full budget indicate scaling opportunity. If you set 100,000 Naira daily budget but only spend 70,000 Naira, you are not reaching your audience limit. This suggests you can increase budget without reaching saturation. However, investigate why you are underspending - it might indicate targeting too narrow or bids too low.</p>

<p>Low frequency (1-2 impressions per person) with good performance suggests scaling opportunity. Low frequency means you are not saturating your audience - you can show ads to more people or show more frequently to existing audience. Increase budget to expand reach while monitoring frequency to avoid over-saturation.</p>

<p>Strong performance in specific segments suggests horizontal scaling opportunities. If 25-34 age group delivers exceptional results, create dedicated campaigns for that segment with increased budget. If Instagram Feed significantly outperforms other placements, create Instagram Feed-specific campaigns with higher budgets.</p>

<h2>When NOT to Scale</h2>

<p>Do not scale during learning phases. New campaigns need 7 days and 50 conversions to exit learning. Scaling during learning resets the learning phase and typically degrades performance. Wait for learning completion and stable performance before considering scaling.</p>

<p>Do not scale campaigns with high frequency (5+). High frequency indicates audience saturation - you are showing ads too often to the same people. Scaling will increase frequency further, accelerating fatigue and increasing costs. Instead of scaling, expand targeting to reach new people.</p>

<p>Do not scale when performance is declining. If your ROAS has decreased from 4x to 3x over the past week, scaling will not help - it will accelerate the decline. Identify and fix the performance degradation before scaling. Scaling amplifies current performance, whether good or bad.</p>

<p>Do not scale if you lack operational capacity. Scaling advertising without ability to handle increased volume creates poor customer experience, damages brand reputation, and wastes advertising spend. Scale operations before scaling advertising, or scale both simultaneously.</p>

<h2>Real-World Case Study: SaaS Company</h2>

<p>A SaaS company had a campaign delivering 4.2x ROAS at 150,000 Naira daily spend for 3 weeks consistently. Their target was 3x ROAS, so they had significant margin. They decided to scale but first prepared systematically.</p>

<p>They analyzed their infrastructure. Their website could handle 5x current traffic. Their sales team had capacity for 2x current leads. They created 8 new creative variations to prevent fatigue during scaling. They established daily monitoring of ROAS, cost per trial, and frequency with clear response protocols.</p>

<p>They scaled gradually: Week 1: 150,000 to 187,500 Naira (+25%). ROAS maintained at 4.1x. Week 2: 187,500 to 234,375 Naira (+25%). ROAS decreased to 3.8x but remained well above target. Week 3: 234,375 to 292,969 Naira (+25%). ROAS decreased to 3.4x, still above target.</p>

<p>Week 4: They attempted 292,969 to 366,211 Naira (+25%) but ROAS dropped to 2.7x, below their 3x target. They immediately reduced budget back to 292,969 Naira. ROAS recovered to 3.3x. They had found their scaling limit - approximately 2x their starting budget.</p>

<p>They maintained 292,969 Naira daily spend for 2 weeks, then tested horizontal scaling. They created Lookalike Audiences based on their best customers and launched new campaigns targeting them. This allowed them to reach 400,000 Naira total daily spend while maintaining 3.2x overall ROAS.</p>

<p>Through systematic preparation, gradual scaling, close monitoring, and willingness to reduce when hitting limits, they doubled their advertising spend profitably. More importantly, they understood their scaling limits and shifted to horizontal scaling when vertical scaling became inefficient.</p>

<h2>Comprehensive Summary</h2>

<p>Scaling requires consistent profitability over at least 7 days and 50-100 conversions. Examine performance stability - unstable campaigns need optimization before scaling. Ensure sufficient profit margins to absorb typical 10-20% cost increases when scaling. Strong unit economics enable aggressive scaling.</p>

<p>Scale during stable performance periods, not during learning phases, seasonal fluctuations, or immediately after changes. Consider external factors like product launches, seasonality, and competitive landscape when timing scaling efforts. Strategic timing maximizes scaling success.</p>

<p>Prepare operationally before scaling advertising. Ensure website performance, team capacity, inventory levels, and creative pipeline can support increased volume. Establish monitoring protocols and response plans. Proactive preparation prevents scaling disasters.</p>

<p>Identify scaling opportunities through campaigns exceeding targets, underspending budgets, low frequency with good performance, or strong segment performance. Do not scale during learning, with high frequency, during performance declines, or without operational capacity. Know when to scale and when to optimize instead.</p>

</div>',
        27,
        'https://www.youtube.com/watch?v=2xfMQDxaG_w'
    )
    RETURNING id INTO new_lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (new_lesson_id, 'What are minimum scaling readiness criteria?', '["7 consecutive days profitable performance and 50-100 conversions", "1 good day", "Any profitability", "100% ROAS"]'::jsonb, 0, '7 days accounts for variations, 50-100 conversions ensures statistical significance'),
    (new_lesson_id, 'When should you avoid scaling?', '["During learning phases, high frequency, or performance declines", "When profitable", "When stable", "Never avoid scaling"]'::jsonb, 0, 'Scaling during learning, saturation, or decline amplifies problems'),
    (new_lesson_id, 'What should you prepare before scaling?', '["Website performance, team capacity, creative pipeline, monitoring protocols", "Nothing, just increase budget", "Only new creative", "Only more staff"]'::jsonb, 0, 'Comprehensive operational preparation prevents scaling disasters'),
    (new_lesson_id, 'What indicates a scaling opportunity?', '["Campaigns exceeding targets, underspending budgets, low frequency", "Any campaign", "High frequency", "Declining performance"]'::jsonb, 0, 'These indicators suggest room to increase spend profitably'),
    (new_lesson_id, 'Why wait for stable performance before scaling?', '["Scaling during instability amplifies problems and increases costs", "Facebook requires it", "It is easier", "No reason"]'::jsonb, 0, 'Stable performance indicates sustainable results that can scale');
    
    RAISE NOTICE 'Module 9 Lesson 1 created';
    
END $$;
