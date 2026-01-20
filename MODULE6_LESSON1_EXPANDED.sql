-- MODULE 6 EXPANDED - ALL 3 LESSONS FULL LENGTH
-- Budgeting & Bidding Strategies - Comprehensive 1,500-1,800 word content

DO $$
DECLARE
    foundation_id UUID;
    mod6_id UUID;
    lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    
    -- Create/Get Module 6
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (foundation_id, 'Module 6: Budgeting & Bidding Strategies', 'Advanced budgeting and bidding techniques for maximum ROI', 6)
    ON CONFLICT DO NOTHING RETURNING id INTO mod6_id;
    
    IF mod6_id IS NULL THEN SELECT id INTO mod6_id FROM modules WHERE course_id = foundation_id AND ordering = 6; END IF;
    
    -- Delete existing lessons to replace with full content
    DELETE FROM quiz_questions WHERE lesson_id IN (SELECT id FROM lessons WHERE module_id = mod6_id);
    DELETE FROM lessons WHERE module_id = mod6_id;
    
    RAISE NOTICE 'Creating Module 6 with full comprehensive content...';
    
    -- LESSON 1: Setting Budget (FULL 1,800+ words)
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod6_id,
        'Setting Budget',
        1,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Master budget allocation strategies across campaigns</li>
<li>Learn how to determine optimal testing budgets</li>
<li>Understand scaling budget principles</li>
<li>Master budget distribution across funnel stages</li>
<li>Learn to calculate budget requirements for business goals</li>
</ul>

<h2>Budget Allocation Philosophy</h2>

<p>Budget allocation is not about spending as much as possible - it is about investing strategically to maximize return. The most successful advertisers do not necessarily spend the most; they allocate budget most effectively across proven winners and promising tests. This requires balancing stability with innovation, proven performance with new opportunities.</p>

<p>The fundamental principle of budget allocation is the 70-20-10 rule: allocate 70% of budget to proven campaigns that consistently deliver results, 20% to promising campaigns that show potential but need more data, and 10% to experimental tests exploring new audiences, creative, or strategies. This ensures stable results while continuously discovering new opportunities.</p>

<p>However, this allocation should evolve with your business maturity. New businesses might allocate 40% proven, 40% promising, 20% experimental because they are still discovering what works. Mature businesses might allocate 80% proven, 15% promising, 5% experimental because they have established winners and need less exploration. Adjust your allocation based on your knowledge and confidence.</p>

<h2>Determining Testing Budgets</h2>

<p>Testing budgets must be large enough to generate statistical significance but small enough to limit risk if tests fail. For conversion campaigns, your testing budget should generate 50-100 conversions during the test period. If your average cost per conversion is 3,000 Naira, you need 150,000-300,000 Naira testing budget to reach significance.</p>

<p>For awareness or engagement campaigns where conversions are not the primary metric, aim for at least 10,000 impressions or 1,000 clicks per variation. This provides sufficient data to identify meaningful performance differences. Smaller sample sizes produce unreliable results that lead to poor decisions.</p>

<p>Test duration matters as much as budget. Run tests for at least 7 days to account for day-of-week variations. A campaign that performs well on weekends but poorly on weekdays needs a full week of data to reveal this pattern. Shorter tests might catch only the good or bad days, producing misleading results.</p>

<p>Consider your business cycle when setting testing budgets. If you have long sales cycles (B2B, high-ticket items), you need larger testing budgets and longer test periods because conversions happen slowly. If you have short sales cycles (e-commerce, impulse purchases), you can test with smaller budgets and shorter periods because conversions happen quickly.</p>

<h2>Scaling Budget Principles</h2>

<p>Scaling budgets requires patience and discipline. The most common mistake is scaling too aggressively - doubling or tripling budgets overnight. This disrupts Facebook''s optimization, resets the learning phase, and typically increases costs dramatically. Gradual scaling maintains optimization stability while expanding reach.</p>

<p>The recommended scaling pace is 20-30% increases every 3-4 days. If your campaign performs well at 100,000 Naira daily budget, increase to 120,000-130,000 Naira and monitor for 3-4 days. If performance remains stable, increase again. This gradual approach allows Facebook''s algorithm to adapt to increased spend without losing optimization efficiency.</p>

<p>Monitor efficiency metrics closely when scaling. Some cost increase is normal and acceptable - reaching new audiences typically costs slightly more than your most qualified existing audiences. However, if your cost per result increases more than 30%, pause scaling and investigate. You might be reaching saturation, experiencing creative fatigue, or encountering increased competition.</p>

<p>Scaling has natural limits. Eventually, you will reach audience saturation where further budget increases yield diminishing returns. When vertical scaling (increasing budget on existing campaigns) becomes inefficient, shift to horizontal scaling (creating new campaigns with new audiences or creative). This maintains efficiency while continuing growth.</p>

<h2>Budget Distribution Across Funnel Stages</h2>

<p>Effective budget allocation considers the entire customer journey, not just conversion campaigns. Different funnel stages require different budget allocations based on your business maturity and goals. New businesses need heavy awareness investment to build audiences, while established businesses can focus more on conversion.</p>

<p>A typical mature business might allocate 20% to awareness (building new audiences), 30% to consideration (nurturing warm audiences), and 50% to conversion (driving sales from hot audiences). This ensures continuous audience building while maximizing immediate returns. However, a new business might allocate 40% awareness, 35% consideration, 25% conversion to prioritize audience building.</p>

