-- Populate Facebook Ads Mastery lessons with AI-focused content
-- Updates existing empty lessons instead of inserting new ones

DO $$
DECLARE
    v_fb_mastery_id UUID := '0987fcde-4321-0987-6543-210987654321';
    v_lesson RECORD;
BEGIN
    RAISE NOTICE 'Populating Facebook Ads Mastery lessons...';

    -- Update each lesson based on its title
    FOR v_lesson IN 
        SELECT l.id, l.title, m.title as module_title
        FROM lessons l
        JOIN modules m ON l.module_id = m.id
        WHERE m.course_id = v_fb_mastery_id
        ORDER BY m.ordering, l.ordering
    LOOP
        CASE 
            WHEN v_lesson.title ILIKE '%Introduction to AI-First%' THEN
                UPDATE lessons SET content = '<h2>Introduction to AI-First Advertising</h2>
<p>In 2026, Facebook Ads has evolved into an AI-first platform where machine learning handles most optimization decisions.</p>
<h3>The AI Revolution</h3>
<ul>
    <li><strong>Advantage+</strong> - Fully automated campaigns</li>
    <li><strong>Generative AI</strong> - Create ads from text prompts</li>
    <li><strong>Predictive Analytics</strong> - Forecast performance before spending</li>
    <li><strong>Smart Bidding</strong> - AI adjusts bids in real-time</li>
</ul>
<h3>Key Benefits</h3>
<ul>
    <li>Faster results with less manual work</li>
    <li>Better performance through continuous learning</li>
    <li>Access to signals humans can''t process</li>
    <li>Automatic creative testing and optimization</li>
</ul>' WHERE id = v_lesson.id;

            WHEN v_lesson.title ILIKE '%Advantage+%' THEN
                UPDATE lessons SET content = '<h2>Advantage+ Pro & Autonomous Campaigns</h2>
<p>Advantage+ campaigns use AI to automate targeting, placements, and creative optimization.</p>
<h3>How It Works</h3>
<p>You provide: Budget, creative assets, and conversion goal. AI handles everything else.</p>
<h3>Best Practices</h3>
<ul>
    <li>Provide 5-10 creative variations for AI to test</li>
    <li>Set realistic daily budgets (minimum ₦10,000)</li>
    <li>Let it run for 7+ days before judging performance</li>
    <li>Use for e-commerce and lead generation</li>
</ul>
<h3>When to Use</h3>
<ul>
    <li>✅ E-commerce with product catalogs</li>
    <li>✅ Sufficient budget for AI learning</li>
    <li>✅ Multiple creative assets available</li>
    <li>❌ Highly specific audience requirements</li>
</ul>' WHERE id = v_lesson.id;

            WHEN v_lesson.title ILIKE '%Objective-Driven%' THEN
                UPDATE lessons SET content = '<h2>Objective-Driven Workflows</h2>
<p>Modern Facebook Ads campaigns are built around specific business objectives, not just clicks.</p>
<h3>Campaign Objectives in 2026</h3>
<ul>
    <li><strong>Awareness</strong> - Reach maximum people</li>
    <li><strong>Traffic</strong> - Drive website visits</li>
    <li><strong>Engagement</strong> - Increase interactions</li>
    <li><strong>Leads</strong> - Collect contact information</li>
    <li><strong>App Promotion</strong> - Drive app installs</li>
    <li><strong>Sales</strong> - Drive purchases and conversions</li>
</ul>
<h3>Choosing the Right Objective</h3>
<p>Your objective determines how Facebook optimizes your campaign. Choose based on your business goal, not what sounds good.</p>' WHERE id = v_lesson.id;

            WHEN v_lesson.title ILIKE '%Zero-Click%' THEN
                UPDATE lessons SET content = '<h2>Zero-Click Commerce</h2>
<p>Zero-click commerce allows customers to purchase without leaving Facebook/Instagram.</p>
<h3>Features</h3>
<ul>
    <li>In-app checkout on Instagram</li>
    <li>Facebook Shops integration</li>
    <li>WhatsApp Business ordering</li>
    <li>Messenger commerce bots</li>
</ul>
<h3>Benefits</h3>
<ul>
    <li>Higher conversion rates (no website friction)</li>
    <li>Faster checkout process</li>
    <li>Better mobile experience</li>
    <li>Reduced cart abandonment</li>
</ul>' WHERE id = v_lesson.id;

            WHEN v_lesson.title ILIKE '%Metaverse%' OR v_lesson.title ILIKE '%AR%' THEN
                UPDATE lessons SET content = '<h2>Metaverse & AR Placements</h2>
