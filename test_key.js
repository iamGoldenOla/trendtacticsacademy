
const { createClient } = require('@supabase/supabase-js');
const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
const SERVICE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NTQ1NjAzOSwiZXhwIjoyMDgxMDMyMDM5fQ.8JUqFTmYJwvV1aVY7Z0FgkR9j5F0pYv3zQ0mX2yZ5c0';
const ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

async function test() {
    console.log("Testing ANON key...");
    const s1 = createClient(SUPABASE_URL, ANON_KEY);
    const { data: d1, error: e1 } = await s1.from('courses').select('id, title').limit(1);
    if (e1) console.error("ANON failed:", e1.message);
    else console.log("ANON success:", d1[0]?.title);

    console.log("Testing SERVICE key...");
    const s2 = createClient(SUPABASE_URL, SERVICE_KEY);
    const { data: d2, error: e2 } = await s2.from('courses').select('id, title').limit(1);
    if (e2) console.error("SERVICE failed:", e2.message);
    else console.log("SERVICE success:", d2[0]?.title);
}
test();
