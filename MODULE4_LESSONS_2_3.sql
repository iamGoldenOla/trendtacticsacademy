-- MODULE 4 - LESSONS 2-3
-- Copywriting and Visual Psychology

DO $$
DECLARE
    foundation_id UUID;
    mod4_id UUID;
    lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod4_id FROM modules WHERE course_id = foundation_id AND ordering = 4;
    
    RAISE NOTICE 'Creating Module 4 Lessons 2-3...';
    
    -- LESSON 2: Writing High-Converting Ad Copy
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod4_id,
        'Writing High-Converting Ad Copy',
        2,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Master the fundamentals of persuasive ad copywriting</li>
<li>Learn proven copywriting frameworks and formulas</li>
<li>Understand how to write for different funnel stages</li>
<li>Master headline and call-to-action best practices</li>
<li>Learn to match copy to audience awareness levels</li>
</ul>

<h2>The Psychology of Persuasive Copy</h2>

<p>Effective ad copy speaks to desires, not features. People do not buy products - they buy better versions of themselves, solutions to problems, or feelings they want to experience. Your copy should focus on the transformation your product provides, not just what it is or does.</p>

<p>Great copy addresses the reader''s internal dialogue. What questions are they asking? What objections do they have? What fears hold them back? Your copy should anticipate and answer these questions before they become barriers to action. This requires deep understanding of your audience''s mindset and motivations.</p>

<p>Clarity beats cleverness every time. Witty, creative copy might win awards, but clear, direct copy wins customers. If someone has to think hard to understand your message, they will scroll past. Your value proposition should be immediately obvious to anyone in your target audience.</p>

<h2>Proven Copywriting Frameworks</h2>

<p>The PAS framework (Problem-Agitate-Solution) starts by identifying a problem your audience faces, agitates that problem by highlighting its consequences, then presents your product as the solution. This framework works well because it creates emotional resonance before presenting your offer.</p>

<p>The AIDA framework (Attention-Interest-Desire-Action) captures attention with a compelling hook, builds interest with relevant information, creates desire by highlighting benefits, and drives action with a clear call-to-action. This classic framework remains effective because it mirrors the natural decision-making process.</p>

<p>The BAB framework (Before-After-Bridge) paints a picture of life before your solution, describes life after using your solution, then bridges the gap by explaining how your product creates this transformation. This framework is powerful for products that create clear, tangible improvements.</p>

<h2>Writing for Different Funnel Stages</h2>

<p>Top of funnel copy for cold audiences should focus on awareness and education. These people do not know your brand, so aggressive sales language will repel them. Instead, provide value, introduce your brand, and create interest. Your goal is to start a relationship, not close a sale immediately.</p>

<p>Middle of funnel copy for warm audiences should focus on benefits and differentiation. These people know your brand and are considering whether to buy. Highlight what makes you different, address common objections, and provide social proof. Your goal is to move them from consideration to decision.</p>

<p>Bottom of funnel copy for hot audiences should focus on action and urgency. These people are ready to buy but need a final push. Use direct language, clear calls-to-action, and urgency elements like limited-time offers or scarcity. Your goal is to convert interest into action.</p>

<h2>Headline Best Practices</h2>

<p>Your headline is the most important element of your ad copy. Most people will read your headline and decide whether to read further. A weak headline means your body copy, no matter how good, will never be read. Invest time in crafting compelling headlines.</p>

<p>Effective headlines promise a specific benefit, create curiosity, or highlight a problem. "Lose 10kg in 30 Days" promises a specific benefit. "The Mistake 90% of Advertisers Make" creates curiosity. "Struggling with Facebook Ads?" highlights a problem. All three approaches can work - choose based on your audience and offer.</p>

<p>Test multiple headline variations. Small changes in headlines can create dramatic differences in performance. Test different benefits, different emotional appeals, different specificity levels. A/B testing headlines is one of the highest-leverage optimization activities you can do.</p>

<h2>Call-to-Action Best Practices</h2>

