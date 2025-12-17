// Script to check the structure of the modules table
const { createClient } = require('@supabase/supabase-js');

// Use your actual Supabase credentials
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkModulesStructure() {
  console.log('🔍 Checking modules table structure...');
  
  try {
    // Get one module to see its structure
    const { data, error } = await supabase
      .from('modules')
      .select('*')
      .limit(1);
    
    if (error) {
      console.error('❌ Error fetching module:', error.message);
      return;
    }
    
    if (data && data.length > 0) {
      console.log('✅ Module structure:');
      const module = data[0];
      Object.keys(module).forEach(key => {
        console.log(`  - ${key}: ${typeof module[key]}`);
      });
    } else {
      console.log('⚠️  No modules found in the database');
    }
  } catch (error) {
    console.error('💥 Unexpected error:', error.message);
  }
}

checkModulesStructure();