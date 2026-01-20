-- FACEBOOK ADS MODULE 1: FOUNDATIONS (Professional Edition)
-- 5 Quizzes per Lesson | Hidden Answers | Facebook Blue Styling
-- Execute after FB_ADS_00_CREATE_MODULES.sql

DO $$
DECLARE
    v_module_id UUID;
    v_blue_box text := 'background-color: #f0f8ff; border-left: 5px solid #1877f2; padding: 20px; border-radius: 5px; margin: 20px 0;';
    v_quiz_box text := 'background-color: #ffffff; border: 2px solid #1877f2; padding: 20px; border-radius: 8px; margin: 20px 0;';
    v_q_style text := 'margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;';
BEGIN
    -- Get Module 1 ID
    SELECT id INTO v_module_id FROM modules 
    WHERE course_id = '123e4567-e89b-12d3-a456-426614174002' 
    AND ordering = 1;

    -- LESSON 1: What Are Facebook Ads
    INSERT INTO lessons (module_id, title, description, video_url, content, ordering) VALUES (
        v_module_id,
        'What Are Facebook Ads & Why They Matter',
        'Understand the power of the platform.',
        'https://www.youtube.com/watch?v=3RkBdJYUL7w',
        '<h2>What Are Facebook Ads?</h2>
<p>Facebook Ads are not just "boosted posts". They are sophisticated, data-driven advertisements served across Facebook, Instagram, Messenger, and the Audience Network.</p>
<h3>Why They Matter</h3>
<ul>
    <li><strong>Micro-Targeting:</strong> Reach people based on what they love, not just what they search for.</li>
    <li><strong>Scale:</strong> Access to 3+ billion active users.</li>
    <li><strong>Measurability:</strong> Track every Naira spent and every result gained.</li>
</ul>

<div style="background-color: #f0f8ff; border-left: 5px solid #1877f2; padding: 20px; border-radius: 5px; margin: 20px 0;">
    <h3 style="color: #1877f2; margin-top: 0;">🛠 Practical Exercise</h3>
    <p><strong>Ad Audit:</strong> Open your Facebook or Instagram feed. Find 3 sponsored posts.</p>
    <ol>
        <li>Click the three dots (...) in the corner.</li>
        <li>Select "Why am I seeing this ad?".</li>
        <li>Write down the targeting criteria used (e.g., "Age 25-45", "Interested in Marketing").</li>
    </ol>
</div>

<div style="background-color: #ffffff; border: 2px solid #1877f2; padding: 20px; border-radius: 8px; margin: 20px 0;">
    <h3 style="color: #1877f2; margin-top: 0; text-align: center;">📝 Knowledge Check</h3>
    <p>Test your understanding. Click to reveal the answers.</p>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>1. What is the primary difference between Facebook Ads and Google Search Ads?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">Facebook Ads are "Paid Social" (Demand Generation), targeting users based on interests/demographics. Google Ads are "Paid Search" (Demand Capture), targeting users based on search intent.</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>2. Which of the following is NOT a placement option for Facebook Ads?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">LinkedIn Newsfeed. (Facebook placements include FB Feed, Instagram, Messenger, Audience Network, and Oculus).</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>3. True or False: You need a minimum budget of ₦50,000 to start advertising.</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">False. You can start with as little as ₦1,000 per day or $1-5/day.</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>4. What does "Organic Reach" refer to?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">The number of people who see your content for free (without paying for ads). On Facebook pages, this is typically very low (<5%).</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>5. Why is "Boosting a Post" often considered less effective than using Ads Manager?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">Boosting limits your objective choices (mostly Engagement) and targeting options. Ads Manager offers full control over objectives (Sales, Leads) and advanced targeting.</p>
        </details>
    </div>
</div>',
        1
    ) ON CONFLICT (module_id, ordering) DO UPDATE SET 
    title = EXCLUDED.title, description = EXCLUDED.description, content = EXCLUDED.content, video_url = EXCLUDED.video_url;

    -- LESSON 2: Setting Up Business Manager
    INSERT INTO lessons (module_id, title, description, video_url, content, ordering) VALUES (
        v_module_id,
        'Setting Up a Business Manager Account',
        'Create your professional advertising hub.',
        'https://www.youtube.com/watch?v=K53x7gaZJ2E',
        '<h2>Meta Business Suite Setup</h2>
<p>Meta Business Manager (now Business Suite) ensures security, asset ownership, and team collaboration. Never run ads from your personal ad account.</p>
<h3>Key Steps</h3>
<ol>
    <li>Go to business.facebook.com</li>
    <li>Create Account (Legal Business Name)</li>
    <li>Add Page (Request Access or Create)</li>
    <li>Create Ad Account (Set Currency to NGN!)</li>
    <li>Add Payment Method</li>
</ol>

<div style="background-color: #f0f8ff; border-left: 5px solid #1877f2; padding: 20px; border-radius: 5px; margin: 20px 0;">
    <h3 style="color: #1877f2; margin-top: 0;">🛠 Practical Exercise</h3>
    <p><strong>Setup Checklist:</strong> Log into your Business Settings and confirm:</p>
    <ul>
        <li>You have at least 2 admins (in case you get locked out).</li>
        <li>Your Ad Account Timezone matches your location.</li>
        <li>Two-Factor Authentication (2FA) is turned ON for everyone.</li>
    </ul>
</div>

<div style="background-color: #ffffff; border: 2px solid #1877f2; padding: 20px; border-radius: 8px; margin: 20px 0;">
    <h3 style="color: #1877f2; margin-top: 0; text-align: center;">📝 Knowledge Check</h3>
    <p>Test your understanding. Click to reveal the answers.</p>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>1. Why is it dangerous to have only one Admin in Business Manager?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">If that personal account gets restricted or hacked, you lose access to all business assets. Always have a backup admin.</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>2. Can you change your Ad Account currency from USD to NGN after creation?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">No. The currency is permanent. You would need to deactivate the account and create a brand new one.</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>3. What is the "Partner" function used for?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">To share assets with another Business Manager (like an Agency) without adding their employees individually.</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>4. Where do you find your invoices and receipts?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">In the "Billing & Payments" section of Business Settings.</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>5. True or False: You can run ads on Instagram without an Instagram account.</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">True. Ads can run on Instagram using your Facebook Page as the identity, though having a linked Instagram account is recommended.</p>
        </details>
    </div>
</div>',
        2
    ) ON CONFLICT (module_id, ordering) DO UPDATE SET 
    title = EXCLUDED.title, description = EXCLUDED.description, content = EXCLUDED.content, video_url = EXCLUDED.video_url;

    -- LESSON 3: Ecosystem
    INSERT INTO lessons (module_id, title, description, video_url, content, ordering) VALUES (
        v_module_id,
        'Understanding the Facebook Ads Ecosystem',
        'How the algorithm, auction, and user experience work together.',
        'https://www.youtube.com/watch?v=8xM4wC7ZBmE',
        '<h2>The Advertising Ecosystem</h2>
<p>Facebook is an ecosystem balanced by three parties: Users (want relevant content), Advertisers (want results), and Meta (wants revenue and retention).</p>
<h3>The Auction Formula</h3>
<p>Start mastering this formula now:</p>
<p><strong>Total Value = Bid Amount + Estimated Action Rate + Ad Quality</strong></p>
<ul>
    <li><strong>Bid:</strong> What you are willing to pay.</li>
    <li><strong>Estimated Action Rate:</strong> How likely the user is to convert.</li>
    <li><strong>Ad Quality:</strong> Feedback, clickbait penalties, load speed.</li>
</ul>

<div style="background-color: #f0f8ff; border-left: 5px solid #1877f2; padding: 20px; border-radius: 5px; margin: 20px 0;">
    <h3 style="color: #1877f2; margin-top: 0;">🛠 Practical Exercise</h3>
    <p><strong>Score Calculation:</strong> Imagine two advertisers competing for the same spot:</p>
    <ul>
        <li>Advertiser A: Bids $10, Poor Creative (Low Quality).</li>
        <li>Advertiser B: Bids $5, Amazing Creative (High Quality, High engagement).</li>
    </ul>
    <p>Result: Advertiser B often wins the auction and pays less because their "Total Value" is higher due to quality.</p>
</div>

<div style="background-color: #ffffff; border: 2px solid #1877f2; padding: 20px; border-radius: 8px; margin: 20px 0;">
    <h3 style="color: #1877f2; margin-top: 0; text-align: center;">📝 Knowledge Check</h3>
    <p>Test your understanding. Click to reveal the answers.</p>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>1. If you have the highest bid, do you always win the auction?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">No. Ad Quality and Estimated Action Rate are heavily weighted. A bad ad with a high bid will either lose or be extremely expensive.</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>2. What happens if your creative contains "Clickbait" or misleading claims?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">Your Ad Quality score drops. Facebook will reduce your reach and charge you significantly more (CPM tax).</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>3. What represents "Estimated Action Rate"?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">Facebook''s AI prediction of how likely a specific user is to perform your desired action (e.g., click or buy) based on their past behavior.</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>4. Why does Facebook prioritize User Experience over Advertiser money?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">If users see irrelevant or annoying ads, they stop using Facebook. If users leave, advertisers leave.</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>5. Which metric indicates good Ad Quality?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">Relevance Score (now detailed as: Quality Ranking, Engagement Rate Ranking, Conversion Rate Ranking).</p>
        </details>
    </div>
</div>',
        3
    ) ON CONFLICT (module_id, ordering) DO UPDATE SET 
    title = EXCLUDED.title, description = EXCLUDED.description, content = EXCLUDED.content, video_url = EXCLUDED.video_url;

    -- LESSON 4: Navigating Ads Manager
    INSERT INTO lessons (module_id, title, description, video_url, content, ordering) VALUES (
        v_module_id,
        'Navigating Meta Ads Manager',
        'Learn the interface inside and out.',
        'https://www.youtube.com/watch?v=62CDBU7Hl2E',
        '<h2>The 3-Level Hierarchy</h2>
<p>Ads Manager is organized into three distinct levels like a folder structure:</p>
<ol>
    <li><strong>Campaign Level:</strong> The "What". (Objective: Sales, Traffic)</li>
    <li><strong>Ad Set Level:</strong> The "Who" & "Where". (Audience, Placements, Budget)</li>
    <li><strong>Ad Level:</strong> The "How". (Creative, Copy, URL)</li>
</ol>

<div style="background-color: #f0f8ff; border-left: 5px solid #1877f2; padding: 20px; border-radius: 5px; margin: 20px 0;">
    <h3 style="color: #1877f2; margin-top: 0;">🛠 Practical Exercise</h3>
    <p><strong>Column Customization:</strong> The default view hides the good data.</p>
    <ol>
        <li>Click "Columns: Performance".</li>
        <li>Select "Customize Columns".</li>
        <li>Add: CPM, CTR (Link Click-Through Rate), CPC (Cost Per Link Click), ROAS, Amount Spent.</li>
        <li>Save as Preset named "My Dashboard".</li>
    </ol>
</div>

<div style="background-color: #ffffff; border: 2px solid #1877f2; padding: 20px; border-radius: 8px; margin: 20px 0;">
    <h3 style="color: #1877f2; margin-top: 0; text-align: center;">📝 Knowledge Check</h3>
    <p>Test your understanding. Click to reveal the answers.</p>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>1. You want to change the target age range for your ads. Which level do you edit?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">Ad Set Level.</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>2. You want to test a new video. Which level do you edit?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">Ad Level.</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>3. You want to switch your goal from "Traffic" to "Sales". Which level do you edit?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">Campaign Level.</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>4. What does the "Breakdown" button allow you to do?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">Segment your data to see performance by Age, Gender, Region, Device, or Placement (e.g., verifying if Instagram is cheaper than Facebook).</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>5. True or False: You can have multiple Ad Sets inside one Campaign.</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">True. This is the standard structure for testing different audiences.</p>
        </details>
    </div>
</div>',
        4
    ) ON CONFLICT (module_id, ordering) DO UPDATE SET 
    title = EXCLUDED.title, description = EXCLUDED.description, content = EXCLUDED.content, video_url = EXCLUDED.video_url;

    -- LESSON 5: Terminology
    INSERT INTO lessons (module_id, title, description, video_url, content, ordering) VALUES (
        v_module_id,
        'Key Terminology: CPM, CTR, ROAS, Pixel & More',
        'Speak the language of professional media buyers.',
        'https://www.youtube.com/watch?v=K53x7gaZJ2E',
        '<h2>Essential Metrics Dictionary</h2>
<h3>Cost Metrics</h3>
<ul>
    <li><strong>CPM (Cost Per Mille):</strong> The cost for 1,000 ad impressions. Indicates audience competition.</li>
    <li><strong>CPC (Cost Per Click):</strong> Price for each link click.</li>
    <li><strong>CPA (Cost Per Action):</strong> Price for a conversion (Lead/Sale).</li>
</ul>
<h3>Performance Metrics</h3>
<ul>
    <li><strong>CTR (Click Through Rate):</strong> (Clicks / Impressions)%. Benchmarks: 1%+ is good.</li>
    <li><strong>ROAS (Return on Ad Spend):</strong> Revenue / Spend. 4.0 = 400% return.</li>
    <li><strong>Frequency:</strong> Average times a unique user saw your ad.</li>
</ul>

<div style="background-color: #f0f8ff; border-left: 5px solid #1877f2; padding: 20px; border-radius: 5px; margin: 20px 0;">
    <h3 style="color: #1877f2; margin-top: 0;">🛠 Practical Exercise</h3>
    <p><strong>Metric Audit:</strong></p>
    <ul>
        <li>If CPM is High ($20+): Your audience is too small or very competitive.</li>
        <li>If CTR is Low (<0.5%): Your creative is boring or irrelevant.</li>
        <li>If CPA is High but CTR is Good: Your landing page is the problem, not the ad.</li>
    </ul>
</div>

<div style="background-color: #ffffff; border: 2px solid #1877f2; padding: 20px; border-radius: 8px; margin: 20px 0;">
    <h3 style="color: #1877f2; margin-top: 0; text-align: center;">📝 Knowledge Check</h3>
    <p>Test your understanding. Click to reveal the answers.</p>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>1. You spent $100 and made $500 in sales. What is your ROAS?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">5.0 (or 5X).</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>2. Your ad has a frequency of 5.2. What does this mean?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">On average, people have seen your ad 5 times. This indicates "Ad Fatigue" and you should probably change the creative.</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>3. Which metric is the best indicator of how interesting your ad is?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">CTR (Click-Through Rate).</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>4. What is the difference between "Reach" and "Impressions"?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">Reach is unique people. Impressions is total views. If 1 person sees an ad 3 times, Reach = 1, Impressions = 3.</p>
        </details>
    </div>

    <div style="margin-bottom: 15px; padding: 10px; border-bottom: 1px solid #eee;">
        <strong>5. What is the Pixel?</strong>
        <details style="margin-top: 10px; cursor: pointer;">
            <summary style="color: #1877f2; font-weight: bold;">Reveal Answer</summary>
            <p style="margin-top: 5px; color: #555;">A snippet of code installed on your website to track conversions and build retargeting audiences.</p>
        </details>
    </div>
</div>',
        5
    ) ON CONFLICT (module_id, ordering) DO UPDATE SET 
    title = EXCLUDED.title, description = EXCLUDED.description, content = EXCLUDED.content, video_url = EXCLUDED.video_url;

    -- LESSON 6: Simulator (No changes)
    INSERT INTO lessons (module_id, title, description, ordering, playground, content) VALUES (
        v_module_id,
        'Meta Ads Manager Practice Simulator',
        'Practice creating campaigns in a risk-free environment',
        6,
        jsonb_build_object(
            'type', 'meta-ads-simulator',
            'url', '/meta-ads-simulator.html',
            'embedded', true,
            'objective', 'Practice creating Facebook ad campaigns'
        ),
        '<h2>Practice Simulator Lab</h2>
<p>Welcome to the Practice Lab! Use the simulator below to build complete campaigns.</p>
<p>This interactive tool mimics the real interface, allowing you to build muscle memory without risking budget.</p>'
    ) ON CONFLICT (module_id, ordering) DO UPDATE SET 
    title = EXCLUDED.title, description = EXCLUDED.description, content = EXCLUDED.content, playground = EXCLUDED.playground;

END $$;
