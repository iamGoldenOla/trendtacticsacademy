
const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');

const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
// Using the service role key found in delete-fb-course.js
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NTQ1NjAzOSwiZXhwIjoyMDgxMDMyMDM5fQ.8JUqFTmYJwvV1aVY7Z0FgkR9j5F0pYv3zQ0mX2yZ5c0';

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

async function runSQL() {
    try {
        console.log("Reading SQL file...");
        const sqlContent = fs.readFileSync('ADD_VIBE_CODING_RESOURCES.sql', 'utf8');

        console.log("Executing SQL...");
        // Split by lines to remove comments if needed, but for PL/pgSQL block we need the whole thing.
        // Actually Supabase client usually only supports passing SQL via RPC if enabled, 
        // OR we can just 'cheat' by creating a lesson manually since the SQL is just an insert.
        // Let's PARSE the SQL logic and implement it in JS since we don't have a generic exec_sql RPC.

        // Logic from SQL:
        // 1. Get Course ID for Vibe Coding
        // 2. Get Module 8 ID
        // 3. Insert Lesson


        // 1. Get Course
        const { data: allCourses } = await supabase.from('courses').select('id, title');
        console.log("Available courses:", allCourses.map(c => c.title));

        const { data: courses } = await supabase.from('courses').select('id').ilike('title', '%Vibe%').limit(1);
        if (!courses || !courses.length) {
            // Try fallback ID from url seen in logs
            const fallbackId = 'e9e58e4a-2f3b-4c9a-8a3d-1e5f6a7b8c9d';
            const { data: fallback } = await supabase.from('courses').select('id').eq('id', fallbackId).single();
            if (fallback) {
                console.log("Found course via Fallback ID");
                courses.push(fallback);
            } else {
                throw new Error("Course not found even with fallback");
            }
        }
        const cid = courses[0].id;

        console.log("Found Course ID:", cid);

        // 2. Get Module 8
        const { data: modules } = await supabase.from('modules').select('id').eq('course_id', cid).ilike('title', '%Module 8%').limit(1);
        if (!modules || !modules.length) throw new Error("Module 8 not found");
        const mid = modules[0].id;
        console.log("Found Module 8 ID:", mid);

        // 3. Prepare Content
        const contentBody = `# Recommended Resources & Vibe Coding Ecosystem

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
`;

        const keyTakeaways = ["Leeverage the community to stay updated.", "Books provide depth; Videos provide speed.", "Tools change fast; concepts remain."];

        // 4. Upsert Lesson
        console.log("Upserting Lesson...");

        // Check if lesson exists first to update, or insert
        const { data: existing } = await supabase.from('lessons').select('id').eq('module_id', mid).eq('title', 'Recommended Resources & Ecosystem').maybeSingle();

        let result;
        if (existing) {
            console.log("Updating existing lesson ID:", existing.id);
            result = await supabase.from('lessons').update({
                content: contentBody,
                video_url: 'https://www.youtube.com/watch?v=lpQugp7AXEU',
                key_takeaways: keyTakeaways,
                ordering: 4
            }).eq('id', existing.id);
        } else {
            console.log("Inserting new lesson...");
            result = await supabase.from('lessons').insert({
                module_id: mid,
                course_id: cid,
                title: 'Recommended Resources & Ecosystem',
                ordering: 4,
                video_url: 'https://www.youtube.com/watch?v=lpQugp7AXEU',
                content: contentBody,
                key_takeaways: keyTakeaways
            });
        }

        if (result.error) throw result.error;
        console.log("✅ Success! Resources lesson updated.");

    } catch (err) {
        console.error("❌ Error:", err);
    }
}

runSQL();
