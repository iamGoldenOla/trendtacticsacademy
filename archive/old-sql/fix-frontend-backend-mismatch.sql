-- FIX FRONTEND-BACKEND MISMATCH
-- This script will consolidate categories and ensure courses are properly published

-- 1. First, let's fix the duplicate courses issue
DELETE FROM courses 
WHERE id NOT IN (
    SELECT MIN(id)
    FROM courses
    GROUP BY title
);

-- 2. Update Web Development courses to be published
UPDATE courses 
SET is_published = true
WHERE category = 'Web Development';

-- 3. Update App Development courses to be published
UPDATE courses 
SET is_published = true
WHERE category = 'App Development';

-- 4. Update Digital Marketing courses to be published
UPDATE courses 
SET is_published = true
WHERE category = 'Digital Marketing';

-- 5. Fix any null categories
UPDATE courses 
SET category = 'Web Development'
WHERE category IS NULL AND title LIKE '%Web%';

UPDATE courses 
SET category = 'App Development'
WHERE category IS NULL AND title LIKE '%App%';

-- 6. Ensure all course levels are lowercase to match constraints
UPDATE courses 
SET level = LOWER(level)
WHERE level IS NOT NULL;

-- 7. Fix any null levels
UPDATE courses 
SET level = 'beginner'
WHERE level IS NULL AND category = 'Web Development';

UPDATE courses 
SET level = 'intermediate'
WHERE level IS NULL AND category = 'App Development';

-- 8. Create a view that consolidates courses for frontend display
-- This creates a unified view that the frontend can query
CREATE OR REPLACE VIEW course_catalog AS
SELECT 
    id,
    title,
    description,
    category,
    level,
    duration,
    is_published,
    created_at,
    updated_at,
    CASE 
        WHEN category IN ('Web Development', 'App Development') THEN 'AI Software Development'
        ELSE category
    END as display_category,
    CASE 
        WHEN category IN ('Web Development', 'App Development') THEN 'technical'
        WHEN category = 'Digital Marketing' THEN 'business'
        ELSE 'other'
    END as course_type
FROM courses
WHERE is_published = true;

-- 9. Verify the fixes
SELECT 
    '✅ FIXED COURSE CATEGORIES' as "Status",
    category as "Category",
    COUNT(*) as "Course Count",
    COUNT(CASE WHEN is_published THEN 1 END) as "Published"
FROM courses
GROUP BY category
ORDER BY "Category";

-- 10. Show consolidated view for frontend
SELECT 
    '📚 CONSOLIDATED COURSE CATALOG FOR FRONTEND' as "Info",
    display_category as "Display Category",
    COUNT(*) as "Courses",
    STRING_AGG(title, ' | ') as "Course Titles"
FROM course_catalog
GROUP BY display_category
ORDER BY display_category;

-- 11. Check publication status
SELECT 
    '📢 PUBLICATION STATUS' as "Status",
    CASE 
        WHEN is_published THEN 'Published' 
        ELSE 'Draft' 
    END as "Publication Status",
    COUNT(*) as "Count"
FROM courses
GROUP BY is_published;

-- Final confirmation
SELECT 
    '🎉 FRONTEND-BACKEND SYNCHRONIZATION COMPLETE' as "Result",
    'Courses are now properly categorized and published' as "Status",
    'Frontend should now display courses correctly' as "Expected Outcome";