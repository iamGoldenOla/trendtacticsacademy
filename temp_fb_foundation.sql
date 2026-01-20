-- Create Facebook Ads Foundation (Beginner Course)

DO $$
DECLARE
    v_new_course_id UUID := 'a1b2c3d4-e5f6-7890-1234-567890abcdef';
    v_mastery_course_id UUID := v_new_course_id; -- Reusing variable name for minimal code change
    v_mod1_id UUID;
    v_mod2_id UUID;
    v_mod3_id UUID;
    v_mod4_id UUID;
    v_mod5_id UUID;
    v_mod6_id UUID;
    v_mod7_id UUID;
    v_mod8_id UUID;
    v_mod9_id UUID;
    v_mod10_id UUID;
BEGIN
    RAISE NOTICE 'Creating Facebook Ads Foundation Course...';

    -- 1. INSERT NEW COURSE (Upsert to be safe)
    INSERT INTO courses (id, title, description, image_url, price, status)
    VALUES (
        v_new_course_id,
        'Facebook Ads Foundation',
        'The complete beginner guide to mastering Meta Ads Managers, Audiences, and Creatives.',
        '/images/facebook-ads-foundation.jpg',
        49.99,
        'published'
    ) ON CONFLICT (id) DO NOTHING;

    -- 2. CLEAR EXISTING CONTENT FOR THIS SPECIFIC COURSE ONLY (Clean slate)
    DELETE FROM lessons WHERE module_id IN (SELECT id FROM modules WHERE course_id = v_new_course_id);
    DELETE FROM modules WHERE course_id = v_new_course_id;

    -- 3. CREATE NEW MODULES
    INSERT INTO modules (course_id, title, description, ordering) VALUES
    (v_new_course_id, 'Module 1: Foundations of Facebook Advertising', 'Master the core concepts of the Meta advertising ecosystem.', 1) RETURNING id INTO v_mod1_id;
    INSERT INTO modules (course_id, title, description, ordering) VALUES
    (v_new_course_id, 'Module 2: Audience & Targeting Mastery', 'Learn to find and target your perfect ideal customers.', 2) RETURNING id INTO v_mod2_id;
    INSERT INTO modules (course_id, title, description, ordering) VALUES
    (v_new_course_id, 'Module 3: Campaign Strategy & Objectives', 'Strategic planning for maximum ROI and campaign success.', 3) RETURNING id INTO v_mod3_id;
    INSERT INTO modules (course_id, title, description, ordering) VALUES
    (v_new_course_id, 'Module 4: Creative That Converts', 'Designing high-performance visuals and writing persuasive copy.', 4) RETURNING id INTO v_mod4_id;
    INSERT INTO modules (course_id, title, description, ordering) VALUES
    (v_new_course_id, 'Module 5: Pixel, Events & Tracking', 'Technical mastery of tracking, attribution, and data accuracy.', 5) RETURNING id INTO v_mod5_id;
    INSERT INTO modules (course_id, title, description, ordering) VALUES
    (v_new_course_id, 'Module 6: Scaling & Optimization', 'Strategies to safely scale budgets and optimize for lower CPAs.', 6) RETURNING id INTO v_mod6_id;
    INSERT INTO modules (course_id, title, description, ordering) VALUES
    (v_new_course_id, 'Module 7: Advanced Tactics & Automation', 'Leveraging AI, automation, and advanced retargeting flows.', 7) RETURNING id INTO v_mod7_id;
    INSERT INTO modules (course_id, title, description, ordering) VALUES
    (v_new_course_id, 'Module 8: Compliance, Ethics & Troubleshooting', 'Navigating policies, avoiding bans, and ethical practices.', 8) RETURNING id INTO v_mod8_id;
    INSERT INTO modules (course_id, title, description, ordering) VALUES
    (v_new_course_id, 'Module 9: Real-World Case Studies & Campaign Builds', 'Watch over-the-shoulder campaign builds for different industries.', 9) RETURNING id INTO v_mod9_id;
    INSERT INTO modules (course_id, title, description, ordering) VALUES
    (v_new_course_id, 'Module 10: Career & Certification Path', 'Building a career or agency business with Facebook Ads skills.', 10) RETURNING id INTO v_mod10_id;

    RAISE NOTICE 'Created 10 new modules for Facebook Ads Foundation.';
-- Rebuild Facebook Ads Mastery - Part 2: Modules 1 & 2 Content

    -- MODULE 1: Foundations of Facebook Advertising -------------------------------------------------------

    -- 1.1 What Are Facebook Ads & Why They Matter
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod1_id, 'What Are Facebook Ads & Why They Matter', 1, 
    '<h2>Definition</h2>
    <p>Facebook Ads is Meta''s paid advertising platform that allows businesses to display promotions to the world''s largest active social media audience. Unlike traditional advertising (billboards, TV), it relies on <strong>data-driven targeting</strong> to show ads only to people likely to be interested.</p>
    
    <h2>Why It Matters</h2>
    <div style="background: linear-gradient(to right, #eef2ff, #fae8ff); padding: 20px; border-radius: 10px; border-left: 5px solid #4f46e5;">
        <p><strong>Impact:</strong> With over 3 billion monthly active users, Meta (Facebook + Instagram) allows you to reach virtually any customer demographic on earth with precision that outdated marketing channels cannot match.</p>
    </div>

    <h3>Step-by-Step Overview</h3>
    <ul>
        <li><strong>Reach:</strong> Access users across Facebook, Instagram, Messenger, and Audience Network.</li>
        <li><strong>Precision:</strong> Target by age, location, interests, behaviors, and life events.</li>
        <li><strong>Cost-Efficiency:</strong> Pay only for results (Impressions, Clicks, or Conversions).</li>
    </ul>

    <h3>Real-World Example</h3>
    <p>A local bakery in Lagos doesn''t need to pay for a radio ad heard by the whole city. With Facebook Ads, they can spend Γéª5,000 to show their cake photos <em>only</em> to people within 5km who have a birthday coming up next week.</p>

    <h3>Common Mistakes</h3>
    <ul>
        <li>Γ¥î <strong>Boosting Posts vs. Ads Manager:</strong> Relying only on the "Boost Post" button limits your targeting options and optimization capabilities.</li>
        <li>Γ¥î <strong>Ignoring Instagram:</strong> Treating Instagram as a separate silo instead of part of the Meta ecosystem.</li>
    </ul>

    <h3>Quick Review</h3>
    <div style="background-color: #f3f4f6; padding: 15px; border-radius: 8px;">
        <p><strong>Reflection:</strong> Think of one specific group of people you want to reach. How would you describe them (Age, Location, Interest)?</p>
    </div>');

    -- 1.2 Setting Up a Business Manager Account
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod1_id, 'Setting Up a Business Manager Account', 2,
    '<h2>Definition</h2>
    <p><strong>Meta Business Manager</strong> (now Meta Business Suite) is the central hub for managing all your Facebook Pages, Instagram accounts, Ad Accounts, and team member permissions in one secure place.</p>

    <h2>Why It Matters</h2>
    <p>Running ads from your personal account is risky and unprofessional. Business Manager creates a safety layer, protecting your personal profile and allowing you to manage assets for multiple clients or businesses securely.</p>

    <h3>Step-by-Step Walkthrough</h3>
    <ol>
        <li><strong>Go to business.facebook.com:</strong> Log in with your personal Facebook account.</li>
        <li><strong>Create an Account:</strong> Click "Create Account" and enter your business name, your name, and business email.</li>
        <li><strong>Add Your Page:</strong> Go to <em>Business Settings > Accounts > Pages</em> and click "Add".</li>
        <li><strong>Create Ad Account:</strong> Go to <em>Accounts > Ad Accounts</em>. Click "Add" > "Create a new ad account".
            <br><em>ΓÜá∩╕Å Important: choose your Time Zone and Currency (Naira/Dollar) carefully! It cannot be changed later.</em>
        </li>
        <li><strong>Add Payment Method:</strong> Navigate to <em>Billing & Payments</em> to add your card.</li>
    </ol>

    <h3>Practical Exercise</h3>
    <div style="border: 1px dashed #4f46e5; padding: 15px; border-radius: 8px; background-color: #f9faff;">
        <p><strong>Task:</strong> Create your Business Manager account right now. Do not just read this lesson. Go to business.facebook.com and complete the setup.</p>
    </div>

    <h3>Common Mistakes</h3>
    <ul>
        <li>Γ¥î <strong>Using Personal Ad Account:</strong> Always create a dedicated business ad account.</li>
        <li>Γ¥î <strong>Wrong Currency:</strong> Selecting USD when you want to pay in Naira (or vice versa) can cause payment issues with local cards.</li>
    </ul>');

    -- 1.3 Understanding the Facebook Ads Ecosystem
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod1_id, 'Understanding the Facebook Ads Ecosystem', 3,
    '<h2>The Big Picture</H2>
    <p>The Meta Ads Ecosystem is a hierarchy. Understanding this structure is crucial for organization and success.</p>

    <h2>The Hierarchy</h2>
    <div style="display: flex; gap: 20px; flex-wrap: wrap; margin: 20px 0;">
        <div style="flex: 1; padding: 15px; background: #e0e7ff; border-radius: 8px; border: 1px solid #c7d2fe;">
            <h3 style="color: #3730a3; margin-top:0;">1. Business Manager</h3>
            <p>The "House" that keys everything. Holds standard accounts, pages, pixels, and people.</p>
        </div>
        <div style="flex: 1; padding: 15px; background: #dcfce7; border-radius: 8px; border: 1px solid #bbf7d0;">
            <h3 style="color: #166534; margin-top:0;">2. Ad Account</h3>
            <p>The "Wallet". Where billing happens and campaigns live.</p>
        </div>
    </div>
    
    <h3>Campaign Structure Levels</h3>
    <ol>
        <li><strong>Campaign:</strong> The "Why". You choose your <strong>Objective</strong> here (e.g., Sales, Leads).</li>
        <li><strong>Ad Set:</strong> The "Who", "Where", & "How Much". You set <strong>Audience, Placements, Budget, & Schedule</strong> here.</li>
        <li><strong>Ad:</strong> The "What". This is the <strong>Creative</strong> (Image/Video) and <strong>Copy</strong> the user sees.</li>
    </ol>

    <h2>Why It Matters</h2>
    <p>Beginners often mess up by creating a new Campaign for every single ad. The correct way is to have ONE Campaign, with MULTIPLE Ad Sets (for testing audiences), and MULTIPLE Ads inside each Ad Set (for testing creatives).</p>

    <h3>Visual Reference</h3>
    <pre style="background: #1f2937; color: #fff; padding: 15px; border-radius: 8px; overflow-x: auto;">
