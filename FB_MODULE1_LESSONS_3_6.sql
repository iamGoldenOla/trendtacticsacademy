-- FACEBOOK ADS FOUNDATION - MODULE 1 LESSONS 3-6
-- Completes Module 1 with 4 additional comprehensive lessons (20 quiz questions)
-- Execute after FB_MODULE1_FINAL.sql

DO $$
DECLARE
    foundation_id UUID;
    mod1_id UUID;
    l3_id UUID; l4_id UUID; l5_id UUID; l6_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod1_id FROM modules WHERE course_id = foundation_id AND ordering = 1;
    
    RAISE NOTICE 'Creating Module 1 Lessons 3-6...';
    
    -- LESSON 3: Setting Up a Business Manager Account
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url) VALUES
    (mod1_id, 'Setting Up a Business Manager Account', 3,
    '<div class="lesson-content">
<h2>🎯 Learning Objectives</h2>
<ul><li>Create a Meta Business Manager account</li><li>Add Facebook Pages and Ad Accounts</li><li>Manage team permissions securely</li><li>Understand Business Manager structure</li></ul>

<h2>📺 Video Tutorial</h2>
<div class="video-container"><iframe width="100%" height="500" src="https://www.youtube.com/embed/JXhQyYwYw5k" frameborder="0" allowfullscreen></iframe></div>

<h2>📖 Introduction</h2>
<p>Meta Business Manager (now Meta Business Suite) is the central hub for managing all your Facebook Pages, Instagram accounts, Ad Accounts, and team permissions. Running ads from your personal account is risky and unprofessional - Business Manager creates a safety layer.</p>

<h2>🔑 Key Concepts</h2>
<h3>Why Business Manager?</h3>
<ul><li><strong>Security:</strong> Protects your personal profile</li><li><strong>Organization:</strong> Manage multiple clients/businesses</li><li><strong>Team Management:</strong> Control who has access to what</li><li><strong>Professional:</strong> Required for agencies and serious advertisers</li></ul>

<h3>Setup Steps</h3>
<ol><li>Go to business.facebook.com</li><li>Click "Create Account"</li><li>Enter business name and details</li><li>Add your Facebook Page</li><li>Create or add Ad Account</li><li>Invite team members with specific roles</li></ol>

<h2>💼 Case Study: Digital Marketing Agency</h2>
<div class="case-study"><p><strong>Challenge:</strong> Managing 15 client accounts from personal profile, security nightmare</p><p><strong>Solution:</strong> Set up Business Manager with proper structure</p><p><strong>Results:</strong> Centralized management | Team access control | No more security risks | Client confidence increased | Onboarding time reduced 70%</p></div>

<h2>✅ Key Takeaways</h2>
<ul><li>Business Manager is essential for professional advertising</li><li>Separates personal and business assets</li><li>Enables secure team collaboration</li><li>Required for managing multiple clients</li></ul>

<h2>📝 Summary</h2>
<p>Meta Business Manager is your professional command center. It protects your personal account, enables team collaboration, and is essential for managing multiple businesses or clients. Set it up before running any serious ad campaigns.</p>
</div>', 18, 'https://www.youtube.com/watch?v=JXhQyYwYw5k')
    RETURNING id INTO l3_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (l3_id, 'Why should you use Business Manager instead of your personal account?', '["Security, organization, and team management", "It is free", "Better ad performance", "Required by law"]'::jsonb, 0, 'Business Manager protects personal profile and enables professional management'),
    (l3_id, 'What is the first step to create a Business Manager account?', '["Go to business.facebook.com", "Create a Facebook Page", "Add payment method", "Invite team members"]'::jsonb, 0, 'Start at business.facebook.com to create account'),
    (l3_id, 'What can you manage in Business Manager?', '["Pages, Ad Accounts, Instagram, and team permissions", "Only Facebook Pages", "Only Ad Accounts", "Only team members"]'::jsonb, 0, 'Business Manager is a central hub for all business assets'),
    (l3_id, 'Who needs Business Manager?', '["Agencies, businesses with teams, and serious advertisers", "Only large companies", "Only agencies", "Everyone who uses Facebook"]'::jsonb, 0, 'Essential for professional advertising and team management'),
    (l3_id, 'What is the main security benefit of Business Manager?', '["Separates personal and business accounts", "Encrypts all data", "Prevents hacking", "Backs up everything"]'::jsonb, 0, 'Keeps personal profile separate from business activities');
    
    -- LESSON 4: Understanding the Facebook Ads Ecosystem
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url) VALUES
    (mod1_id, 'Understanding the Facebook Ads Ecosystem', 4,
    '<div class="lesson-content">
<h2>🎯 Learning Objectives</h2>
<ul><li>Understand the Meta advertising ecosystem</li><li>Learn how Facebook and Instagram ads work together</li><li>Discover placement options across platforms</li><li>Understand the auction system</li></ul>

<h2>📺 Video Tutorial</h2>
<div class="video-container"><iframe width="100%" height="500" src="https://www.youtube.com/embed/smIMGQbvVDY" frameborder="0" allowfullscreen></iframe></div>

<h2>📖 Introduction</h2>
<p>The Meta ecosystem includes Facebook, Instagram, Messenger, and Audience Network. Understanding how these platforms work together is crucial for maximizing your advertising reach and effectiveness.</p>

<h2>🔑 Key Concepts</h2>
<h3>The Meta Family</h3>
<ul><li><strong>Facebook:</strong> 2.9B users, diverse demographics</li><li><strong>Instagram:</strong> 2B users, younger, visual-focused</li><li><strong>Messenger:</strong> Direct messaging ads</li><li><strong>Audience Network:</strong> Third-party apps and websites</li></ul>

<h3>How the Auction Works</h3>
<p>Facebook uses an auction system where advertisers bid for ad space. Winners are determined by: <strong>Total Value = Bid × Estimated Action Rate × Ad Quality</strong></p>

<h3>Placement Options</h3>
<ul><li>Facebook Feed, Stories, Reels, Marketplace</li><li>Instagram Feed, Stories, Reels, Explore</li><li>Messenger inbox and stories</li><li>Audience Network apps</li></ul>

<h2>💼 Case Study: E-commerce Brand</h2>
<div class="case-study"><p><strong>Challenge:</strong> Only advertising on Facebook Feed, missing 60% of potential audience</p><p><strong>Solution:</strong> Expanded to Instagram, Stories, and Reels</p><p><strong>Results:</strong> Reach increased 3x | Cost per purchase decreased 40% | Younger demographic acquired | Sales up 250%</p></div>

<h2>✅ Key Takeaways</h2>
<ul><li>Meta ecosystem offers multiple platforms and placements</li><li>Auction system rewards quality and relevance</li><li>Different placements reach different audiences</li><li>Cross-platform campaigns maximize results</li></ul>

<h2>📝 Summary</h2>
<p>The Meta advertising ecosystem is vast and interconnected. By understanding how Facebook, Instagram, Messenger, and Audience Network work together, you can create campaigns that reach your audience wherever they are.</p>
</div>', 16, 'https://www.youtube.com/watch?v=smIMGQbvVDY')
    RETURNING id INTO l4_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (l4_id, 'Which platforms are part of the Meta advertising ecosystem?', '["Facebook, Instagram, Messenger, Audience Network", "Only Facebook and Instagram", "Only Facebook", "Facebook, Instagram, and Twitter"]'::jsonb, 0, 'Meta ecosystem includes all Meta-owned platforms'),
    (l4_id, 'How does the Facebook ad auction determine winners?', '["Bid × Estimated Action Rate × Ad Quality", "Highest bid wins", "First come first served", "Random selection"]'::jsonb, 0, 'Total value considers bid, performance prediction, and quality'),
    (l4_id, 'What is the Audience Network?', '["Third-party apps and websites where Meta shows ads", "Facebook groups", "Instagram influencers", "Facebook Marketplace"]'::jsonb, 0, 'Audience Network extends reach beyond Meta platforms'),
    (l4_id, 'Why advertise on multiple placements?', '["Reach different audiences and maximize results", "It is required", "Lower costs only", "Better analytics"]'::jsonb, 0, 'Different placements reach different audience segments'),
    (l4_id, 'What is the largest Meta platform by users?', '["Facebook with 2.9B users", "Instagram with 2B users", "Messenger", "WhatsApp"]'::jsonb, 0, 'Facebook has the largest user base in Meta ecosystem');
    
    -- LESSON 5: Navigating Meta Ads Manager
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url) VALUES
    (mod1_id, 'Navigating Meta Ads Manager', 5,
    '<div class="lesson-content">
<h2>🎯 Learning Objectives</h2>
<ul><li>Master Ads Manager navigation</li><li>Understand dashboard sections and tools</li><li>Learn to customize columns and views</li><li>Use filters and breakdowns effectively</li></ul>

<h2>📺 Video Tutorial</h2>
<div class="video-container"><iframe width="100%" height="500" src="https://www.youtube.com/embed/qaZC3XSAeR8" frameborder="0" allowfullscreen></iframe></div>

<h2>📖 Introduction</h2>
<p>Meta Ads Manager is your control panel for creating, managing, and analyzing ad campaigns. Mastering navigation saves time and helps you make data-driven decisions quickly.</p>

<h2>🔑 Key Features</h2>
<h3>Main Tabs</h3>
<ul><li><strong>Campaigns:</strong> High-level overview of all campaigns</li><li><strong>Ad Sets:</strong> Audience, budget, and schedule details</li><li><strong>Ads:</strong> Individual ad creative performance</li><li><strong>All Ads:</strong> Unified view across all levels</li></ul>

<h3>Essential Tools</h3>
<ul><li><strong>Create Button:</strong> Start new campaigns</li><li><strong>Filters:</strong> Find specific campaigns/ads</li><li><strong>Columns:</strong> Customize metrics displayed</li><li><strong>Breakdowns:</strong> Analyze by age, gender, placement, etc.</li><li><strong>Date Range:</strong> Compare performance periods</li></ul>

<h3>Pro Tips</h3>
<ul><li>Save custom column sets for quick access</li><li>Use keyboard shortcuts (C for create, etc.)</li><li>Set up automated rules for optimization</li><li>Export reports for client presentations</li></ul>

<h2>💼 Case Study: Performance Marketer</h2>
<div class="case-study"><p><strong>Challenge:</strong> Spending 2 hours daily navigating Ads Manager inefficiently</p><p><strong>Solution:</strong> Learned shortcuts, custom columns, and filters</p><p><strong>Results:</strong> Daily management time: 2hrs → 30min | Faster decision-making | Better campaign optimization | Manages 3x more accounts</p></div>

<h2>✅ Key Takeaways</h2>
<ul><li>Ads Manager has powerful navigation and filtering tools</li><li>Customize views to match your workflow</li><li>Use breakdowns for deeper insights</li><li>Keyboard shortcuts save significant time</li></ul>

<h2>📝 Summary</h2>
<p>Efficient Ads Manager navigation is a competitive advantage. Master the interface, customize your views, and use advanced features to manage campaigns faster and make better decisions.</p>
</div>', 17, 'https://www.youtube.com/watch?v=qaZC3XSAeR8')
    RETURNING id INTO l5_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (l5_id, 'What are the three main tabs in Ads Manager?', '["Campaigns, Ad Sets, Ads", "Create, Manage, Analyze", "Budget, Audience, Creative", "Overview, Reports, Settings"]'::jsonb, 0, 'The three-tier structure: Campaigns, Ad Sets, Ads'),
    (l5_id, 'What do breakdowns allow you to do?', '["Analyze performance by demographics, placement, etc.", "Create new campaigns", "Edit multiple ads", "Export data"]'::jsonb, 0, 'Breakdowns segment data for deeper analysis'),
    (l5_id, 'How can you save time in Ads Manager?', '["Use keyboard shortcuts and custom column sets", "Hire an assistant", "Use only mobile app", "Avoid using filters"]'::jsonb, 0, 'Shortcuts and customization dramatically improve efficiency'),
    (l5_id, 'What is the purpose of custom columns?', '["Display only the metrics you care about", "Create new metrics", "Hide campaigns", "Change ad creative"]'::jsonb, 0, 'Custom columns show relevant metrics for your goals'),
    (l5_id, 'Where do you start creating a new campaign?', '["Click the Create button", "Go to Settings", "Use the search bar", "Click on any existing campaign"]'::jsonb, 0, 'The Create button starts new campaign creation');
    
    -- LESSON 6: Key Terminology (CPM, CTR, ROAS, Pixel)
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url) VALUES
    (mod1_id, 'Key Terminology (CPM, CTR, ROAS, Pixel)', 6,
    '<div class="lesson-content">
<h2>🎯 Learning Objectives</h2>
<ul><li>Master essential Facebook Ads metrics</li><li>Understand CPM, CPC, CTR, and ROAS</li><li>Learn what the Facebook Pixel does</li><li>Know which metrics matter for your goals</li></ul>

<h2>📺 Video Tutorial</h2>
<div class="video-container"><iframe width="100%" height="500" src="https://www.youtube.com/embed/R9JNM36iPug" frameborder="0" allowfullscreen></iframe></div>

<h2>📖 Introduction</h2>
<p>Understanding Facebook Ads terminology is essential for making data-driven decisions. These metrics tell you what is working, what is not, and where to optimize.</p>

<h2>🔑 Essential Metrics</h2>
<h3>CPM (Cost Per Mille)</h3>
<p><strong>Definition:</strong> Cost per 1,000 impressions<br><strong>Formula:</strong> (Total Spend ÷ Impressions) × 1,000<br><strong>Good CPM:</strong> ₦500-₦2,000 (varies by industry)<br><strong>Use:</strong> Measure ad delivery cost</p>

<h3>CPC (Cost Per Click)</h3>
<p><strong>Definition:</strong> Average cost for each click<br><strong>Formula:</strong> Total Spend ÷ Clicks<br><strong>Good CPC:</strong> ₦50-₦300 (varies by industry)<br><strong>Use:</strong> Measure traffic acquisition cost</p>

<h3>CTR (Click-Through Rate)</h3>
<p><strong>Definition:</strong> Percentage of people who clicked<br><strong>Formula:</strong> (Clicks ÷ Impressions) × 100<br><strong>Good CTR:</strong> 1-3% (varies by objective)<br><strong>Use:</strong> Measure ad relevance and appeal</p>

<h3>ROAS (Return on Ad Spend)</h3>
<p><strong>Definition:</strong> Revenue generated per naira spent<br><strong>Formula:</strong> Revenue ÷ Ad Spend<br><strong>Good ROAS:</strong> 3x-5x minimum for profitability<br><strong>Use:</strong> Measure campaign profitability</p>

<h3>Facebook Pixel</h3>
<p><strong>Definition:</strong> Code snippet that tracks website actions<br><strong>Purpose:</strong> Measure conversions, build audiences, optimize delivery<br><strong>Essential for:</strong> E-commerce, lead generation, conversion tracking</p>

<h2>💼 Case Study: Online Store</h2>
<div class="case-study"><p><strong>Before:</strong> Spending ₦100k/month, no tracking, guessing results</p><p><strong>After:</strong> Installed Pixel, tracked all metrics</p><p><strong>Results:</strong> Discovered: CTR 0.5% (bad) → improved creative → CTR 2.1% | CPC ₦500 → ₦180 | ROAS 1.2x → 4.8x | Profitable campaigns identified</p></div>

<h2>✅ Key Takeaways</h2>
<ul><li>CPM measures delivery cost, CPC measures click cost</li><li>CTR indicates ad relevance and quality</li><li>ROAS is the ultimate profitability metric</li><li>Facebook Pixel is essential for tracking and optimization</li></ul>

<h2>📝 Summary</h2>
<p>Mastering Facebook Ads terminology empowers you to make informed decisions. Track CPM, CPC, CTR, and ROAS to understand performance. Install the Facebook Pixel to unlock advanced tracking and optimization capabilities.</p>
</div>', 19, 'https://www.youtube.com/watch?v=R9JNM36iPug')
    RETURNING id INTO l6_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation) VALUES
    (l6_id, 'What does CPM stand for and measure?', '["Cost Per Mille - cost per 1,000 impressions", "Cost Per Month", "Clicks Per Minute", "Cost Per Message"]'::jsonb, 0, 'CPM = Cost Per Mille (thousand impressions)'),
    (l6_id, 'How do you calculate CTR?', '["(Clicks ÷ Impressions) × 100", "Clicks ÷ Cost", "Impressions ÷ Clicks", "Cost ÷ Conversions"]'::jsonb, 0, 'CTR shows percentage of viewers who clicked'),
    (l6_id, 'What is a good ROAS for profitability?', '["3x-5x minimum", "1x is enough", "10x minimum", "Any positive number"]'::jsonb, 0, 'Need 3-5x ROAS to cover costs and profit'),
    (l6_id, 'What does the Facebook Pixel do?', '["Tracks website actions and builds audiences", "Creates ads automatically", "Designs graphics", "Manages budget"]'::jsonb, 0, 'Pixel tracks conversions and enables optimization'),
    (l6_id, 'Which metric best indicates ad relevance?', '["CTR (Click-Through Rate)", "CPM", "CPC", "ROAS"]'::jsonb, 0, 'High CTR means ad resonates with audience');
    
    RAISE NOTICE 'Module 1 Lessons 3-6 created successfully!';
    RAISE NOTICE 'Module 1 is now complete with 6 lessons and 30 quiz questions';
    
END $$;

-- Verify all Module 1 lessons
SELECT 
    l.ordering, 
    l.title, 
    COUNT(q.id) as quizzes
FROM lessons l
LEFT JOIN quiz_questions q ON l.id = q.lesson_id
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation' AND m.ordering = 1
GROUP BY l.id, l.ordering, l.title
ORDER BY l.ordering;
