-- Integrate Meta Ads Manager Simulator into Facebook Ads course
-- Adds the simulator as a special "playground" lesson in Module 4

DO $$
DECLARE
    v_course_id UUID := 'b2c3d4e5-f6a7-8901-bcde-f01234567891'; -- Facebook Ads: Building Profitable...
    v_module_id UUID;
    v_lesson_id UUID;
    v_simulator_content TEXT;
BEGIN
    -- Find Module 4 or create it if it doesn't exist
    SELECT id INTO v_module_id
    FROM modules
    WHERE course_id = v_course_id
    AND (title ILIKE '%Module 4%' OR ordering = 4)
    LIMIT 1;

    IF v_module_id IS NULL THEN
        -- Create Module 4 if it doesn't exist
        INSERT INTO modules (course_id, title, description, ordering)
        VALUES (
            v_course_id,
            'Module 4: Ads Manager Mastery',
            'Master the Facebook Ads Manager interface with hands-on practice',
            4
        )
        RETURNING id INTO v_module_id;
        
        RAISE NOTICE 'Created Module 4';
    END IF;

    -- Create the simulator lesson
    v_simulator_content := '<h2>🎯 Meta Ads Manager - Interactive Simulator</h2>

<p>Welcome to the <strong>Meta Ads Manager Practice Simulator</strong>! This is where theory meets practice.</p>

<h3>What You''ll Do</h3>
<p>In this interactive simulator, you''ll create a complete Facebook ad campaign from scratch - without spending a single naira. You''ll:</p>
<ul>
    <li>Choose your campaign objective</li>
    <li>Build your target audience</li>
    <li>Set your budget and schedule</li>
    <li>Design your ad creative</li>
    <li>Review and "launch" your campaign</li>
    <li>See simulated performance metrics</li>
    <li>Get AI-powered feedback on your choices</li>
</ul>

<h3>Why This Matters</h3>
<p>The Meta Ads Manager interface can be overwhelming for beginners. This simulator lets you:</p>
<ul>
    <li>✅ Practice without risk (no real money spent)</li>
    <li>✅ Build muscle memory for the real interface</li>
    <li>✅ Learn from mistakes in a safe environment</li>
    <li>✅ Get instant feedback on your decisions</li>
</ul>

<h3>🚀 Launch the Simulator</h3>
<div class="playground-box" style="background: linear-gradient(135deg, #1877f2 0%, #42b72a 100%); padding: 30px; border-radius: 12px; margin: 20px 0; text-align: center;">
    <h2 style="color: white; margin-bottom: 16px;">Ready to Practice?</h2>
    <p style="color: white; margin-bottom: 24px;">Open the simulator in a new tab for the full experience</p>
    <a href="/meta-ads-simulator.html" target="_blank" style="display: inline-block; background: white; color: #1877f2; padding: 16px 32px; border-radius: 8px; text-decoration: none; font-weight: 700; font-size: 18px;">
        🎮 Launch Simulator
    </a>
</div>

<h3>Practice Scenarios</h3>
<p>Try these scenarios to build your skills:</p>

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
    <li>📝 Take notes on what works and what doesn''t</li>
    <li>🔄 Try different approaches and compare results</li>
    <li>🎯 Pay attention to the AI feedback - it''s based on real best practices</li>
    <li>💡 Experiment with different audience sizes and budgets</li>
    <li>📊 Study the simulated metrics to understand what good performance looks like</li>
</ul>

<h3>After the Simulator</h3>
<p>Once you''ve practiced with the simulator, you''ll be ready to create real campaigns in the actual Meta Ads Manager with confidence!</p>';

    -- Insert or update the simulator lesson
    INSERT INTO lessons (module_id, title, description, content, ordering, playground)
    VALUES (
        v_module_id,
        '🎮 Interactive Ads Manager Practice',
        'Practice creating Facebook ad campaigns in a risk-free simulator',
        v_simulator_content,
        1, -- Put it first in the module
        jsonb_build_object(
            'type', 'meta-ads-simulator',
            'url', '/meta-ads-simulator.html',
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

    RAISE NOTICE '✅ Meta Ads Manager Simulator integrated into course!';
END $$;

-- Verify integration
SELECT 
    m.title as module_title,
    l.title as lesson_title,
    l.playground IS NOT NULL as has_playground
FROM lessons l
JOIN modules m ON l.module_id = m.id
WHERE m.course_id = 'b2c3d4e5-f6a7-8901-bcde-f01234567891'
AND l.playground IS NOT NULL;
