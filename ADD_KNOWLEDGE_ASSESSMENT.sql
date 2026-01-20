-- CREATE KNOWLEDGE ASSESSMENT BONUS LESSON
-- Since quiz_questions requires lesson_id, create a bonus lesson for knowledge base

DO $$
DECLARE
    foundation_id UUID;
    mod10_id UUID;
    knowledge_lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod10_id FROM modules WHERE course_id = foundation_id AND ordering = 10;
    
    RAISE NOTICE 'Creating Knowledge Assessment bonus lesson...';
    
    -- Create bonus knowledge assessment lesson
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod10_id,
        'Course Knowledge Assessment',
        99, -- High ordering to place at end
        '<div class="lesson-content">

<h2>📋 Comprehensive Knowledge Assessment</h2>

<p>Congratulations on completing all 10 modules of the Facebook Ads Foundation course! This final assessment tests your understanding across all topics covered in the course.</p>

<p><strong>Assessment Overview:</strong></p>
<ul>
<li>36 comprehensive questions covering all modules</li>
<li>Tests foundational knowledge, targeting, strategy, creative, metrics, bidding, placements, tracking, scaling, and advanced strategies</li>
<li>Passing score: 80% (29 out of 36 questions correct)</li>
<li>You can retake this assessment as many times as needed</li>
</ul>

<h2>📚 Topics Covered</h2>

<h3>Foundational Knowledge</h3>
<p>Campaign structure, Facebook Pixel purpose, ROAS definition, and core advertising concepts.</p>

<h3>Targeting & Audiences</h3>
<p>Lookalike Audiences, audience stacking, segmentation strategies, and precision targeting techniques.</p>

<h3>Campaign Strategy</h3>
<p>Campaign objectives, budget types, Campaign Budget Optimization, and strategic planning.</p>

<h3>Creative & Content</h3>
<p>Ad formats, aspect ratios, Dynamic Creative, and creative optimization principles.</p>

<h3>Metrics & Analytics</h3>
<p>CTR, CPM, frequency, conversion rate, and performance measurement fundamentals.</p>

<h3>Bidding & Budgeting</h3>
<p>Bidding strategies, Cost Cap, budget scaling, and optimization techniques.</p>

<h3>Placements</h3>
<p>Placement types, automatic vs manual selection, Audience Network considerations.</p>

<h3>Pixel & Tracking</h3>
<p>Custom parameters, server-side tracking, event optimization, and data collection.</p>

<h3>Scaling</h3>
<p>Scaling readiness, vertical vs horizontal scaling, when to pause, and sustainable growth.</p>

<h3>Advanced Strategies</h3>
<p>Sequential retargeting, multivariate testing, statistical significance, and advanced optimization.</p>

<h3>Best Practices</h3>
<p>Learning phases, campaign management, exclusions, and budget allocation frameworks.</p>

<h2>✅ How to Use This Assessment</h2>

<ol>
<li><strong>Review Course Materials:</strong> Before taking the assessment, review lessons where you feel less confident</li>
<li><strong>Take Your Time:</strong> Read each question carefully and consider all options</li>
<li><strong>Learn from Explanations:</strong> Each answer includes detailed explanations - read them even for correct answers</li>
<li><strong>Identify Weak Areas:</strong> Questions you miss indicate topics to review further</li>
<li><strong>Retake as Needed:</strong> Use this assessment multiple times to reinforce learning</li>
</ol>

<h2>🎓 After Completing This Assessment</h2>

<p>Once you achieve 80%+ on this assessment, you have demonstrated comprehensive understanding of Facebook Ads fundamentals and advanced strategies. You are ready to:</p>

<ul>
<li>Launch and manage profitable Facebook ad campaigns</li>
<li>Optimize campaigns using data-driven decision making</li>
<li>Scale campaigns while maintaining efficiency</li>
<li>Implement advanced targeting and retargeting strategies</li>
<li>Test and iterate for continuous improvement</li>
</ul>

<h2>📖 Additional Resources</h2>

<p><em>Disclaimer: The following resources are not owned by Trendtactics Digital. They are curated external resources to supplement your learning.</em></p>

<p>For continued learning, explore the study guide resources provided at the end of each module. These curated YouTube videos provide additional perspectives and examples to reinforce your knowledge.</p>

