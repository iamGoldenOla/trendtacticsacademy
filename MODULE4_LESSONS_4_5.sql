-- MODULE 4 - LESSONS 4-5 COMPLETE
-- A/B Testing and Dynamic Creative Optimization

DO $$
DECLARE
    foundation_id UUID;
    mod4_id UUID;
    lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod4_id FROM modules WHERE course_id = foundation_id AND ordering = 4;
    
    RAISE NOTICE 'Creating Module 4 final lessons...';
    
    -- LESSON 4: A/B Testing Creatives
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod4_id,
        'A/B Testing Creatives',
        4,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Understand the fundamentals of A/B testing</li>
<li>Learn what elements to test and when</li>
<li>Master test design and statistical significance</li>
<li>Understand how to analyze and act on test results</li>
<li>Learn to build a systematic testing culture</li>
</ul>

<h2>Why A/B Testing Matters</h2>

<p>A/B testing is the process of comparing two versions of an ad to determine which performs better. Small improvements compound over time - a 10% improvement in CTR or conversion rate can double your profitability over a year. The difference between successful and struggling advertisers is often not strategy or budget, but systematic testing and optimization.</p>

<p>Assumptions about what works are often wrong. What you think will perform best frequently underperforms, while unexpected variations win. A/B testing replaces opinions with data, allowing you to make decisions based on actual performance rather than preferences or assumptions.</p>

<p>Testing is not a one-time activity but an ongoing process. Markets change, audiences evolve, and ad fatigue sets in. Continuous testing keeps your campaigns fresh and optimized. The advertisers who test consistently outperform those who set campaigns and forget them.</p>

<h2>What to Test</h2>

<p>Test one element at a time to isolate what drives performance differences. If you change the image, headline, and CTA simultaneously, you cannot determine which change caused the performance difference. Single-variable testing provides clear, actionable insights.</p>

<p>High-impact elements to test include headlines, images or videos, calls-to-action, ad copy, value propositions, and offers. These elements significantly affect performance, making them worth testing first. Lower-impact elements like button colors or minor copy tweaks can be tested later once major elements are optimized.</p>

<p>Test variations that are meaningfully different, not just slightly different. Testing "Buy Now" versus "Purchase Now" will not reveal much. Testing "Buy Now" versus "Start Your Free Trial" tests fundamentally different approaches and provides valuable insights.</p>

<h2>Test Design and Statistical Significance</h2>

<p>Run tests simultaneously, not sequentially. If you test variation A this week and variation B next week, external factors like day of week, seasonality, or market conditions could affect results. Simultaneous testing ensures both variations face identical conditions.</p>

<p>Ensure sufficient sample size before declaring a winner. Small sample sizes produce unreliable results. As a rule of thumb, wait for at least 100 conversions per variation before making decisions. For awareness or engagement campaigns, wait for at least 1,000 impressions per variation.</p>

<p>Statistical significance indicates whether your results are likely due to actual performance differences or random chance. Facebook provides statistical significance indicators in A/B test results. Only act on results that reach statistical significance, typically 95% confidence level.</p>

<h2>Analyzing Test Results</h2>

<p>Look beyond surface-level metrics to understand why one variation won. If variation A has higher CTR but variation B has higher conversion rate, which is better? It depends on your objective and economics. Calculate cost per result and ROAS, not just engagement metrics.</p>

<p>Consider secondary metrics alongside primary metrics. A variation might have higher conversion rate but attract lower-quality customers with higher refund rates or lower lifetime value. Analyze the full customer journey, not just the initial conversion.</p>

<p>Document your test results and learnings. Build a testing library that captures what worked, what did not, and why. This institutional knowledge prevents repeating failed tests and helps identify patterns across multiple tests.</p>

<h2>Building a Testing Culture</h2>

<p>Always have tests running. When one test concludes, launch the next. Continuous testing creates continuous improvement. Advertisers who test weekly outperform those who test monthly, who outperform those who test quarterly.</p>

<p>Test boldly, not just incrementally. While incremental tests (blue button versus green button) have their place, breakthrough improvements come from testing fundamentally different approaches. Test different value propositions, different target audiences, different ad formats.</p>

<p>Accept that most tests will not produce winners. If 70% of your tests show no significant difference or perform worse, you are testing properly. The 30% that win more than compensate for the 70% that do not. Testing is about finding the winners, not avoiding the losers.</p>

<h2>Real-World Case Study: SaaS Company</h2>

