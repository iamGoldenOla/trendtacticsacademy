-- Rebuild Facebook Ads Mastery - Part 3: Modules 3 & 4 Content

DO $$
DECLARE
    v_mastery_course_id UUID := '0987fcde-4321-0987-6543-210987654321';
    v_mod3_id UUID;
    v_mod4_id UUID;
BEGIN
    -- Get Module IDs
    SELECT id INTO v_mod3_id FROM modules WHERE course_id = v_mastery_course_id AND ordering = 3;
    SELECT id INTO v_mod4_id FROM modules WHERE course_id = v_mastery_course_id AND ordering = 4;

    -- MODULE 3: Campaign Strategy & Objectives -----------------------------------------------------------

    -- 3.1 Choosing the Right Campaign Objective
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod3_id, 'Choosing the Right Campaign Objective', 1,
    '<h2>The First Critical Decision</h2>
    <p>When you hit "Create", Facebook asks "What''s your campaign objective?" This is the most critical technical setting.</p>

    <h2>The 6 Objectives (ODAX)</h2>
    <p>Meta simplified objectives into 6 categories (ODAX - Outcome-Driven Ad Experiences):</p>
    
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
        <div style="background: #eff6ff; padding: 10px; border-radius: 6px;">
            <strong>1. Awareness:</strong> Show to people most likely to remember your brand (Reach).
        </div>
        <div style="background: #eff6ff; padding: 10px; border-radius: 6px;">
            <strong>2. Traffic:</strong> Send people to a destination (Website, Link Clicks). *Warning: "Clickers" are not always "Buyers".*
        </div>
        <div style="background: #eff6ff; padding: 10px; border-radius: 6px;">
            <strong>3. Engagement:</strong> Get Page Likes, Video Views, or Comments.
        </div>
        <div style="background: #dcfce7; padding: 10px; border-radius: 6px;">
            <strong>4. Leads:</strong> Collect forms or calls. Good for service businesses.
        </div>
        <div style="background: #dcfce7; padding: 10px; border-radius: 6px;">
            <strong>5. App Promotion:</strong> Get installs for your app.
        </div>
        <div style="background: #fef08a; padding: 10px; border-radius: 6px;">
            <strong>6. Sales:</strong> Find people likely to purchase. (The Gold Standard for E-com).
        </div>
    </div>

    <h3>Why It Matters</h3>
    <p><strong>The algorithm gives you exactly what you ask for.</strong> If you choose "Traffic", Facebook finds people who click links but never buy. If you choose "Sales", it finds expensive users who actually pull out credit cards.</p>

    <h3>Golden Rule</h3>
    <p>If you want Sales, choose <strong>Sales</strong>. Do not "warm up" with Traffic ads hoping they switch to buyers later. It rarely works efficiently.</p>');

    -- 3.2 Awareness vs. Consideration vs. Conversion
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod3_id, 'Awareness vs. Consideration vs. Conversion', 2,
    '<h2>The Marketing Funnel</h2>
    <p>Your strategy should map to where the customer is in their journey.</p>
    
    <h3>1. Awareness (Top of Funnel - TOFU)</h3>
    <p><strong>Goal:</strong> Stop the scroll. Introduce the problem.</p>
    <p><strong>Ad Type:</strong> Short viral videos, educational content, influencer skits.</p>
    <p><strong>KPIs:</strong> Reach, CPM, Video Thru-Plays.</p>

    <h3>2. Consideration (Middle of Funnel - MOFU)</h3>
    <p><strong>Goal:</strong> Build trust and desire.</p>
    <p><strong>Ad Type:</strong> Testimonials, deep-dive demos, "How it works" carousels.</p>
    <p><strong>KPIs:</strong> Click-Through Rate (CTR), Landing Page Views.</p>

    <h3>3. Conversion (Bottom of Funnel - BOFU)</h3>
    <p><strong>Goal:</strong> Get the money.</p>
    <p><strong>Ad Type:</strong> Discount offers, "Low Stock" warnings, direct product shots.</p>
    <p><strong>KPIs:</strong> Cost Per Purchase (CPP/CPA), ROAS.</p>

    <h3>Common Mistake</h3>
    <p>Trying to marry on the first date. Don''t show a "Buy Now" ad to a cold audience for a $500 product without building value first (unless it''s an impulse buy).</p>');

    -- 3.3 Funnel Mapping with Facebook Ads
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod3_id, 'Funnel Mapping with Facebook Ads', 3,
    '<h2>Building a System, Not Just an Ad</h2>
    <p>A funnel is a connected series of ads that guides a stranger to becoming a customer.</p>

    <h3>The 3-Step E-Commerce Funnel</h3>
    <div style="background: #ffffff; padding: 20px; border: 1px solid #e5e7eb; border-radius: 8px;">
        <h4 style="margin-top:0;">Step 1: The Hook (Broad Targeting)</h4>
        <p>Run a video ad demonstrating the product. Optimize for "Sales".</p>
        <p><em>Excludes:</em> Buyers (Last 180 Days).</p>
        <hr>
        <h4>Step 2: The Retargeting (Warm Audience)</h4>
        <p>Target: People who viewed video 50% OR visited website.</p>
        <p>Show: A compilation of customer testimonials.</p>
        <hr>
        <h4>Step 3: The Offer (Hot Audience)</h4>
        <p>Target: Added to Cart (7 Days).</p>
        <p>Show: "10% Off Code: WELCOME10".</p>
    </div>

    <h3>Practical Exercise</h3>
    <p>Draw your funnel on a piece of paper. What acts as your "Intro"? What acts as your "Closer"?</p>');

    -- 3.4 Budgeting: Daily vs. Lifetime
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod3_id, 'Budgeting: Daily vs. Lifetime', 4,
    '<h2>How Meta Spends Your Money</h2>
    
    <h3>Daily Budget (Recommended for Beginners)</h3>
    <p><strong>Definition:</strong> "Spend exactly ₦5,000 every single day."</p>
    <p><strong>Pros:</strong> Consistent, easier to control, good for evergreen campaigns.</p>
    <p><strong>Cons:</strong> Facebook might force spend even on a "bad day".</p>

    <h3>Lifetime Budget</h3>
    <p><strong>Definition:</strong> "Spend ₦50,000 between Jan 1st and Jan 31st."</p>
    <p><strong>Pros:</strong> Allows "Dayparting" (e.g., Run ads only 9am-5pm). Facebook spends more on days with better opportunities.</p>
    <p><strong>Cons:</strong> Harder to scale. If you add money, it recalculates the pace.</p>

    <h3>The "20% Rule" for Scaling</h3>
    <p>If a Daily Budget campaign is working, do not double the budget overnight. It resets the learning phase. Increase it by <strong>20% every 2-3 days</strong> to maintain stability.</p>');

    -- 3.5 Bidding Strategies & Optimization
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod3_id, 'Bidding Strategies & Optimization', 5,
    '<h2>Controlling the Costs</h2>
    <p>Facebook is an auction. You are bidding against competitors for the user''s attention.</p>

    <h3>1. Lowest Cost (Auto-Bid) - Default</h3>
    <p><strong>Logic:</strong> "Get me the most results for my budget."</p>
    <p><strong>Use When:</strong> 99% of the time. Let the AI handle the math.</p>

    <h3>2. Cost Cap</h3>
    <p><strong>Logic:</strong> "Get me results, but do NOT pay more than ₦2,000 per purchase."</p>
    <p><strong>Risk:</strong> If your cap is too low, Facebook will simply stop spending. Your ad won''t deliver.</p>

    <h3>3. Bid Cap</h3>
    <p><strong>Logic:</strong> "Do not bid more than X in the auction."</p>
    <p><strong>Use When:</strong> You are an advanced media buyer engaging in manual bidding wars.</p>
    
    <h3>Optimization Events</h3>
    <p>Always utilize "Optimize for Conversions" if you want sales. Optimizing for "Link Clicks" will get you cheap clicks from bots or accidental clickers, not buyers.</p>');


    -- MODULE 4: Creative That Converts -------------------------------------------------------------------

    -- 4.1 Ad Formats: Image, Video, Carousel, Collection
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod4_id, 'Ad Formats: Image, Video, Carousel, Collection', 1,
    '<h2>The Creative is the New Targeting</h2>
    <p>In 2026, the algorithm is so smart that your "Creative" (the ad itself) does 80% of the targeting work. Good creative finds good buyers.</p>

    <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px;">
        <div style="border: 1px solid #ddd; padding: 15px; border-radius: 8px;">
            <h3>Single Image</h3>
            <p><strong>Best for:</strong> Clean, simple product shots. Flash sales. Offers.</p>
        </div>
        <div style="border: 1px solid #ddd; padding: 15px; border-radius: 8px;">
            <h3>Single Video (Reels/Stories)</h3>
            <p><strong>Best for:</strong> Demonstrations, storytelling, UGC (User Generated Content).</p>
        </div>
        <div style="border: 1px solid #ddd; padding: 15px; border-radius: 8px;">
            <h3>Carousel</h3>
            <p><strong>Best for:</strong> Showing multiple products, telling a sequential story, or handling objections card-by-card.</p>
        </div>
        <div style="border: 1px solid #ddd; padding: 15px; border-radius: 8px;">
            <h3>Collection</h3>
            <p><strong>Best for:</strong> Mobile shopping. Opens an Instant Experience page.</p>
        </div>
    </div>

    <h3>Pro Tip: Format Ratios</h3>
    <ul>
        <li><strong>Feed:</strong> 1:1 (Square) or 4:5 (Vertical)</li>
        <li><strong>Stories/Reels:</strong> 9:16 (Full Screen Vertical) - <em>Critical in 2026!</em></li>
        <li><strong>Right Column:</strong> 16:9 (Landscape)</li>
    </ul>');

    -- 4.2 Writing High-Converting Ad Copy
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod4_id, 'Writing High-Converting Ad Copy', 2,
    '<h2>The Art of Persuasion</h2>
    <p>Good copy doesn''t just describe the product; it sells the transformation.</p>

    <h3>Formula: AIDA</h3>
    <div style="background: #fff; padding: 20px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); border-radius: 8px;">
        <p><strong>Attention:</strong> Hook the reader immediately. <br><em>"Tired of back pain ruining your sleep?"</em></p>
        <p><strong>Interest:</strong> Agitate the problem/Present solution. <br><em>"Traditional mattresses curve your spine..."</em></p>
        <p><strong>Desire:</strong> Value proposition/Benefits. <br><em>"Our Ortho-Cloud tech aligns your back instantly..."</em></p>
        <p><strong>Action:</strong> Clear instruction. <br><em>"Click Shop Now for 50% Off."</em></p>
    </div>

    <h3>Long Copy vs. Short Copy</h3>
    <ul>
        <li><strong>Short:</strong> Impulse buys, cheap products, clear visuals.</li>
        <li><strong>Long:</strong> Expensive items, complicated services, coaching.</li>
    </ul>

    <h3>The "Primary Text" vs. "Headline"</h3>
    <p>The <strong>Headine</strong> (bold text near button) is the most read part. Make it punchy. "50% Off Ends Tonight".</p>');

    -- 4.3 Visual Psychology & Design Principles
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod4_id, 'Visual Psychology & Design Principles', 3,
    '<h2>Stopping the Scroll</h2>
    <p>The human brain processes images 60,000x faster than text. Your image must do the heavy lifting.</p>

    <h3>Design Principles for Ads</h3>
    <ol>
        <li><strong>Contrast:</strong> Use colors that pop against the Facebook Blue/White background. (Orange, Red, Green).</li>
        <li><strong>Pattern Interrupt:</strong> Do something unexpected. Upside-down images, weird angles, bold text overlays.</li>
        <li><strong>Faces:</strong> Humans are wired to look at eyes. Use real people showing emotion.</li>
        <li><strong>Text Overlay:</strong> Keep it under 20% of the image. Use it to highlight the "Hook".</li>
    </ol>

    <h3>The "Ugly Ad" Paradox</h3>
    <p>Sometimes, overly polished "Corporate" ads perform worse than raw, iPhone-shot photos. Why? Because they look like <em>content</em>, not ads. Native content builds trust.</p>');

    -- 4.4 A/B Testing Creatives
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod4_id, 'A/B Testing Creatives', 4,
    '<h2>Testing is the Secret Sauce</h2>
    <p>You never know what will work until you test it.</p>

    <h3>How to structure a Creative Test</h3>
    <p><strong>The Campaign:</strong> "Creative Sandbox"</p>
    <p><strong>The Ad Set:</strong> Broad Audience.</p>
    <p><strong>The Ads:</strong> 3-5 distinct variations.</p>
    <ul>
        <li>Ad A: Video (UGC testimonial)</li>
        <li>Ad B: Image (Product only)</li>
        <li>Ad C: Carousel (Benefits)</li>
    </ul>

    <h3>The Rule</h3>
    <p>Run them for 48-72 hours. Turn off the losers (High Cost per Purchase). Take the winner and move it to your "Scaling" campaign.</p>

    <h3>Common Mistake</h3>
    <p>Testing too many things at once. If you change the Headline <em>and</em> the Image <em>and</em> the Audience... you don''t know what caused the improvement.</p>');

    -- 4.5 Using Dynamic Creative Optimization
    INSERT INTO lessons (module_id, title, ordering, content) VALUES (v_mod4_id, 'Using Dynamic Creative Optimization', 5,
    '<h2>Let the Machine Decide</h2>
    <p>Dynamic Creative Optimization (DCO) allows you to throw multiple ingredients into a bucket and let Facebook serve the best combo to each user.</p>

    <h3>How DCO Works</h3>
    <p>You upload:</p>
    <ul>
        <li>5 Images</li>
        <li>3 Headlines</li>
        <li>3 Primary Texts</li>
        <li>1 Call to Action</li>
    </ul>
    <p>Facebook mixes and matches them. It might show User A "Image 1 + Headline 2" and User B "Image 3 + Headline 1", depending on what they are most likely to click.</p>

    <h3>Benefits</h3>
    <ul>
        <li><strong>Speed:</strong> Tests 15 combinations instantly.</li>
        <li><strong>Fatigue:</strong> Keeps ads fresh longer.</li>
        <li><strong>Personalization:</strong> Adapts to user preferences.</li>
    </ul>

    <h3>Warning</h3>
    <p>Ensure ALL text options make sense with ALL image options. Don''t reference "the red shirt in the photo" if the photo might dynamically switch to a blue shirt.</p>');

    RAISE NOTICE 'Modules 3 & 4 Content Populated.';
END $$;
