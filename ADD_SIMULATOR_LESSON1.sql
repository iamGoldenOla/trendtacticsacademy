-- Add Meta Ads Manager Simulator to Lesson 1
-- Adds interactive practice section with link to actual Meta Ads Manager

DO $$
DECLARE
    foundation_id UUID;
    mod1_id UUID;
    lesson1_id UUID;
BEGIN
    -- Get IDs
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod1_id FROM modules WHERE course_id = foundation_id AND ordering = 1;
    SELECT id INTO lesson1_id FROM lessons WHERE module_id = mod1_id AND ordering = 1;
    
    RAISE NOTICE 'Adding Meta Ads Manager Simulator to Lesson 1...';
    
    -- Update Lesson 1 content to add simulator section
    UPDATE lessons
    SET content = REPLACE(
        content,
        '<div class="ai-playground">
            <h2>🎮 Interactive Practice</h2>
            <p><strong>Try the Meta Ads Manager Simulator:</strong></p>
            <p>Practice creating a campaign, ad set, and ad without spending real money. Experiment with different objectives and targeting options.</p>
            <a href="https://www.facebook.com/business/tools/ads-manager" target="_blank" class="btn-primary">Open Ads Manager</a>
        </div>',
        '<div class="simulator-section" style="background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%); padding: 2rem; border-radius: 12px; margin: 2rem 0;">
            <h2 style="color: white; margin-bottom: 1rem;">🎮 Practice with Meta Ads Manager</h2>
            <p style="color: rgba(255,255,255,0.9); margin-bottom: 1.5rem;">
                Get hands-on experience with the actual Meta Ads Manager interface. This is a safe environment to explore and learn without spending money.
            </p>
            
            <div style="background: white; padding: 1.5rem; border-radius: 8px; margin-bottom: 1rem;">
                <h3 style="color: #1e3a8a; margin-bottom: 0.5rem;">What to Practice:</h3>
                <ul style="color: #374151; margin-left: 1.5rem;">
                    <li>Navigate the Campaign, Ad Set, and Ad tabs</li>
                    <li>Explore different campaign objectives</li>
                    <li>Browse targeting options (demographics, interests, behaviors)</li>
                    <li>Review the metrics dashboard</li>
                    <li>Familiarize yourself with the interface layout</li>
                </ul>
            </div>
            
            <a href="https://www.facebook.com/business/tools/ads-manager" target="_blank" 
               style="display: inline-block; background: white; color: #1e3a8a; padding: 1rem 2rem; border-radius: 8px; text-decoration: none; font-weight: bold; transition: transform 0.2s;">
                🚀 Open Meta Ads Manager →
            </a>
            
            <p style="color: rgba(255,255,255,0.7); font-size: 0.875rem; margin-top: 1rem;">
                💡 Tip: You''ll need a Facebook account. Don''t worry - you won''t spend any money unless you actively create and publish a campaign!
            </p>
        </div>'
    )
    WHERE id = lesson1_id;
    
    RAISE NOTICE 'Meta Ads Manager Simulator added to Lesson 1!';
    
END $$;

-- Verify
SELECT 
    l.title,
    CASE 
        WHEN l.content LIKE '%simulator-section%' THEN 'HAS SIMULATOR'
        ELSE 'NO SIMULATOR'
    END as simulator_status
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation' AND m.ordering = 1 AND l.ordering = 1;
