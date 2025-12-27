import { createClient } from '@supabase/supabase-js';

<<<<<<< HEAD
// Initialize Supabase client
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';
=======
// Use the same Supabase configuration as in the frontend
require('dotenv').config();
const supabaseUrl = process.env.SUPABASE_URL || 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY;
if (!supabaseAnonKey) {
  console.error('Missing SUPABASE_ANON_KEY. Set in environment (.env) and never hardcode.');
  process.exit(1);
}
>>>>>>> 73219f9bdc90257c2cd625b139c3939bc21645a3

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function testCourseService() {
  try {
    console.log('Testing course service directly...');
    
    // Test the exact query used in courseService.getAllCourses()
    const { data, error } = await supabase
      .from('courses')
      .select(`
        *,
        modules (
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
      console.error('Supabase query error:', error);
      return;
    }
    
    console.log('Query successful!');
    console.log('Data received:', JSON.stringify(data, null, 2));
    console.log('Number of courses:', data ? data.length : 0);
    
    if (data && data.length > 0) {
      console.log('First course details:');
      console.log('- ID:', data[0].id);
      console.log('- Title:', data[0].title);
      console.log('- Modules count:', data[0].modules ? data[0].modules.length : 0);
    }

  } catch (err) {
    console.error('Unexpected error:', err);
  }
}

// Run the test
testCourseService();