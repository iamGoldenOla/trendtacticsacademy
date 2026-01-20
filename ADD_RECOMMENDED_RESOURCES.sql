-- ============================================================================
-- ADD RECOMMENDED RESOURCES LESSON
-- ============================================================================
-- Adds a final lesson to Module 6: "Recommended Resources & Path Forward"
-- Populates it with the curated list of external videos.
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
    m6_id UUID;
BEGIN
    -- Get Module 6 ID
    SELECT id INTO m6_id FROM modules WHERE course_id = cid AND title LIKE 'Module 6%';

    -- Insert the new lesson (Ordering 4, right after "Final Projects")
    INSERT INTO lessons (module_id, course_id, title, ordering, video_url, content, key_takeaways)
    VALUES (
        m6_id, 
        cid, 
        'Recommended Resources & Further Learning', 
        4, 
        'https://www.youtube.com/watch?v=bJX5t9L5Wyk', -- Placeholder (Prompt Engineering Roadmap video)
        '# Recommended Resources & Further Learning

## 1. Overview
Your journey doesn''t end here. The field of AI is moving at breakneck speed. To stay ahead, we have curated a list of the best external resources, tutorials, and deep dives. These range from 20-minute summaries to full 9-hour courses.

## 2. Curated Video Library

### Fundamentals & Quick Starts
| Resource | Description | Link |
| :--- | :--- | :--- |
| **Google''s 9 Hour AI Prompt Engineering Course in 20 Minutes** | A concise overview of fundamentals, multimodal prompting, and advanced techniques. | [Watch on YouTube](https://www.youtube.com/results?search_query=Google%27s+9+Hour+AI+Prompt+Engineering+Course+in+20+Minutes) |
| **Master Prompt Engineering for Beginners! (7 Essential Tips)** | Practical strategies like defining SMART goals, creating roles, and formatting outputs. | [Watch on YouTube](https://www.youtube.com/results?search_query=Master+Prompt+Engineering+for+Beginners+7+Essential+Tips) |
| **Prompt Engineering for Beginners (Tutorial Series)** | Step-by-step introduction to using OpenAI APIs, syntax, tokens, and playground demos. | [Watch on YouTube](https://www.youtube.com/results?search_query=Prompt+Engineering+for+Beginners+Tutorial+Series) |

### Advanced Techniques & Deep Dives
| Resource | Description | Link |
| :--- | :--- | :--- |
| **Prompt Engineering Guide – From Beginner to Advanced** | Explains sampling controls, contextual prompting, tree of thoughts, and automatic prompt engineering. | [Watch on YouTube](https://www.youtube.com/results?search_query=Prompt+Engineering+Guide+Beginner+to+Advanced) |
| **AI Prompt Engineering: A Deep Dive (Anthropic Experts)** | Discusses refining prompts, personas, metaphors, and enterprise use cases. | [Watch on YouTube](https://www.youtube.com/results?search_query=AI+Prompt+Engineering+Anthropic+Experts) |
| **Prompt Engineering Tutorial – Master ChatGPT and LLMs** | Covers best practices, zero-shot/few-shot prompts, and handling hallucinations. | [Watch on YouTube](https://www.youtube.com/results?search_query=Prompt+Engineering+Tutorial+Master+ChatGPT) |

### Comprehensive Courses
| Resource | Description | Link |
| :--- | :--- | :--- |
| **Prompt Engineering 2025 Full Course** | A comprehensive course including components of good prompts, common errors, and hands-on examples. | [Watch on YouTube](https://www.youtube.com/results?search_query=Prompt+Engineering+2025+Full+Course) |
| **Prompt Engineering Full Course 2026 | Generative AI** | A long-form course with practical examples, system instructions, and advanced applications. | [Watch on YouTube](https://www.youtube.com/results?search_query=Prompt+Engineering+Full+Course+2026) |

## 3. How to Use These Resources
*   **Weekly Audits:** Pick one "Deep Dive" video per week to dissect.
*   **Implementation:** Don''t just watch; open the Playground and try to replicate the techniques shown.
*   **Cross-Reference:** Compare techniques from Google vs Anthropic. Different models respond to different prompt structures.

## 4. Summary
Keep learning. The standard for "Good Prompting" changes every 6 months. These resources will help you maintain your edge.
',
        '["Continuous learning is non-negotiable in AI.", "Diverse perspectives (Google vs Anthropic) refine your skills.", "Apply what you watch immediately in the Playground."]'::jsonb
    );

END $$;