<h2>🚀 Ready to Begin?</h2>

<p>Complete the 36-question assessment below to test your comprehensive understanding of Facebook Ads. Good luck!</p>

</div>',
        15,
        'https://www.youtube.com/watch?v=006V3t__xkc'
    )
    RETURNING id INTO knowledge_lesson_id;
    
    -- Now add all 36 knowledge base questions to this lesson
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    
    -- FOUNDATIONAL KNOWLEDGE
    (knowledge_lesson_id, 'What are the three levels of Facebook Ads campaign structure?', 
     '["Campaign, Ad Set, Ad", "Account, Campaign, Creative", "Budget, Targeting, Creative", "Objective, Audience, Placement"]'::jsonb,
     0, 'The three-tier structure is Campaign (objective), Ad Set (targeting and budget), and Ad (creative)'),
    
    (knowledge_lesson_id, 'What is the primary purpose of the Facebook Pixel?', 
     '["Track conversions and build audiences for optimization", "Create ads automatically", "Manage ad budgets", "Design creative"]'::jsonb,
     0, 'The Pixel tracks user actions for conversion tracking, audience building, and campaign optimization'),
    
    (knowledge_lesson_id, 'What does ROAS stand for?', 
     '["Return on Ad Spend", "Rate of Ad Success", "Revenue on All Sales", "Reach of Ad Set"]'::jsonb,
     0, 'ROAS (Return on Ad Spend) measures revenue generated per dollar spent on advertising'),
    
    -- TARGETING & AUDIENCES
    (knowledge_lesson_id, 'What is a Lookalike Audience?', 
     '["People similar to your existing customers", "People who look at your ads", "People in similar locations", "People with similar interests"]'::jsonb,
     0, 'Lookalike Audiences find people similar to your best customers based on Facebook data'),
    
    (knowledge_lesson_id, 'What is the difference between 1% and 5% Lookalike Audiences?', 
     '["1% is more similar but smaller, 5% is less similar but larger", "No difference", "5% is always better", "1% costs more"]'::jsonb,
     0, '1% Lookalikes are most similar to source audience, 5% are less similar but reach more people'),
    
    (knowledge_lesson_id, 'What is audience stacking?', 
     '["Combining multiple targeting criteria for precision", "Creating multiple audiences", "Excluding audiences", "Testing audiences"]'::jsonb,
     0, 'Audience stacking layers criteria like Lookalike + interests for highly qualified audiences'),
    
    -- CAMPAIGN STRATEGY
    (knowledge_lesson_id, 'Which campaign objective should you use for online sales?', 
     '["Conversions (Sales)", "Traffic", "Engagement", "Awareness"]'::jsonb,
     0, 'Conversions objective optimizes for purchases and sales'),
    
    (knowledge_lesson_id, 'What is the difference between daily and lifetime budgets?', 
     '["Daily spends evenly each day, lifetime allows Facebook to optimize across campaign duration", "No difference", "Lifetime is always better", "Daily costs more"]'::jsonb,
     0, 'Daily budgets spend consistently each day, lifetime budgets allow Facebook to optimize spending across the campaign period'),
    
    (knowledge_lesson_id, 'What is Campaign Budget Optimization (CBO)?', 
     '["Automatically distributes budget across ad sets for best results", "Manual budget setting", "A bidding strategy", "A targeting option"]'::jsonb,
     0, 'CBO automatically allocates campaign budget to best-performing ad sets'),
    
    -- CREATIVE & CONTENT
    (knowledge_lesson_id, 'What is the recommended aspect ratio for Facebook Feed ads?', 
     '["1:1 (square) or 4:5 (vertical)", "16:9 (horizontal)", "9:16 (vertical)", "Any ratio"]'::jsonb,
     0, 'Square (1:1) or vertical (4:5) formats work best for mobile Feed placements'),
    
    (knowledge_lesson_id, 'What is the recommended aspect ratio for Stories ads?', 
     '["9:16 (vertical full-screen)", "1:1 (square)", "16:9 (horizontal)", "4:5 (vertical)"]'::jsonb,
     0, 'Stories require 9:16 vertical format to fill the full-screen mobile experience'),
    
    (knowledge_lesson_id, 'What is Dynamic Creative?', 
     '["Facebook tests combinations of headlines, images, and descriptions to find winners", "Ads that change based on time", "Video ads only", "Automated ad creation"]'::jsonb,
     0, 'Dynamic Creative automatically tests combinations of creative elements to optimize performance'),
    
    -- METRICS & ANALYTICS
    (knowledge_lesson_id, 'What does CTR measure?', 
     '["Click-through rate - percentage of people who click after seeing ad", "Cost to reach", "Conversion tracking rate", "Customer transaction rate"]'::jsonb,
     0, 'CTR (Click-Through Rate) shows percentage of impressions that result in clicks'),
    
    (knowledge_lesson_id, 'What does CPM stand for?', 
     '["Cost per 1,000 impressions", "Cost per million", "Cost per month", "Cost per metric"]'::jsonb,
     0, 'CPM measures the cost to show your ad 1,000 times'),
    
    (knowledge_lesson_id, 'What is a good frequency range for most campaigns?', 
     '["1-3 impressions per person", "10+ impressions per person", "0.5 impressions per person", "Frequency does not matter"]'::jsonb,
     0, 'Frequency of 1-3 maintains awareness without causing ad fatigue'),
    
    (knowledge_lesson_id, 'What does conversion rate measure?', 
     '["Percentage of clicks that result in conversions", "Total conversions", "Cost per conversion", "Click-through rate"]'::jsonb,
     0, 'Conversion rate shows how well your landing page converts traffic into results'),
    
    -- BIDDING & BUDGETING
    (knowledge_lesson_id, 'Which bidding strategy should beginners start with?', 
     '["Lowest Cost to establish baselines", "Bid Cap immediately", "Cost Cap first", "Minimum ROAS always"]'::jsonb,
     0, 'Lowest Cost provides baseline performance data before testing other strategies'),
    
    (knowledge_lesson_id, 'What does Cost Cap bidding do?', 
     '["Maintains target cost while maximizing volume", "Sets maximum bid per auction", "Ensures minimum ROAS", "Minimizes all costs"]'::jsonb,
     0, 'Cost Cap balances cost control with volume by maintaining average target cost'),
    
    (knowledge_lesson_id, 'What is the recommended budget scaling pace?', 
     '["20-30% increases every 3-4 days", "Double budget immediately", "10% daily increases", "50% weekly increases"]'::jsonb,
     0, 'Gradual 20-30% increases maintain optimization stability when scaling'),
    
    -- PLACEMENTS
    (knowledge_lesson_id, 'What are the main Facebook ad placement categories?', 
     '["Facebook, Instagram, Messenger, Audience Network", "Only Facebook and Instagram", "Only Facebook Feed", "Desktop and mobile"]'::jsonb,
     0, 'Ads can appear across Facebook, Instagram, Messenger, and Audience Network'),
    
    (knowledge_lesson_id, 'When should you use automatic placements?', 
     '["When starting without placement performance data", "Always", "Never", "Only for large budgets"]'::jsonb,
     0, 'Automatic placements gather data across all placements to inform future optimization'),
    
    (knowledge_lesson_id, 'What is a common issue with Audience Network?', 
     '["Often delivers lower quality traffic than Facebook properties", "Too expensive", "Not enough reach", "Only works on desktop"]'::jsonb,
     0, 'Audience Network extends reach but often has lower engagement and conversion rates'),
    
    -- PIXEL & TRACKING
    (knowledge_lesson_id, 'What are custom parameters in Pixel events?', 
     '["Additional data like product IDs that enable advanced optimization", "Required Facebook fields", "Bidding options", "Targeting criteria"]'::jsonb,
     0, 'Custom parameters provide additional context for better optimization and audience building'),
    
    (knowledge_lesson_id, 'What is server-side tracking?', 
     '["Tracking events from your server instead of browser", "Tracking on Facebook servers", "Advanced Pixel feature", "Mobile-only tracking"]'::jsonb,
     0, 'Server-side tracking sends events from your server, bypassing browser limitations like ad blockers'),
    
    (knowledge_lesson_id, 'How much more data can server-side tracking capture?', 
     '["20-30% more events than browser-only", "Same as browser", "5% more", "100% more"]'::jsonb,
     0, 'Server-side tracking typically captures 20-30% more events by bypassing ad blockers and privacy settings'),
    
    -- SCALING
    (knowledge_lesson_id, 'What are minimum scaling readiness criteria?', 
     '["7 consecutive days profitable and 50-100 conversions", "1 good day", "Any profitability", "100% ROAS"]'::jsonb,
     0, '7 days accounts for variations, 50-100 conversions ensures statistical significance'),
    
    (knowledge_lesson_id, 'What is vertical scaling?', 
     '["Increasing budget on existing campaigns", "Creating new campaigns", "Expanding to new markets", "Changing creative"]'::jsonb,
     0, 'Vertical scaling increases spend on current campaigns'),
    
    (knowledge_lesson_id, 'What is horizontal scaling?', 
     '["Creating new campaigns with new audiences or creative", "Increasing existing budgets", "Reducing spend", "Pausing campaigns"]'::jsonb,
     0, 'Horizontal scaling expands reach through new campaigns'),
    
    (knowledge_lesson_id, 'When should you pause scaling?', 
     '["When cost per result increases more than 30%", "Never pause scaling", "After any cost increase", "When budget doubles"]'::jsonb,
     0, 'Cost increases over 30% indicate problems requiring investigation before further scaling'),
    
    -- ADVANCED STRATEGIES
    (knowledge_lesson_id, 'What is sequential retargeting?', 
     '["Showing different messages based on engagement level", "Showing same message repeatedly", "Targeting in alphabetical order", "Random message selection"]'::jsonb,
     0, 'Sequential retargeting guides prospects through decision-making with progressive messaging'),
    
    (knowledge_lesson_id, 'What is optimal retargeting frequency?', 
     '["3-5 impressions per person per week", "1 impression per week", "10+ impressions per day", "Any frequency"]'::jsonb,
     0, '3-5 impressions maintains awareness without causing fatigue'),
    
    (knowledge_lesson_id, 'What is multivariate testing?', 
     '["Testing multiple elements simultaneously to find winning combinations", "Testing one element only", "Testing audiences only", "Testing budgets only"]'::jsonb,
     0, 'Multivariate testing tests combinations of elements to find optimal mix'),
    
    (knowledge_lesson_id, 'What statistical significance is required for A/B tests?', 
     '["95%+ before concluding tests", "50% is enough", "Any difference", "100% certainty"]'::jsonb,
     0, '95% significance means only 5% probability results are due to random chance'),
    
    -- BEST PRACTICES
    (knowledge_lesson_id, 'How long should you let a new campaign run before making changes?', 
     '["At least 7 days and 50 conversions", "24 hours", "1 hour", "30 days"]'::jsonb,
     0, 'Campaigns need 7 days and 50 conversions to exit learning phase and stabilize'),
    
    (knowledge_lesson_id, 'What should you do with consistently poor-performing ad sets?', 
     '["Pause them to prevent wasting budget", "Increase their budget", "Keep them running", "Duplicate them"]'::jsonb,
     0, 'Pause poor performers to focus budget on effective ad sets'),
    
    (knowledge_lesson_id, 'Why exclude existing customers from acquisition campaigns?', 
     '["Prevents wasting budget on people who already purchased", "Facebook requires it", "It reduces costs", "It improves creative"]'::jsonb,
     0, 'Excluding customers focuses acquisition budget on new prospects'),
    
    (knowledge_lesson_id, 'What is the 70-20-10 budget allocation rule?', 
     '["70% proven campaigns, 20% promising, 10% experimental", "70% awareness, 20% consideration, 10% conversion", "70% testing, 20% scaling, 10% maintenance", "70% Facebook, 20% Instagram, 10% other"]'::jsonb,
     0, '70-20-10 allocates most budget to proven winners while maintaining testing for new opportunities');
    
    RAISE NOTICE '======================';
    RAISE NOTICE 'KNOWLEDGE ASSESSMENT LESSON CREATED!';
    RAISE NOTICE 'Bonus lesson with 36 comprehensive quiz questions';
    RAISE NOTICE 'Placed at end of Module 10';
    RAISE NOTICE '======================';
    
END $$;
