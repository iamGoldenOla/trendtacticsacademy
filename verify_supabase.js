
const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

async function verifyTables() {
    console.log('Verifying Supabase Tables...');

    // Check Modules
    const { data: modules, error: modulesError } = await supabase
        .from('modules')
        .select('id')
        .limit(1);

    if (modulesError) {
        console.error('❌ Error accessing "modules" table:');
        console.error(modulesError);
    } else {
        console.log('✅ "modules" table is accessible.');
    }

    // Check Lessons
    const { data: lessons, error: lessonsError } = await supabase
        .from('lessons')
        .select('id')
        .limit(1);

    if (lessonsError) {
        console.error('❌ Error accessing "lessons" table:');
        console.error(lessonsError);
    } else {
        console.log('✅ "lessons" table is accessible.');
    }
}

verifyTables();
