-- Rebuild Facebook Ads Mastery - Part 5: Modules 7 & 8 Content

DO $$
DECLARE
    v_mastery_course_id UUID := '0987fcde-4321-0987-6543-210987654321';
    v_mod7_id UUID;
    v_mod8_id UUID;
BEGIN
    -- Get Module IDs
    SELECT id INTO v_mod7_id FROM modules WHERE course_id = v_mastery_course_id AND ordering = 7;
    SELECT id INTO v_mod8_id FROM modules WHERE course_id = v_mastery_course_id AND ordering = 8;

    -- MODULE 7: Advanced Tactics & Automation -----------------------------------------------------------

    -- 7.1 Automated Rules & Scheduling
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod7_id, 'Automated Rules & Scheduling', 1,
    '<h2>Sleep More, Stress Less</h2>
    <p>Facebook can manage your ads while you sleep. Automated rules are logical instructions you give to the engine.</p>

    <h3>Top 3 Rules to Setup</h3>

    <h4>1. The "Stop Loss" (Safety Net)</h4>
    <div style="background: #fee2e2; padding: 15px; border-radius: 8px; border: 1px solid #fecaca;">
        <p><strong>IF</strong> Spend > 2x Target CPA <strong>AND</strong> Purchases < 1</p>
        <p><strong>THEN:</strong> Turn off Ad</p>
        <p><strong>Why:</strong> Prevents a bad ad from draining your wallet overnight.</p>
    </div>

    <h4>2. The "Winner Watch" (Notification)</h4>
    <div style="background: #dcfce7; padding: 15px; border-radius: 8px; border: 1px solid #bbf7d0;">
        <p><strong>IF</strong> ROAS > 4.0 <strong>AND</strong> Spend > $50</p>
        <p><strong>THEN:</strong> Send Email Notification</p>
        <p><strong>Why:</strong> Tells you immediately when you have a hit so you can scale manualy.</p>
    </div>

    <h4>3. The "Reviver" (Frequency Check)</h4>
    <div style="background: #e0f2fe; padding: 15px; border-radius: 8px; border: 1px solid #bae6fd;">
        <p><strong>IF</strong> Frequency > 2.5 <strong>AND</strong> CTR < 1%</p>
        <p><strong>THEN:</strong> Decrease Budget by 20%</p>
        <p><strong>Why:</strong> Prevents ad fatigue automatically.</p>
    </div>

    <h3>How to Set Up</h3>
    <p>In Ads Manager, click the "Rules" button (Process icon) > "Create New Rule".</p>');

    -- 7.2 Advanced Bidding: Cost Caps & Bid Caps
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod7_id, 'Advanced Bidding: Cost Caps & Bid Caps', 2,
    '<h2>Beyond Auto-Bidding</h2>
    <p>Most advertisers use "Lowest Cost". But "Cost Caps" give you sniper-like control.</p>

    <h3>Cost Cap Strategy</h3>
    <p>You tell Facebook: <em>"I want as many sales as possible, but ONLY if they cost $15 average."</em></p>
    <ul>
        <li><strong>Pros:</strong> Guaranteed profitability. If Facebook can''t find cheap buyers, it just won''t spend your money.</li>
        <li><strong>Cons:</strong> Scale issues. It''s hard to spend large budgets with strict caps.</li>
    </ul>

    <h3>The "Bully" Strategy (Bid Cap)</h3>
    <p>Set a Bid Cap 5x higher than your competitors (e.g., $100 bid for a $20 product). <br>
    <em>Why?</em> You win the highest quality traffic first. You don''t pay $100; you pay just enough to beat the second bidder.</p>
    <p><strong>Warning:</strong> Only for advanced media buyers with proven offers.</p>');

    -- 7.3 Retargeting with Catalogs & Dynamic Ads
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod7_id, 'Retargeting with Catalogs & Dynamic Ads', 3,
    '<h2>DPA: Dynamic Product Ads</h2>
    <p>Ever look at a pair of shoes, leave the site, and then see those EXACT shoes stalking you on Instagram? That is a DPA.</p>

    <h3>Why They Work</h3>
    <ul>
        <li><strong>Relevance:</strong> Users see arguably the most relevant ad possible (the thing they just looked at).</li>
        <li><strong>Automation:</strong> You create one template, and it works for 1,000 products automatically.</li>
    </ul>

    <h3>Setup Steps</h3>
    <ol>
        <li><strong>Commerce Manager:</strong> specific Create a "Catalog" and sync it with Shopify/WooCommerce.</li>
        <li><strong>Campaign:</strong> Choose "Sales" Objective > "Catalog Sales".</li>
        <li><strong>Ad Set:</strong> Select "Retarget ads to people who interacted with your products on and off Facebook".</li>
        <li><strong>Option:</strong> "Viewed or Added to Cart but not Purchased (14 Days)".</li>
    </ol>

    <h3>Visual Aid</h3>
    <p>The ad template uses tags like <code>{{product.name}}</code> and <code>{{product.price}}</code> to dynamically fill in the info.</p>');

    -- 7.4 Using UTM Parameters for Deep Analytics
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod7_id, 'Using UTM Parameters for Deep Analytics', 4,
    '<h2>Trusting Google Analytics</h2>
    <p>Facebook''s data is biased (it claims all credit). You need a second opinion. UTMs let you see Facebook traffic inside Google Analytics.</p>

    <h3>The URL Builder</h3>
    <p>Instead of linking to <code>mysite.com</code>, you link to: <br>
    <code>mysite.com?utm_source=facebook&utm_medium=cpc&utm_campaign=summer_sale&utm_content=video_01</code></p>

    <h3>Meta''s Dynamic Parameters</h3>
    <p>You don''t have to type this manually. In the Ad Level "Tracking" section, click "Build a URL Parameter".</p>
    <p>Use dynamic values: <code>utm_campaign={{campaign.name}}</code>. Facebook will auto-fill the name.</p>

    <h3>Why It Matters</h3>
    <p>If Facebook says "10 Sales" but Google Analytics says "2 Sales", you have a tracking problem. UTMs are the source of truth for "Click-based" attribution.</p>');

    -- 7.5 Integrating Facebook Ads with Email Funnels
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod7_id, 'Integrating Facebook Ads with Email Funnels', 5,
    '<h2> The "Profit Sandwich"</h2>
    <p>Ads bring them in. Email closes the deal. They work better together.</p>

    <h3>Strategy 1: The Lead Magnet</h3>
    <ul>
        <li><strong>Ad:</strong> "Get our Free Guide". (Objective: Leads).</li>
        <li><strong>Email:</strong> Delivers guide + 5-day Welcome Series selling the product.</li>
        <li><strong>Result:</strong> You build an asset (Email List) you own forever.</li>
    </ul>

    <h3>Strategy 2: The "Sync"</h3>
    <p>Upload your Email List to Facebook as a Custom Audience.</p>
    <ul>
        <li><strong>Exclude:</strong> People who already subscribed (so they don''t see the "Subscribe" ad again).</li>
        <li><strong>Target:</strong> People who opened emails but didn''t buy (Show them a special "VIP Discount" ad).</li>
    </ul>

    <h3>The Logic</h3>
    <p>Email is "Free" traffic. Ads are "Paid" traffic. Use paid traffic to feed the free channel.</p>');


    -- MODULE 8: Compliance, Ethics & Troubleshooting -----------------------------------------------------

    -- 8.1 Facebook Ad Policies & Common Violations
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod8_id, 'Facebook Ad Policies & Common Violations', 1,
    '<h2>Don''t Get Banned!</h2>
    <p>Meta uses AI to review ads. It is strict and often bans first, asks questions later.</p>

    <h3>The Big 4 Violations</h3>
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
        <div style="background: #fef2f2; padding: 10px; border: 1px solid #fecaca; border-radius: 6px;">
            <h4 style="color: #991b1b; margin-top:0;">1. Personal Attributes</h4>
            <p><strong>Bad:</strong> "Are you fat?"</p>
            <p><strong>Good:</strong> "Weight loss tips for busy dads."</p>
            <p>Never imply you know the user''s race, disability, or medical status.</p>
        </div>
        <div style="background: #fef2f2; padding: 10px; border: 1px solid #fecaca; border-radius: 6px;">
            <h4 style="color: #991b1b; margin-top:0;">2. Making Unrealistic Claims</h4>
            <p><strong>Bad:</strong> "Make $10,000 in 2 days!"</p>
            <p><strong>Good:</strong> "How I built a profitable side hustle."</p>
            <p>No "Before/After" photos showing extreme weight loss.</p>
        </div>
        <div style="background: #fef2f2; padding: 10px; border: 1px solid #fecaca; border-radius: 6px;">
            <h4 style="color: #991b1b; margin-top:0;">3. Non-Functional Landing Page</h4>
            <p>Your site must match the ad. No broken links. No PDF direct downloads. No "Under Construction".</p>
        </div>
        <div style="background: #fef2f2; padding: 10px; border: 1px solid #fecaca; border-radius: 6px;">
            <h4 style="color: #991b1b; margin-top:0;">4. Sensational Content</h4>
            <p>No shocking, scary, or sexually suggestive images. No excessive use of CAPS or emojis.</p>
        </div>
    </div>');

    -- 8.2 Getting Unbanned & Appeal Process
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod8_id, 'Getting Unbanned & Appeal Process', 2,
    '<h2>The "Account Desalition" Procedure</h2>
    <p>It happens to the best of us.</p>

    <h3>Step 1: Determine the Ban Type</h3>
    <ul>
        <li><strong>Ad Rejected:</strong> Fix the creative and re-submit.</li>
        <li><strong>Ad Account Disabled:</strong> You can''t run ads, but Business Manager is fine.</li>
        <li><strong>Business Manager Disabled:</strong> The nuclear option. You are locked out.</li>
    </ul>

    <h3>Step 2: The Appeal</h3>
    <p>Go to <strong>Account Quality</strong> (business.facebook.com/accountquality).</p>
    <p>Click "Request Review".</p>
    
    <h3>Writing the Appeal</h3>
    <p>Do NOT be angry. Be professional and apologetic (even if you are right).</p>
    <div style="background: #f3f4f6; padding: 15px; border-radius: 8px; font-family: monospace;">
        "Hello Meta Support team,<br><br>
        I noticed my ad account was disabled. I have reviewed the policies and believe this may be a mistake by the automation. My business sells [Product] and we strictly adhere to advertising guidelines.<br><br>
        If I made a specific error, please clarify so I can fix it immediately. I value the platform and want to remain compliant.<br><br>
        Thank you."
    </div>');

    -- 8.3 Ethical Advertising Practices
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod8_id, 'Ethical Advertising Practices', 3,
    '<h2>Marketing with Integrity</h2>
    <p>Just because you <em>can</em> trick someone into clicking, doesn''t mean you <em>should</em>.</p>

    <h3>Dark Patterns to Avoid</h3>
    <ul>
        <li><strong>Fake Urgency:</strong> "Sale ends in 5 minutes!" (But it resets every time). This destroys trust.</li>
        <li><strong>Hidden Costs:</strong> Advertising "Free + Shipping" but shipping is $20.</li>
        <li><strong>Clickbait:</strong> "You won''t believe what happened!" (And nothing happened).</li>
    </ul>

    <h3>The Long Game</h3>
    <p>Ethical ads build brand equity. Deceptive ads might get a sale today but guarantee 0 repeat customers. Building a sustainable business requires trust.</p>');

    -- 8.4 Troubleshooting Disapproved Ads
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod8_id, 'Troubleshooting Disapproved Ads', 4,
    '<h2>Reading the Rejection Code</h2>
    <p>When an ad is rejected, Facebook usually gives a vague reason: "Circumventing Systems" or "Unacceptable Business Practices".</p>

    <h3>Common Triggers & Fixes</h3>
    
    <h4>Trigger: "Personal Attributes"</h4>
    <p><strong>Fix:</strong> Change "Do YOU struggle with acne?" to "Acne can be a struggle." Shift focus from the user to the problem.</p>

    <h4>Trigger: "Adult Content"</h4>
    <p><strong>Fix:</strong> Less exposed skin. Sometimes zooming out the image helps because the AI thinks a close-up of a shoulder is nudity.</p>

    <h4>Trigger: "Text in Image"</h4>
    <p><strong>Fix:</strong> Reduce text size. While the "20% Rule" is officially gone, text-heavy images still get penalized with lower reach.</p>');

    -- 8.5 Navigating iOS14+ Privacy Changes
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod8_id, 'Navigating iOS14+ Privacy Changes', 5,
    '<h2>The New Normal</h2>
    <p>Since Apple introduced App Tracking Transparency (ATT), we must assume we are losing data.</p>

    <h3>Aggregated Event Measurement (AEM)</h3>
    <p>You must verify your Domain in Business Manager. Then, you must configure your "Top 8 Events" in priority order.</p>

    <h3>How to Adapt</h3>
    <ol>
        <li><strong> broader Targeting:</strong> Small audiences don''t work as well anymore. Go broad and let the machine learn.</li>
        <li><strong>First-Party Data:</strong> Collect emails and phone numbers aggressively. You own that data; Apple can''t block it.</li>
        <li><strong>Server-Side Tracking (CAPI):</strong> Implement CAPI to capture data that browser pixels miss.</li>
    </ol>');

    RAISE NOTICE 'Modules 7 & 8 Content Populated.';
END $$;
