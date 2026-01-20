-- Rebuild Facebook Ads Mastery - Part 6: Modules 9 & 10 Content

DO $$
DECLARE
    v_mastery_course_id UUID := '0987fcde-4321-0987-6543-210987654321';
    v_mod9_id UUID;
    v_mod10_id UUID;
BEGIN
    -- Get Module IDs
    SELECT id INTO v_mod9_id FROM modules WHERE course_id = v_mastery_course_id AND ordering = 9;
    SELECT id INTO v_mod10_id FROM modules WHERE course_id = v_mastery_course_id AND ordering = 10;

    -- MODULE 9: Real-World Case Studies & Campaign Builds ------------------------------------------------

    -- 9.1 E-commerce Funnel Build
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod9_id, 'E-commerce Funnel Build (Walkthrough)', 1,
    '<h2>The Fashion Brand Strategy</h2>
    <p>Watch as we build a campaign for a hypothetical unisex sneaker brand, "Kicks Lagos".</p>

    <h3>Phase 1: Testing (ABO)</h3>
    <p><strong>Budget:</strong> $50/day.<br>
    <strong>Structure:</strong> 1 Campaign (Sales) > 5 Ad Sets (Interests: Sneakers, Nike, Streetwear, Hypebeast, Broad).<br>
    <strong>Creative:</strong> 3 Videos, 2 Images.<br>
    <strong>Goal:</strong> Find the winning Interest and Creative.</p>

    <h3>Phase 2: Scaling (CBO)</h3>
    <p><strong>Action:</strong> Found that "Streetwear" interest + "Video B" was the winner ($12 CPA).</p>
    <p><strong>Move:</strong> Created new CBO Campaign. Put "Streetwear" Ad Set inside. Budget $200/day.</p>

    <h3>Key Takeaway</h3>
    <p>Do not scale unproven ads. Test small, then bet big on the winner.</p>');

    -- 9.2 Local Business Lead Gen Campaign
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod9_id, 'Local Business Lead Gen Campaign', 2,
    '<h2>The Dentist Strategy</h2>
    <p>Service businesses need LEADS (Phone numbers), not "Add to Carts".</p>

    <h3>The "Lead Form" Advantage</h3>
    <p>We use Facebook''s "Instant Forms" so the user never leaves the app. It auto-fills their Name/Number.</p>

    <h3>The Offer</h3>
    <div style="background: #fdf2f8; padding: 15px; border-radius: 8px; border: 1px dashed #db2777;">
        <p><strong>Headline:</strong> Free Teeth Cleaning* (First 20 People Only)</p>
        <p><strong>Creative:</strong> Photo of the friendly Dentist + Clean Office.</p>
        <p><strong>Targeting:</strong> "Pin Drop" 5-mile radius around the clinic.</p>
    </div>

    <h3>The Follow-Up</h3>
    <p>Speed to Lead is everything. If you don''t call the lead within 15 minutes, the close rate drops by 80%.</p>');

    -- 9.3 Digital Product Launch Strategy
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod9_id, 'Digital Product Launch Strategy', 3,
    '<h2>Selling Knowledge (Course/Ebook)</h2>
    <p>Digital products require high trust.</p>

    <h3>The Webinar Funnel</h3>
    <ol>
        <li><strong>Ad:</strong> "Free Masterclass: How to [Benefit] without [Pain]".</li>
        <li><strong>Landing Page:</strong> Registration for the webinar.</li>
        <li><strong>Thank You Page:</strong> "Join our WhatsApp Group".</li>
        <li><strong>Email Sequence:</strong> Reminders to show up.</li>
        <li><strong>Webinar:</strong> Deliver value for 45 mins, Pitch for 15 mins.</li>
        <li><strong>Retargeting Ads:</strong> "Replay Available" + "Doors Closing Soon".</li>
    </ol>');

    -- 9.4 Agency Client Campaign Audit
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod9_id, 'Agency Client Campaign Audit', 4,
    '<h2>How to "Fix" a Broken Account</h2>
    <p>So you landed a client, but their ads suck. Here is your audit checklist.</p>

    <h3>The "Red Flag" Checklist</h3>
    <ul>
        <li><strong>[ ] Structure:</strong> Are there 50 campaigns running? (Consolidate them!).</li>
        <li><strong>[ ] Creative:</strong> Are they using the same image for 6 months? (Ad Fatigue).</li>
        <li><strong>[ ] Audience:</strong> Are they targeting "Everyone"? or overlapping audiences?</li>
        <li><strong>[ ] Pixel:</strong> Is the pixel actually firing?</li>
    </ul>

    <h3>The "Quick Win"</h3>
    <p>Usually, simply turning off the losing ads and consolidating the budget into the top 2-3 ads will improve results by 30% overnight.</p>');

    -- 9.5 Building a Portfolio for Freelance Work
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod9_id, 'Building a Portfolio for Freelance Work', 5,
    '<h2>"But I have no experience..."</h2>
    <p>You can''t get clients without results. You can''t get results without clients. Here is the hack.</p>

    <h3>The "Free Trial" Method</h3>
    <p>Offer a business owner: "I will manage your ads for FREE for 14 days. You pay the ad spend (e.g., $200). If I get you profit, you hire me for $500/month."</p>

    <h3>The "Mockup" Portfolio</h3>
    <p>Create spec work. "Here is how I WOULD run ads for Nike." Design the creative, write the copy, screenshot it. Put it in a PDF. It shows you know your stuff even if you haven''t run it yet.</p>');


    -- MODULE 10: Career & Certification Path -------------------------------------------------------------

    -- 10.1 Becoming a Facebook Ads Specialist
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod10_id, 'Becoming a Facebook Ads Specialist', 1,
    '<h2>The Career Ladder</h2>
    <p>Media Buying is a high-income skill. The market pays for RESULTS, not degrees.</p>

    <h3>Levels</h3>
    <ul>
        <li><strong>Junior Buyer:</strong> Execution. You press the buttons. ($500 - $1,500/mo).</li>
        <li><strong>Strategist:</strong> Planning. You design the funnels and offers. ($2,000 - $5,000/mo).</li>
        <li><strong>CMO (Chief Marketing Officer):</strong> Leadership. You manage the team and budget. ($10k+/mo).</li>
    </ul>');

    -- 10.2 Freelancing vs. Agency vs. In-House
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod10_id, 'Freelancing vs. Agency vs. In-House', 2,
    '<h2>Choose Your Character</h2>

    <h3>1. Freelancing (The Lone Wolf)</h3>
    <p><strong>Pros:</strong> Freedom, keep 100% of profit, choose clients.</p>
    <p><strong>Cons:</strong> You have to do sales, accounting, and work. Unstable income.</p>

    <h3>2. Agency (The Soldier)</h3>
    <p><strong>Pros:</strong> Learn FAST. Use other people''s money. Networking.</p>
    <p><strong>Cons:</strong> High stress. Burnout. Lower pay than freelancing initially.</p>

    <h3>3. In-House (The Employee)</h3>
    <p><strong>Pros:</strong> Stable salary. Focus on ONE brand deeply.</p>
    <p><strong>Cons:</strong> Capped income. Boring eventually?</p>');

    -- 10.3 Meta Blueprint Certification Prep
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod10_id, 'Meta Blueprint Certification Prep', 3,
    '<h2>Is it worth it?</h2>
    <p><strong>Meta Blueprint</strong> is the official certification.</p>

    <h3>The Verdict</h3>
    <p>Clients usually don''t care. Agencies DO care. If you want a job, get it. If you want freelance clients, your case studies matter more.</p>

    <h3>Top Certifications</h3>
    <ul>
        <li><strong>410-101:</strong> Media Buying Professional (The Standard).</li>
        <li><strong>400-101:</strong> Media Planning Professional.</li>
    </ul>
    <p>It costs money to take the exam. Study hard!</p>');

    -- 10.4 Building Your Personal Brand
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod10_id, 'Building Your Personal Brand', 4,
    '<h2>Don''t be a Secret Agent</h2>
    <p>If people don''t know you exist, they can''t hire you.</p>

    <h3>The Content Strategy</h3>
    <p>Post "How-To" content on LinkedIn and Twitter/X.</p>
    <p><em>Example:</em> "I spent $5,000 on ads this week. Here are the 3 things I learned about the new Algorithm."</p>

    <h3>The "Authority" Effect</h3>
    <p>When you share knowledge, you stop chasing clients. Clients start chasing you.</p>');

    -- 10.5 Landing Clients & Pricing Your Services
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod10_id, 'Landing Clients & Pricing Your Services', 5,
    '<h2>Show Me The Money</h2>
    
    <h3>Pricing Models</h3>
    <ul>
        <li><strong>Retainer:</strong> Flat fee (e.g., $1,000/month). Best for stability.</li>
        <li><strong>% of Ad Spend:</strong> 15% of whatever they spend. Best for big clients ($50k+ spend).</li>
        <li><strong>Performance:</strong> Small base + % of Revenue generated. High risk, High reward.</li>
    </ul>

    <h3>The Pitch</h3>
    <p>Don''t sell "Facebook Ads". Sell "Customers".</p>
    <p><strong>Bad:</strong> "I will set up your campaigns and pixel."</p>
    <p><strong>Good:</strong> "I help dentists get 20 new patients a month using paid traffic."</p>');

    RAISE NOTICE 'Modules 9 & 10 Content Populated.';
END $$;
