-- MODULE 4: CREATIVE THAT CONVERTS - ALL 5 LESSONS
-- Comprehensive content on ad formats, copy, design, testing, and DCO

DO $$
DECLARE
    foundation_id UUID;
    mod4_id UUID;
    lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod4_id FROM modules WHERE course_id = foundation_id AND ordering = 4;
    
    RAISE NOTICE 'Creating Module 4 - All 5 lessons...';
    
    -- LESSON 1: Ad Formats
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod4_id,
        'Ad Formats: Image, Video, Carousel, Collection',
        1,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Understand all Facebook ad format options</li>
<li>Learn when to use each ad format</li>
<li>Master format-specific best practices</li>
<li>Understand format performance characteristics</li>
<li>Learn to match formats to campaign objectives</li>
</ul>

<h2>Image Ads: Simple and Effective</h2>

<p>Image ads are the simplest ad format - a single image with text, headline, and call-to-action. Despite their simplicity, image ads remain highly effective when executed well. They load quickly, work on all devices, and allow your message to be consumed at a glance.</p>

<p>Image ads work best for simple messages and direct response campaigns. If you can communicate your value proposition in one image and a few words, image ads are efficient and cost-effective. They typically have lower production costs than video and can be created and tested quickly.</p>

<p>Best practices for image ads include using high-quality, eye-catching images that stand out in the feed. Avoid text-heavy images - Facebook recommends keeping text to less than 20% of the image. Use bright colors, faces, and emotion to capture attention. Ensure your image is relevant to your message and target audience.</p>

<h2>Video Ads: Engaging and Versatile</h2>

<p>Video ads capture attention and allow you to tell stories that static images cannot. They can demonstrate products, explain complex concepts, showcase testimonials, or build emotional connections. Video ads typically have higher engagement rates than image ads but require more production effort.</p>

<p>Video ads work best for brand awareness, product demonstrations, and storytelling. If your product requires explanation or demonstration, video is ideal. If you want to build emotional connection or show your brand personality, video excels. However, video production requires more time and resources than images.</p>

<p>Best practices for video ads include capturing attention in the first 3 seconds - most people decide whether to keep watching within this window. Design for sound-off viewing since most Facebook videos are watched without sound. Use captions to convey your message visually. Keep videos short - 15-30 seconds typically performs best for most objectives.</p>

<h2>Carousel Ads: Multiple Products or Features</h2>

<p>Carousel ads allow you to showcase up to 10 images or videos in a single ad, each with its own link. Users can swipe through the carousel to see different products, features, or messages. This format is powerful for e-commerce, storytelling, or showcasing multiple value propositions.</p>

<p>Carousel ads work best for e-commerce stores with multiple products, businesses with multiple services, or complex products with multiple features. Each carousel card can highlight a different product, feature, or benefit. You can also use carousels to tell sequential stories across multiple cards.</p>

<p>Best practices for carousel ads include using consistent visual style across all cards while making each card distinct and interesting. Order cards strategically - Facebook will automatically optimize card order based on performance. Use each card''s headline and description to provide context. Ensure each card can stand alone since users might not view all cards.</p>

<h2>Collection Ads: Immersive Shopping Experience</h2>

<p>Collection ads combine a cover image or video with multiple product images below. When users tap the ad, it opens an instant, full-screen experience showcasing your products. This format is designed specifically for mobile shopping and works exceptionally well for e-commerce.</p>

<p>Collection ads work best for e-commerce businesses with product catalogs. They create an immersive shopping experience without requiring users to leave Facebook. Users can browse products, view details, and purchase - all within the Facebook app. This reduced friction typically improves conversion rates.</p>

<p>Best practices for collection ads include using an attention-grabbing cover image or video that represents your brand or product category. Curate your product selection carefully - show your best or most relevant products. Ensure your product catalog is properly set up with high-quality images, accurate descriptions, and current pricing.</p>

<h2>Choosing the Right Format</h2>

<p>Match your format to your objective and message complexity. For simple messages and direct response, use image ads. For demonstrations and storytelling, use video ads. For multiple products or features, use carousel ads. For mobile shopping experiences, use collection ads.</p>

