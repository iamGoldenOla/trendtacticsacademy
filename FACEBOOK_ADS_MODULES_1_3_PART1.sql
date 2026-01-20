-- Facebook Ads Course: Modules 1-3 Content Generation
-- Phase 1: Foundations, Audience & Targeting, Campaign Strategy (15 lessons)

DO $$
DECLARE
    v_course_id UUID := '123e4567-e89b-12d3-a456-426614174002'; -- Facebook Ads
    v_module1_id UUID;
    v_module2_id UUID;
    v_module3_id UUID;
BEGIN
    -- First, delete existing modules and lessons to start fresh
    DELETE FROM lessons WHERE module_id IN (
        SELECT id FROM modules WHERE course_id = v_course_id
    );
    DELETE FROM modules WHERE course_id = v_course_id;

    -- Create Module 1: Foundations of Facebook Advertising
    INSERT INTO modules (course_id, title, description, ordering)
    VALUES (
        v_course_id,
        'Module 1: Foundations of Facebook Advertising',
        'Master the fundamentals of Facebook advertising and set up your advertising foundation',
        1
    ) RETURNING id INTO v_module1_id;

    -- Module 1, Lesson 1: What Are Facebook Ads & Why They Matter
    INSERT INTO lessons (module_id, title, description, video_url, content, ordering)
    VALUES (
        v_module1_id,
        'What Are Facebook Ads & Why They Matter',
        'Understand the power and potential of Facebook advertising for businesses',
        'https://www.youtube.com/watch?v=3RkBdJYUL7w',
        '<h2>What Are Facebook Ads & Why They Matter</h2>

<h3>What Are Facebook Ads?</h3>
<p>Facebook Ads are paid advertisements that appear across Meta''s family of apps and services, including Facebook, Instagram, Messenger, and the Audience Network. They allow businesses to reach specific audiences with targeted messages, products, or services.</p>

<p><strong>Key characteristics:</strong></p>
<ul>
    <li>Highly targeted based on demographics, interests, and behaviors</li>
    <li>Appear in users'' feeds, stories, and sidebars</li>
    <li>Pay-per-click (CPC) or pay-per-impression (CPM) models</li>
    <li>Measurable results with detailed analytics</li>
    <li>Scalable from small budgets to enterprise campaigns</li>
</ul>

<h3>Why Facebook Ads Matter</h3>
<p>Facebook Ads have become essential for modern businesses because:</p>

<ul>
    <li><strong>Massive Reach:</strong> 3+ billion active users across Meta platforms</li>
    <li><strong>Precision Targeting:</strong> Reach exactly who you want, when you want</li>
    <li><strong>Cost-Effective:</strong> Start with as little as ₦1,000/day</li>
    <li><strong>Measurable ROI:</strong> Track every naira spent and result generated</li>
    <li><strong>Level Playing Field:</strong> Small businesses can compete with big brands</li>
</ul>

<h3>Real-World Impact</h3>
<p>Businesses using Facebook Ads report:</p>
<ul>
    <li>30-50% lower customer acquisition costs vs. traditional advertising</li>
    <li>2-5x return on ad spend (ROAS) on average</li>
    <li>Ability to reach customers at every stage of the buying journey</li>
    <li>Faster market testing and product validation</li>
</ul>

<h3>How Facebook Ads Work (Simple Overview)</h3>
<ol>
    <li><strong>Create Campaign:</strong> Choose your objective (sales, leads, awareness)</li>
    <li><strong>Define Audience:</strong> Select who sees your ads</li>
    <li><strong>Set Budget:</strong> Decide how much to spend</li>
    <li><strong>Design Creative:</strong> Create compelling images/videos and copy</li>
    <li><strong>Launch & Monitor:</strong> Track performance and optimize</li>
</ol>

<h3>Practical Exercise</h3>
<div style="background: #e7f3ff; padding: 16px; border-radius: 8px; margin: 16px 0;">
    <strong>Try This:</strong>
    <p>Open Facebook on your phone or computer. Scroll through your feed and identify 5 ads. For each ad, note:</p>
    <ul>
        <li>What product/service is being advertised?</li>
        <li>What makes the ad stand out?</li>
        <li>What action does the ad want you to take?</li>
        <li>Why do you think Facebook showed YOU this specific ad?</li>
    </ul>
    <p>This exercise helps you understand targeting and creative strategy from a user perspective.</p>
</div>

<h3>Common Mistakes</h3>
<ul>
    <li>❌ Starting ads without clear objectives → ✅ Define specific, measurable goals first</li>
    <li>❌ Targeting everyone to maximize reach → ✅ Target specific audiences for better results</li>
    <li>❌ Expecting instant results → ✅ Allow 3-7 days for Facebook''s algorithm to optimize</li>
    <li>❌ Ignoring mobile users → ✅ Design mobile-first (80%+ of users are on mobile)</li>
</ul>

<h3>Knowledge Check</h3>
<div style="background: #f7f8fa; padding: 16px; border-radius: 8px; margin: 16px 0;">
    <strong>Question:</strong> Why is Facebook Ads considered more cost-effective than traditional advertising like TV or radio?
    <p style="margin-top: 8px; font-size: 13px; color: #65676b;">Hint: Think about targeting precision, budget flexibility, and measurability.</p>
</div>',
        1
    );

    -- Module 1, Lesson 2: Setting Up a Business Manager Account
    INSERT INTO lessons (module_id, title, description, video_url, content, ordering)
    VALUES (
        v_module1_id,
        'Setting Up a Business Manager Account',
        'Create and configure your Facebook Business Manager for professional advertising',
        'https://www.youtube.com/watch?v=K53x7gaZJ2E',
        '<h2>Setting Up a Business Manager Account</h2>

<h3>What Is Facebook Business Manager?</h3>
<p>Facebook Business Manager (now called Meta Business Suite) is a centralized platform that lets you manage your Facebook Pages, ad accounts, team members, and assets in one place. It''s essential for running professional Facebook ad campaigns.</p>

<p><strong>Why use Business Manager instead of your personal account?</strong></p>
<ul>
    <li>Separate business and personal activities</li>
    <li>Manage multiple ad accounts and Pages</li>
    <li>Grant access to team members without sharing passwords</li>
    <li>Access advanced advertising features</li>
    <li>Protect your assets if team members leave</li>
</ul>

<h3>Why It Matters</h3>
<p>Proper Business Manager setup is crucial because:</p>
<ul>
    <li>Prevents account bans and restrictions</li>
    <li>Enables collaboration with agencies and freelancers</li>
    <li>Provides better security and control</li>
    <li>Required for advanced features like Custom Audiences</li>
    <li>Allows you to scale your advertising operations</li>
</ul>

<h3>Step-by-Step Setup Guide</h3>

<h4>Step 1: Create Your Business Manager Account</h4>
<ol>
    <li>Go to <strong>business.facebook.com</strong></li>
    <li>Click <strong>"Create Account"</strong></li>
    <li>Enter your business name (use your legal business name)</li>
    <li>Enter your name and business email</li>
    <li>Provide business details (address, phone number)</li>
    <li>Click <strong>"Submit"</strong></li>
</ol>

<h4>Step 2: Add Your Facebook Page</h4>
<ol>
    <li>In Business Manager, go to <strong>Business Settings</strong></li>
    <li>Click <strong>Accounts → Pages</strong></li>
    <li>Click <strong>"Add"</strong></li>
    <li>Choose <strong>"Add a Page"</strong> (if you own it) or <strong>"Request Access"</strong> (if someone else owns it)</li>
    <li>Enter your Page name or URL</li>
    <li>Confirm and save</li>
</ol>

<h4>Step 3: Create an Ad Account</h4>
<ol>
    <li>Go to <strong>Business Settings → Accounts → Ad Accounts</strong></li>
    <li>Click <strong>"Add"</strong></li>
    <li>Select <strong>"Create a new ad account"</strong></li>
    <li>Name your ad account (e.g., "Main Ad Account - Nigeria")</li>
    <li>Select your time zone (Nigeria - WAT)</li>
    <li>Choose your currency (Nigerian Naira - NGN)</li>
    <li>Click <strong>"Next"</strong> and assign yourself as admin</li>
</ol>

<h4>Step 4: Add Payment Method</h4>
<ol>
    <li>Go to <strong>Business Settings → Payments</strong></li>
    <li>Click <strong>"Add Payment Method"</strong></li>
    <li>Choose your payment type (Credit/Debit Card or PayPal)</li>
    <li>Enter payment details</li>
    <li>Set as primary payment method</li>
    <li>Save</li>
</ol>

<h4>Step 5: Verify Your Business (Optional but Recommended)</h4>
<ol>
    <li>Go to <strong>Business Settings → Security Center</strong></li>
    <li>Click <strong>"Start Verification"</strong></li>
    <li>Upload required documents (business registration, utility bill, etc.)</li>
    <li>Wait 1-3 business days for approval</li>
</ol>

<h3>Tool Reference</h3>
<p><strong>Key Locations in Business Manager:</strong></p>
<ul>
    <li><strong>Business Settings:</strong> Top-right gear icon</li>
    <li><strong>Ads Manager:</strong> Left sidebar → "Ads Manager"</li>
    <li><strong>Pages:</strong> Business Settings → Accounts → Pages</li>
    <li><strong>Ad Accounts:</strong> Business Settings → Accounts → Ad Accounts</li>
    <li><strong>People:</strong> Business Settings → Users → People</li>
</ul>

<h3>Practical Exercise</h3>
<div style="background: #e7f3ff; padding: 16px; border-radius: 8px; margin: 16px 0;">
    <strong>Try This:</strong>
    <p>Complete your Business Manager setup checklist:</p>
    <ol>
        <li>Create your Business Manager account</li>
        <li>Add or create a Facebook Page</li>
        <li>Create your first ad account</li>
        <li>Add a payment method</li>
        <li>Invite one team member (or yourself with a different email) to test permissions</li>
    </ol>
    <p><strong>Bonus:</strong> Take screenshots of each completed step for your records.</p>
</div>

<h3>Common Mistakes</h3>
<ul>
    <li>❌ Using personal account for business ads → ✅ Always use Business Manager</li>
    <li>❌ Wrong currency or timezone → ✅ Double-check before creating ad account (can''t change later)</li>
    <li>❌ Sharing login credentials with team → ✅ Use Business Manager permissions instead</li>
    <li>❌ Skipping business verification → ✅ Verify early to avoid spending limits</li>
    <li>❌ Creating multiple Business Managers → ✅ Use one Business Manager with multiple ad accounts</li>
</ul>

<h3>Knowledge Check</h3>
<div style="background: #f7f8fa; padding: 16px; border-radius: 8px; margin: 16px 0;">
    <strong>Question:</strong> Why is it important to choose the correct currency and timezone when creating an ad account?
    <p style="margin-top: 8px; font-size: 13px; color: #65676b;">Hint: Think about what happens to your reporting and billing if these settings are wrong.</p>
</div>',
        2
    );

    RAISE NOTICE 'Module 1 lessons 1-2 created successfully';

    -- Continue with remaining lessons...
    -- (Due to length, I''ll create the complete script in parts)

END $$;
