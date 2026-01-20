-- Clean up wrong lessons and populate Facebook Ads courses properly

DO $$
DECLARE
    v_fb_ads_id UUID := '123e4567-e89b-12d3-a456-426614174002'; -- Facebook Ads
    v_fb_mastery_id UUID := '0987fcde-4321-0987-6543-210987654321'; -- Facebook Ads Mastery
    v_fb_profitable_id UUID := 'b2c3d4e5-f6a7-8901-bcde-f01234567891'; -- Facebook Ads: Building Profitable...
BEGIN
    RAISE NOTICE 'Cleaning up and populating Facebook Ads courses...';

    -- 1. Delete wrong Prompt Engineering lessons from Facebook Ads courses
    DELETE FROM lessons
    WHERE module_id IN (
        SELECT id FROM modules WHERE course_id IN (v_fb_ads_id, v_fb_mastery_id, v_fb_profitable_id)
    )
    AND (
        title ILIKE '%Prompt Engineering%'
        OR title ILIKE '%Understanding AI Models%'
        OR title ILIKE '%Prompt Anatomy%'
        OR title ILIKE '%Your First Prompts%'
    );

    RAISE NOTICE 'Deleted wrong Prompt Engineering lessons';

    -- 2. Populate Facebook Ads Mastery (AI-focused) with content
    -- This course focuses on AI-powered Facebook advertising
    
    -- Get modules for Facebook Ads Mastery and add lessons
    INSERT INTO lessons (module_id, title, description, video_url, content, ordering)
    SELECT 
        m.id,
        'Introduction to AI-First Advertising',
        'Learn how AI is transforming Facebook advertising in 2026',
        'https://www.youtube.com/watch?v=3RkBdJYUL7w',
        '<h2>Introduction to AI-First Advertising</h2>
<p>In 2026, Facebook Ads has evolved into an AI-first platform. Understanding how to leverage AI is no longer optional—it''s essential.</p>
<h3>The AI Revolution in Advertising</h3>
<ul>
    <li><strong>Advantage+</strong> - AI-powered campaign automation</li>
    <li><strong>Generative AI</strong> - Create ads from text prompts</li>
    <li><strong>Predictive Analytics</strong> - AI forecasts campaign performance</li>
    <li><strong>Smart Optimization</strong> - AI adjusts bids and targeting in real-time</li>
</ul>
<h3>Why AI Matters</h3>
<p>AI can process billions of data points per second to:</p>
<ul>
    <li>Find your ideal customers faster</li>
    <li>Optimize your budget automatically</li>
    <li>Create better-performing ads</li>
    <li>Predict and prevent campaign failures</li>
</ul>',
        1
    FROM modules m
    WHERE m.course_id = v_fb_mastery_id
    AND m.ordering = 1
    ON CONFLICT DO NOTHING;

    -- Add more lessons to Facebook Ads Mastery
    INSERT INTO lessons (module_id, title, description, video_url, content, ordering)
    SELECT 
        m.id,
        'Advantage+ Shopping Campaigns',
        'Master Meta''s AI-powered shopping campaigns',
        'https://www.youtube.com/watch?v=8xM4wC7ZBmE',
        '<h2>Advantage+ Shopping Campaigns</h2>
<p>Advantage+ is Meta''s fully automated campaign type that uses AI to handle targeting, creative, and optimization.</p>
<h3>How It Works</h3>
<p>You provide:</p>
<ul>
    <li>Your product catalog</li>
    <li>Budget</li>
    <li>Creative assets (images/videos)</li>
</ul>
<p>AI handles:</p>
<ul>
    <li>Finding the right audience</li>
    <li>Choosing the best placements</li>
    <li>Optimizing bids</li>
    <li>Testing creative combinations</li>
</ul>
<h3>When to Use Advantage+</h3>
<ul>
    <li>✅ E-commerce with product catalogs</li>
    <li>✅ When you want hands-off optimization</li>
    <li>✅ When you have sufficient budget (₦50,000+/month)</li>
    <li>❌ When you need precise audience control</li>
    <li>❌ For lead generation or local businesses</li>
