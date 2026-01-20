
const { createClient } = require('@supabase/supabase-js');
const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
const ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(SUPABASE_URL, ANON_KEY);

async function check() {
    const { data: courses } = await supabase.from('courses').select('id, title').ilike('title', '%Prompt%');
    const pe = courses[0];
    console.log(`Course: ${pe.title}`);

    const { data: modules } = await supabase.from('modules').select('id, title, ordering').eq('course_id', pe.id).order('ordering');

    modules.forEach(m => console.log(`${m.ordering}. ${m.title} (${m.id})`));
}
check();