Campaign (Objective: Sales)
 Γö£ΓöÇΓöÇ Ad Set A (Target: Broad)
 Γöé    Γö£ΓöÇΓöÇ Ad 1 (Video)
 Γöé    ΓööΓöÇΓöÇ Ad 2 (Image)
 ΓööΓöÇΓöÇ Ad Set B (Target: Retargeting)
      Γö£ΓöÇΓöÇ Ad 1 (Video)
      ΓööΓöÇΓöÇ Ad 2 (Image)
    </pre>');

    -- 1.4 Navigating Meta Ads Manager
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod1_id, 'Navigating Meta Ads Manager', 4,
    '<h2>Definition</h2>
    <p><strong>Ads Manager</strong> is the dashboard where you actually build, run, and monitor your campaigns.</p>

    <h2>Interface Tour</h2>
    <p>Let''s break down the main sections you will use daily:</p>

    <h3>1. The Navigation Bar (Left Side)</h3>
    <ul>
        <li><strong>Campaigns Icon:</strong> Main grid view of your ads.</li>
        <li><strong>Audiences:</strong> Where you build Custom and Lookalike audiences.</li>
        <li><strong>Events Manager:</strong> Where you check your Pixel and data sources.</li>
        <li><strong>Billing:</strong> Payment history and settings.</li>
    </ul>

    <h3>2. The Main Workspace (Tabs)</h3>
    <p>You will see three tabs at the top:</p>
    <ul>
        <li><strong>Campaigns Tab:</strong> High, top-level view.</li>
        <li><strong>Ad Sets Tab:</strong> Mid-level targeting view.</li>
        <li><strong>Ads Tab:</strong> Creative level view.</li>
    </ul>

    <h3>3. The Inspector Panel</h3>
    <p>Clicking "Edit" on any campaign opens the side panel (or full screen) where you actually input your settings. This is your cockpit.</p>

    <h3>Practical Exercise</h3>
    <p>Log into Ads Manager. Click through the three tabs (Campaigns, Ad Sets, Ads) to minimize and maximize the levels. Try to find the "Columns" button to see how you can change your data view.</p>');

    -- 1.5 Key Terminology: CPM, CTR, ROAS, Pixel, etc.
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod1_id, 'Key Terminology: CPM, CTR, ROAS, Pixel', 5,
    '<h2>The Language of Ads</h2>
    <p>To master Facebook Ads, you must speak the language. Here are the metric definitions that matter.</p>

    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px; margin-top: 20px;">
        
        <div style="padding: 15px; border: 1px solid #e5e7eb; border-radius: 8px; background: white; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
            <h3 style="color: #2563eb; margin-top: 0;">CPM (Cost Per Mille)</h3>
            <p><strong>Cost per 1,000 Impressions.</strong> Indicates how expensive it is to reach your audience. High CPM = Expensive competition.</p>
        </div>

        <div style="padding: 15px; border: 1px solid #e5e7eb; border-radius: 8px; background: white; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
            <h3 style="color: #2563eb; margin-top: 0;">CTR (Click-Through Rate)</h3>
            <p><strong>Percentage of people who click.</strong> Indicates how "thumb-stopping" your creative is. Average is ~1%. Good is 2%+.</p>
        </div>

        <div style="padding: 15px; border: 1px solid #e5e7eb; border-radius: 8px; background: white; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
            <h3 style="color: #2563eb; margin-top: 0;">CPC (Cost Per Click)</h3>
            <p><strong>Cost for each click.</strong> Lower is usually better, but not if the traffic is low quality. Focus on conversion cost first.</p>
        </div>

        <div style="padding: 15px; border: 1px solid #e5e7eb; border-radius: 8px; background: white; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
            <h3 style="color: #2563eb; margin-top: 0;">ROAS (Return On Ad Spend)</h3>
            <p><strong>Revenue / Ad Spend.</strong> If you spend $100 and make $300, your ROAS is 3.0. The "Holy Grail" metric for e-commerce.</p>
        </div>
        
    </div>

    <h3>Infrastructure Terms</h3>
    <ul>
        <li><strong>Pixel:</strong> A piece of code on your website that tracks user activity (views, carts, purchases) and sends it back to Facebook.</li>
        <li><strong>CAPI (Conversions API):</strong> A server-side backup to the Pixel, crucial for accurate tracking in a privacy-first world (iOS14+).</li>
    </ul>

    <h3>Quiz</h3>
    <p><strong>Q:</strong> If you have a high CTR but 0 Sales, what is likely the problem?</p>
    <p><em>A: Your website or landing page. The ad did its job (got the click), but the page failed to convert.</em></p>');


    -- MODULE 2: Audience & Targeting Mastery -------------------------------------------------------------

    -- 2.1 Types of Audiences: Core, Custom, Lookalike
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod2_id, 'Types of Audiences: Core, Custom, Lookalike', 1,
    '<h2>The Three Pillars of Targeting</h2>
    <p>Facebook offers three distinct ways to find people. Mastering the mix is key to scale.</p>

    <h3>1. Core Audiences (Cold Traffic)</h3>
    <p>Targeting based on native Facebook data.</p>
    <ul>
        <li><strong>Demographics:</strong> Age, Gender, Education, Job Title.</li>
        <li><strong>Location:</strong> Country, City, or "within X miles" of a pin drop.</li>
        <li><strong>Interests:</strong> "Fitness", "Digital Marketing", "Real Estate".</li>
        <li><strong>Behaviors:</strong> "Frequent Shoppers", "International Travelers".</li>
    </ul>

    <h3>2. Custom Audiences (Warm Traffic)</h3>
    <p>Retargeting people who have <em>already</em> interacted with you.</p>
    <ul>
        <li><strong>Website Visitors:</strong> Using Pixel data (e.g., "Add to Cart 30 Days").</li>
        <li><strong>Customer List:</strong> Uploading email/phone numbers of existing clients.</li>
        <li><strong>Engagement:</strong> People who watched your video or liked your IG post.</li>
    </ul>

    <h3>3. Lookalike Audiences (LAL)</h3>
    <p>AI-generated audiences similar to your best customers.</p>
    <p><strong>How it works:</strong> You give Facebook a "Source" (e.g., list of 500 purchasers). Facebook analyzes their 10,000+ data points and finds the top 1% of people in your country who match that profile.</p>

    <h3>Strategic Use</h3>
    <p>Use <strong>Lookalikes</strong> to scale winning offers. Use <strong>Custom Audiences</strong> to close the sale (Retargeting). Use <strong>Core Audiences</strong> when you are brand new and have no data.</p>');

    -- 2.2 Building Buyer Personas
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod2_id, 'Building Buyer Personas', 2,
    '<h2>Definition</h2>
    <p>A <strong>Buyer Persona</strong> is a semi-fictional representation of your ideal customer based on market research and real data.</p>

    <h2>Why It Matters</h2>
    <p>You cannot target "everyone". If you sell luxury watches, targeting "18-65+, All Genders" is burning money. You need to know exactly who wants your product.</p>

    <h3>The Persona Components</h3>
    <div style="background: #ffffff; padding: 20px; border-radius: 8px; border: 1px solid #e5e7eb;">
        <p><strong>Name:</strong> "Corporate Chris"</p>
        <p><strong>Demographics:</strong> Male, 30-45, Lives in Lagos/Abuja, Income Γéª500k+/month.</p>
        <p><strong>Pain Points:</strong> Looks unprofessional in meetings. Wants status. Wants durability.</p>
        <p><strong>Interests:</strong> Forbes, Mercedes Benz, Investment Banking, Golf.</p>
        <p><strong>Objections:</strong> "Is it authentic?" "Will it last?"</p>
    </div>

    <h3>Practical Exercise</h3>
    <p>Write down one persona for your business right now. Answer these three questions:</p>
    <ol>
        <li>What keeps them up at night? (Pain)</li>
        <li>What is their dream outcome? (Desire)</li>
        <li>What brands do they currently follow? (Targeting Interest ideas)</li>
    </ol>');

    -- 2.3 Geo, Demographic & Behavioral Targeting
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod2_id, 'Geo, Demographic & Behavioral Targeting', 3,
    '<h2>Going Deeper into Core Audiences</h2>
    
    <h3>Geographic Targeting (Geo)</h3>
    <p>You can target by Country, State, City, or Zip Code. </p>
    <p><strong>Pro Tip:</strong> You can also <em>Exclude</em> locations. e.g., Target "Nigeria" but Exclude "Borno" if you cannot deliver there.</p>
    <p><strong>Pin Drop:</strong> For local businesses (restaurants, salons), drop a pin on your street and target "1 mile radius".</p>

    <h3>Demographics</h3>
    <p>Age and Gender are standard. But look for "Life Events":</p>
    <ul>
        <li>Newly Engaged (Great for wedding photographers)</li>
        <li>New Parents (Great for baby products)</li>
        <li>Birthday in [Current Month] (Great for restaurants/gifts)</li>
    </ul>

    <h3>Behaviors (The Hidden Gem)</h3>
    <p>Behaviors track what users <em>do</em>, not just what they like.</p>
    <ul>
        <li><strong>Digital Activities:</strong> "Facebook Payments Users" (Likely to buy online).</li>
        <li><strong>Travel:</strong> "Frequent International Travelers" (High net worth signal).</li>
        <li><strong>Mobile Device User:</strong> "iPhone X or newer" (PROXY for disposable income).</li>
    </ul>

    <h3>Common Mistake</h3>
    <p><strong>Over-layering.</strong> Do not select "Parents" AND "Golf" AND "iPhone Users" AND "Lagos". This makes your audience too small (Tiny audience = High CPM). Keep it relatively broad and let the AI find the buyers within the bucket.</p>');

    -- 2.4 Retargeting Strategies
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod2_id, 'Retargeting Strategies', 4,
    '<h2>Definition</h2>
    <p><strong>Retargeting</strong> is showing ads to people who have already engaged with your business but didn''t buy yet. "The money is in the retargeting."</p>

    <h2>Why It Matters</h2>
    <p>Studies show over 96% of visitors leave a website without buying on their first visit. Retargeting brings them back.</p>

    <h3>The Classic Retargeting Stack</h3>
    <ol>
        <li><strong>The Introducer (Top of Funnel):</strong> Video Ad to Cold Audience.</li>
        <li><strong>The Reminder (Middle/Bottom of Funnel):</strong> Image Ad showing the product to anyone who watched 50% of the video.</li>
        <li><strong>The Closer (Bottom of Funnel):</strong> "10% Off" Coupon Ad shown ONLY to people who "Added to Cart" but did not Purchase in the last 7 days.</li>
    </ol>

    <h3>How to Set It Up</h3>
    <ol>
        <li>Go to <strong>Audiences</strong>.</li>
        <li>Create <strong>Custom Audience</strong> > Website.</li>
        <li>Select event "AddToCart".</li>
        <li>Retention: "30 Days".</li>
        <li>Name it "ATC 30 Days".</li>
        <li>Create a new Ad Set and put this audience in the "Custom Audiences" box.</li>
    </ol>

    <h3>Mockup Suggestion</h3>
    <div style="background: #fdf2f8; padding: 15px; border-radius: 8px; font-style: italic;">
        "Hey! We noticed you left something behind. ≡ƒæÇ<br>
        Your [Product Name] is saved in your cart.<br>
        Grab it now before stock runs out!<br>
        [Link]"
    </div>');

    -- 2.5 Audience Layering for Precision
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod2_id, 'Audience Layering for Precision', 5,
    '<h2>The Logic of Layering</h2>
    <p>Layering allows you to combine constraints to find a highly specific avatar. It uses "AND" logic vs "OR" logic.</p>

    <h3>Include (OR Logic)</h3>
    <p>If you select "Golf" and "Tennis", Facebook targets people who like Golf <strong>OR</strong> Tennis. The audience gets <strong>BIGGER</strong>.</p>

    <h3>Narrow Further (AND Logic)</h3>
    <p>If you click "Narrow Audience", you are telling Facebook: They must like Golf <strong>AND</strong> also be "Frequent Travelers". The audience gets <strong>SMALLER</strong> and more precise.</p>

    <h3>Step-by-Step Instructions</h3>
    <ol>
        <li>Select your first interest (e.g., "Real Estate").</li>
        <li><strong>Do NOT</strong> just add "Luxury Goods" directly below it (that makes it OR).</li>
        <li>Click the button <strong>"Narrow Audience"</strong> (or "Define Further").</li>
        <li>Add "Luxury Goods" in the new box.</li>
        <li>Facebook now looks for the intersection of the two circles.</li>
    </ol>

    <h3>When to Use This</h3>
    <p>Use layering when a broad interest is too vague. <br>
    <em>Example:</em> "Physical Fitness" is huge. <br>
    <em>Layered:</em> "Physical Fitness" <strong>AND</strong> "Protein Supplement" interest implies a more serious gym-goer.</p>

    <h3>Warning</h3>
    <p>Avoid "Audience Fragmentation". If your estimated audience size drops below 100k (for a national campaign) or 50k (for local), you might be too specific. Trust the algorithmΓÇöit works better with some breathing room.</p>');

    RAISE NOTICE 'Modules 1 & 2 Content Populated.';
