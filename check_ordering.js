
const { createClient } = require('@supabase/supabase-js');
const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
const ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(SUPABASE_URL, ANON_KEY);

async function check() {
    const mid = '1cd9e719-f05f-436b-b52a-fb6d6c958b7d';
    console.log(`Checking lessons for module ${mid}...`);

    const { data: lessons, error } = await supabase.from('lessons')
        .select('id, title, ordering')
        .eq('module_id', mid)
        .order('ordering');

    if (error) console.error(error);
    else {
        lessons.forEach(l => console.log(`${l.ordering}: ${l.title}`));
    }
}
check();
