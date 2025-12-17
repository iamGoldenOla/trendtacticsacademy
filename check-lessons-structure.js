// Script to check the structure of the lessons table
const { createClient } = require('@supabase/supabase-js');

// Use your actual Supabase credentials
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkLessonsStructure() {
  console.log('🔍 Checking lessons table structure...');
  
  try {
    // Get one lesson to see its structure
    const { data, error } = await supabase
      .from('lessons')
      .select('*')
      .limit(1);
    
    if (error) {
      console.error('❌ Error fetching lesson:', error.message);
      return;
    }
    
    if (data && data.length > 0) {
      console.log('✅ Lesson structure:');
      const lesson = data[0];
      Object.keys(lesson).forEach(key => {
        console.log(`  - ${key}: ${typeof lesson[key]}`);
      });
    } else {
      console.log('⚠️  No lessons found in the database');
    }
  } catch (error) {
    console.error('💥 Unexpected error:', error.message);
  }
}

checkLessonsStructure();