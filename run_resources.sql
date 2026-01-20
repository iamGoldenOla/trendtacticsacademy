-- ============================================================================
-- ADD VIBE CODING RESOURCES LESSON
-- ============================================================================
-- Adds a final lesson to Module 8: "Recommended Resources & Ecosystem"
-- Populates it with the curated list of external tools, books, and courses.
-- ============================================================================

DO $$
DECLARE
    cid UUID;
    m8_id UUID;
    content_body TEXT;
BEGIN
    -- Get Vibe Coding Course ID
    SELECT id INTO cid FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1;
    
    -- Get Module 8 ID
    SELECT id INTO m8_id FROM modules WHERE course_id = cid AND title LIKE '%Module 8%' LIMIT 1;

    content_body := '# Recommended Resources & Vibe Coding Ecosystem

## 1. Overview
Vibe Coding is an emerging field. To master it, you need to stay plugged into the ecosystem of tools, courses, and thought leaders. Here is a curated list of the best resources for 2025-2026.

## 2. Curated Resource Library

### 📚 Courses & Guides
| Resource | Description | Link |
| :--- | :--- | :--- |
| **10 Best Prompt Engineering Courses (2025)** | A roundup of structured courses covering fundamentals and advanced techniques. | [GeeksforGeeks](https://www.geeksforgeeks.org/blogs/best-prompt-engineering-courses/) |
| **Top 10 Learning Resources** | Includes Anthropic’s Claude Prompting Guide and OpenAI’s rules. | [Prompt-Engineer.com](https://prompt-engineer.com/top-10-resources-for-learning-prompt-engineering/) |
| **11 Best Free AI Prompting Courses (2026)** | Beginner to advanced free courses for hands-on practice. | [KripeshAdwani.com](https://kripeshadwani.com/free-ai-prompting-courses/) |

### 📖 Books
| Resource | Description | Link |
| :--- | :--- | :--- |
| **7 Must-Read AI Books (2025)** | Covers practical strategies and advanced applications. | [Dev.to](https://dev.to/somadevtoo/7-must-read-ai-and-prompt-engineering-books-for-developers-in-2025) |
| **Top 15 Best Prompt Engineering Books** | A comprehensive list of books with unique perspectives. | [Analytics Vidhya](https://www.analyticsvidhya.com/blog/2024/04/top-best-prompt-engineering-books/) |
| **The 5 Best Prompt Books (2025)** | Focused on essential reads for mastering communication with AI. | [TheHumanPrompts](https://thehumanprompts.com/best-prompt-engineering-books/) |

### 🛠️ Tools & Ecosystem
| Resource | Description | Link |
| :--- | :--- | :--- |
| **Vibe Coding Resources Hub** | Curated collections of AI coding tools, editors, and assistants. | [VibeCodingResources.net](https://vibecodingresources.net/) |
| **Vibe Coding App Directory** | Directory of 64+ AI-powered development tools and IDEs. | [VibeCoding.app](https://vibecoding.app/) |
| **Top 10 Vibe Coding AI Tools** | Highlights standout tools transforming software development. | [Dev.to](https://dev.to/devland/top-10-vibe-coding-ai-tools-every-developer-needs-in-2025-29pf) |

### 🎥 YouTube Channels
*   **FREE AI Development Course:** [Watch Playlist](https://www.youtube.com/playlist?list=PLOfLYVXrwqXp07YjEBLcAEuqkesxvzoJT)
*   **21 Must-Subscribe AI Channels:** [Read List](https://dev.to/andrewbaisden/21-must-subscribe-ai-youtube-channels-for-learning-and-inspiration-12m3)
*   **AI Engineer Playlist:** [LinkedIn Guide](https://www.linkedin.com/pulse/must-watch-ai-engineer-youtube-playlist-akshay-sharma--47erc)

## 3. Key Considerations
*   **Stay Updated:** Prompt engineering evolves quickly; resources from 2025–2026 are most relevant.
*   **Balance Theory & Practice:** Books and courses give depth, but tools and YouTube demos show real-world workflows.
*   **Avoid Overloading:** Pick 1–2 resources per category to avoid overwhelm and focus on application.
';

    -- Insert Lesson (or Update if exists)
    INSERT INTO lessons (module_id, course_id, title, ordering, video_url, content, key_takeaways)
    VALUES (
        m8_id,
        cid,
        'Recommended Resources & Ecosystem',
        4, 
        'https://www.youtube.com/watch?v=lpQugp7AXEU', -- Placeholder Vibe Coding video
        content_body,
        '["Leeverage the community to stay updated.", "Books provide depth; Videos provide speed.", "Tools change fast; concepts remain."]'::jsonb
    );

END $$;
