-- Comprehensive Course Roadmap for Trendtactics Academy
-- Showing learning pathways and course relationships

-- 1. FOUNDATION COURSES (Entry Point for All Students)
WITH foundation_courses AS (
    SELECT 
        title as course_title,
        category,
        level,
        duration,
        '🌱 FOUNDATION' as learning_stage,
        1 as stage_order
    FROM courses 
    WHERE level = 'beginner' AND is_published = true
),

-- 2. SKILL BUILDING COURSES (Intermediate Development)
skill_courses AS (
    SELECT 
        title as course_title,
        category,
        level,
        duration,
        '🔨 SKILL BUILDING' as learning_stage,
        2 as stage_order
    FROM courses 
    WHERE level = 'intermediate' AND is_published = true
),

-- 3. ADVANCED SPECIALIZATION (Expert Level)
advanced_courses AS (
    SELECT 
        title as course_title,
        category,
        level,
        duration,
        '🚀 ADVANCED SPECIALIZATION' as learning_stage,
        3 as stage_order
    FROM courses 
    WHERE level = 'advanced' AND is_published = true
),

-- 4. FUTURE OPPORTUNITIES (Planned Expansions)
future_courses AS (
    SELECT 
        'Artificial Intelligence for Developers' as course_title,
        'Software Development' as category,
        'advanced' as level,
        '12 weeks' as duration,
        '🔮 FUTURE OPPORTUNITIES' as learning_stage,
        4 as stage_order
    UNION ALL
    SELECT 
        'Business Intelligence & Analytics' as course_title,
        'Data Science' as category,
        'intermediate' as level,
        '8 weeks' as duration,
        '🔮 FUTURE OPPORTUNITIES' as learning_stage,
        4 as stage_order
)

-- Combine all stages into a complete learning roadmap
SELECT 
    learning_stage as "Learning Stage",
    course_title as "Course Title",
    category as "Category",
    level as "Level",
    duration as "Duration"
FROM (
    SELECT * FROM foundation_courses
    UNION ALL
    SELECT * FROM skill_courses
    UNION ALL
    SELECT * FROM advanced_courses
    UNION ALL
    SELECT * FROM future_courses
) roadmap
ORDER BY stage_order, category, 
    CASE level 
        WHEN 'beginner' THEN 1
        WHEN 'intermediate' THEN 2
        WHEN 'advanced' THEN 3
        ELSE 4
    END;

-- 2. SPECIALIZATION PATHWAYS
-- Web Development Career Path
SELECT 
    '🌐 WEB DEVELOPMENT CAREER PATH' as "Pathway",
    title as "Course",
    level as "Level",
    duration as "Time Investment",
    'Sequential Learning' as "Progression Type"
FROM courses 
WHERE category = 'Software Development' 
    AND title LIKE '%Web%'
ORDER BY 
    CASE level 
        WHEN 'beginner' THEN 1
        WHEN 'intermediate' THEN 2
        WHEN 'advanced' THEN 3
        ELSE 4
    END;

-- Mobile Development Career Path
SELECT 
    '📱 MOBILE DEVELOPMENT CAREER PATH' as "Pathway",
    title as "Course",
    level as "Level",
    duration as "Time Investment",
    'Sequential Learning' as "Progression Type"
FROM courses 
WHERE category = 'Software Development' 
    AND title LIKE '%Mobile%' OR title LIKE '%App%'
ORDER BY 
    CASE level 
        WHEN 'beginner' THEN 1
        WHEN 'intermediate' THEN 2
        WHEN 'advanced' THEN 3
        ELSE 4
    END;

-- Digital Marketing Specialization Path
SELECT 
    '📈 DIGITAL MARKETING SPECIALIZATION PATH' as "Pathway",
    title as "Course",
    level as "Level",
    duration as "Time Investment",
    'Flexible Specialization' as "Progression Type"
FROM courses 
WHERE category = 'Digital Marketing'
ORDER BY title;

