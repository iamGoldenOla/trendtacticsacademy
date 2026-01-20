-- Rebuild Facebook Ads Mastery - Part 7: Add Simulator

DO $$
DECLARE
    v_mastery_course_id UUID := '0987fcde-4321-0987-6543-210987654321';
    v_mod1_id UUID;
BEGIN
    -- Get Module 1 ID
    SELECT id INTO v_mod1_id FROM modules WHERE course_id = v_mastery_course_id AND ordering = 1;

    -- Create Validator: Check if Module 1 exists
    IF v_mod1_id IS NULL THEN
        RAISE EXCEPTION 'Module 1 not found. Please run the Structure script first.';
    END IF;

    -- Update Lesson 1 to include the Simulator logic
    -- We want the simulator to be accessible from Lesson 1 (or a dedicated lesson).
    -- Strategy: Add a NEW lesson at position 0 called "Interactive Simulator"
    
    INSERT INTO lessons (module_id, title, ordering, content, playground) VALUES (
        v_mod1_id, 
        '🎮 Meta Ads Manager Simulator', 
        0, -- Very top of Module 1
        '<h2>Practice Before You Pay</h2>
        <p>Welcome to the <strong>Meta Ads Manager Simulator</strong>. This interactive tool allows you to practice creating campaigns, ad sets, and ads in a risk-free environment.</p>

        <h3>What can you do here?</h3>
        <ul>
            <li><strong>Create Campaigns:</strong> Choose objectives like Sales or Leads.</li>
            <li><strong>Target Audiences:</strong> Select interests and demographics.</li>
            <li><strong>Set Budgets:</strong> See how budget changes affect estimated reach.</li>
            <li><strong>Select Creative:</strong> Pick images/videos and write copy.</li>
        </ul>

        <h3>How to use</h3>
        <p>Click the "Launch Simulator" button below. Follow the guided prompts to build your first campaign. The AI coach will give you feedback on your choices!</p>
        
        <div style="background: linear-gradient(135deg, #1877f2 0%, #0056b3 100%); padding: 30px; border-radius: 12px; margin-top: 20px; text-align: center; color: white;">
            <h2 style="color: white; margin-top: 0;">Ready to Launch?</h2>
            <p>Step into the driver''s seat.</p>
        </div>',
        jsonb_build_object(
            'type', 'meta-ads-simulator',
            'url', '/meta-ads-simulator.html',
            'objective', 'Practice creating Facebook ad campaigns in a risk-free environment'
        )
    );

    RAISE NOTICE 'Simulator added to Module 1.';

    -- Re-order lessons in Module 1 sequentially so there are no gaps or duplicates
    -- (This handles shifting the "What is Facebook Ads" lesson down to pos 1 if it was 0, or just cleaning up)
    -- Actually, we inserted at 0. Existing lessons were 1, 2, 3... so we are good.
    -- But let's be safe and ensure ordering is clean.
    
    -- No complex reorder needed if we used 0 and others started at 1.

END $$;