<p>A SaaS company was running ads with a 1.8% conversion rate and 4,500 Naira cost per trial. They implemented systematic A/B testing, running one test per week for 12 weeks.</p>

<p>Week 1-2: Tested benefit-focused headline versus feature-focused headline. Benefit-focused won with 2.1% conversion rate (+17%). Week 3-4: Tested video versus image ads. Video won with 2.4% conversion rate (+14%). Week 5-6: Tested "Start Free Trial" versus "Get Started" CTA. "Start Free Trial" won with 2.7% conversion rate (+13%).</p>

<p>Week 7-8: Tested customer testimonial versus product demo. Testimonial won with 3.0% conversion rate (+11%). Week 9-10: Tested urgency messaging versus no urgency. Urgency won with 3.2% conversion rate (+7%). Week 11-12: Tested different value propositions. "Save 10 hours per week" won with 3.5% conversion rate (+9%).</p>

<p>After 12 weeks of systematic testing, their conversion rate increased from 1.8% to 3.5% - a 94% improvement. Their cost per trial dropped from 4,500 Naira to 2,300 Naira. Same budget, same audience, but nearly double the results through systematic testing. Each individual test produced modest improvements, but compounded over 12 weeks, the results were transformative.</p>

<h2>Comprehensive Summary</h2>

<p>A/B testing replaces assumptions with data, allowing you to optimize based on actual performance rather than opinions. Small improvements compound over time - systematic testing is often the difference between successful and struggling advertisers. Testing is not a one-time activity but an ongoing process that keeps campaigns optimized as markets and audiences evolve.</p>

<p>Test one element at a time to isolate performance drivers. Focus on high-impact elements like headlines, images, CTAs, and value propositions. Ensure meaningful differences between variations - testing similar options provides little insight. Run tests simultaneously with sufficient sample size and wait for statistical significance before acting on results.</p>

<p>Analyze results holistically, considering cost per result, ROAS, and customer quality, not just surface metrics. Document learnings to build institutional knowledge and prevent repeating failed tests. Look for patterns across multiple tests to identify broader insights about what resonates with your audience.</p>

<p>Build a culture of continuous testing by always having tests running. Test boldly, trying fundamentally different approaches, not just incremental variations. Accept that most tests will not produce winners - the few that do more than compensate for those that do not. Systematic testing compounds into transformative results over time.</p>

</div>',
        25,
        'https://www.youtube.com/watch?v=JRnB1OJrqzk'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'Why is A/B testing important?',
     '["Small improvements compound over time into significant results", "Facebook requires it", "It reduces advertising costs immediately", "It guarantees success"]'::jsonb,
     0,
     'A/B testing creates small improvements that compound over time, often making the difference between success and failure'),
    
    (lesson_id,
     'What should you test at a time?',
     '["One element to isolate what drives performance", "Everything simultaneously", "Only headlines", "Only images"]'::jsonb,
     0,
     'Testing one element at a time isolates what causes performance differences'),
    
    (lesson_id,
     'When should you declare a test winner?',
     '["After reaching statistical significance with sufficient sample size", "After 24 hours", "When one variation looks better", "After 100 impressions"]'::jsonb,
     0,
     'Wait for statistical significance and sufficient sample size (typically 100+ conversions per variation)'),
    
    (lesson_id,
     'What percentage of tests typically produce winners?',
     '["About 30% - most tests show no significant difference", "100% if done correctly", "50-50 chance", "90% with good strategy"]'::jsonb,
     0,
     'Most tests (70%) show no significant difference or perform worse - the 30% that win compensate for the rest'),
    
    (lesson_id,
     'Why should tests run simultaneously rather than sequentially?',
     '["To ensure both variations face identical external conditions", "It costs less", "Facebook requires it", "It is faster"]'::jsonb,
     0,
     'Simultaneous testing eliminates external factors like day of week or seasonality that could skew results');
    
    RAISE NOTICE 'Lesson 4 created';
    
    -- LESSON 5: Using Dynamic Creative Optimization
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod4_id,
        'Using Dynamic Creative Optimization',
        5,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Understand what Dynamic Creative is and how it works</li>
<li>Learn when to use Dynamic Creative versus manual testing</li>
<li>Master setting up Dynamic Creative campaigns</li>
<li>Understand how to analyze Dynamic Creative results</li>
<li>Learn best practices for creative asset preparation</li>
</ul>

<h2>What is Dynamic Creative?</h2>

