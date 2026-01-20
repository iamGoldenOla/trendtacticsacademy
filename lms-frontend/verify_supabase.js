
const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

async function verifyTables() {
    console.log('Verifying Supabase Tables and Insert...');

    // 1. Check Modules Read
    const { data: modules, error: modulesError } = await supabase
        .from('modules')
        .select('id')
        .limit(1);

    if (modulesError) {
        console.error('❌ Error accessing "modules" table:', modulesError);
    } else {
        console.log('✅ "modules" table is accessible (READ).');
    }

    // 2. Try Dummy Insert to Modules
    // We will use a fake course_id, which might fail if FK constraint exists
    // But we want to see IF it returns JSON error or throws HTML error
    // To be safe, try to select a course first

    const { data: courses } = await supabase.from('courses').select('id').limit(1);
    const validCourseId = courses && courses.length > 0 ? courses[0].id : null;

    if (validCourseId) {
        console.log(`Attempting insert with course_id: ${validCourseId}`);
        const { data: inserted, error: insertError } = await supabase
            .from('modules')
            .insert([{
                course_id: validCourseId,
                title: 'TEST_MODULE_VERIFICATION',
                ordering: 999
            }])
            .select();

        if (insertError) {
            console.error('❌ Error inserting into "modules" table:');
            console.error(insertError);
        } else {
            console.log('✅ "modules" table is accessible (WRITE).');
            // Cleanup
            if (inserted && inserted.length > 0) {
                await supabase.from('modules').delete().eq('id', inserted[0].id);
                console.log('✅ Cleaned up test module.');
            }
        }
    } else {
        console.log('⚠️ No courses found to test module insert.');
    }
}

verifyTables();
