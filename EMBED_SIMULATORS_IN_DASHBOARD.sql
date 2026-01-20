-- Update Facebook Ads Mastery to use the AI-Coached Simulator (FIXED)
-- Changes the simulator URL to the AI coach version and embeds it

-- Step 1: Update Facebook Ads Mastery lesson to use AI Coach
UPDATE lessons
SET 
    content = '<h2>🎯 AI-Powered Campaign Coach</h2>

<p>Welcome to the <strong>AI Campaign Coach</strong>! Unlike traditional simulators, this is an interactive learning experience where an AI coach guides you through every decision.</p>

<h3>What Makes This Special?</h3>
<ul>
    <li>🤖 <strong>Real-time AI coaching</strong> - Get instant feedback on every choice</li>
    <li>📊 <strong>Smart recommendations</strong> - AI scores each option based on billions of data points</li>
    <li>🎮 <strong>Gamified learning</strong> - Unlock achievement badges as you progress</li>
    <li>💡 <strong>Personalized insights</strong> - Budget analysis, creative tips, performance predictions</li>
    <li>🎯 <strong>AI confidence scores</strong> - See how confident the AI is in your campaign</li>
</ul>

<h3>🚀 Start Your AI-Coached Campaign</h3>
<div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 30px; border-radius: 12px; margin: 20px 0; text-align: center;">
    <h2 style="color: white; margin-bottom: 16px;">Ready to Learn from AI?</h2>
    <p style="color: white; margin-bottom: 24px;">The AI coach will guide you through creating a high-performing campaign</p>
</div>

<!-- Embedded Simulator -->
<div style="position: relative; width: 100%; height: 800px; border-radius: 12px; overflow: hidden; box-shadow: 0 8px 32px rgba(0,0,0,0.1); margin: 20px 0;">
    <iframe 
        src="/meta-ads-ai-coach.html" 
        style="width: 100%; height: 100%; border: none;"
        title="AI Campaign Coach Simulator"
    ></iframe>
</div>

<h3>Learning Objectives</h3>
<p>By completing this AI-coached simulation, you''ll learn:</p>
<ul>
    <li>How to choose objectives that AI can optimize effectively</li>
    <li>When to use Advantage+ vs manual targeting</li>
    <li>How to set budgets that allow AI to learn quickly</li>
    <li>What creative elements AI favors for better performance</li>
    <li>How to interpret AI confidence scores and predictions</li>
</ul>

<h3>🎓 Pro Tips</h3>
<ul>
    <li>Pay attention to the AI scores - they''re based on real campaign data</li>
    <li>Try different approaches and compare the AI''s feedback</li>
    <li>The AI coach explains WHY certain choices work better</li>
    <li>Unlock all 4 achievement badges to master AI-powered advertising</li>
</ul>',
    playground = jsonb_build_object(
        'type', 'meta-ads-ai-coach',
        'url', '/meta-ads-ai-coach.html',
        'embedded', true,
        'objective', 'Learn AI-powered Facebook advertising through interactive coaching'
    ),
    updated_at = NOW()
WHERE id = (
    SELECT l.id
    FROM lessons l
    JOIN modules m ON l.module_id = m.id
    JOIN courses c ON m.course_id = c.id
    WHERE c.id = '0987fcde-4321-0987-6543-210987654321' -- Facebook Ads Mastery
    AND l.title ILIKE '%Meta Ads Manager Practice%'
    LIMIT 1
);

-- Step 2: Update other Facebook courses to embed their simulators
UPDATE lessons
SET 
    playground = jsonb_set(
        COALESCE(playground, '{}'::jsonb),
        '{embedded}',
        'true'::jsonb
    ),
    updated_at = NOW()
WHERE playground IS NOT NULL
AND playground->>'url' = '/meta-ads-simulator.html';

-- Verify the updates
SELECT 
    c.title as course,
    l.title as lesson,
    l.playground->>'url' as simulator_url,
    l.playground->>'embedded' as is_embedded,
    l.playground->>'type' as simulator_type
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title ILIKE '%Facebook%'
AND l.playground IS NOT NULL
ORDER BY c.title;