<p>Dynamic Creative automatically tests different combinations of ad elements (images, videos, headlines, descriptions, CTAs) to find the best-performing combinations for each person. Instead of manually creating and testing multiple ad variations, you provide multiple assets and Facebook''s algorithm automatically combines and tests them.</p>

<p>Dynamic Creative works by showing different combinations to different people based on what Facebook''s algorithm predicts will perform best. Person A might see Image 1 with Headline 2 and CTA 1, while Person B sees Image 3 with Headline 1 and CTA 2. The algorithm learns which combinations perform best and shows them more frequently.</p>

<p>This automated testing happens at scale impossible to achieve manually. If you provide 5 images, 5 headlines, and 3 CTAs, that creates 75 possible combinations. Testing all 75 manually would be impractical, but Dynamic Creative tests them automatically and efficiently.</p>

<h2>When to Use Dynamic Creative</h2>

<p>Use Dynamic Creative when you have multiple quality assets and want to find the best combinations efficiently. If you have 5 strong images and 5 strong headlines but are unsure which combinations work best, Dynamic Creative tests them automatically. This is more efficient than manually creating and testing 25 ad variations.</p>

<p>Use Dynamic Creative for ongoing campaigns where continuous optimization is valuable. The algorithm continues learning and optimizing over time, automatically shifting to better-performing combinations as it gathers data. This is ideal for evergreen campaigns that run continuously.</p>

<p>Use Dynamic Creative when targeting diverse audiences. Different combinations might work better for different demographic segments or interest groups. Dynamic Creative automatically personalizes combinations for each person, maximizing relevance across your entire audience.</p>

<h2>When NOT to Use Dynamic Creative</h2>

<p>Do not use Dynamic Creative when you want to test fundamentally different creative strategies. If you want to test benefit-focused messaging versus feature-focused messaging, create separate ad sets. Dynamic Creative optimizes within a strategy, not between strategies.</p>

<p>Do not use Dynamic Creative with insufficient assets. If you only have 2 images and 2 headlines, manual testing is more appropriate. Dynamic Creative works best with at least 5 variations of each element to provide sufficient testing options.</p>

<p>Do not use Dynamic Creative when you need granular control over specific combinations. If you have a specific message that requires specific image-headline pairings, create manual ads. Dynamic Creative might create combinations that do not align with your intended message.</p>

<h2>Setting Up Dynamic Creative</h2>

<p>Prepare multiple high-quality assets for each element. Create 5-10 images or videos, 5 headlines, 5 descriptions, and 3-5 CTAs. Ensure each asset is strong independently - Dynamic Creative optimizes combinations, but cannot fix weak individual assets.</p>

<p>Ensure assets work well together in any combination. Since Dynamic Creative will create combinations automatically, any image should work with any headline. Avoid assets that only make sense with specific pairings. This flexibility allows the algorithm to test freely.</p>

<p>Enable Dynamic Creative at the ad level when creating your campaign. Upload your multiple assets for each element. Facebook will automatically create and test combinations. Set your optimization goal (conversions, link clicks, etc.) and the algorithm will optimize toward that goal.</p>

<h2>Analyzing Dynamic Creative Results</h2>

<p>Review asset performance reports to see which individual assets perform best. Facebook provides breakdowns showing which images, headlines, and CTAs drive the best results. This reveals which creative elements resonate most with your audience.</p>

<p>Look for patterns across winning assets. If your top 3 performing images all feature people rather than products, that is a valuable insight. If your top headlines all emphasize a specific benefit, that reveals what your audience values most. These patterns inform future creative development.</p>

<p>Use insights from Dynamic Creative to inform manual campaigns. If Dynamic Creative reveals that benefit-focused headlines outperform feature-focused headlines, apply that learning to all your campaigns. Dynamic Creative is not just an optimization tool but a learning tool.</p>

<h2>Best Practices for Creative Assets</h2>

<p>Maintain consistent brand identity across all assets while varying the specific message or visual. All images should feel cohesive even if they show different products or angles. This ensures any combination feels like a coherent ad, not a random assemblage.</p>

<p>Test meaningfully different variations, not just slight variations. Five nearly identical headlines provide little testing value. Five headlines emphasizing different benefits or approaches provide valuable insights. Diversity in your assets allows the algorithm to find what truly works.</p>

<p>Refresh assets regularly to prevent ad fatigue. Even the best-performing combinations lose effectiveness over time as audiences see them repeatedly. Add new images, headlines, and CTAs monthly to keep your Dynamic Creative fresh and effective.</p>

