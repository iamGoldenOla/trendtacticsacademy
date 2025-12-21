const { createClient } = require('@supabase/supabase-js');

// Supabase credentials
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function checkSchema() {
  console.log('🔍 Checking database schema...');
  
  try {
    // Check courses table structure
    const { data: coursesColumns, error: coursesError } = await supabase
      .from('courses')
      .select(`
        *,
        modules!modules_course_id_fkey (
          id,
          title,
          description,
          ordering,
          duration,
          lessons!lessons_module_id_fkey (
            id,
            title,
            ordering,
            duration
          )
        )
      `)
      .limit(1);
    
    if (coursesError) {
      console.error('Error fetching courses:', coursesError.message);
      return;
    }
    
    console.log('✅ Successfully connected to database');
    console.log('📋 Sample course data structure:');
    console.log(JSON.stringify(coursesColumns[0], null, 2));
    
    // Check if Vibe Coding course exists
    const { data: vibeCoding, error: vibeError } = await supabase
      .from('courses')
      .select('*')
      .eq('id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890')
      .single();
    
    if (vibeError) {
      console.error('Error fetching Vibe Coding course:', vibeError.message);
    } else {
      console.log('\n🎯 Vibe Coding course found:');
      console.log(`   Title: ${vibeCoding.title}`);
      console.log(`   Published: ${vibeCoding.is_published}`);
      console.log(`   Category: ${vibeCoding.category || 'None'}`);
      console.log(`   Level: ${vibeCoding.level || 'None'}`);
    }
    
  } catch (error) {
    console.error('Unexpected error:', error.message);
  }
}

checkSchema();