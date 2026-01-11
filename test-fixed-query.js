import { createClient } from '@supabase/supabase-js';

// Initialize Supabase client
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function testFixedQuery() {
  try {
    console.log('Testing FIXED course service query...');
    
    // Test the FIXED query with the explicit relationship
    const { data, error } = await supabase
      .from('courses')
      .select(`
        *,
        modules!modules_course_id_fkey (
          id,
          title,
          description,
          ordering,
          duration,
          lessons (
            id,
            title,
            ordering,
            duration
          )
        )
      `)
      .eq('is_published', true)
      .eq('id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890') // Only fetch Vibe Coding course
      .order('created_at', { ascending: false });

    if (error) {
      console.error('❌ Supabase query error:', error);
      return;
    }
    
    console.log('✅ Query successful!');
    console.log('Data received:', JSON.stringify(data, null, 2));
    console.log('Number of courses:', data ? data.length : 0);
    
    if (data && data.length > 0) {
      console.log('\nCourse details:');
      console.log('- ID:', data[0].id);
      console.log('- Title:', data[0].title);
      console.log('- Modules count:', data[0].modules ? data[0].modules.length : 0);
      
      if (data[0].modules && data[0].modules.length > 0) {
        console.log('\nFirst module details:');
        console.log('  - Title:', data[0].modules[0].title);
        console.log('  - Lessons count:', data[0].modules[0].lessons ? data[0].modules[0].lessons.length : 0);
      }
    } else {
      console.log('⚠️ No courses found');
    }

  } catch (err) {
    console.error('💥 Unexpected error:', err);
  }
}

// Run the test
testFixedQuery();