-- 3. CROSS-CATEGORY SKILL COMBINATIONS
-- Recommended combinations for students
SELECT 
    '🤝 RECOMMENDED SKILL COMBINATIONS' as "Combination Type",
    'Full Stack Web Development + Digital Marketing' as "Skills Combination",
    'Build marketing websites and understand business needs' as "Benefit",
    'High-demand freelance combination' as "Market Opportunity"
UNION ALL
SELECT 
    '🤝 RECOMMENDED SKILL COMBINATIONS' as "Combination Type",
    'Mobile App Development + Social Media Marketing' as "Skills Combination",
    'Create apps and market them effectively' as "Benefit",
    'Entrepreneur startup package' as "Market Opportunity"
UNION ALL
SELECT 
    '🤝 RECOMMENDED SKILL COMBINATIONS' as "Combination Type",
    'Content Creation + Web Development' as "Skills Combination",
    'Create beautiful, functional websites with great content' as "Benefit",
    'Premium agency-level skills' as "Market Opportunity";

-- 4. TIME INVESTMENT ANALYSIS
SELECT 
    '⏱️ TIME INVESTMENT BY CATEGORY' as "Analysis Type",
    category as "Category",
    COUNT(*) as "Number of Courses",
    SUM(
        CASE 
            WHEN duration LIKE '%week%' THEN 
                CAST(TRIM(LEADING ' ' FROM SPLIT_PART(duration, ' ', 1)) AS INTEGER)
            ELSE 0
        END
    ) as "Total Weeks",
    ROUND(
        AVG(
            CASE 
                WHEN duration LIKE '%week%' THEN 
                    CAST(TRIM(LEADING ' ' FROM SPLIT_PART(duration, ' ', 1)) AS INTEGER)
                ELSE 0
            END
        ), 1
    ) as "Avg Weeks Per Course"
FROM courses 
WHERE is_published = true
GROUP BY category
ORDER BY "Total Weeks" DESC;

-- 5. STUDENT PROGRESSION MILESTONES
SELECT 
    '🏆 STUDENT PROGRESSION MILESTONES' as "Milestone",
    'Complete 1 Foundation Course' as "Achievement",
    'Earn Beginner Certificate' as "Reward",
    '1-4 weeks' as "Time Frame"
UNION ALL
SELECT 
    '🏆 STUDENT PROGRESSION MILESTONES' as "Milestone",
    'Complete 3 Skill Building Courses' as "Achievement",
    'Earn Intermediate Certificate' as "Reward",
    '3-6 months' as "Time Frame"
UNION ALL
SELECT 
    '🏆 STUDENT PROGRESSION MILESTONES' as "Milestone",
    'Complete 2 Advanced Specializations' as "Achievement",
    'Earn Expert Certificate' as "Reward",
    '6-12 months' as "Time Frame"
UNION ALL
SELECT 
    '🏆 STUDENT PROGRESSION MILESTONES' as "Milestone",
    'Complete Full Learning Path' as "Achievement",
    'Earn Master Certification' as "Reward",
    '12-18 months' as "Time Frame";

-- 6. MARKET ALIGNMENT
SELECT 
    '💼 MARKET ALIGNMENT' as "Alignment Type",
    'Software Development Courses' as "Category",
    'High demand in tech industry' as "Market Need",
    'Competitive salaries and remote opportunities' as "Career Benefits"
UNION ALL
SELECT 
    '💼 MARKET ALIGNMENT' as "Alignment Type",
    'Digital Marketing Courses' as "Category",
    'Growing demand in all industries' as "Market Need",
    'Entrepreneurship and freelance opportunities' as "Career Benefits";

-- Final Roadmap Summary
SELECT 
    '✅ COMPLETE ROADMAP SUMMARY' as "Status",
    'Your course offerings provide comprehensive learning pathways' as "Summary",
    'Students can specialize or combine skills for maximum career impact' as "Outcome";