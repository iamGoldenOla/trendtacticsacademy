-- Add Meta Ads Manager Simulator to Facebook Ads Mastery
-- This adds the simulator as a dedicated lesson in the course

DO $$
DECLARE
    v_fb_mastery_id UUID := '0987fcde-4321-0987-6543-210987654321';
    v_module_id UUID;
BEGIN
    -- Find the first module or create a new one for the simulator
    SELECT id INTO v_module_id
    FROM modules
    WHERE course_id = v_fb_mastery_id
    ORDER BY ordering
    LIMIT 1;

    IF v_module_id IS NULL THEN
        RAISE EXCEPTION 'No modules found in Facebook Ads Mastery';
    END IF;

    -- Insert the simulator lesson at the beginning
    INSERT INTO lessons (module_id, title, description, content, ordering, playground)
    VALUES (
        v_module_id,
        '🎮 Meta Ads Manager Practice Simulator',
        'Practice creating Facebook ad campaigns in a risk-free environment',
        '<h2>🎯 Meta Ads Manager - Interactive Simulator</h2>

<p>Welcome to the <strong>Meta Ads Manager Practice Simulator</strong>! This is where you put your AI advertising knowledge into practice.</p>

<h3>What You''ll Practice</h3>
<p>In this interactive simulator, you''ll create AI-powered Facebook ad campaigns from scratch:</p>
<ul>
    <li>Choose campaign objectives optimized by AI</li>
    <li>Build audiences using AI recommendations</li>
    <li>Set budgets with AI-powered estimates</li>
    <li>Design creatives with AI assistance</li>
    <li>Review simulated AI-optimized performance</li>
    <li>Get AI-powered campaign analysis</li>
</ul>

<h3>🚀 Launch the Simulator</h3>
<div style="background: linear-gradient(135deg, #1877f2 0%, #42b72a 100%); padding: 30px; border-radius: 12px; margin: 20px 0; text-align: center;">
    <h2 style="color: white; margin-bottom: 16px;">Ready to Practice AI-Powered Ads?</h2>
    <p style="color: white; margin-bottom: 24px;">Open the simulator in a new tab</p>
    <a href="/meta-ads-simulator.html" target="_blank" style="display: inline-block; background: white; color: #1877f2; padding: 16px 32px; border-radius: 8px; text-decoration: none; font-weight: 700; font-size: 18px;">
        🎮 Launch AI Ads Simulator
    </a>
</div>

<h3>AI-Powered Practice Scenarios</h3>

<h4>Scenario 1: Advantage+ Shopping Campaign</h4>
<ul>
    <li><strong>Objective:</strong> Sales (AI-optimized)</li>
    <li><strong>Audience:</strong> Let AI find your customers</li>
    <li><strong>Budget:</strong> ₦50,000/day</li>
    <li><strong>Goal:</strong> Maximize ROAS with AI</li>
</ul>

<h4>Scenario 2: AI-Generated Creative Campaign</h4>
<ul>
    <li><strong>Objective:</strong> Engagement</li>
    <li><strong>Creative:</strong> AI-generated from text prompt</li>
    <li><strong>Budget:</strong> ₦20,000/day</li>
    <li><strong>Goal:</strong> Test AI creative generation</li>
</ul>

<h4>Scenario 3: Predictive Analytics Campaign</h4>
<ul>
    <li><strong>Objective:</strong> Conversions</li>
    <li><strong>Audience:</strong> AI-predicted high-intent users</li>
    <li><strong>Budget:</strong> ₦30,000/day</li>
    <li><strong>Goal:</strong> Leverage AI predictions</li>
</ul>

<h3>Tips for AI-Powered Success</h3>
<ul>
    <li>🤖 Trust the AI recommendations - they''re based on billions of data points</li>
    <li>📊 Study the AI analysis to understand optimization decisions</li>
    <li>🔄 Experiment with different AI features</li>
    <li>💡 Compare AI-automated vs manual approaches</li>
</ul>',
        0, -- Put it first in the module
        jsonb_build_object(
            'type', 'meta-ads-simulator',
            'url', '/meta-ads-simulator.html',
            'objective', 'Practice AI-powered Facebook ad campaigns without spending money'
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
    AND ordering >= 0
    AND id != (SELECT id FROM lessons WHERE module_id = v_module_id AND ordering = 0 LIMIT 1);

    RAISE NOTICE '✅ Simulator added to Facebook Ads Mastery!';
END $$;

-- Verify
SELECT 
    c.title as course,
    m.title as module,
    l.title as lesson,
    l.playground IS NOT NULL as has_simulator
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.id = '0987fcde-4321-0987-6543-210987654321'
AND l.playground IS NOT NULL;
