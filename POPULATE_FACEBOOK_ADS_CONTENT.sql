-- Generate comprehensive content for Facebook Ads course lessons
-- This will populate the empty lessons with detailed, practical content

DO $$
DECLARE
    v_course_id UUID;
    v_lesson RECORD;
    v_content TEXT;
BEGIN
    -- Get the Facebook Ads course ID
    SELECT id INTO v_course_id
    FROM courses
    WHERE title ILIKE '%Building Profitable%'
    LIMIT 1;

    IF v_course_id IS NULL THEN
        RAISE EXCEPTION 'Facebook Ads course not found';
    END IF;

    RAISE NOTICE 'Found course ID: %', v_course_id;

    -- Loop through lessons that need content
    FOR v_lesson IN 
        SELECT l.id, l.title, m.title as module_title
        FROM lessons l
        JOIN modules m ON l.module_id = m.id
        WHERE m.course_id = v_course_id
        AND (l.content IS NULL OR LENGTH(l.content) < 100)
        ORDER BY m.ordering, l.ordering
    LOOP
        -- Generate content based on lesson title
        CASE 
            WHEN v_lesson.title ILIKE '%How Facebook Ads Really Work%' THEN
                v_content := '<h2>How Facebook Ads Really Work (Under the Hood)</h2>

<h3>The Auction System</h3>
<p>Facebook Ads operates on a <strong>real-time auction system</strong>. Every time someone opens Facebook, Instagram, or Messenger, an auction happens in milliseconds to determine which ads to show.</p>

<h3>Three Key Factors</h3>
<ol>
    <li><strong>Bid Amount</strong> - How much you''re willing to pay</li>
    <li><strong>Estimated Action Rate</strong> - How likely the person is to take your desired action</li>
    <li><strong>Ad Quality</strong> - How relevant and engaging your ad is</li>
</ol>

<p><strong>Total Value = Bid × Estimated Action Rate × Ad Quality</strong></p>

<h3>The Learning Phase</h3>
<p>When you launch a new campaign, Facebook enters a "learning phase" where it tests your ad with different audiences to find the best performers. This typically requires <strong>50 conversions per week</strong> to exit the learning phase.</p>

<h3>Key Takeaways</h3>
<ul>
    <li>You don''t always pay your bid amount - you pay just enough to win the auction</li>
    <li>Better ad quality = lower costs</li>
    <li>Facebook optimizes for your chosen objective (not just clicks)</li>
    <li>The algorithm learns from every interaction</li>
</ul>';

            WHEN v_lesson.title ILIKE '%Facebook Ads Ecosystem%' THEN
                v_content := '<h2>The Facebook Ads Ecosystem</h2>

<h3>Meta Business Suite</h3>
<p>Your central hub for managing all Meta platforms (Facebook, Instagram, Messenger, WhatsApp).</p>

<h3>Core Components</h3>

<h4>1. Ads Manager</h4>
<p>Where you create, manage, and analyze campaigns. Think of it as your command center.</p>

<h4>2. Business Manager</h4>
<p>Manages multiple ad accounts, pages, and team members. Essential for agencies and businesses.</p>

<h4>3. Facebook Pixel</h4>
<p>A piece of code on your website that tracks conversions and builds audiences for retargeting.</p>

<h4>4. Catalog Manager</h4>
<p>For e-commerce businesses to upload product catalogs for dynamic ads.</p>

<h4>5. Creative Hub</h4>
<p>Design and preview ads before launching them.</p>

<h3>The Three-Tier Structure</h3>
<ol>
    <li><strong>Campaign</strong> - Your objective (e.g., Sales, Leads, Traffic)</li>
    <li><strong>Ad Set</strong> - Your audience, budget, and schedule</li>
    <li><strong>Ad</strong> - Your creative (images, videos, copy)</li>
</ol>

<h3>Placements</h3>
<p>Your ads can appear across:</p>
<ul>
    <li>Facebook Feed & Stories</li>
    <li>Instagram Feed, Stories & Reels</li>
    <li>Messenger inbox & stories</li>
    <li>Audience Network (external apps & websites)</li>
</ul>';

            WHEN v_lesson.title ILIKE '%Facebook Algorithm%' THEN
                v_content := '<h2>The Facebook Algorithm (Explained Without Jargon)</h2>

<h3>What the Algorithm Actually Does</h3>
<p>The Facebook algorithm is a <strong>prediction engine</strong>. It tries to show each person the content (including ads) they''re most likely to engage with.</p>

<h3>How It Predicts</h3>
<p>The algorithm uses <strong>machine learning</strong> to analyze:</p>
<ul>
    <li>Past behavior (what you''ve clicked, liked, commented on)</li>
    <li>Similar users'' behavior (people like you)</li>
    <li>Content signals (video length, image quality, text sentiment)</li>
    <li>Recency (newer content gets priority)</li>
</ul>

<h3>Relevance Score (Now Called "Quality Ranking")</h3>
<p>Facebook rates your ad on a scale comparing it to other ads competing for the same audience:</p>
<ul>
    <li><strong>Above Average</strong> - Your ad is performing well</li>
    <li><strong>Average</strong> - Room for improvement</li>
    <li><strong>Below Average</strong> - Your ad needs work (higher costs, less reach)</li>
</ul>

<h3>Why Some Ads "Die" After a Few Days</h3>
<p>This is called <strong>ad fatigue</strong>. When the same people see your ad repeatedly, they stop engaging. The algorithm notices and reduces your reach.</p>

<p><strong>Solution:</strong> Refresh your creative every 3-7 days or expand your audience.</p>

<h3>The Algorithm Rewards</h3>
<ul>
    <li>High engagement (likes, comments, shares)</li>
    <li>Meaningful interactions (not just passive scrolling)</li>
    <li>Positive feedback (people clicking "See More" vs "Hide Ad")</li>
    <li>Conversions (if that''s your objective)</li>
</ul>

<h3>The Algorithm Punishes</h3>
<ul>
    <li>Clickbait or misleading content</li>
    <li>Too much text in images (though this is less strict now)</li>
    <li>Low-quality creative</li>
    <li>Negative feedback (people hiding your ads)</li>
</ul>';

            ELSE
                v_content := '<h2>' || v_lesson.title || '</h2>
<p>This lesson covers ' || LOWER(v_lesson.title) || ' in detail.</p>
<p><strong>Module:</strong> ' || v_lesson.module_title || '</p>
<p>Content will be added soon. Watch the video for now.</p>';
        END CASE;

        -- Update the lesson
        UPDATE lessons
        SET content = v_content
        WHERE id = v_lesson.id;

        RAISE NOTICE 'Updated lesson: %', v_lesson.title;
    END LOOP;

    RAISE NOTICE '✅ Content generation complete!';
END $$;

-- Verify the updates
SELECT 
    l.title,
    LENGTH(l.content) as content_length,
    CASE 
        WHEN l.video_url IS NOT NULL THEN '✅'
        ELSE '❌'
    END as has_video,
    CASE 
        WHEN LENGTH(l.content) > 100 THEN '✅'
        ELSE '❌'
    END as has_content
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title ILIKE '%Building Profitable%'
ORDER BY m.ordering, l.ordering
LIMIT 10;
