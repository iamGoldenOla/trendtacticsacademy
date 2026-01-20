-- Fix Facebook Ads Foundation Module 1 - Remove Duplicate Videos from Content
-- This removes the iframe embeds from lesson content since VideoPlayer component handles videos

DO $$
DECLARE
    foundation_id UUID;
    mod1_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod1_id FROM modules WHERE course_id = foundation_id AND ordering = 1;
    
    RAISE NOTICE 'Removing duplicate video iframes from Module 1 lessons...';
    
    -- Update all Module 1 lessons to remove the video-container div with iframe
    UPDATE lessons
    SET content = REGEXP_REPLACE(
        content,
        '<h2>📺 Video Tutorial</h2>\s*<div class="video-container">.*?</div>',
        '',
        'g'
    )
    WHERE module_id = mod1_id;
    
    RAISE NOTICE 'Duplicate videos removed from all Module 1 lessons';
    
END $$;

-- Verify - check that video-container is gone
SELECT 
    l.ordering,
    l.title,
    CASE 
        WHEN l.content LIKE '%video-container%' THEN 'HAS DUPLICATE'
        ELSE 'CLEAN'
    END as status,
    l.video_url IS NOT NULL as has_video_url
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation' AND m.ordering = 1
ORDER BY l.ordering;
