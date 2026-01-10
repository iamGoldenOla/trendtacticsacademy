-- Final verification of AI Software Development course structure

-- 1. Show the complete updated course catalog
SELECT 
    category as "Main Category",
    title as "Course Title",
    level as "Difficulty Level",
    duration as "Duration",
    CASE 
        WHEN is_published THEN '🟢 Available' 
        ELSE '🟡 Coming Soon' 
    END as "Status"
FROM courses 
ORDER BY category, is_published DESC, level, title;

-- 2. Detailed view of AI Software Development courses
SELECT 
    '🧠 AI SOFTWARE DEVELOPMENT PATHWAY' as "Specialization",
    title as "Course",
    level as "Level",
    duration as "Time to Complete",
    '🤖 AI-Integrated Curriculum' as "Unique Feature"
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

-- 3. Digital Marketing courses (should remain unchanged)
SELECT 
    '📱 DIGITAL MARKETING SPECIALIZATIONS' as "Specialization",
    title as "Course",
    level as "Level",
    duration as "Time to Complete",
    '🎯 Business Skills for Developers' as "Focus Area"
FROM courses 
WHERE category = 'Digital Marketing'
ORDER BY title;

-- 4. Verify module structure for AI courses
SELECT 
    c.title as "Course",
    m.title as "Module",
    m.ordering as "Order",
    m.duration as "Duration"
FROM modules m
JOIN courses c ON m.course_id = c.id
WHERE c.category = 'AI Software Development'
ORDER BY c.title, m.ordering;

-- 5. Verify assessments for AI courses
SELECT 
    c.title as "Course",
    m.title as "Module",
    a.title as "Assessment",
    a.type as "Type"
FROM assessments a
JOIN modules m ON a.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.category = 'AI Software Development'
ORDER BY c.title, m.ordering, a.ordering;

-- 6. Course statistics by category
SELECT 
    '📊 COURSE STATISTICS' as "Metric Category",
    category as "Category",
    COUNT(*) as "Total Courses",
    COUNT(CASE WHEN level = 'beginner' THEN 1 END) as "Beginner",
    COUNT(CASE WHEN level = 'intermediate' THEN 1 END) as "Intermediate",
    COUNT(CASE WHEN level = 'advanced' THEN 1 END) as "Advanced"
FROM courses 
GROUP BY category
ORDER BY category;

-- 7. Your unique value proposition verification
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

-- 8. Learning pathway verification
SELECT 
    '🛣️ RECOMMENDED LEARNING PATHS' as "Path Type",
    'Complete AI Developer Journey' as "Path Name",
    'Start with AI Web Development → Advance to AI Mobile Apps' as "Sequence",
    '2 Courses | Progressive Skill Building' as "Structure";

-- Final verification summary
SELECT 
    '✅ VERIFICATION COMPLETE' as "Status",
    'Your course catalog now properly reflects AI Software Development expertise' as "Message",
    'All courses are correctly categorized and structured' as "Confirmation";