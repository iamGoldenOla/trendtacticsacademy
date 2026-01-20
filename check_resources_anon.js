
const { createClient } = require('@supabase/supabase-js');
const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
const ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(SUPABASE_URL, ANON_KEY);

async function check() {

    console.log("Searching for Prompt Engineering course...");
    const { data: courses } = await supabase.from('courses').select('id, title').ilike('title', '%Prompt%');


    if (!courses || !courses.length) {
        console.log("No Vibe course found.");
        return;
    }

    const vibeCourse = courses[0];
    console.log(`Found Course: ${vibeCourse.title} (${vibeCourse.id})`);

    // Check for Module 8
    const { data: modules } = await supabase.from('modules').select('id, title').eq('course_id', vibeCourse.id).ilike('title', '%Module 8%');
    if (!modules || !modules.length) {
        console.log("Module 8 not found.");
        return;
    }
    const m8 = modules[0];
    console.log(`Found Module 8: ${m8.title} (${m8.id})`);

    // Check for Lesson
    const { data: lessons } = await supabase.from('lessons').select('id, title').eq('module_id', m8.id).ilike('title', '%Resources%');

    if (lessons && lessons.length) {
        console.log("✅ Resources Lesson FOUND:", lessons[0].title);
    } else {
        console.log("❌ Resources Lesson NOT found.");
    }
}
check();
