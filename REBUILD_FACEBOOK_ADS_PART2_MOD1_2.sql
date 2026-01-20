-- Rebuild Facebook Ads Mastery - Part 2: Modules 1 & 2 Content

DO $$
DECLARE
    v_mastery_course_id UUID := '0987fcde-4321-0987-6543-210987654321';
    v_mod1_id UUID;
    v_mod2_id UUID;
BEGIN
    -- Get Module IDs
    SELECT id INTO v_mod1_id FROM modules WHERE course_id = v_mastery_course_id AND ordering = 1;
    SELECT id INTO v_mod2_id FROM modules WHERE course_id = v_mastery_course_id AND ordering = 2;

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
    <p>A local bakery in Lagos doesn''t need to pay for a radio ad heard by the whole city. With Facebook Ads, they can spend ₦5,000 to show their cake photos <em>only</em> to people within 5km who have a birthday coming up next week.</p>

    <h3>Common Mistakes</h3>
    <ul>
        <li>❌ <strong>Boosting Posts vs. Ads Manager:</strong> Relying only on the "Boost Post" button limits your targeting options and optimization capabilities.</li>
        <li>❌ <strong>Ignoring Instagram:</strong> Treating Instagram as a separate silo instead of part of the Meta ecosystem.</li>
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
            <br><em>⚠️ Important: choose your Time Zone and Currency (Naira/Dollar) carefully! It cannot be changed later.</em>
        </li>
        <li><strong>Add Payment Method:</strong> Navigate to <em>Billing & Payments</em> to add your card.</li>
    </ol>

    <h3>Practical Exercise</h3>
    <div style="border: 1px dashed #4f46e5; padding: 15px; border-radius: 8px; background-color: #f9faff;">
        <p><strong>Task:</strong> Create your Business Manager account right now. Do not just read this lesson. Go to business.facebook.com and complete the setup.</p>
    </div>

    <h3>Common Mistakes</h3>
    <ul>
        <li>❌ <strong>Using Personal Ad Account:</strong> Always create a dedicated business ad account.</li>
        <li>❌ <strong>Wrong Currency:</strong> Selecting USD when you want to pay in Naira (or vice versa) can cause payment issues with local cards.</li>
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
 ├── Ad Set A (Target: Broad)
 │    ├── Ad 1 (Video)
 │    └── Ad 2 (Image)
 └── Ad Set B (Target: Retargeting)
      ├── Ad 1 (Video)
      └── Ad 2 (Image)
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
        <p><strong>Demographics:</strong> Male, 30-45, Lives in Lagos/Abuja, Income ₦500k+/month.</p>
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
        "Hey! We noticed you left something behind. 👀<br>
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
    <p>Avoid "Audience Fragmentation". If your estimated audience size drops below 100k (for a national campaign) or 50k (for local), you might be too specific. Trust the algorithm—it works better with some breathing room.</p>');

    RAISE NOTICE 'Modules 1 & 2 Content Populated.';
END $$;
