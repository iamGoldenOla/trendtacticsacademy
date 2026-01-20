-- ==========================================
-- ADD MERMAID DIAGRAMS TO LESSONS
-- Automatically adds relevant diagrams to lessons
-- ==========================================

-- Example 1: Add Learning Process Diagram to Module 1 Lessons
DO $$
DECLARE
    lesson_record RECORD;
BEGIN
    -- Add diagram to first lesson of each course
    FOR lesson_record IN 
        SELECT DISTINCT ON (c.id) l.id, l.title, c.title as course_title
        FROM lessons l
        JOIN modules m ON l.module_id = m.id
        JOIN courses c ON m.course_id = c.id
        WHERE l.ordering = 1 AND m.ordering = 1
        ORDER BY c.id, m.ordering, l.ordering
    LOOP
        -- Add a welcome/learning process diagram
        UPDATE lessons
        SET content = content || '

<h3>📊 Your Learning Journey</h3>
<div class="mermaid">
graph LR
    A[📺 Watch Video] --> B[📖 Read Content]
    B --> C[✅ Take Quiz]
    C --> D[💪 Practice]
    D --> E[🎓 Master Skill]
    style A fill:#00D9FF,stroke:#fff,color:#000
    style E fill:#4ADE80,stroke:#fff,color:#000
</div>
'
        WHERE id = lesson_record.id;
        
        RAISE NOTICE 'Added diagram to: % - %', lesson_record.course_title, lesson_record.title;
    END LOOP;
END $$;

-- Example 2: Add Workflow Diagram to Vibe Coding Lessons
UPDATE lessons
SET content = content || '

<h3>🔄 Vibe Coding Workflow</h3>
<div class="mermaid">
graph TD
    A[Define Intent] --> B[AI Generates Code]
    B --> C{Test Result}
    C -->|Works| D[Deploy]
    C -->|Issues| E[Refine Prompt]
    E --> B
    style A fill:#00D9FF,stroke:#fff,color:#000
    style D fill:#4ADE80,stroke:#fff,color:#000
</div>
'
WHERE title LIKE '%Vibe Coding Loop%'
AND EXISTS (
    SELECT 1 FROM modules m 
    JOIN courses c ON m.course_id = c.id
    WHERE m.id = lessons.module_id 
    AND c.title LIKE '%Vibe%'
);

-- Example 3: Add Facebook Ads Funnel Diagram
UPDATE lessons
SET content = content || '

<h3>📈 Facebook Ads Funnel</h3>
<div class="mermaid">
graph TD
    A[Awareness] --> B[Interest]
    B --> C[Consideration]
    C --> D[Conversion]
    D --> E[Retention]
    style A fill:#00D9FF,stroke:#fff,color:#000
    style D fill:#4ADE80,stroke:#fff,color:#000
    style E fill:#FFD700,stroke:#000,color:#000
</div>
'
WHERE title LIKE '%Funnel%' OR title LIKE '%Campaign%'
AND EXISTS (
    SELECT 1 FROM modules m 
    JOIN courses c ON m.course_id = c.id
    WHERE m.id = lessons.module_id 
    AND c.title LIKE '%Facebook%'
);

-- Example 4: Add Prompt Engineering Process
UPDATE lessons
SET content = content || '

<h3>🎯 Prompt Engineering Process</h3>
<div class="mermaid">
sequenceDiagram
    participant You
    participant AI
    participant Result
    You->>AI: Write Prompt
    AI->>Result: Generate Output
    Result->>You: Review Quality
    You->>AI: Refine Prompt
    AI->>Result: Improved Output
</div>
'
WHERE (title LIKE '%Prompt%' OR title LIKE '%Engineering%')
AND EXISTS (
    SELECT 1 FROM modules m 
    JOIN courses c ON m.course_id = c.id
    WHERE m.id = lessons.module_id 
    AND c.title LIKE '%Prompt%Engineering%'
)
AND id IN (
    SELECT l.id FROM lessons l
    JOIN modules m ON l.module_id = m.id
    JOIN courses c ON m.course_id = c.id
    WHERE (l.title LIKE '%Prompt%' OR l.title LIKE '%Engineering%')
    AND c.title LIKE '%Prompt%Engineering%'
    ORDER BY m.ordering, l.ordering
    LIMIT 5
);

-- Example 5: Add Time Distribution Pie Chart
UPDATE lessons
SET content = content || '

<h3>⏱️ Recommended Learning Time</h3>
<div class="mermaid">
pie title Time Distribution
    "Watch Videos" : 30
    "Read Content" : 25
    "Practice" : 30
    "Take Quizzes" : 15
</div>
'
WHERE (title LIKE '%Getting Started%' OR title LIKE '%Introduction%')
AND id IN (
    SELECT id FROM lessons
    WHERE title LIKE '%Getting Started%' OR title LIKE '%Introduction%'
    ORDER BY id
    LIMIT 10
);

-- Verification Query
SELECT 
    c.title as course,
    l.title as lesson,
    CASE 
        WHEN l.content LIKE '%<div class="mermaid">%' THEN '✅ Has Diagram'
        ELSE '❌ No Diagram'
    END as diagram_status
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE l.content LIKE '%<div class="mermaid">%'
ORDER BY c.title, m.ordering, l.ordering;