<p>Augmented Reality (AR) and metaverse placements offer immersive advertising experiences.</p>
<h3>AR Ad Formats</h3>
<ul>
    <li><strong>Try-On Ads</strong> - Virtual product trials (makeup, glasses, etc.)</li>
    <li><strong>AR Filters</strong> - Branded Instagram/Facebook filters</li>
    <li><strong>3D Product Views</strong> - Interactive product exploration</li>
</ul>
<h3>Use Cases</h3>
<ul>
    <li>Fashion and beauty brands</li>
    <li>Furniture and home decor</li>
    <li>Automotive (virtual test drives)</li>
    <li>Gaming and entertainment</li>
</ul>' WHERE id = v_lesson.id;

            WHEN v_lesson.title ILIKE '%Text-to-Video%' OR v_lesson.title ILIKE '%Generative%' THEN
                UPDATE lessons SET content = '<h2>Text-to-Video Ad Generation</h2>
<p>Meta''s generative AI can create video ads from simple text prompts.</p>
<h3>How It Works</h3>
<ol>
    <li>Describe your product/service in text</li>
    <li>AI generates multiple video variations</li>
    <li>Choose the best performers</li>
    <li>AI continues optimizing based on results</li>
</ol>
<h3>Best Practices</h3>
<ul>
    <li>Be specific in your prompts</li>
    <li>Provide brand guidelines (colors, fonts, style)</li>
    <li>Generate multiple variations for testing</li>
    <li>Review AI-generated content before publishing</li>
</ul>
<h3>Benefits</h3>
<ul>
    <li>Create video ads without expensive production</li>
    <li>Test multiple concepts quickly</li>
    <li>Personalize at scale</li>
    <li>Reduce creative costs by 70%+</li>
</ul>' WHERE id = v_lesson.id;

            WHEN v_lesson.title ILIKE '%Predicting Churn%' OR v_lesson.title ILIKE '%Predictive%' THEN
                UPDATE lessons SET content = '<h2>Predicting Churn with AI</h2>
<p>AI can predict which customers are likely to stop buying, allowing you to re-engage them proactively.</p>
<h3>How It Works</h3>
<p>Facebook analyzes customer behavior patterns to identify churn signals:</p>
<ul>
    <li>Decreased engagement with your content</li>
    <li>Longer time between purchases</li>
    <li>Reduced website visits</li>
    <li>Similar users who churned</li>
</ul>
<h3>Retention Campaigns</h3>
<p>Create campaigns targeting at-risk customers with:</p>
<ul>
    <li>Special offers and discounts</li>
    <li>Win-back messaging</li>
    <li>Product recommendations</li>
    <li>Loyalty program reminders</li>
</ul>' WHERE id = v_lesson.id;

            WHEN v_lesson.title ILIKE '%Scaling%' OR v_lesson.title ILIKE '%Optimization%' THEN
                UPDATE lessons SET content = '<h2>Scaling Successful Campaigns</h2>
<p>Once you have a winning campaign, scaling requires strategy to maintain performance.</p>
<h3>Scaling Methods</h3>
<h4>1. Vertical Scaling</h4>
<p>Increase budget on existing campaigns:</p>
<ul>
    <li>Increase by 20% every 3-5 days</li>
    <li>Monitor performance closely</li>
    <li>Expect temporary performance dips</li>
</ul>
<h4>2. Horizontal Scaling</h4>
<p>Duplicate winning campaigns:</p>
<ul>
    <li>Create identical campaigns with fresh learning phases</li>
    <li>Test new audiences</li>
    <li>Expand to new placements</li>
</ul>
<h3>Common Mistakes</h3>
<ul>
    <li>❌ Scaling too fast (causes performance drops)</li>
    <li>❌ Changing multiple variables at once</li>
    <li>❌ Not monitoring daily during scaling</li>
    <li>❌ Ignoring audience saturation signals</li>
</ul>' WHERE id = v_lesson.id;

            ELSE
                -- Generic content for any other lessons
                UPDATE lessons SET content = '<h2>' || v_lesson.title || '</h2>
<p>This lesson covers <strong>' || LOWER(v_lesson.title) || '</strong> as part of ' || v_lesson.module_title || '.</p>
<p>Watch the video for detailed instruction on this AI-powered Facebook Ads topic.</p>' 
                WHERE id = v_lesson.id;
        END CASE;

        RAISE NOTICE 'Updated: %', v_lesson.title;
    END LOOP;

    RAISE NOTICE '✅ Facebook Ads Mastery content populated!';
END $$;

-- Verify
SELECT 
    c.title,
    COUNT(DISTINCT l.id) as lessons,
    COUNT(DISTINCT CASE WHEN LENGTH(l.content) > 100 THEN l.id END) as lessons_with_content
FROM courses c
JOIN modules m ON m.course_id = c.id
JOIN lessons l ON l.module_id = m.id
WHERE c.id = '0987fcde-4321-0987-6543-210987654321'
GROUP BY c.id, c.title;