</ul>',
        2
    FROM modules m
    WHERE m.course_id = v_fb_mastery_id
    AND m.ordering = 2
    ON CONFLICT DO NOTHING;

    -- 3. Add more lessons to basic Facebook Ads course
    INSERT INTO lessons (module_id, title, description, video_url, content, ordering)
    SELECT 
        m.id,
        'Facebook Pixel Setup & Tracking',
        'Install and configure the Facebook Pixel for conversion tracking',
        'https://www.youtube.com/watch?v=K53x7gaZJ2E',
        '<h2>Facebook Pixel Setup & Tracking</h2>
<p>The Facebook Pixel is a piece of code that tracks what people do on your website. It''s ESSENTIAL for:</p>
<ul>
    <li>Tracking conversions (purchases, sign-ups, etc.)</li>
    <li>Building retargeting audiences</li>
    <li>Optimizing ad delivery</li>
    <li>Measuring ROI</li>
</ul>
<h3>Installation Steps</h3>
<ol>
    <li>Go to Events Manager in Business Manager</li>
    <li>Click "Connect Data Sources" → "Web"</li>
    <li>Choose "Facebook Pixel" → "Connect"</li>
    <li>Name your Pixel</li>
    <li>Copy the Pixel code</li>
    <li>Paste it in your website''s &lt;head&gt; section</li>
</ol>
<h3>Verification</h3>
<p>Install the <strong>Facebook Pixel Helper</strong> Chrome extension to verify your Pixel is firing correctly.</p>',
        2
    FROM modules m
    WHERE m.course_id = v_fb_ads_id
    AND m.ordering = 1
    ON CONFLICT DO NOTHING;

    INSERT INTO lessons (module_id, title, description, video_url, content, ordering)
    SELECT 
        m.id,
        'Creating Your First Campaign',
        'Step-by-step guide to launching your first Facebook ad campaign',
        'https://www.youtube.com/watch?v=62CDBU7Hl2E',
        '<h2>Creating Your First Campaign</h2>
<p>Let''s create your first Facebook ad campaign step by step.</p>
<h3>Step 1: Choose Your Objective</h3>
<p>Go to Ads Manager → Click "Create" → Choose objective:</p>
<ul>
    <li><strong>Traffic</strong> - Send people to your website (good for beginners)</li>
    <li><strong>Engagement</strong> - Get likes, comments, shares</li>
    <li><strong>Leads</strong> - Collect contact information</li>
    <li><strong>Sales</strong> - Drive purchases (requires Pixel)</li>
</ul>
<h3>Step 2: Set Up Ad Set</h3>
<ul>
    <li><strong>Audience</strong> - Start broad (e.g., "Lagos, Nigeria, Age 25-45")</li>
    <li><strong>Placements</strong> - Use "Advantage+ Placements" (automatic)</li>
    <li><strong>Budget</strong> - Start with ₦2,000-5,000/day</li>
</ul>
<h3>Step 3: Create Your Ad</h3>
<ul>
    <li>Choose your Facebook Page</li>
    <li>Upload image or video (1080x1080px works everywhere)</li>
    <li>Write compelling copy (focus on benefits)</li>
    <li>Add headline and call-to-action</li>
    <li>Enter destination URL</li>
</ul>
<h3>Step 4: Review & Publish</h3>
<p>Double-check everything, then click "Publish". Your ad will go into review (usually 24 hours).</p>',
        3
    FROM modules m
    WHERE m.course_id = v_fb_ads_id
    AND m.ordering = 2
    ON CONFLICT DO NOTHING;

    RAISE NOTICE '✅ All Facebook Ads courses populated!';
END $$;

-- Verify the fix
SELECT 
    c.title,
    COUNT(DISTINCT m.id) as modules,
    COUNT(DISTINCT l.id) as lessons,
    COUNT(DISTINCT CASE WHEN LENGTH(l.content) > 100 THEN l.id END) as lessons_with_content
FROM courses c
LEFT JOIN modules m ON m.course_id = c.id
LEFT JOIN lessons l ON l.module_id = m.id
WHERE c.title ILIKE '%Facebook%'
GROUP BY c.id, c.title
ORDER BY c.title;
