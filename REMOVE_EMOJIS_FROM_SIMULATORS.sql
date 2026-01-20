-- Remove emojis from Facebook Ads simulator lessons

UPDATE lessons
SET content = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    content,
    '🎯', ''),
    '🤖', ''),
    '📊', ''),
    '🎮', ''),
    '💡', ''),
    '🎯', ''),
    '🚀', ''),
    '🎓', ''),
    '✨', ''),
    '👋', '')
WHERE playground IS NOT NULL
AND playground->>'url' LIKE '%meta-ads%';

-- Verify
SELECT 
    c.title as course,
    l.title as lesson,
    LEFT(l.content, 100) as content_preview
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE l.playground IS NOT NULL
AND l.playground->>'url' LIKE '%meta-ads%';
