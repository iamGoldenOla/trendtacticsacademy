-- FACEBOOK ADS MODULE 1: FOUNDATIONS (Complete - 5 Lessons)
-- Execute after FB_ADS_00_CREATE_MODULES.sql

-- This file contains all 5 lessons for Module 1 with full instructional content
-- Each lesson follows the 7-part structure: Definition, Why It Matters, How-To, Tools, Exercise, Mistakes, Quiz

DO $$
DECLARE
    v_module_id UUID;
BEGIN
    -- Get Module 1 ID
    SELECT id INTO v_module_id FROM modules 
    WHERE course_id = '123e4567-e89b-12d3-a456-426614174002' 
    AND ordering = 1;

    -- LESSON 1: What Are Facebook Ads & Why They Matter
    INSERT INTO lessons (module_id, title, description, video_url, content, ordering) VALUES (
        v_module_id,
        'What Are Facebook Ads & Why They Matter',
        'Understand the power and potential of Facebook advertising',
        'https://www.youtube.com/watch?v=3RkBdJYUL7w',
        '<h2>What Are Facebook Ads & Why They Matter</h2>
<h3>What Are Facebook Ads?</h3>
<p>Facebook Ads are paid advertisements across Meta platforms (Facebook, Instagram, Messenger, Audience Network). They allow precise audience targeting with measurable results.</p>
<h3>Why It Matters</h3>
<ul><li>3+ billion users worldwide</li><li>Precision targeting by demographics, interests, behaviors</li><li>Start from ₦1,000/day</li><li>Track every naira spent</li><li>Level playing field for all businesses</li></ul>
<h3>How Facebook Ads Work</h3>
<ol><li>Choose objective (sales, leads, awareness)</li><li>Define target audience</li><li>Set budget</li><li>Create ad creative</li><li>Launch and optimize</li></ol>
<h3>Practical Exercise</h3>
<div style="background:#e7f3ff;padding:16px;border-radius:8px;margin:16px 0"><strong>Try This:</strong> Identify 5 ads in your Facebook feed. Note: product, what stands out, call-to-action, and why Facebook showed it to YOU.</div>
<h3>Common Mistakes</h3>
<ul><li>❌ No clear objectives → ✅ Define specific goals first</li><li>❌ Targeting everyone → ✅ Target specific audiences</li><li>❌ Expecting instant results → ✅ Allow 3-7 days for optimization</li></ul>
<h3>Knowledge Check</h3>
<div style="background:#f7f8fa;padding:16px;border-radius:8px"><strong>Q:</strong> Why are Facebook Ads more cost-effective than TV/radio?</div>',
        1
    );

    -- LESSON 2: Setting Up Business Manager
    INSERT INTO lessons (module_id, title, description, video_url, content, ordering) VALUES (
        v_module_id,
        'Setting Up a Business Manager Account',
        'Create and configure your Facebook Business Manager',
        'https://www.youtube.com/watch?v=K53x7gaZJ2E',
        '<h2>Setting Up Business Manager</h2>
<h3>What Is Business Manager?</h3>
<p>Meta Business Suite is the centralized platform for managing Pages, ad accounts, team members, and assets professionally.</p>
<h3>Why It Matters</h3>
<ul><li>Separates business from personal</li><li>Manages multiple accounts</li><li>Team collaboration without password sharing</li><li>Advanced features access</li><li>Asset protection</li></ul>
<h3>Step-by-Step Setup</h3>
<h4>1. Create Account</h4>
<ol><li>Go to business.facebook.com</li><li>Click "Create Account"</li><li>Enter business name, email, details</li><li>Submit</li></ol>
<h4>2. Add Facebook Page</h4>
<ol><li>Business Settings → Pages</li><li>Click "Add"</li><li>Add or request access to Page</li></ol>
<h4>3. Create Ad Account</h4>
<ol><li>Business Settings → Ad Accounts</li><li>Create new ad account</li><li>Set timezone (WAT) and currency (NGN)</li><li>Assign yourself as admin</li></ol>
<h4>4. Add Payment Method</h4>
<ol><li>Business Settings → Payments</li><li>Add card or PayPal</li><li>Set as primary</li></ol>
<h3>Practical Exercise</h3>
<div style="background:#e7f3ff;padding:16px;border-radius:8px;margin:16px 0"><strong>Complete:</strong> Create Business Manager, add Page, create ad account, add payment method. Take screenshots of each step.</div>
<h3>Common Mistakes</h3>
<ul><li>❌ Using personal account → ✅ Use Business Manager</li><li>❌ Wrong currency/timezone → ✅ Double-check (can''t change later)</li><li>❌ Sharing login credentials → ✅ Use permissions</li></ul>
<h3>Knowledge Check</h3>
<div style="background:#f7f8fa;padding:16px;border-radius:8px"><strong>Q:</strong> Why is choosing the correct currency and timezone critical?</div>',
        2
    );

    -- LESSON 3: Understanding the Facebook Ads Ecosystem
    INSERT INTO lessons (module_id, title, description, video_url, content, ordering) VALUES (
        v_module_id,
        'Understanding the Facebook Ads Ecosystem',
        'Learn how Facebook Ads fit into the broader Meta advertising platform',
        'https://www.youtube.com/watch?v=8xM4wC7ZBmE',
        '<h2>The Facebook Ads Ecosystem</h2>
<h3>What Is the Ecosystem?</h3>
<p>The Facebook Ads ecosystem includes all Meta platforms, tools, and services that work together to deliver and optimize your advertisements.</p>
<h3>Core Components</h3>
<ul><li><strong>Platforms:</strong> Facebook, Instagram, Messenger, Audience Network</li><li><strong>Tools:</strong> Ads Manager, Business Manager, Meta Pixel, Events Manager</li><li><strong>Audiences:</strong> Core, Custom, Lookalike</li><li><strong>Placements:</strong> Feed, Stories, Reels, In-stream, Search</li><li><strong>Ad Formats:</strong> Image, Video, Carousel, Collection, Dynamic</li></ul>
<h3>How It All Works Together</h3>
<ol><li><strong>Business Manager:</strong> Central hub for all assets</li><li><strong>Ads Manager:</strong> Where you create and manage campaigns</li><li><strong>Meta Pixel:</strong> Tracks website actions</li><li><strong>Catalog:</strong> Product inventory for dynamic ads</li><li><strong>Creative Hub:</strong> Design and preview ads</li></ol>
<h3>The Ad Delivery System</h3>
<p>Facebook uses an auction system:</p>
<ol><li>You create ad and set budget</li><li>Facebook identifies relevant users</li><li>Auction determines which ads show</li><li>Winner based on: bid + estimated action rate + ad quality</li><li>You pay only when objective is met (click, impression, etc.)</li></ol>
<h3>Practical Exercise</h3>
<div style="background:#e7f3ff;padding:16px;border-radius:8px;margin:16px 0"><strong>Explore:</strong> Log into Ads Manager. Navigate to each section: Campaigns, Ad Sets, Ads, Audiences, Pixels. Familiarize yourself with the interface.</div>
<h3>Common Mistakes</h3>
<ul><li>❌ Ignoring Instagram placement → ✅ Use both Facebook and Instagram</li><li>❌ Not installing Pixel → ✅ Install Pixel before running ads</li><li>❌ Using only one ad format → ✅ Test multiple formats</li></ul>
<h3>Knowledge Check</h3>
<div style="background:#f7f8fa;padding:16px;border-radius:8px"><strong>Q:</strong> What three factors determine who wins the Facebook ad auction?</div>',
        3
    );

    -- LESSON 4: Navigating Meta Ads Manager
    INSERT INTO lessons (module_id, title, description, video_url, content, ordering) VALUES (
        v_module_id,
        'Navigating Meta Ads Manager',
        'Master the Ads Manager interface and key features',
        'https://www.youtube.com/watch?v=62CDBU7Hl2E',
        '<h2>Navigating Meta Ads Manager</h2>
<h3>What Is Ads Manager?</h3>
<p>Ads Manager is your command center for creating, managing, and analyzing Facebook ad campaigns. It''s where you''ll spend most of your time as an advertiser.</p>
<h3>Why Master It?</h3>
<ul><li>Faster campaign creation</li><li>Better optimization decisions</li><li>Avoid costly mistakes</li><li>Access advanced features</li><li>Professional workflow</li></ul>
<h3>Key Interface Elements</h3>
<h4>Top Navigation</h4>
<ul><li><strong>Account Dropdown:</strong> Switch between ad accounts</li><li><strong>Create Button:</strong> Start new campaigns</li><li><strong>Search:</strong> Find specific campaigns/ads</li><li><strong>Notifications:</strong> Alerts and updates</li></ul>
<h4>Left Sidebar</h4>
<ul><li><strong>Campaigns:</strong> Campaign-level view</li><li><strong>Ad Sets:</strong> Audience and budget settings</li><li><strong>Ads:</strong> Creative level</li><li><strong>All Ads:</strong> View all ads across campaigns</li><li><strong>Audiences:</strong> Saved audience library</li><li><strong>Billing:</strong> Payment and spending</li></ul>
<h4>Main Dashboard</h4>
<ul><li><strong>Performance Chart:</strong> Visual metrics over time</li><li><strong>Data Table:</strong> Detailed campaign stats</li><li><strong>Columns:</strong> Customize metrics displayed</li><li><strong>Filters:</strong> Narrow down data</li><li><strong>Breakdowns:</strong> Analyze by age, gender, placement, etc.</li></ul>
<h3>Essential Actions</h3>
<h4>Creating a Campaign</h4>
<ol><li>Click green "Create" button</li><li>Choose objective</li><li>Name campaign</li><li>Set budget (optional at campaign level)</li><li>Click "Next"</li></ol>
<h4>Customizing Columns</h4>
<ol><li>Click "Columns" dropdown</li><li>Select preset or "Customize Columns"</li><li>Add/remove metrics</li><li>Save as preset</li></ol>
<h4>Using Filters</h4>
<ol><li>Click "Filter" button</li><li>Choose filter type (delivery, objective, etc.)</li><li>Apply</li><li>Save filter for reuse</li></ol>
<h3>Practical Exercise</h3>
<div style="background:#e7f3ff;padding:16px;border-radius:8px;margin:16px 0"><strong>Practice:</strong> Open Ads Manager. Customize columns to show: Results, Reach, Impressions, CTR, CPC, Amount Spent. Create a filter for "Active campaigns only". Save both.</div>
<h3>Common Mistakes</h3>
<ul><li>❌ Using default columns → ✅ Customize for your KPIs</li><li>❌ Not using filters → ✅ Filter to focus on relevant data</li><li>❌ Editing at wrong level → ✅ Know campaign vs ad set vs ad level</li></ul>
<h3>Knowledge Check</h3>
<div style="background:#f7f8fa;padding:16px;border-radius:8px"><strong>Q:</strong> What''s the difference between editing at the Campaign level vs Ad Set level?</div>',
        4
    );

    -- LESSON 5: Key Terminology
    INSERT INTO lessons (module_id, title, description, video_url, content, ordering) VALUES (
        v_module_id,
        'Key Terminology: CPM, CTR, ROAS, Pixel & More',
        'Master essential Facebook Ads metrics and terminology',
        'https://www.youtube.com/watch?v=K53x7gaZJ2E',
        '<h2>Key Facebook Ads Terminology</h2>
<h3>Why Terminology Matters</h3>
<p>Understanding metrics is crucial for making data-driven decisions, optimizing campaigns, and communicating with clients or team members professionally.</p>
<h3>Essential Metrics</h3>
<h4>Cost Metrics</h4>
<ul><li><strong>CPM (Cost Per Mille):</strong> Cost per 1,000 impressions. Shows how expensive it is to reach people.</li><li><strong>CPC (Cost Per Click):</strong> Average cost for each link click. Lower is better.</li><li><strong>CPA (Cost Per Action):</strong> Cost for each conversion (purchase, sign-up, etc.).</li><li><strong>CPL (Cost Per Lead):</strong> Cost to acquire one lead.</li></ul>
<h4>Performance Metrics</h4>
<ul><li><strong>CTR (Click-Through Rate):</strong> (Clicks ÷ Impressions) × 100. Shows ad relevance. Good CTR: 1-3%+</li><li><strong>Conversion Rate:</strong> (Conversions ÷ Clicks) × 100. Shows landing page effectiveness.</li><li><strong>ROAS (Return on Ad Spend):</strong> Revenue ÷ Ad Spend. 3:1 ROAS = ₦3 revenue per ₦1 spent.</li><li><strong>Frequency:</strong> Average times each person saw your ad. High frequency (3+) = ad fatigue.</li></ul>
<h4>Reach & Delivery</h4>
<ul><li><strong>Reach:</strong> Number of unique people who saw your ad</li><li><strong>Impressions:</strong> Total times your ad was shown (includes repeats)</li><li><strong>Relevance Score:</strong> 1-10 rating of ad quality and engagement</li></ul>
<h3>Key Tools & Features</h3>
<ul><li><strong>Meta Pixel:</strong> Code snippet that tracks website actions</li><li><strong>Custom Audiences:</strong> Audiences built from your data (website visitors, email lists)</li><li><strong>Lookalike Audiences:</strong> New people similar to your best customers</li><li><strong>Dynamic Ads:</strong> Automatically show relevant products to each person</li></ul>
<h3>Campaign Structure Terms</h3>
<ul><li><strong>Campaign:</strong> Top level - contains objective and budget</li><li><strong>Ad Set:</strong> Middle level - contains audience, placement, schedule, budget</li><li><strong>Ad:</strong> Bottom level - contains creative (image/video + copy)</li></ul>
<h3>Practical Exercise</h3>
<div style="background:#e7f3ff;padding:16px;border-radius:8px;margin:16px 0"><strong>Calculate:</strong> If you spent ₦10,000 and got 500 clicks, what''s your CPC? If 50 of those clicks converted, what''s your conversion rate? If those 50 conversions generated ₦50,000 revenue, what''s your ROAS?</div>
<h3>Common Mistakes</h3>
<ul><li>❌ Focusing only on clicks → ✅ Track conversions and ROAS</li><li>❌ Ignoring frequency → ✅ Monitor to avoid ad fatigue</li><li>❌ Not understanding the difference between reach and impressions → ✅ Know the distinction</li></ul>
<h3>Knowledge Check</h3>
<div style="background:#f7f8fa;padding:16px;border-radius:8px"><strong>Q:</strong> If your ROAS is 2:1, are you profitable? What other factors should you consider?</div>',
        5
    );

    RAISE NOTICE 'Module 1 complete: 5 lessons created';
END $$;
