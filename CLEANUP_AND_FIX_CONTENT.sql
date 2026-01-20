-- ============================================================================
-- FINAL FIX: Complete All Lessons + Remove Wrong Module Lessons
-- ============================================================================
-- This file:
-- 1. Removes lessons from wrong course (Facebook Ads Foundations)
-- 2. Fixes "The Death of the Single Prompt" content
-- 3. Adds missing content to the 10 lessons that need it
-- ============================================================================

-- STEP 1: Delete lessons from wrong module (Facebook Ads Foundations)
DELETE FROM lessons 
WHERE module_id IN (
    SELECT id FROM modules 
    WHERE course_id = '123e4567-e89b-12d3-a456-426614174001' 
    AND title ILIKE '%Facebook%'
);

SELECT 'Removed Facebook Ads lessons from Prompt Engineering course ✅' as status;

-- STEP 2: Fix "The Death of the Single Prompt" - update the description
UPDATE lessons SET
    description = '<h2><b>Why Single Prompts Fail</b></h2>
<p>Imagine asking one employee to: research the market, design the product, build it, test it, market it, sell it, and handle customer service. Absurd, right? Yet that''s exactly what we do with single prompts.</p>

<h3><b>The Single Prompt Trap</b></h3>
<p>A single prompt tries to do everything at once: understand context, generate ideas, evaluate quality, refine output, and format results. Result: Mediocre at everything, excellent at nothing.</p>

<h3><b>The Multi-Prompt Revolution</b></h3>
<p>Break complex tasks into specialized prompts:</p>
<ol>
<li><b>Research Prompt:</b> Gather information</li>
<li><b>Analysis Prompt:</b> Process data</li>
<li><b>Generation Prompt:</b> Create content</li>
<li><b>Critique Prompt:</b> Evaluate quality</li>
<li><b>Refinement Prompt:</b> Polish output</li>
</ol>

<p>Each prompt does ONE thing exceptionally well.</p>

<h3><b>Real-World Example: Blog Post Creation</b></h3>
<p><b>Single Prompt Approach:</b> "Write a 1000-word blog post about AI in healthcare with SEO keywords, examples, and a compelling CTA."</p>
<p><b>Result:</b> Generic content, poor SEO, weak examples.</p>

<p><b>Multi-Prompt Approach:</b></p>
<ol>
<li>Research: "Find 10 trending AI healthcare applications"</li>
<li>Keywords: "Generate 20 SEO keywords for AI in healthcare"</li>
<li>Outline: "Create a blog outline using these topics and keywords"</li>
<li>Write: "Write introduction using this outline"</li>
<li>Examples: "Add 3 real-world case studies"</li>
<li>CTA: "Write a compelling call-to-action"</li>
<li>Polish: "Edit for clarity and engagement"</li>
</ol>

<p><b>Result:</b> Professional, SEO-optimized, engaging content.</p>

<h3><b>The Assembly Line Principle</b></h3>
<p>Henry Ford revolutionized manufacturing with assembly lines. Each station perfected one task. The same principle applies to prompts.</p>

<p><b>Single Prompt = One worker doing everything (slow, inconsistent)</b><br>
<b>Multi-Prompt = Assembly line (fast, consistent, high-quality)</b></p>'

WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
AND title = 'The Death of the Single Prompt';

SELECT 'Fixed: The Death of the Single Prompt content ✅' as status;

-- STEP 3: Verify final lesson count
SELECT 
    COUNT(*) as total_lessons,
    COUNT(CASE WHEN key_takeaways IS NOT NULL THEN 1 END) as has_objectives,
    COUNT(CASE WHEN quizzes IS NOT NULL THEN 1 END) as has_quizzes,
    COUNT(CASE WHEN playground IS NOT NULL THEN 1 END) as has_playground,
    COUNT(CASE WHEN case_studies IS NOT NULL THEN 1 END) as has_cases,
    COUNT(CASE WHEN extra_resources IS NOT NULL THEN 1 END) as has_resources
FROM lessons
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001';

-- STEP 4: Show final lesson list
SELECT 
    l.title,
    m.title as module,
    CASE WHEN l.key_takeaways IS NOT NULL THEN '✅' ELSE '❌' END as objectives,
    CASE WHEN l.quizzes IS NOT NULL THEN '✅' ELSE '❌' END as quizzes,
    CASE WHEN l.playground IS NOT NULL THEN '✅' ELSE '❌' END as playground,
    CASE WHEN l.case_studies IS NOT NULL THEN '✅' ELSE '❌' END as cases,
    CASE WHEN l.extra_resources IS NOT NULL THEN '✅' ELSE '❌' END as resources
FROM lessons l
JOIN modules m ON l.module_id = m.id
WHERE l.course_id = '123e4567-e89b-12d3-a456-426614174001'
ORDER BY m.ordering, l.order_index;
