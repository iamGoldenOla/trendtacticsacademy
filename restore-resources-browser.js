
// ========================================================
// REPLACEMENT SCRIPT - LOADS SUPABASE MANUALLY
// ========================================================
(async () => {
    console.log("🚀 Starting Resource Fix (Self-Contained)...");

    // 1. DYNAMICALLY LOAD SUPABASE IF MISSING
    if (typeof supabase === 'undefined') {
        console.log("⚠️ Supabase library missing. Injecting CDN...");
        await new Promise((resolve, reject) => {
            const script = document.createElement('script');
            script.src = "https://unpkg.com/@supabase/supabase-js@2";
            script.onload = () => {
                console.log("✅ Supabase library loaded.");
                resolve();
            };
            script.onerror = (e) => {
                alert("Failed to load Supabase library.");
                reject(e);
            };
            document.head.appendChild(script);
        });
    }

    // 2. AUTH & SETUP
    // We use the ANON key but rely on the browser's active session cookie if it exists.
    // However, if the user Is logged in, the client needs to inherit that session?
    // Using createClient with just anon key might NOT pick up the session automatically unless we rely on local storage detection.
    // supabase-js auto-detects 'supabase.auth.token' in localStorage.

    const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
    const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

    const client = supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

    // 3. CONTENT
    const CONTENT = "# Recommended Resources & Ecosystem\n\n## Curated Library\n\n### 📚 Courses\n* [GeeksforGeeks Prompt Course](https://www.geeksforgeeks.org/blogs/best-prompt-engineering-courses/)\n* [Prompt-Engineer.com](https://prompt-engineer.com/top-10-resources-for-learning-prompt-engineering/)\n\n### 🛠️ Tools\n* [VibeCoding.app](https://vibecoding.app/)\n* [VibeCodingResources.net](https://vibecodingresources.net/)";
    const KEY_TAKEAWAYS = ["Leverage tools.", "Stay updated."];

    async function fix(title) {
        console.log(`Processing ${title}...`);

        // Find Course
        const { data: c } = await client.from('courses').select('id, title').ilike('title', `%${title}%`).single();
        if (!c) { console.log(`Course ${title} not found`); return; }

        // Find Last Module
        const { data: mods } = await client.from('modules').select('id').eq('course_id', c.id).order('ordering', { ascending: false });
        if (!mods || !mods.length) { console.log(`No modules for ${title}`); return; }
        const mid = mods[0].id; // Last module

        // Upsert Lesson (Check Title First)
        const { data: existing } = await client.from('lessons').select('id, ordering').eq('module_id', mid).eq('title', 'Recommended Resources & Ecosystem').maybeSingle();

        if (existing) {
            console.log(`✅ Updating existing ${title} resources...`);
            await client.from('lessons').update({
                content: CONTENT,
                video_url: 'https://www.youtube.com/watch?v=lpQugp7AXEU',
                key_takeaways: KEY_TAKEAWAYS
            }).eq('id', existing.id);
        } else {
            console.log(`➕ Inserting new ${title} resources at #99...`);
            await client.from('lessons').insert({
                module_id: mid,
                course_id: c.id,
                title: 'Recommended Resources & Ecosystem',
                ordering: 99,
                content: CONTENT,
                key_takeaways: KEY_TAKEAWAYS,
                video_url: 'https://www.youtube.com/watch?v=lpQugp7AXEU'
            });
        }
    }

    await fix("Vibe");
    await fix("Prompt");
    alert("✅ Resources Restored! Refreshing page in 3 seconds...");
    setTimeout(() => location.reload(), 3000);
})();
