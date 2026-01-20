-- Add Meta Ads Simulator to the basic "Facebook Ads" course

DO $$
DECLARE
    v_fb_ads_id UUID := '123e4567-e89b-12d3-a456-426614174002'; -- Facebook Ads (basic)
    v_module_id UUID;
BEGIN
    -- Find the first module or create a practice module
    SELECT id INTO v_module_id
    FROM modules
    WHERE course_id = v_fb_ads_id
    ORDER BY ordering
    LIMIT 1;

    IF v_module_id IS NULL THEN
        RAISE EXCEPTION 'No modules found in Facebook Ads course';
    END IF;

    -- Insert the simulator lesson
    INSERT INTO lessons (module_id, title, description, content, ordering, playground)
    VALUES (
        v_module_id,
        'Meta Ads Manager Practice Simulator',
        'Practice creating Facebook ad campaigns in a risk-free environment',
        '<h2>Meta Ads Manager - Practice Simulator</h2>

<p>Welcome to the <strong>Meta Ads Manager Practice Simulator</strong>! This is where you put your knowledge into practice without spending real money.</p>

<h3>What You''ll Practice</h3>
<p>In this interactive simulator, you''ll create complete Facebook ad campaigns from scratch:</p>
<ul>
    <li>Choose campaign objectives</li>
    <li>Build target audiences</li>
    <li>Set budgets and schedules</li>
    <li>Design ad creatives</li>
    <li>Review simulated performance metrics</li>
    <li>Get recommendations for improvement</li>
</ul>

<h3>Practice Scenarios</h3>

<h4>Scenario 1: E-commerce Product Launch</h4>
<ul>
    <li><strong>Objective:</strong> Sales</li>
    <li><strong>Audience:</strong> Women 25-45 in Lagos interested in fashion</li>
    <li><strong>Budget:</strong> ₦5,000/day for 7 days</li>
    <li><strong>Goal:</strong> Maximize purchases</li>
</ul>

<h4>Scenario 2: Local Service Business</h4>
<ul>
    <li><strong>Objective:</strong> Leads</li>
    <li><strong>Audience:</strong> People within 10km of your location</li>
    <li><strong>Budget:</strong> ₦3,000/day for 14 days</li>
    <li><strong>Goal:</strong> Collect phone numbers</li>
</ul>

<h4>Scenario 3: Brand Awareness</h4>
<ul>
    <li><strong>Objective:</strong> Awareness</li>
    <li><strong>Audience:</strong> Broad audience in Nigeria aged 18-35</li>
    <li><strong>Budget:</strong> ₦10,000/day for 30 days</li>
    <li><strong>Goal:</strong> Maximize reach</li>
</ul>

<h3>Tips for Success</h3>
<ul>
    <li>Take notes on what works and what doesn''t</li>
    <li>Try different approaches and compare results</li>
    <li>Pay attention to the recommendations</li>
    <li>Experiment with different audience sizes and budgets</li>
    <li>Study the simulated metrics to understand good performance</li>
</ul>

<h3>After the Simulator</h3>
<p>Once you''ve practiced with the simulator, you''ll be ready to create real campaigns in the actual Meta Ads Manager with confidence!</p>',
        1, -- Put it as the first lesson
        jsonb_build_object(
            'type', 'meta-ads-simulator',
            'url', '/meta-ads-simulator.html',
            'embedded', true,
            'objective', 'Practice creating Facebook ad campaigns without spending money'
        )
    )
    ON CONFLICT (module_id, ordering) 
    DO UPDATE SET
        title = EXCLUDED.title,
        description = EXCLUDED.description,
        content = EXCLUDED.content,
        playground = EXCLUDED.playground,
        updated_at = NOW();

    -- Shift other lessons down by 1
    UPDATE lessons
    SET ordering = ordering + 1
    WHERE module_id = v_module_id
    AND ordering >= 1
    AND id != (SELECT id FROM lessons WHERE module_id = v_module_id AND ordering = 1 LIMIT 1);

    RAISE NOTICE '✅ Simulator added to Facebook Ads course!';
END $$;

-- Verify all three courses now have simulators
SELECT 
    c.title as course,
    m.title as module,
    l.title as lesson,
    l.playground->>'url' as simulator_url,
    l.playground->>'embedded' as embedded
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title ILIKE '%Facebook%'
AND l.playground IS NOT NULL
ORDER BY c.title;