-- Rebuild Facebook Ads Mastery - Part 3: Modules 3 & 4 Content


    -- MODULE 3: Campaign Strategy & Objectives -----------------------------------------------------------

    -- 3.1 Choosing the Right Campaign Objective
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod3_id, 'Choosing the Right Campaign Objective', 1,
    '<h2>The First Critical Decision</h2>
    <p>When you hit "Create", Facebook asks "What''s your campaign objective?" This is the most critical technical setting.</p>

    <h2>The 6 Objectives (ODAX)</h2>
    <p>Meta simplified objectives into 6 categories (ODAX - Outcome-Driven Ad Experiences):</p>
    
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
        <div style="background: #eff6ff; padding: 10px; border-radius: 6px;">
            <strong>1. Awareness:</strong> Show to people most likely to remember your brand (Reach).
        </div>
        <div style="background: #eff6ff; padding: 10px; border-radius: 6px;">
            <strong>2. Traffic:</strong> Send people to a destination (Website, Link Clicks). *Warning: "Clickers" are not always "Buyers".*
        </div>
        <div style="background: #eff6ff; padding: 10px; border-radius: 6px;">
            <strong>3. Engagement:</strong> Get Page Likes, Video Views, or Comments.
        </div>
        <div style="background: #dcfce7; padding: 10px; border-radius: 6px;">
            <strong>4. Leads:</strong> Collect forms or calls. Good for service businesses.
        </div>
        <div style="background: #dcfce7; padding: 10px; border-radius: 6px;">
            <strong>5. App Promotion:</strong> Get installs for your app.
        </div>
        <div style="background: #fef08a; padding: 10px; border-radius: 6px;">
            <strong>6. Sales:</strong> Find people likely to purchase. (The Gold Standard for E-com).
        </div>
    </div>

    <h3>Why It Matters</h3>
    <p><strong>The algorithm gives you exactly what you ask for.</strong> If you choose "Traffic", Facebook finds people who click links but never buy. If you choose "Sales", it finds expensive users who actually pull out credit cards.</p>

    <h3>Golden Rule</h3>
    <p>If you want Sales, choose <strong>Sales</strong>. Do not "warm up" with Traffic ads hoping they switch to buyers later. It rarely works efficiently.</p>');

    -- 3.2 Awareness vs. Consideration vs. Conversion
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod3_id, 'Awareness vs. Consideration vs. Conversion', 2,
    '<h2>The Marketing Funnel</h2>
    <p>Your strategy should map to where the customer is in their journey.</p>
    
    <h3>1. Awareness (Top of Funnel - TOFU)</h3>
    <p><strong>Goal:</strong> Stop the scroll. Introduce the problem.</p>
    <p><strong>Ad Type:</strong> Short viral videos, educational content, influencer skits.</p>
    <p><strong>KPIs:</strong> Reach, CPM, Video Thru-Plays.</p>

    <h3>2. Consideration (Middle of Funnel - MOFU)</h3>
    <p><strong>Goal:</strong> Build trust and desire.</p>
    <p><strong>Ad Type:</strong> Testimonials, deep-dive demos, "How it works" carousels.</p>
    <p><strong>KPIs:</strong> Click-Through Rate (CTR), Landing Page Views.</p>

    <h3>3. Conversion (Bottom of Funnel - BOFU)</h3>
    <p><strong>Goal:</strong> Get the money.</p>
    <p><strong>Ad Type:</strong> Discount offers, "Low Stock" warnings, direct product shots.</p>
    <p><strong>KPIs:</strong> Cost Per Purchase (CPP/CPA), ROAS.</p>

    <h3>Common Mistake</h3>
    <p>Trying to marry on the first date. Don''t show a "Buy Now" ad to a cold audience for a $500 product without building value first (unless it''s an impulse buy).</p>');

    -- 3.3 Funnel Mapping with Facebook Ads
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod3_id, 'Funnel Mapping with Facebook Ads', 3,
    '<h2>Building a System, Not Just an Ad</h2>
    <p>A funnel is a connected series of ads that guides a stranger to becoming a customer.</p>

    <h3>The 3-Step E-Commerce Funnel</h3>
    <div style="background: #ffffff; padding: 20px; border: 1px solid #e5e7eb; border-radius: 8px;">
        <h4 style="margin-top:0;">Step 1: The Hook (Broad Targeting)</h4>
        <p>Run a video ad demonstrating the product. Optimize for "Sales".</p>
        <p><em>Excludes:</em> Buyers (Last 180 Days).</p>
        <hr>
        <h4>Step 2: The Retargeting (Warm Audience)</h4>
        <p>Target: People who viewed video 50% OR visited website.</p>
        <p>Show: A compilation of customer testimonials.</p>
        <hr>
        <h4>Step 3: The Offer (Hot Audience)</h4>
        <p>Target: Added to Cart (7 Days).</p>
        <p>Show: "10% Off Code: WELCOME10".</p>
    </div>

    <h3>Practical Exercise</h3>
    <p>Draw your funnel on a piece of paper. What acts as your "Intro"? What acts as your "Closer"?</p>');

    -- 3.4 Budgeting: Daily vs. Lifetime
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod3_id, 'Budgeting: Daily vs. Lifetime', 4,
    '<h2>How Meta Spends Your Money</h2>
    
    <h3>Daily Budget (Recommended for Beginners)</h3>
    <p><strong>Definition:</strong> "Spend exactly Γéª5,000 every single day."</p>
    <p><strong>Pros:</strong> Consistent, easier to control, good for evergreen campaigns.</p>
    <p><strong>Cons:</strong> Facebook might force spend even on a "bad day".</p>

    <h3>Lifetime Budget</h3>
    <p><strong>Definition:</strong> "Spend Γéª50,000 between Jan 1st and Jan 31st."</p>
    <p><strong>Pros:</strong> Allows "Dayparting" (e.g., Run ads only 9am-5pm). Facebook spends more on days with better opportunities.</p>
    <p><strong>Cons:</strong> Harder to scale. If you add money, it recalculates the pace.</p>

    <h3>The "20% Rule" for Scaling</h3>
    <p>If a Daily Budget campaign is working, do not double the budget overnight. It resets the learning phase. Increase it by <strong>20% every 2-3 days</strong> to maintain stability.</p>');

    -- 3.5 Bidding Strategies & Optimization
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod3_id, 'Bidding Strategies & Optimization', 5,
    '<h2>Controlling the Costs</h2>
    <p>Facebook is an auction. You are bidding against competitors for the user''s attention.</p>

    <h3>1. Lowest Cost (Auto-Bid) - Default</h3>
    <p><strong>Logic:</strong> "Get me the most results for my budget."</p>
    <p><strong>Use When:</strong> 99% of the time. Let the AI handle the math.</p>

    <h3>2. Cost Cap</h3>
    <p><strong>Logic:</strong> "Get me results, but do NOT pay more than Γéª2,000 per purchase."</p>
    <p><strong>Risk:</strong> If your cap is too low, Facebook will simply stop spending. Your ad won''t deliver.</p>

    <h3>3. Bid Cap</h3>
    <p><strong>Logic:</strong> "Do not bid more than X in the auction."</p>
    <p><strong>Use When:</strong> You are an advanced media buyer engaging in manual bidding wars.</p>
    
    <h3>Optimization Events</h3>
    <p>Always utilize "Optimize for Conversions" if you want sales. Optimizing for "Link Clicks" will get you cheap clicks from bots or accidental clickers, not buyers.</p>');


    -- MODULE 4: Creative That Converts -------------------------------------------------------------------

    -- 4.1 Ad Formats: Image, Video, Carousel, Collection
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod4_id, 'Ad Formats: Image, Video, Carousel, Collection', 1,
    '<h2>The Creative is the New Targeting</h2>
    <p>In 2026, the algorithm is so smart that your "Creative" (the ad itself) does 80% of the targeting work. Good creative finds good buyers.</p>

    <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px;">
        <div style="border: 1px solid #ddd; padding: 15px; border-radius: 8px;">
            <h3>Single Image</h3>
            <p><strong>Best for:</strong> Clean, simple product shots. Flash sales. Offers.</p>
        </div>
        <div style="border: 1px solid #ddd; padding: 15px; border-radius: 8px;">
            <h3>Single Video (Reels/Stories)</h3>
            <p><strong>Best for:</strong> Demonstrations, storytelling, UGC (User Generated Content).</p>
        </div>
        <div style="border: 1px solid #ddd; padding: 15px; border-radius: 8px;">
            <h3>Carousel</h3>
            <p><strong>Best for:</strong> Showing multiple products, telling a sequential story, or handling objections card-by-card.</p>
        </div>
        <div style="border: 1px solid #ddd; padding: 15px; border-radius: 8px;">
            <h3>Collection</h3>
            <p><strong>Best for:</strong> Mobile shopping. Opens an Instant Experience page.</p>
        </div>
    </div>

    <h3>Pro Tip: Format Ratios</h3>
    <ul>
        <li><strong>Feed:</strong> 1:1 (Square) or 4:5 (Vertical)</li>
        <li><strong>Stories/Reels:</strong> 9:16 (Full Screen Vertical) - <em>Critical in 2026!</em></li>
        <li><strong>Right Column:</strong> 16:9 (Landscape)</li>
    </ul>');

    -- 4.2 Writing High-Converting Ad Copy
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod4_id, 'Writing High-Converting Ad Copy', 2,
    '<h2>The Art of Persuasion</h2>
    <p>Good copy doesn''t just describe the product; it sells the transformation.</p>

    <h3>Formula: AIDA</h3>
    <div style="background: #fff; padding: 20px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); border-radius: 8px;">
        <p><strong>Attention:</strong> Hook the reader immediately. <br><em>"Tired of back pain ruining your sleep?"</em></p>
        <p><strong>Interest:</strong> Agitate the problem/Present solution. <br><em>"Traditional mattresses curve your spine..."</em></p>
        <p><strong>Desire:</strong> Value proposition/Benefits. <br><em>"Our Ortho-Cloud tech aligns your back instantly..."</em></p>
        <p><strong>Action:</strong> Clear instruction. <br><em>"Click Shop Now for 50% Off."</em></p>
    </div>

    <h3>Long Copy vs. Short Copy</h3>
    <ul>
        <li><strong>Short:</strong> Impulse buys, cheap products, clear visuals.</li>
        <li><strong>Long:</strong> Expensive items, complicated services, coaching.</li>
    </ul>

    <h3>The "Primary Text" vs. "Headline"</h3>
    <p>The <strong>Headine</strong> (bold text near button) is the most read part. Make it punchy. "50% Off Ends Tonight".</p>');

    -- 4.3 Visual Psychology & Design Principles
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod4_id, 'Visual Psychology & Design Principles', 3,
    '<h2>Stopping the Scroll</h2>
    <p>The human brain processes images 60,000x faster than text. Your image must do the heavy lifting.</p>

    <h3>Design Principles for Ads</h3>
    <ol>
        <li><strong>Contrast:</strong> Use colors that pop against the Facebook Blue/White background. (Orange, Red, Green).</li>
        <li><strong>Pattern Interrupt:</strong> Do something unexpected. Upside-down images, weird angles, bold text overlays.</li>
        <li><strong>Faces:</strong> Humans are wired to look at eyes. Use real people showing emotion.</li>
        <li><strong>Text Overlay:</strong> Keep it under 20% of the image. Use it to highlight the "Hook".</li>
    </ol>

    <h3>The "Ugly Ad" Paradox</h3>
    <p>Sometimes, overly polished "Corporate" ads perform worse than raw, iPhone-shot photos. Why? Because they look like <em>content</em>, not ads. Native content builds trust.</p>');

    -- 4.4 A/B Testing Creatives
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod4_id, 'A/B Testing Creatives', 4,
    '<h2>Testing is the Secret Sauce</h2>
    <p>You never know what will work until you test it.</p>

    <h3>How to structure a Creative Test</h3>
    <p><strong>The Campaign:</strong> "Creative Sandbox"</p>
    <p><strong>The Ad Set:</strong> Broad Audience.</p>
    <p><strong>The Ads:</strong> 3-5 distinct variations.</p>
    <ul>
        <li>Ad A: Video (UGC testimonial)</li>
        <li>Ad B: Image (Product only)</li>
        <li>Ad C: Carousel (Benefits)</li>
    </ul>

    <h3>The Rule</h3>
    <p>Run them for 48-72 hours. Turn off the losers (High Cost per Purchase). Take the winner and move it to your "Scaling" campaign.</p>

    <h3>Common Mistake</h3>
    <p>Testing too many things at once. If you change the Headline <em>and</em> the Image <em>and</em> the Audience... you don''t know what caused the improvement.</p>');

    -- 4.5 Using Dynamic Creative Optimization
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod4_id, 'Using Dynamic Creative Optimization', 5,
    '<h2>Let the Machine Decide</h2>
    <p>Dynamic Creative Optimization (DCO) allows you to throw multiple ingredients into a bucket and let Facebook serve the best combo to each user.</p>

    <h3>How DCO Works</h3>
    <p>You upload:</p>
    <ul>
        <li>5 Images</li>
        <li>3 Headlines</li>
        <li>3 Primary Texts</li>
        <li>1 Call to Action</li>
    </ul>
    <p>Facebook mixes and matches them. It might show User A "Image 1 + Headline 2" and User B "Image 3 + Headline 1", depending on what they are most likely to click.</p>

    <h3>Benefits</h3>
    <ul>
        <li><strong>Speed:</strong> Tests 15 combinations instantly.</li>
        <li><strong>Fatigue:</strong> Keeps ads fresh longer.</li>
        <li><strong>Personalization:</strong> Adapts to user preferences.</li>
    </ul>

    <h3>Warning</h3>
    <p>Ensure ALL text options make sense with ALL image options. Don''t reference "the red shirt in the photo" if the photo might dynamically switch to a blue shirt.</p>');

    RAISE NOTICE 'Modules 3 & 4 Content Populated.';