<h2>Real-World Case Study: E-Commerce Store</h2>

<p>An e-commerce store was manually creating and testing ad variations, managing 20 different ads across multiple ad sets. This was time-consuming and made it difficult to identify which specific elements drove performance.</p>

<p>They consolidated into Dynamic Creative with 8 product images, 6 benefit-focused headlines, 5 descriptions highlighting different features, and 4 CTAs. This created 960 possible combinations that the algorithm could test automatically.</p>

<p>Within two weeks, Dynamic Creative identified winning patterns. Images showing products in use outperformed product-only images by 35%. Headlines emphasizing time-saving benefits outperformed cost-saving headlines by 28%. The CTA "Shop Now" outperformed "Learn More" by 42%.</p>

<p>They applied these insights across all campaigns. They created more in-use product images, focused headlines on time-saving benefits, and used "Shop Now" as their primary CTA. Their overall ROAS increased from 3.2x to 4.5x. Dynamic Creative not only optimized their ads but revealed insights that improved their entire creative strategy.</p>

<h2>Comprehensive Summary</h2>

<p>Dynamic Creative automatically tests combinations of ad elements to find the best-performing variations for each person. This automated testing happens at scale impossible to achieve manually, making it efficient for testing multiple assets. The algorithm continuously learns and optimizes, automatically shifting to better combinations over time.</p>

<p>Use Dynamic Creative when you have multiple quality assets, want continuous optimization, or target diverse audiences. Do not use it when testing fundamentally different strategies, when you have insufficient assets, or when you need specific asset pairings. Dynamic Creative optimizes within a strategy, not between strategies.</p>

<p>Prepare 5-10 variations of each element (images, headlines, descriptions, CTAs) that work well in any combination. Review performance reports to identify winning assets and patterns. Use these insights to inform not just Dynamic Creative but your entire creative strategy.</p>

<p>Dynamic Creative is both an optimization tool and a learning tool. The patterns it reveals about which images, messages, and CTAs resonate with your audience provide valuable insights for all your marketing. Systematic use of Dynamic Creative combined with regular asset refreshment creates continuously optimized, effective advertising.</p>

</div>',
        23,
        'https://www.youtube.com/watch?v=2xfMQDxaG_w'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'What is Dynamic Creative?',
     '["Automatically tests combinations of ad elements to find best performers", "A manual testing tool", "An ad format", "A targeting option"]'::jsonb,
     0,
     'Dynamic Creative automatically combines and tests different ad elements (images, headlines, CTAs) to find winning combinations'),
    
    (lesson_id,
     'When should you use Dynamic Creative?',
     '["When you have multiple quality assets and want efficient testing", "For all campaigns always", "Only for small budgets", "When you have 2 images"]'::jsonb,
     0,
     'Dynamic Creative works best when you have 5+ variations of each element to test combinations efficiently'),
    
    (lesson_id,
     'What is a limitation of Dynamic Creative?',
     '["Cannot test fundamentally different creative strategies", "Too expensive", "Only works on mobile", "Requires video ads"]'::jsonb,
     0,
     'Dynamic Creative optimizes within a strategy but cannot test between fundamentally different approaches'),
    
    (lesson_id,
     'How many assets should you provide for Dynamic Creative?',
     '["5-10 variations of each element for sufficient testing", "2 of each element", "1 of each element", "20+ of each element"]'::jsonb,
     0,
     'Provide 5-10 variations of each element (images, headlines, CTAs) for effective Dynamic Creative testing'),
    
    (lesson_id,
     'What should you do with Dynamic Creative insights?',
     '["Apply learnings to inform your entire creative strategy", "Ignore them", "Only use for that specific campaign", "Delete underperforming assets immediately"]'::jsonb,
     0,
     'Dynamic Creative reveals patterns about what resonates - apply these insights across all campaigns');
    
    RAISE NOTICE 'Lesson 5 created';
    RAISE NOTICE '======================';
    RAISE NOTICE 'MODULE 4 COMPLETE!';
    RAISE NOTICE 'All 5 lessons created with comprehensive content and quizzes';
    RAISE NOTICE '======================';
    
END $$;

-- Verify Module 4
SELECT 
    m.ordering as module,
    l.ordering as lesson,
    l.title,
    LENGTH(l.content) as chars,
    (SELECT COUNT(*) FROM quiz_questions WHERE lesson_id = l.id) as quizzes
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation' AND m.ordering = 4
ORDER BY l.ordering;
