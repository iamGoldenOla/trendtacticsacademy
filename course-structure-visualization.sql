-- Course Structure Visualization for Trendtactics Academy

-- Display the hierarchical structure of your course offerings

-- 1. Main Categories Overview
SELECT 
    '📚 MAIN CATEGORIES' as "Structure Level",
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

-- 3. Software Development Pathway
SELECT 
    '💻 SOFTWARE DEVELOPMENT PATHWAY' as "Specialization",
    title as "Course",
    level as "Level",
    duration as "Time to Complete",
    '🔗 Sequential Learning Path' as "Learning Path"
FROM courses 
WHERE category = 'Software Development'
ORDER BY 
    CASE level 
        WHEN 'beginner' THEN 1
        WHEN 'intermediate' THEN 2
        WHEN 'advanced' THEN 3
        ELSE 4
    END,
    title;

-- 4. Digital Marketing Specializations
SELECT 
    '📱 DIGITAL MARKETING SPECIALIZATIONS' as "Specialization",
    title as "Course",
    level as "Level",
    duration as "Time to Complete",
    '🎯 Skill-Based Specialization' as "Focus Area"
FROM courses 
WHERE category = 'Digital Marketing'
ORDER BY title;

-- 5. Future Course Expansion Opportunities
SELECT 
    '🔮 FUTURE EXPANSION OPPORTUNITIES' as "Opportunity Area",
    'AI & Machine Learning' as "Potential Category",
    'Artificial Intelligence for Developers' as "Planned Course",
    'advanced' as "Level",
    '12 weeks' as "Duration",
    'Not Yet Created' as "Status"
UNION ALL
SELECT 
    '🔮 FUTURE EXPANSION OPPORTUNITIES' as "Opportunity Area",
    'Data Science & Analytics' as "Potential Category",
    'Business Intelligence & Analytics' as "Planned Course",
    'intermediate' as "Level",
    '8 weeks' as "Duration",
    'Not Yet Created' as "Status"
UNION ALL
SELECT 
    '🔮 FUTURE EXPANSION OPPORTUNITIES' as "Opportunity Area",
    'UI/UX Design' as "Potential Category",
    'User Experience Design Masterclass' as "Planned Course",
    'beginner' as "Level",
    '6 weeks' as "Duration",
    'Not Yet Created' as "Status";

-- 6. Course Completion Statistics
SELECT 
    '📊 CURRENT PLATFORM STATISTICS' as "Metric Category",
    'Total Available Courses' as "Metric",
    COUNT(*)::text as "Value"
FROM courses 
WHERE is_published = true
UNION ALL
SELECT 
    '📊 CURRENT PLATFORM STATISTICS' as "Metric Category",
    'Total Course Categories' as "Metric",
    COUNT(DISTINCT category)::text as "Value"
FROM courses
UNION ALL
SELECT 
    '📊 CURRENT PLATFORM STATISTICS' as "Metric Category",
    'Beginner Level Courses' as "Metric",
    COUNT(*)::text as "Value"
FROM courses 
WHERE level = 'beginner' AND is_published = true
UNION ALL
SELECT 
    '📊 CURRENT PLATFORM STATISTICS' as "Metric Category",
    'Intermediate Level Courses' as "Metric",
    COUNT(*)::text as "Value"
FROM courses 
WHERE level = 'intermediate' AND is_published = true;

-- 7. Learning Path Recommendations
SELECT 
    '🛣️ RECOMMENDED LEARNING PATHS' as "Path Type",
    'Complete Web Developer Journey' as "Path Name",
    'Start with Web Development → Advance to Mobile Apps → Explore AI Development' as "Recommended Sequence",
    '3 Courses | 30 Weeks Total' as "Time Investment"
UNION ALL
SELECT 
    '🛣️ RECOMMENDED LEARNING PATHS' as "Path Type",
    'Digital Marketing Specialist Track' as "Path Name",
    'Begin with Digital Marketing → Choose Specializations → Master Advanced Techniques' as "Recommended Sequence",
    '5 Courses | 25 Weeks Total' as "Time Investment";

-- Final Summary
SELECT 
    '✅ COURSE STRUCTURE SUMMARY' as "Status",
    'Your course catalog is well-organized with clear categories and learning paths' as "Description",
    'Ready for student enrollment and future expansion' as "Next Steps";