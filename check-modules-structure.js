// Script to check the structure of the modules table
const { createClient } = require('@supabase/supabase-js');

// Use your actual Supabase credentials
require('dotenv').config();
const supabaseUrl = process.env.SUPABASE_URL || 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseKey = process.env.SUPABASE_ANON_KEY;
if (!supabaseKey) {
  console.error('Missing SUPABASE_ANON_KEY. Set in environment (.env); do not hardcode.');
  process.exit(1);
}

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