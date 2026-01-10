-- AI-Focused Course Structure Visualization for Trendtactics Academy

-- Display the hierarchical structure with proper AI Software Development emphasis

-- 1. Main Categories Overview with AI Focus
SELECT 
    '🤖 MAIN AI-INTEGRATED CATEGORIES' as "Structure Level",
    category as "Category",
    COUNT(*) as "Courses",
    STRING_AGG(
        CASE WHEN is_published THEN title ELSE title || ' (Coming Soon)' END, 
        ', '
    ) as "Course List"
FROM courses 
GROUP BY category
ORDER BY category;

-- 2. Detailed Course Catalog by Category
SELECT 
    category as "Category",
    title as "Course Title",
    level as "Difficulty Level",
    duration as "Duration",
    CASE 
        WHEN is_published THEN '🟢 Available' 
        ELSE '🟡 Coming Soon' 
    END as "Status"
FROM courses 
ORDER BY category, is_published DESC, level, title;

-- 3. AI Software Development Pathway
SELECT 
    '🧠 AI SOFTWARE DEVELOPMENT PATHWAY' as "Specialization",
    title as "Course",
    level as "Level",
    duration as "Time to Complete",
    '🔗 Sequential AI Learning Path' as "Learning Path"
FROM courses 
WHERE category = 'AI Software Development'
ORDER BY 
    CASE level 
        WHEN 'beginner' THEN 1
        WHEN 'intermediate' THEN 2
        WHEN 'advanced' THEN 3
        ELSE 4
    END,
    title;

-- 4. Digital Marketing Specializations (Complementary Skills)
SELECT 
    '📱 DIGITAL MARKETING SPECIALIZATIONS' as "Specialization",
    title as "Course",
    level as "Level",
    duration as "Time to Complete",
    '🎯 Business Skills for AI Developers' as "Focus Area"
FROM courses 
WHERE category = 'Digital Marketing'
ORDER BY title;

-- 5. Your Unique Value Proposition
SELECT 
    '💎 YOUR UNIQUE VALUE PROPOSITION' as "Differentiator",
    'AI-First Software Development' as "Specialty",
    'Building intelligent applications from day one' as "Description",
    'High-demand skillset in modern development' as "Market Advantage"
UNION ALL
SELECT 
    '💎 YOUR UNIQUE VALUE PROPOSITION' as "Differentiator",
    'Integrated Business Skills' as "Specialty",
    'Technical + Marketing expertise for complete solutions' as "Description",
    'Freelance and entrepreneurship opportunities' as "Market Advantage";

-- 6. Course Completion Statistics with AI Focus
SELECT 
    '📊 CURRENT PLATFORM STATISTICS' as "Metric Category",
    'Total Available Courses' as "Metric",
    COUNT(*)::text as "Value"
FROM courses 
WHERE is_published = true
UNION ALL
SELECT 
    '📊 CURRENT PLATFORM STATISTICS' as "Metric Category",
    'AI Software Development Courses' as "Metric",
    COUNT(*)::text as "Value"
FROM courses 
WHERE category = 'AI Software Development' AND is_published = true
UNION ALL
SELECT 
    '📊 CURRENT PLATFORM STATISTICS' as "Metric Category",
    'Digital Marketing Courses' as "Metric",
    COUNT(*)::text as "Value"
FROM courses 
WHERE category = 'Digital Marketing' AND is_published = true;

-- 7. Learning Path Recommendations with AI Emphasis
SELECT 
    '🛣️ RECOMMENDED LEARNING PATHS' as "Path Type",
    'Complete AI Developer Journey' as "Path Name",
    'Start with AI Web Development → Advance to AI Mobile Apps' as "Recommended Sequence",
    '2 Courses | 18 Weeks Total' as "Time Investment"
UNION ALL
SELECT 
    '🛣️ RECOMMENDED LEARNING PATHS' as "Path Type",
    'AI Developer + Marketing Specialist Track' as "Path Name",
    'Combine technical AI skills with business marketing knowledge' as "Recommended Sequence",
    'Multiple Courses | Flexible Timeline' as "Time Investment";

-- 8. Market Positioning
SELECT 
    '🎯 MARKET POSITIONING' as "Positioning Type",
    'AI Software Development Specialist' as "Role",
    'Building intelligent web and mobile applications' as "Specialty",
    'Premium rates for AI-integrated solutions' as "Compensation"
UNION ALL
SELECT 
    '🎯 MARKET POSITIONING' as "Positioning Type",
    'Full-Stack AI Developer + Marketer' as "Role",
    'Technical development with business understanding' as "Specialty",
    'Entrepreneurship and consulting opportunities' as "Compensation";

-- Final Summary
SELECT 
    '✅ CORRECTED COURSE STRUCTURE SUMMARY' as "Status",
    'Your course catalog now properly emphasizes AI Software Development' as "Description",
    'Ready for student enrollment with accurate representation of your expertise' as "Next Steps";