<p>Your call-to-action should be specific and action-oriented. "Learn More" is weak and vague. "Get Your Free Guide" is specific and clear. "Start Your Free Trial" tells people exactly what will happen when they click. Specific CTAs outperform generic ones.</p>

<p>Match your CTA to your objective and audience temperature. Cold audiences might respond to "Learn More" or "Watch Video." Warm audiences might respond to "Get Started" or "See Pricing." Hot audiences might respond to "Buy Now" or "Claim Offer." More aggressive CTAs work better with warmer audiences.</p>

<p>Create urgency when appropriate. "Limited Time Offer," "Only 5 Spots Left," or "Sale Ends Tonight" create urgency that motivates action. However, false urgency damages trust. Only use urgency when it is genuine.</p>

<h2>Real-World Case Study: Online Course Platform</h2>

<p>An online course platform was using feature-focused copy: "Our platform includes 50+ courses, lifetime access, and certificates." Their CTR was 0.9% and conversion rate was 1.2%. The copy focused on what they offered, not what customers would gain.</p>

<p>They rewrote their copy using the BAB framework, focusing on transformation: "Before: Stuck in a job you hate, unsure how to change careers. After: Confidently pursuing your dream career with in-demand skills. Bridge: Our career transformation program gives you the skills and confidence to make the switch in 90 days."</p>

<p>They also tested multiple headlines. "Change Your Career in 90 Days" outperformed "50+ Professional Courses" by 180%. Their CTA changed from "Learn More" to "Start Your Transformation" which felt more specific and aspirational.</p>

<p>Results were dramatic. CTR increased to 2.4% and conversion rate to 3.1%. The same traffic, same budget, but transformation-focused copy that spoke to desires rather than features. They learned that people do not buy courses - they buy career changes, confidence, and better futures.</p>

<h2>Comprehensive Summary</h2>

<p>Effective ad copy speaks to desires and transformations, not features and specifications. People buy better versions of themselves, solutions to problems, and feelings they want to experience. Your copy should focus on the transformation your product provides and address the reader''s internal dialogue, questions, and objections.</p>

<p>Proven frameworks like PAS, AIDA, and BAB provide structure for persuasive copy. These frameworks work because they mirror natural decision-making processes and create emotional resonance before presenting offers. Use these frameworks as starting points, then customize based on your audience and product.</p>

<p>Different funnel stages require different copy approaches. Cold audiences need education and value, warm audiences need benefits and differentiation, hot audiences need action and urgency. Matching your copy to audience temperature dramatically improves performance.</p>

<p>Headlines and CTAs are critical elements that deserve significant attention and testing. Your headline determines whether people read your copy, your CTA determines whether they take action. Small improvements in these elements create disproportionate improvements in overall performance.</p>

</div>',
        26,
        'https://www.youtube.com/watch?v=006V3t__xkc'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'What should effective ad copy focus on?',
     '["Desires and transformations, not features", "Product specifications", "Company history", "Industry jargon"]'::jsonb,
     0,
     'People buy transformations and solutions, not features - focus on what they will gain'),
    
    (lesson_id,
     'What is the PAS copywriting framework?',
     '["Problem-Agitate-Solution", "Price-Action-Sale", "Product-Audience-Strategy", "Plan-Act-Succeed"]'::jsonb,
     0,
     'PAS stands for Problem-Agitate-Solution, a proven framework for persuasive copy'),
    
    (lesson_id,
     'How should copy differ for cold vs hot audiences?',
     '["Cold needs education, hot needs action and urgency", "No difference needed", "Cold needs urgency, hot needs education", "Both need the same approach"]'::jsonb,
     0,
     'Cold audiences need awareness and education, hot audiences need direct CTAs and urgency'),
    
    (lesson_id,
     'What makes a headline effective?',
     '["Promises specific benefit, creates curiosity, or highlights problem", "Uses clever wordplay", "Mentions company name", "Contains many keywords"]'::jsonb,
     0,
     'Effective headlines promise benefits, create curiosity, or highlight problems the audience faces'),
    
    (lesson_id,
     'Why should CTAs be specific?',
     '["Specific CTAs tell people exactly what will happen when they click", "Facebook requires it", "They cost less", "They look more professional"]'::jsonb,
     0,
     'Specific CTAs like "Get Your Free Guide" outperform vague ones like "Learn More"');
    
    RAISE NOTICE 'Lesson 2 created';
    
    -- LESSON 3: Visual Psychology & Design Principles
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod4_id,
        'Visual Psychology & Design Principles',
        3,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Understand how visual elements affect ad performance</li>