-- Rebuild Facebook Ads Mastery - Part 4: Modules 5 & 6 Content


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
-- Rebuild Facebook Ads Mastery - Part 5: Modules 7 & 8 Content


    -- MODULE 7: Advanced Tactics & Automation -----------------------------------------------------------

    -- 7.1 Automated Rules & Scheduling
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod7_id, 'Automated Rules & Scheduling', 1,
    '<h2>Sleep More, Stress Less</h2>
    <p>Facebook can manage your ads while you sleep. Automated rules are logical instructions you give to the engine.</p>

    <h3>Top 3 Rules to Setup</h3>

    <h4>1. The "Stop Loss" (Safety Net)</h4>
    <div style="background: #fee2e2; padding: 15px; border-radius: 8px; border: 1px solid #fecaca;">
        <p><strong>IF</strong> Spend > 2x Target CPA <strong>AND</strong> Purchases < 1</p>
        <p><strong>THEN:</strong> Turn off Ad</p>
        <p><strong>Why:</strong> Prevents a bad ad from draining your wallet overnight.</p>
    </div>

    <h4>2. The "Winner Watch" (Notification)</h4>
    <div style="background: #dcfce7; padding: 15px; border-radius: 8px; border: 1px solid #bbf7d0;">
        <p><strong>IF</strong> ROAS > 4.0 <strong>AND</strong> Spend > $50</p>
        <p><strong>THEN:</strong> Send Email Notification</p>
        <p><strong>Why:</strong> Tells you immediately when you have a hit so you can scale manualy.</p>
    </div>

    <h4>3. The "Reviver" (Frequency Check)</h4>
    <div style="background: #e0f2fe; padding: 15px; border-radius: 8px; border: 1px solid #bae6fd;">
        <p><strong>IF</strong> Frequency > 2.5 <strong>AND</strong> CTR < 1%</p>
        <p><strong>THEN:</strong> Decrease Budget by 20%</p>
        <p><strong>Why:</strong> Prevents ad fatigue automatically.</p>
    </div>

    <h3>How to Set Up</h3>
    <p>In Ads Manager, click the "Rules" button (Process icon) > "Create New Rule".</p>');

    -- 7.2 Advanced Bidding: Cost Caps & Bid Caps
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod7_id, 'Advanced Bidding: Cost Caps & Bid Caps', 2,
    '<h2>Beyond Auto-Bidding</h2>
    <p>Most advertisers use "Lowest Cost". But "Cost Caps" give you sniper-like control.</p>

    <h3>Cost Cap Strategy</h3>
    <p>You tell Facebook: <em>"I want as many sales as possible, but ONLY if they cost $15 average."</em></p>
    <ul>
        <li><strong>Pros:</strong> Guaranteed profitability. If Facebook can''t find cheap buyers, it just won''t spend your money.</li>
        <li><strong>Cons:</strong> Scale issues. It''s hard to spend large budgets with strict caps.</li>
    </ul>

    <h3>The "Bully" Strategy (Bid Cap)</h3>
    <p>Set a Bid Cap 5x higher than your competitors (e.g., $100 bid for a $20 product). <br>
    <em>Why?</em> You win the highest quality traffic first. You don''t pay $100; you pay just enough to beat the second bidder.</p>
    <p><strong>Warning:</strong> Only for advanced media buyers with proven offers.</p>');

    -- 7.3 Retargeting with Catalogs & Dynamic Ads
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod7_id, 'Retargeting with Catalogs & Dynamic Ads', 3,
    '<h2>DPA: Dynamic Product Ads</h2>
    <p>Ever look at a pair of shoes, leave the site, and then see those EXACT shoes stalking you on Instagram? That is a DPA.</p>

    <h3>Why They Work</h3>
    <ul>
        <li><strong>Relevance:</strong> Users see arguably the most relevant ad possible (the thing they just looked at).</li>
        <li><strong>Automation:</strong> You create one template, and it works for 1,000 products automatically.</li>
    </ul>

    <h3>Setup Steps</h3>
    <ol>
        <li><strong>Commerce Manager:</strong> specific Create a "Catalog" and sync it with Shopify/WooCommerce.</li>
        <li><strong>Campaign:</strong> Choose "Sales" Objective > "Catalog Sales".</li>
        <li><strong>Ad Set:</strong> Select "Retarget ads to people who interacted with your products on and off Facebook".</li>
        <li><strong>Option:</strong> "Viewed or Added to Cart but not Purchased (14 Days)".</li>
    </ol>

    <h3>Visual Aid</h3>
    <p>The ad template uses tags like <code>{{product.name}}</code> and <code>{{product.price}}</code> to dynamically fill in the info.</p>');

    -- 7.4 Using UTM Parameters for Deep Analytics
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod7_id, 'Using UTM Parameters for Deep Analytics', 4,
    '<h2>Trusting Google Analytics</h2>
    <p>Facebook''s data is biased (it claims all credit). You need a second opinion. UTMs let you see Facebook traffic inside Google Analytics.</p>

    <h3>The URL Builder</h3>
    <p>Instead of linking to <code>mysite.com</code>, you link to: <br>
    <code>mysite.com?utm_source=facebook&utm_medium=cpc&utm_campaign=summer_sale&utm_content=video_01</code></p>

    <h3>Meta''s Dynamic Parameters</h3>
    <p>You don''t have to type this manually. In the Ad Level "Tracking" section, click "Build a URL Parameter".</p>
    <p>Use dynamic values: <code>utm_campaign={{campaign.name}}</code>. Facebook will auto-fill the name.</p>

    <h3>Why It Matters</h3>
    <p>If Facebook says "10 Sales" but Google Analytics says "2 Sales", you have a tracking problem. UTMs are the source of truth for "Click-based" attribution.</p>');

    -- 7.5 Integrating Facebook Ads with Email Funnels
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod7_id, 'Integrating Facebook Ads with Email Funnels', 5,
    '<h2> The "Profit Sandwich"</h2>
    <p>Ads bring them in. Email closes the deal. They work better together.</p>

    <h3>Strategy 1: The Lead Magnet</h3>
    <ul>
        <li><strong>Ad:</strong> "Get our Free Guide". (Objective: Leads).</li>
        <li><strong>Email:</strong> Delivers guide + 5-day Welcome Series selling the product.</li>
        <li><strong>Result:</strong> You build an asset (Email List) you own forever.</li>
    </ul>

    <h3>Strategy 2: The "Sync"</h3>
    <p>Upload your Email List to Facebook as a Custom Audience.</p>
    <ul>
        <li><strong>Exclude:</strong> People who already subscribed (so they don''t see the "Subscribe" ad again).</li>
        <li><strong>Target:</strong> People who opened emails but didn''t buy (Show them a special "VIP Discount" ad).</li>
    </ul>

    <h3>The Logic</h3>
    <p>Email is "Free" traffic. Ads are "Paid" traffic. Use paid traffic to feed the free channel.</p>');


    -- MODULE 8: Compliance, Ethics & Troubleshooting -----------------------------------------------------

    -- 8.1 Facebook Ad Policies & Common Violations
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod8_id, 'Facebook Ad Policies & Common Violations', 1,
    '<h2>Don''t Get Banned!</h2>
    <p>Meta uses AI to review ads. It is strict and often bans first, asks questions later.</p>

    <h3>The Big 4 Violations</h3>
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
        <div style="background: #fef2f2; padding: 10px; border: 1px solid #fecaca; border-radius: 6px;">
            <h4 style="color: #991b1b; margin-top:0;">1. Personal Attributes</h4>
            <p><strong>Bad:</strong> "Are you fat?"</p>
            <p><strong>Good:</strong> "Weight loss tips for busy dads."</p>
            <p>Never imply you know the user''s race, disability, or medical status.</p>
        </div>
        <div style="background: #fef2f2; padding: 10px; border: 1px solid #fecaca; border-radius: 6px;">
            <h4 style="color: #991b1b; margin-top:0;">2. Making Unrealistic Claims</h4>
            <p><strong>Bad:</strong> "Make $10,000 in 2 days!"</p>
            <p><strong>Good:</strong> "How I built a profitable side hustle."</p>
            <p>No "Before/After" photos showing extreme weight loss.</p>
        </div>
        <div style="background: #fef2f2; padding: 10px; border: 1px solid #fecaca; border-radius: 6px;">
            <h4 style="color: #991b1b; margin-top:0;">3. Non-Functional Landing Page</h4>
            <p>Your site must match the ad. No broken links. No PDF direct downloads. No "Under Construction".</p>
        </div>
        <div style="background: #fef2f2; padding: 10px; border: 1px solid #fecaca; border-radius: 6px;">
            <h4 style="color: #991b1b; margin-top:0;">4. Sensational Content</h4>
            <p>No shocking, scary, or sexually suggestive images. No excessive use of CAPS or emojis.</p>
        </div>
    </div>');

    -- 8.2 Getting Unbanned & Appeal Process
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod8_id, 'Getting Unbanned & Appeal Process', 2,
    '<h2>The "Account Desalition" Procedure</h2>
    <p>It happens to the best of us.</p>

    <h3>Step 1: Determine the Ban Type</h3>
    <ul>
        <li><strong>Ad Rejected:</strong> Fix the creative and re-submit.</li>
        <li><strong>Ad Account Disabled:</strong> You can''t run ads, but Business Manager is fine.</li>
        <li><strong>Business Manager Disabled:</strong> The nuclear option. You are locked out.</li>
    </ul>

    <h3>Step 2: The Appeal</h3>
    <p>Go to <strong>Account Quality</strong> (business.facebook.com/accountquality).</p>
    <p>Click "Request Review".</p>
    
    <h3>Writing the Appeal</h3>
    <p>Do NOT be angry. Be professional and apologetic (even if you are right).</p>
    <div style="background: #f3f4f6; padding: 15px; border-radius: 8px; font-family: monospace;">
        "Hello Meta Support team,<br><br>
        I noticed my ad account was disabled. I have reviewed the policies and believe this may be a mistake by the automation. My business sells [Product] and we strictly adhere to advertising guidelines.<br><br>
        If I made a specific error, please clarify so I can fix it immediately. I value the platform and want to remain compliant.<br><br>
        Thank you."
    </div>');

    -- 8.3 Ethical Advertising Practices
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod8_id, 'Ethical Advertising Practices', 3,
    '<h2>Marketing with Integrity</h2>
    <p>Just because you <em>can</em> trick someone into clicking, doesn''t mean you <em>should</em>.</p>

    <h3>Dark Patterns to Avoid</h3>
    <ul>
        <li><strong>Fake Urgency:</strong> "Sale ends in 5 minutes!" (But it resets every time). This destroys trust.</li>
        <li><strong>Hidden Costs:</strong> Advertising "Free + Shipping" but shipping is $20.</li>
        <li><strong>Clickbait:</strong> "You won''t believe what happened!" (And nothing happened).</li>
    </ul>

    <h3>The Long Game</h3>
    <p>Ethical ads build brand equity. Deceptive ads might get a sale today but guarantee 0 repeat customers. Building a sustainable business requires trust.</p>');

    -- 8.4 Troubleshooting Disapproved Ads
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod8_id, 'Troubleshooting Disapproved Ads', 4,
    '<h2>Reading the Rejection Code</h2>
    <p>When an ad is rejected, Facebook usually gives a vague reason: "Circumventing Systems" or "Unacceptable Business Practices".</p>

    <h3>Common Triggers & Fixes</h3>
    
    <h4>Trigger: "Personal Attributes"</h4>
    <p><strong>Fix:</strong> Change "Do YOU struggle with acne?" to "Acne can be a struggle." Shift focus from the user to the problem.</p>

    <h4>Trigger: "Adult Content"</h4>
    <p><strong>Fix:</strong> Less exposed skin. Sometimes zooming out the image helps because the AI thinks a close-up of a shoulder is nudity.</p>

    <h4>Trigger: "Text in Image"</h4>
    <p><strong>Fix:</strong> Reduce text size. While the "20% Rule" is officially gone, text-heavy images still get penalized with lower reach.</p>');

    -- 8.5 Navigating iOS14+ Privacy Changes
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod8_id, 'Navigating iOS14+ Privacy Changes', 5,
    '<h2>The New Normal</h2>
    <p>Since Apple introduced App Tracking Transparency (ATT), we must assume we are losing data.</p>

    <h3>Aggregated Event Measurement (AEM)</h3>
    <p>You must verify your Domain in Business Manager. Then, you must configure your "Top 8 Events" in priority order.</p>

    <h3>How to Adapt</h3>
    <ol>
        <li><strong> broader Targeting:</strong> Small audiences don''t work as well anymore. Go broad and let the machine learn.</li>
        <li><strong>First-Party Data:</strong> Collect emails and phone numbers aggressively. You own that data; Apple can''t block it.</li>
        <li><strong>Server-Side Tracking (CAPI):</strong> Implement CAPI to capture data that browser pixels miss.</li>
    </ol>');

    RAISE NOTICE 'Modules 7 & 8 Content Populated.';

    -- MODULE 9: Real-World Case Studies & Campaign Builds ------------------------------------------------

    -- 9.1 E-commerce Funnel Build
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod9_id, 'E-commerce Funnel Build (Walkthrough)', 1,
    '<h2>The Fashion Brand Strategy</h2>
    <p>Watch as we build a campaign for a hypothetical unisex sneaker brand, "Kicks Lagos".</p>

    <h3>Phase 1: Testing (ABO)</h3>
    <p><strong>Budget:</strong> $50/day.<br>
    <strong>Structure:</strong> 1 Campaign (Sales) > 5 Ad Sets (Interests: Sneakers, Nike, Streetwear, Hypebeast, Broad).<br>
    <strong>Creative:</strong> 3 Videos, 2 Images.<br>
    <strong>Goal:</strong> Find the winning Interest and Creative.</p>

    <h3>Phase 2: Scaling (CBO)</h3>
    <p><strong>Action:</strong> Found that "Streetwear" interest + "Video B" was the winner ($12 CPA).</p>
    <p><strong>Move:</strong> Created new CBO Campaign. Put "Streetwear" Ad Set inside. Budget $200/day.</p>

    <h3>Key Takeaway</h3>
    <p>Do not scale unproven ads. Test small, then bet big on the winner.</p>');

    -- 9.2 Local Business Lead Gen Campaign
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod9_id, 'Local Business Lead Gen Campaign', 2,
    '<h2>The Dentist Strategy</h2>
    <p>Service businesses need LEADS (Phone numbers), not "Add to Carts".</p>

    <h3>The "Lead Form" Advantage</h3>
    <p>We use Facebook''s "Instant Forms" so the user never leaves the app. It auto-fills their Name/Number.</p>

    <h3>The Offer</h3>
    <div style="background: #fdf2f8; padding: 15px; border-radius: 8px; border: 1px dashed #db2777;">
        <p><strong>Headline:</strong> Free Teeth Cleaning* (First 20 People Only)</p>
        <p><strong>Creative:</strong> Photo of the friendly Dentist + Clean Office.</p>
        <p><strong>Targeting:</strong> "Pin Drop" 5-mile radius around the clinic.</p>
    </div>

    <h3>The Follow-Up</h3>
    <p>Speed to Lead is everything. If you don''t call the lead within 15 minutes, the close rate drops by 80%.</p>');

    -- 9.3 Digital Product Launch Strategy
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod9_id, 'Digital Product Launch Strategy', 3,
    '<h2>Selling Knowledge (Course/Ebook)</h2>
    <p>Digital products require high trust.</p>

    <h3>The Webinar Funnel</h3>
    <ol>
        <li><strong>Ad:</strong> "Free Masterclass: How to [Benefit] without [Pain]".</li>
        <li><strong>Landing Page:</strong> Registration for the webinar.</li>
        <li><strong>Thank You Page:</strong> "Join our WhatsApp Group".</li>
        <li><strong>Email Sequence:</strong> Reminders to show up.</li>
        <li><strong>Webinar:</strong> Deliver value for 45 mins, Pitch for 15 mins.</li>
        <li><strong>Retargeting Ads:</strong> "Replay Available" + "Doors Closing Soon".</li>
    </ol>');

    -- 9.4 Agency Client Campaign Audit
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod9_id, 'Agency Client Campaign Audit', 4,
    '<h2>How to "Fix" a Broken Account</h2>
    <p>So you landed a client, but their ads suck. Here is your audit checklist.</p>

    <h3>The "Red Flag" Checklist</h3>
    <ul>
        <li><strong>[ ] Structure:</strong> Are there 50 campaigns running? (Consolidate them!).</li>
        <li><strong>[ ] Creative:</strong> Are they using the same image for 6 months? (Ad Fatigue).</li>
        <li><strong>[ ] Audience:</strong> Are they targeting "Everyone"? or overlapping audiences?</li>
        <li><strong>[ ] Pixel:</strong> Is the pixel actually firing?</li>
    </ul>

    <h3>The "Quick Win"</h3>
    <p>Usually, simply turning off the losing ads and consolidating the budget into the top 2-3 ads will improve results by 30% overnight.</p>');

    -- 9.5 Building a Portfolio for Freelance Work
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod9_id, 'Building a Portfolio for Freelance Work', 5,
    '<h2>"But I have no experience..."</h2>
    <p>You can''t get clients without results. You can''t get results without clients. Here is the hack.</p>

    <h3>The "Free Trial" Method</h3>
    <p>Offer a business owner: "I will manage your ads for FREE for 14 days. You pay the ad spend (e.g., $200). If I get you profit, you hire me for $500/month."</p>

    <h3>The "Mockup" Portfolio</h3>
    <p>Create spec work. "Here is how I WOULD run ads for Nike." Design the creative, write the copy, screenshot it. Put it in a PDF. It shows you know your stuff even if you haven''t run it yet.</p>');


    -- MODULE 10: Career & Certification Path -------------------------------------------------------------

    -- 10.1 Becoming a Facebook Ads Specialist
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod10_id, 'Becoming a Facebook Ads Specialist', 1,
    '<h2>The Career Ladder</h2>
    <p>Media Buying is a high-income skill. The market pays for RESULTS, not degrees.</p>

    <h3>Levels</h3>
    <ul>
        <li><strong>Junior Buyer:</strong> Execution. You press the buttons. ($500 - $1,500/mo).</li>
        <li><strong>Strategist:</strong> Planning. You design the funnels and offers. ($2,000 - $5,000/mo).</li>
        <li><strong>CMO (Chief Marketing Officer):</strong> Leadership. You manage the team and budget. ($10k+/mo).</li>
    </ul>');

    -- 10.2 Freelancing vs. Agency vs. In-House
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod10_id, 'Freelancing vs. Agency vs. In-House', 2,
    '<h2>Choose Your Character</h2>

    <h3>1. Freelancing (The Lone Wolf)</h3>
    <p><strong>Pros:</strong> Freedom, keep 100% of profit, choose clients.</p>
    <p><strong>Cons:</strong> You have to do sales, accounting, and work. Unstable income.</p>

    <h3>2. Agency (The Soldier)</h3>
    <p><strong>Pros:</strong> Learn FAST. Use other people''s money. Networking.</p>
    <p><strong>Cons:</strong> High stress. Burnout. Lower pay than freelancing initially.</p>

    <h3>3. In-House (The Employee)</h3>
    <p><strong>Pros:</strong> Stable salary. Focus on ONE brand deeply.</p>
    <p><strong>Cons:</strong> Capped income. Boring eventually?</p>');

    -- 10.3 Meta Blueprint Certification Prep
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod10_id, 'Meta Blueprint Certification Prep', 3,
    '<h2>Is it worth it?</h2>
    <p><strong>Meta Blueprint</strong> is the official certification.</p>

    <h3>The Verdict</h3>
    <p>Clients usually don''t care. Agencies DO care. If you want a job, get it. If you want freelance clients, your case studies matter more.</p>

    <h3>Top Certifications</h3>
    <ul>
        <li><strong>410-101:</strong> Media Buying Professional (The Standard).</li>
        <li><strong>400-101:</strong> Media Planning Professional.</li>
    </ul>
    <p>It costs money to take the exam. Study hard!</p>');

    -- 10.4 Building Your Personal Brand
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod10_id, 'Building Your Personal Brand', 4,
    '<h2>Don''t be a Secret Agent</h2>
    <p>If people don''t know you exist, they can''t hire you.</p>

    <h3>The Content Strategy</h3>
    <p>Post "How-To" content on LinkedIn and Twitter/X.</p>
    <p><em>Example:</em> "I spent $5,000 on ads this week. Here are the 3 things I learned about the new Algorithm."</p>

    <h3>The "Authority" Effect</h3>
    <p>When you share knowledge, you stop chasing clients. Clients start chasing you.</p>');

    -- 10.5 Landing Clients & Pricing Your Services
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod10_id, 'Landing Clients & Pricing Your Services', 5,
    '<h2>Show Me The Money</h2>
    
    <h3>Pricing Models</h3>
    <ul>
        <li><strong>Retainer:</strong> Flat fee (e.g., $1,000/month). Best for stability.</li>
        <li><strong>% of Ad Spend:</strong> 15% of whatever they spend. Best for big clients ($50k+ spend).</li>
        <li><strong>Performance:</strong> Small base + % of Revenue generated. High risk, High reward.</li>
    </ul>

    <h3>The Pitch</h3>
    <p>Don''t sell "Facebook Ads". Sell "Customers".</p>
    <p><strong>Bad:</strong> "I will set up your campaigns and pixel."</p>
    <p><strong>Good:</strong> "I help dentists get 20 new patients a month using paid traffic."</p>');

    RAISE NOTICE 'Modules 9 & 10 Content Populated.';
    -- Simulator Integration
    -- Update Lesson 1 to include the Simulator logic
    -- We want the simulator to be accessible from Lesson 1 (or a dedicated lesson).
    -- Strategy: Add a NEW lesson at position 0 called "Interactive Simulator"
    
    INSERT INTO lessons (module_id, title, ordering, content, playground) VALUES (
        v_mod1_id, 
        '≡ƒÄ« Meta Ads Manager Simulator', 
        0, -- Very top of Module 1
        '<h2>Practice Before You Pay</h2>
        <p>Welcome to the <strong>Meta Ads Manager Simulator</strong>. This interactive tool allows you to practice creating campaigns, ad sets, and ads in a risk-free environment.</p>

        <h3>What can you do here?</h3>
        <ul>
            <li><strong>Create Campaigns:</strong> Choose objectives like Sales or Leads.</li>
            <li><strong>Target Audiences:</strong> Select interests and demographics.</li>
            <li><strong>Set Budgets:</strong> See how budget changes affect estimated reach.</li>
            <li><strong>Select Creative:</strong> Pick images/videos and write copy.</li>
        </ul>

        <h3>How to use</h3>
        <p>Click the "Launch Simulator" button below. Follow the guided prompts to build your first campaign. The AI coach will give you feedback on your choices!</p>
        
        <div style="background: linear-gradient(135deg, #1877f2 0%, #0056b3 100%); padding: 30px; border-radius: 12px; margin-top: 20px; text-align: center; color: white;">
            <h2 style="color: white; margin-top: 0;">Ready to Launch?</h2>
            <p>Step into the driver''s seat.</p>
        </div>',
        jsonb_build_object(
            'type', 'meta-ads-simulator',
            'url', '/meta-ads-simulator.html',
            'objective', 'Practice creating Facebook ad campaigns in a risk-free environment'
        )
    );

    RAISE NOTICE 'Simulator added to Module 1.';

    -- Re-order lessons in Module 1 sequentially so there are no gaps or duplicates
    -- (This handles shifting the "What is Facebook Ads" lesson down to pos 1 if it was 0, or just cleaning up)
    -- Actually, we inserted at 0. Existing lessons were 1, 2, 3... so we are good.
    -- But let's be safe and ensure ordering is clean.
    
    -- No complex reorder needed if we used 0 and others started at 1.

END $$;

