
const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NTQ1NjAzOSwiZXhwIjoyMDgxMDMyMDM5fQ.8JUqFTmYJwvV1aVY7Z0FgkR9j5F0pYv3zQ0mX2yZ5c0';

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

async function deleteCourse() {
    const COURSE_ID = '123e4567-e89b-12d3-a456-426614174002';
    console.log(`Deleting empty course: ${COURSE_ID}`);

    const { error } = await supabase
        .from('courses')
        .delete()
        .eq('id', COURSE_ID);

    if (error) {
        console.error('Error deleting course:', error);
    } else {
        console.log('Successfully deleted course.');
    }
}

deleteCourse();