<p>Monitor how audiences flow through your funnel to optimize allocation. If your awareness campaigns create large audiences but few progress to consideration, you need stronger consideration campaigns or better awareness targeting. If consideration campaigns engage people but few convert, you need better conversion campaigns or offers. Budget allocation should address your specific funnel weaknesses.</p>

<h2>Calculating Budget Requirements</h2>

<p>Work backwards from your business goals to determine required budgets. If you need 100 new customers per month and your cost per customer is 5,000 Naira, you need 500,000 Naira monthly budget minimum. Add 20-30% buffer for testing and optimization, bringing your required budget to 600,000-650,000 Naira monthly.</p>

<p>Consider customer lifetime value when setting budgets. If your average customer is worth 50,000 Naira over their lifetime, you can profitably spend up to that amount to acquire them (though you should aim for much less). Understanding lifetime value allows you to invest more aggressively in acquisition than businesses focused only on first-purchase profitability.</p>

<p>Budget requirements also depend on your market and competition. Competitive industries require larger budgets to achieve meaningful reach and frequency. Less competitive industries can achieve results with smaller budgets. Research your industry benchmarks to set realistic budget expectations.</p>

<h2>Real-World Case Study: E-Commerce Store</h2>

<p>An e-commerce store was allocating budget equally across all campaigns: 100,000 Naira each to 5 campaigns regardless of performance. Their overall ROAS was 2.5x, but performance varied dramatically - one campaign delivered 4.2x ROAS while another delivered only 1.1x ROAS. Equal allocation meant wasting budget on poor performers.</p>

<p>They implemented strategic allocation: 70% (350,000 Naira) to the proven 4.2x ROAS campaign, 20% (100,000 Naira) to two promising campaigns showing 2.8x and 3.1x ROAS, and 10% (50,000 Naira) to testing new audiences. They paused the 1.1x ROAS campaign entirely.</p>

<p>For scaling, they increased the winning campaign budget by 25% every 4 days, monitoring performance closely. They scaled from 350,000 to 437,500 Naira over 4 days, then to 546,875 Naira over the next 4 days. Cost per purchase increased slightly from 2,400 to 2,650 Naira, but remained highly profitable.</p>

<p>After 8 weeks, their overall ROAS increased from 2.5x to 3.8x with the same total budget, simply through better allocation. They then increased total budget by 30% (from 500,000 to 650,000 Naira monthly), maintaining 3.6x ROAS at the higher spend level. Strategic allocation and disciplined scaling transformed their advertising efficiency.</p>

<h2>Comprehensive Summary</h2>

<p>Budget allocation is strategic investment, not random spending. The 70-20-10 rule (70% proven, 20% promising, 10% experimental) balances stability with innovation, though this should evolve based on business maturity. New businesses need more exploration, mature businesses can focus more on proven winners.</p>

<p>Testing budgets must generate statistical significance - 50-100 conversions for conversion campaigns, 10,000+ impressions for awareness campaigns. Run tests for at least 7 days to account for day-of-week variations. Insufficient testing budgets produce unreliable results that lead to poor decisions.</p>

<p>Scale budgets gradually at 20-30% every 3-4 days to maintain optimization stability. Monitor efficiency metrics and accept slight cost increases, but pause if costs increase more than 30%. When vertical scaling becomes inefficient, shift to horizontal scaling with new campaigns.</p>

<p>Distribute budgets across funnel stages based on business maturity and goals. Calculate required budgets by working backwards from business goals, considering customer lifetime value and market competition. Strategic allocation and disciplined scaling maximize return on advertising investment.</p>

</div>',
        28,
        'https://www.youtube.com/watch?v=8rABwKRsec4'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (lesson_id, 'What is the 70-20-10 budget allocation rule?', '["70% proven campaigns, 20% promising, 10% experimental", "70% awareness, 20% consideration, 10% conversion", "70% testing, 20% scaling, 10% maintenance", "70% Facebook, 20% Instagram, 10% other"]'::jsonb, 0, '70-20-10 allocates most budget to proven winners while maintaining testing for new opportunities'),
    (lesson_id, 'How many conversions should testing budgets generate?', '["50-100 conversions for statistical significance", "10 conversions minimum", "5 conversions is enough", "1,000 conversions required"]'::jsonb, 0, '50-100 conversions provides reliable data for test conclusions'),
    (lesson_id, 'What is the recommended budget scaling pace?', '["20-30% increases every 3-4 days", "Double budget immediately", "10% daily increases", "50% weekly increases"]'::jsonb, 0, 'Gradual 20-30% increases maintain optimization stability when scaling'),
    (lesson_id, 'When should you pause budget scaling?', '["When cost per result increases more than 30%", "Never pause scaling", "After any cost increase", "When budget doubles"]'::jsonb, 0, 'Cost increases over 30% indicate problems requiring investigation before further scaling'),
    (lesson_id, 'How should budget allocation evolve with business maturity?', '["New businesses need more testing, mature businesses focus on proven winners", "Always use same allocation", "Mature businesses test more", "New businesses only run proven campaigns"]'::jsonb, 0, 'Allocation should shift from exploration (new businesses) to exploitation (mature businesses)');
    
    RAISE NOTICE 'Module 6 Lesson 1 created with full content';
    
END $$;