<p>Consider your production capabilities. Image ads require minimal production. Video ads require more time and resources. Carousel ads require multiple images or videos. Collection ads require a product catalog. Choose formats you can execute well rather than formats you cannot produce quality content for.</p>

<p>Test different formats to discover what works for your audience. Create the same campaign with different formats and compare performance. Some audiences respond better to video, others to images. Some products sell better through carousels, others through collections. Let data guide your format decisions.</p>

<h2>Real-World Case Study: Fashion E-Commerce</h2>

<p>A fashion e-commerce store was using only image ads, achieving a 2.8x ROAS. They decided to test all four formats with the same budget allocation to identify the best format for their business.</p>

<p>Image ads delivered 2.8x ROAS (baseline). Video ads showing models wearing their clothes delivered 3.2x ROAS with higher engagement. Carousel ads showcasing outfit combinations delivered 3.6x ROAS - customers loved seeing multiple styling options. Collection ads delivered 4.1x ROAS - the immersive mobile shopping experience significantly reduced friction and increased conversion rates.</p>

<p>They learned that different formats served different purposes. They used video ads for brand awareness and new customer acquisition. They used carousel ads for showcasing new collections and styling ideas. They used collection ads for conversion campaigns targeting warm audiences. By matching formats to objectives and audience temperature, they increased overall ROAS to 3.7x.</p>

<h2>Comprehensive Summary</h2>

<p>Facebook offers multiple ad formats, each with unique strengths and ideal use cases. Image ads are simple and effective for direct messages. Video ads engage and tell stories. Carousel ads showcase multiple products or features. Collection ads create immersive mobile shopping experiences. Understanding each format''s strengths allows you to choose the right format for your objective.</p>

<p>Format selection should consider your objective, message complexity, and production capabilities. Simple messages work well with images, complex messages need video, multiple products benefit from carousels, and mobile shopping excels with collections. Choose formats you can execute well rather than formats that sound impressive but you cannot produce quality content for.</p>

<p>Testing different formats reveals what works for your specific audience and products. Some audiences prefer video, others respond better to images. Some products sell better through carousels, others through collections. Systematic testing and data-driven decisions optimize your format selection over time.</p>

<p>The most sophisticated advertisers use multiple formats strategically rather than relying on a single format. Different formats serve different objectives and audience temperatures. Video for awareness, carousel for consideration, collection for conversion. This multi-format approach maximizes performance across the entire funnel.</p>

</div>',
        24,
        'https://www.youtube.com/watch?v=2xfMQDxaG_w'
    )
    RETURNING id INTO lesson_id;
    
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'What is the main advantage of image ads?',
     '["Simple, quick to create, and effective for direct messages", "Best engagement rates", "Highest conversion rates", "Most expensive format"]'::jsonb,
     0,
     'Image ads are simple, load quickly, and work well for straightforward messages'),
    
    (lesson_id,
     'What should you do in the first 3 seconds of video ads?',
     '["Capture attention immediately", "Show your logo", "Display pricing", "Add music"]'::jsonb,
     0,
     'The first 3 seconds are critical - most people decide whether to continue watching in this window'),
    
    (lesson_id,
     'What are carousel ads best for?',
     '["Showcasing multiple products or features", "Single product focus", "Brand awareness only", "Video content"]'::jsonb,
     0,
     'Carousel ads excel at showing multiple products, features, or telling sequential stories'),
    
    (lesson_id,
     'What makes collection ads unique?',
     '["Immersive full-screen mobile shopping experience", "Cheapest format", "Best for desktop", "Video-only format"]'::jsonb,
     0,
     'Collection ads create an immersive shopping experience within Facebook, ideal for mobile e-commerce'),
    
    (lesson_id,
     'How should you choose between ad formats?',
     '["Match format to objective, message complexity, and production capability", "Always use video", "Use the cheapest format", "Random selection"]'::jsonb,
     0,
     'Format selection should align with your objective, message needs, and what you can produce well');
    
    RAISE NOTICE 'Lesson 1 created';
    
END $$;
