// Script to check the structure of the lessons table
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