<li>Master color psychology for advertising</li>
<li>Learn composition and layout best practices</li>
<li>Understand the role of faces and emotion in ads</li>
<li>Master mobile-first design principles</li>
</ul>

<h2>The Power of Visual First Impressions</h2>

<p>People process visual information 60,000 times faster than text. Your ad''s visual elements determine whether someone stops scrolling and reads your copy. If your visual does not capture attention immediately, your carefully crafted copy will never be read. Visual design is not decoration - it is the gateway to your message.</p>

<p>Facebook feeds are crowded and fast-moving. Users scroll quickly, giving each post a fraction of a second of attention. Your ad must stand out visually to earn the attention needed for your message to be consumed. This requires understanding what captures attention and what blends into the background.</p>

<h2>Color Psychology in Advertising</h2>

<p>Colors evoke emotional responses and associations. Red creates urgency and excitement, blue builds trust and calm, green suggests health and growth, yellow captures attention and optimism. Understanding color psychology allows you to reinforce your message visually.</p>

<p>Contrast is more important than specific color choice. Your ad must stand out against the predominantly white and blue Facebook interface. Bright, saturated colors typically perform better than muted tones because they create visual contrast. However, your color choices should align with your brand and message.</p>

<p>Test different color schemes to discover what resonates with your audience. Some audiences respond to bold, vibrant colors while others prefer subtle, sophisticated palettes. Cultural factors also influence color perception - colors that work well in one market might not work in another.</p>

<h2>Composition and Layout Principles</h2>

<p>The rule of thirds creates visually balanced, engaging compositions. Divide your image into a 3x3 grid and place important elements along the grid lines or at intersections. This creates more dynamic, interesting compositions than centering everything.</p>

<p>Visual hierarchy guides the viewer''s eye through your ad. Use size, color, and placement to direct attention to the most important elements first. Your primary message or product should be the most prominent visual element, with supporting elements sized and positioned accordingly.</p>

<p>Negative space (empty space) is not wasted space - it gives your design room to breathe and makes your message clearer. Cluttered ads with too many elements confuse and overwhelm. Simple, focused designs with ample negative space typically outperform busy, complex designs.</p>

<h2>The Role of Faces and Emotion</h2>

<p>Faces capture attention more effectively than any other visual element. Humans are hardwired to notice faces, making them powerful attention-grabbers in ads. Ads featuring faces typically have higher engagement rates than those without.</p>

<p>Emotion in faces creates connection and resonance. Happy faces create positive associations, surprised faces create curiosity, concerned faces create empathy. The emotion displayed should align with your message - a smiling face works for aspirational products, a concerned face works for problem-solution messaging.</p>

<p>Eye direction guides viewer attention. If the person in your ad is looking at your product or headline, viewers will follow that gaze. If they are looking directly at the camera, it creates connection and engagement. Use eye direction strategically to guide attention to your key message.</p>

<h2>Mobile-First Design Principles</h2>

<p>Over 90% of Facebook users access the platform on mobile devices. Your ads must be designed for small screens first, not adapted from desktop designs. Text must be readable on small screens, important elements must be large enough to see clearly, and your message must be consumable at a glance.</p>

<p>Vertical and square formats work better on mobile than horizontal formats. Vertical formats take up more screen space, creating more impact. Square formats work well across all placements. Horizontal formats waste screen space on mobile and should generally be avoided.</p>

