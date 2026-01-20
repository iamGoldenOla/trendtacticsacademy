
const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

async function checkCourses() {
    console.log('Searching for Facebook courses...');

    const { data: courses, error } = await supabase
        .from('courses')
        .select(`
            id, 
            title, 
            description,
            modules:modules!modules_course_id_fkey (id, title)
        `)
        .ilike('title', '%Facebook%');

    if (error) {
        console.error('Error:', error);
        return;
    }

    if (!courses || courses.length === 0) {
        console.log('No Facebook courses found.');
        return;
    }

    courses.forEach(c => {
        // Handle count structure differences in supabase-js v2
        // It often returns array of objects for count if not using head:true?
        // Actually .select('modules(count)') returns something like modules: [ { count: 5 } ]
        // Let's print raw first or use a simpler query. 
        // We will just verify the IDs and titles.
        console.log(`\nID: ${c.id}`);
        console.log(`Title: ${c.title}`);
        console.log(`Description: ${c.description || 'N/A'}`);
        // For counts, let's just do separate specific checks if needed, but the object might have it.
        // Let's do a deeper fetch to be sure.
    });

    // Detailed check with modules
    for (const c of courses) {
        const { count: modCount } = await supabase.from('modules').select('id', { count: 'exact', head: true }).eq('course_id', c.id);
        console.log(`  -> Modules: ${modCount}`);
    }
}

checkCourses();
