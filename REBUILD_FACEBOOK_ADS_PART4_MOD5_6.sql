-- Rebuild Facebook Ads Mastery - Part 4: Modules 5 & 6 Content

DO $$
DECLARE
    v_mastery_course_id UUID := '0987fcde-4321-0987-6543-210987654321';
    v_mod5_id UUID;
    v_mod6_id UUID;
BEGIN
    -- Get Module IDs
    SELECT id INTO v_mod5_id FROM modules WHERE course_id = v_mastery_course_id AND ordering = 5;
    SELECT id INTO v_mod6_id FROM modules WHERE course_id = v_mastery_course_id AND ordering = 6;

    -- MODULE 5: Pixel, Events & Tracking -----------------------------------------------------------------

    -- 5.1 Installing the Facebook Pixel
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod5_id, 'Installing the Facebook Pixel', 1,
    '<h2>The Heart of the Installation</h2>
    <p>The <strong>Meta Pixel</strong> is a snippet of Javascript code that connects your website to Facebook ads. Without it, you are flying blind.</p>

    <h3>Why It Matters</h3>
    <ul>
        <li><strong>Tracking:</strong> Know exactly who bought.</li>
        <li><strong>Optimization:</strong> Tell Facebook "Find more people like THIS buyer".</li>
        <li><strong>Retargeting:</strong> Show ads to people who visited but left.</li>
    </ul>

    <h3>Installation Step-by-Step</h3>
    <ol>
        <li>Go to <strong>Events Manager</strong> in Business Manager.</li>
        <li>Click <strong>Connect Data Sources</strong> > Web.</li>
        <li>Name your Pixel (e.g., "Main Store Pixel").</li>
        <li><strong>Choice:</strong> Manual Code vs. Partner Integration.</li>
    </ol>

    <h4>Method A: Partner Integration (Easiest)</h4>
    <p>If you use Shopify, WordPress, or WooCommerce, use this. Log into your platform, install the Facebook App, and click "Connect". It handles everything automatically.</p>

    <h4>Method B: Manual Install</h4>
    <p>Copy the Base Code. Paste it into the <code>&lt;head&gt;</code> section of your website header. It must appear on EVERY page.</p>

    <h3>Verification</h3>
    <p>Download the chrome extension <strong>"Meta Pixel Helper"</strong>. Visit your site. The icon should turn blue and show "PageForm" event firing.</p>');

    -- 5.2 Standard vs. Custom Events
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod5_id, 'Standard vs. Custom Events', 2,
    '<h2>Tracking Specific Actions</h2>
    <p>The "Base Code" tracks visits (PageViews). But you need to track <strong>Actions</strong> (Events).</p>

    <h3>Standard Events (The Basics)</h3>
    <p>Meta has predefined events that the algorithm understands perfectly:</p>
    <ul>
        <li><strong>ViewContent:</strong> Viewed a product page.</li>
        <li><strong>AddToCart:</strong> Clicked "Add to Cart".</li>
        <li><strong>InitiateCheckout:</strong> Reached the payment page.</li>
        <li><strong>Purchase:</strong> Completed payment. (The big one!)</li>
        <li><strong>Lead:</strong> Submitted a form.</li>
    </ul>

    <h3>Custom Conversions (The Specifics)</h3>
    <p>Use these when you can''t add code. You define them by URL rules.</p>
    <p><em>Example:</em> "Anyone who visits <code>/thank-you-ebook</code> counts as a LEAD."</p>
    
    <h3>Hierarchy of Value</h3>
    <p>Purchase > InitiateCheckout > AddToCart > ViewContent. <br>Always optimize for the highest value event you have enough data for.</p>');

    -- 5.3 Conversion Tracking & Attribution
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod5_id, 'Conversion Tracking & Attribution', 3,
    '<h2>Who Gets the Credit?</h2>
    <p><strong>Attribution</strong> is how Facebook decides if your ad caused the sale.</p>

    <h3>The Default Setting: 7-Day Click, 1-Day View</h3>
    <p>This means Facebook takes credit if:</p>
    <ul>
        <li>Someone clicks your ad and buys within 7 days.</li>
        <li>Someone VIEWS your ad (doesn''t click) and buys within 24 hours.</li>
    </ul>

    <h3>The iOS14 Problem</h3>
    <p>Apple''s privacy updates made tracking harder. Many "View-Through" conversions are now missed. Data in Ads Manager is often under-reported by 10-20% compared to your actual bank account.</p>

    <h3>Solution: Third-Party Tracking</h3>
    <p>Tools like Hyros or TripleWhale help specialized advertisers track accurate data. for beginners, rely on Facebook but understand it might miss some sales.</p>');

    -- 5.4 Offline Conversions & CRM Integration
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod5_id, 'Offline Conversions & CRM Integration', 4,
    '<h2>Bridging the Gap</h2>
    <p>What if you run ads for a car dealership? The "Purchase" happens in person, not online. How does Facebook know?</p>

    <h3>Offline Event Sets</h3>
    <p>You can upload a CSV file of your sales (Name, Email, Phone, Value) back to Facebook. Facebook matches these customers to people who saw your ads and reports the "Offline Conversion".</p>

    <h3>CRM Integration (Zapier / CAPI)</h3>
    <p>Connect your CRM (HubSpot, Salesforce) to Facebook via API. When a salesperson marks a lead "Closed Won", the signal is sent back to Facebook instantly so the algorithm learns "This type of person buys cars".</p>');

    -- 5.5 Troubleshooting Pixel Issues
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod5_id, 'Troubleshooting Pixel Issues', 5,
    '<h2>When Things Break</h2>
    <p>Common pixel errors and how to fix them.</p>

    <h3>1. "Pixel Not Found"</h3>
    <p>Check if you have an Adblocker on. Turn it off. Check if the code is actually in the <code>&lt;head&gt;</code>.</p>

    <h3>2. "Multiple Events Firing"</h3>
    <p>If you see "Purchase" firing 2x for one sale, your ROAS will look double what it really is! This happens if you have both Shopify Integration AND manual code installed. Use on ONLY one method.</p>

    <h3>3. "Event Missing Deduplication Parameter"</h3>
    <p>Technical Alert! This means you are sending data via Browser (Pixel) and Server (CAPI) but forgot to tag them with the same "Event ID". Facebook doesn''t know they are the same event.</p>');


    -- MODULE 6: Scaling & Optimization -------------------------------------------------------------------

    -- 6.1 Reading Performance Data
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod6_id, 'Reading Performance Data', 1,
    '<h2>Data Analysis 101</h2>
    <p>Don''t just stare at the dashboard. Know what to look for.</p>

    <h3>The "North Star" Metric</h3>
    <p><strong>CPA (Cost Per Acquisition)</strong> or <strong>ROAS</strong>. Nothing else matters if these are bad. If you are profitable, you win.</p>

    <h3>Secondary Metrics (Troubleshooting)</h3>
    <ul>
        <li><strong>High CPM?</strong> Your audience is too small or competition is fierce. Creative might be flagged.</li>
        <li><strong>High CTR but Low Sales?</strong> Problem is your Website/Offer. (Ad worked, Site failed).</li>
        <li><strong>Low CTR?</strong> Problem is the Ad. (People are scrolling past).</li>
    </ul>

    <h3>Custom Columns</h3>
    <p>Don''t use the default view. Create a custom column set: <br>
    <em>Amount Spent > Impressions > CPM > Link Clicks > CTR > CPC > Add to Cart > Cost per ATC > Purchases > Cost per Purchase > ROAS.</em></p>');

    -- 6.2 KPIs That Matter
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod6_id, 'KPIs That Matter', 2,
    '<h2>Key Performance Indicators</h2>
    <p>Benchmarks vary by industry, but here are general rules of thumb for E-commerce in 2026:</p>
    
    <div style="background: #f8fafc; padding: 20px; border-radius: 8px;">
        <p><strong>CTR (Link Click-Through):</strong> Shoot for > 1.0% (Cold Traffic) and > 2.0% (Retargeting).</p>
        <p><strong>CPM:</strong> Highly variable. $5-$20 is normal. >$50 is dangerous.</p>
        <p><strong>Conversion Rate (CVR):</strong> Website conversion should be > 2%.</p>
        <p><strong>Scroll Stopper (3-sec View):</strong> > 25% of people should watch at least 3 seconds.</p>
    </div>

    <h3>The "Breakeven ROAS" Calculation</h3>
    <p>You MUST know this number. If your profit margin is 50%, your Breakeven ROAS is 2.0. <br>
    (You spend $1 to make $2 revenue, giving you $1 profit to cover the ad cost -> $0 net).</p>');

    -- 6.3 Scaling Strategies: Horizontal vs. Vertical
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod6_id, 'Scaling Strategies: Horizontal vs. Vertical', 3,
    '<h2>How to Spend More Without Losing Money</h2>
    <p>Scaling is the hardest part. Typically, as spend goes up, ROAS goes down. Your job is to manage that decline.</p>

    <div style="display: flex; gap: 20px; flex-wrap: wrap;">
        <div style="flex: 1; padding: 15px; border: 2px solid #3b82f6; border-radius: 8px;">
            <h3 style="color: #1d4ed8; text-align: center;">Vertical Scaling (Up)</h3>
            <p><strong>Definition:</strong> Increasing the budget on a winning Ad Set.</p>
            <p><strong>Method:</strong> Increase by 20% every 48-72 hours.</p>
            <p><strong>Analogy:</strong> Pouring more fuel on an existing fire. Too much at once suffocates it (resets learning).</p>
        </div>
        
        <div style="flex: 1; padding: 15px; border: 2px solid #10b981; border-radius: 8px;">
            <h3 style="color: #047857; text-align: center;">Horizontal Scaling (Out)</h3>
            <p><strong>Definition:</strong> Creating NEW Ad Sets targeting NEW people.</p>
            <p><strong>Method:</strong> Duplicate the winning ad creative into a new Lookalike Audience or Interest.</p>
            <p><strong>Analogy:</strong> Lighting new campfires in different locations.</p>
        </div>
    </div>

    <h3>The "Surfing" Strategy</h3>
    <p>On days where performance is amazing, increase budget aggressively (Vertical). On bad days, cut back. This creates a "Surfing" pattern on the chart.</p>');

    -- 6.4 Budget Optimization Techniques
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod6_id, 'Techniques: CBO vs ABO', 4,
    '<h2>Where to Control the Money?</h2>
    
    <h3>CBO (Advantage+ Campaign Budget)</h3>
    <p><strong>Definition:</strong> You set budget at the CAMPAIGN level (e.g., $100). Facebook splits it between Ad Sets automatically.</p>
    <p><strong>Best For:</strong> Scaling. Let the AI give money to the winning audience.</p>

    <h3>ABO (Ad Set Budget Optimization)</h3>
    <p><strong>Definition:</strong> You set budget at the AD SET level ($20 here, $20 there).</p>
    <p><strong>Best For:</strong> Testing. You force Facebook to spend money on specific audiences to see if they work.</p>

    <h3>Strategy: The "Testing to Scaling" Pipeline</h3>
    <ol>
        <li>Test creatives/audiences using <strong>ABO</strong> (Force the spend).</li>
        <li>Identify winners.</li>
        <li>Move winners into a massive <strong>CBO</strong> campaign for scaling.</li>
    </ol>');

    -- 6.5 When & How to Kill Underperforming Ads
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod6_id, 'When & How to Kill Underperforming Ads', 5,
    '<h2>The "Kill" Criteria</h2>
    <p>Emotions lose money. Rules make money. Set your rules before you launch.</p>

    <h3>Example Rules for a $50 Product (CPA Goal: $20)</h3>
    <ul>
        <li><strong>Rule 1:</strong> Spend > $20 (1x CPA) with 0 Add-to-Carts? -> <strong>KILL</strong>.</li>
        <li><strong>Rule 2:</strong> Spend > $40 (2x CPA) with 0 Purchases? -> <strong>KILL</strong>.</li>
        <li><strong>Rule 3:</strong> ROAS < 1.5 over last 3 days? -> <strong>KILL</strong>.</li>
    </ul>

    <h3>Stop Loss Automation</h3>
    <p>You can set "Automated Rules" in Facebook to do this for you while you sleep. <br>
    <em>"Turn off ad if Spend > $40 AND Purchases < 1."</em></p>

    <h3>Don''t Kill too Early</h3>
    <p>If an ad has spent $5... it hasn''t had a chance. Give it at least 24-48 hours or 1x your target CPA before judging.</p>');

    RAISE NOTICE 'Modules 5 & 6 Content Populated.';
END $$;