<p>Keep text minimal and large. Small text is unreadable on mobile screens. If text is essential to your ad, make it large and concise. Better yet, convey your message visually and use ad copy text rather than text in images.</p>

<h2>Real-World Case Study: Fitness App</h2>

<p>A fitness app was using stock photos of people exercising with generic, muted colors. Their ads blended into the feed and had a 0.7% CTR. The visuals were professional but forgettable - they looked like every other fitness ad.</p>

<p>They redesigned their ads using visual psychology principles. They used bright, contrasting colors (orange and teal) that stood out against Facebook''s blue interface. They featured close-up faces showing genuine emotion - determination, joy, accomplishment. They applied the rule of thirds for dynamic composition.</p>

<p>They also optimized for mobile by using vertical video format, large text, and simple compositions. Each ad focused on one clear message rather than trying to show everything. They tested different emotional expressions and found that determined, focused faces outperformed smiling faces for their audience.</p>

<p>Results exceeded expectations. CTR increased to 2.8% - a 4x improvement. Engagement rates doubled. Most importantly, the quality of leads improved because the authentic, emotional visuals attracted people genuinely interested in transformation, not just casual browsers. Visual psychology turned their ads from invisible to irresistible.</p>

<h2>Comprehensive Summary</h2>

<p>Visual elements determine whether your ad captures attention in crowded feeds. People process visuals 60,000 times faster than text, making visual design the gateway to your message. Understanding visual psychology and design principles is essential for creating ads that stop the scroll and earn attention.</p>

<p>Color psychology and contrast create emotional responses and visual distinction. Bright, contrasting colors stand out against Facebook''s interface, while color choices reinforce your message emotionally. Composition principles like the rule of thirds and visual hierarchy guide attention and create engaging, balanced designs.</p>

<p>Faces and emotion create connection and resonance more effectively than any other visual element. Humans are hardwired to notice faces, and emotional expressions create associations with your brand and message. Strategic use of faces and eye direction dramatically improves ad performance.</p>

<p>Mobile-first design is non-negotiable given that over 90% of users access Facebook on mobile devices. Vertical or square formats, large text, simple compositions, and mobile-optimized layouts ensure your ads work effectively on small screens where most people will see them.</p>

</div>',
        24,
        'https://www.youtube.com/watch?v=8rABwKRsec4'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'How much faster do people process visual information than text?',
     '["60,000 times faster", "10 times faster", "100 times faster", "Same speed"]'::jsonb,
     0,
     'People process visual information 60,000 times faster than text, making visuals critical for attention'),
    
    (lesson_id,
     'Why is contrast important in Facebook ads?',
     '["Ads must stand out against Facebook''s white and blue interface", "Facebook requires it", "It reduces costs", "It improves ad quality score"]'::jsonb,
     0,
     'Contrast helps your ad stand out visually in the predominantly white and blue Facebook feed'),
    
    (lesson_id,
     'What is the rule of thirds?',
     '["Divide image into 3x3 grid and place important elements along grid lines", "Use three colors only", "Show three products", "Target three audiences"]'::jsonb,
     0,
     'The rule of thirds creates balanced, dynamic compositions by placing elements along grid lines'),
    
    (lesson_id,
     'Why are faces effective in ads?',
     '["Humans are hardwired to notice faces", "They are cheaper to produce", "Facebook prioritizes them", "They require less text"]'::jsonb,
     0,
     'Humans naturally notice faces more than any other visual element, making them powerful attention-grabbers'),
    
    (lesson_id,
     'Why should ads be designed mobile-first?',
     '["Over 90% of Facebook users access on mobile devices", "Mobile ads cost less", "Facebook requires it", "Desktop is obsolete"]'::jsonb,
     0,
     'Over 90% of Facebook usage is on mobile, making mobile-first design essential');
    
    RAISE NOTICE 'Lesson 3 created';
    
END $$;
