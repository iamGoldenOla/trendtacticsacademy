// Debug script to check course loading issues
const { createClient } = require('@supabase/supabase-js');

// Use your actual Supabase credentials
const supabaseUrl = process.env.SUPABASE_URL || 'YOUR_SUPABASE_PROJECT_URL';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || 'YOUR_SERVICE_ROLE_KEY';

if (!supabaseUrl || !supabaseKey) {
  console.error('Missing Supabase credentials. Please set SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY environment variables.');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function debugCourses() {
  console.log('🔍 Debugging course loading...');
  
  try {
    // Check if we can connect to Supabase
    console.log('1. Testing Supabase connection...');
    const { data: healthCheck, error: healthError } = await supabase
      .from('courses')
      .select('count()', { count: 'exact' })
      .limit(1);
    
    if (healthError) {
      console.error('❌ Connection failed:', healthError.message);
      return;
    }
    console.log('✅ Supabase connection successful');
    
    // Check courses table structure
    console.log('\n2. Checking courses table structure...');
    const { data: tableInfo, error: tableError } = await supabase
      .from('courses')
      .select('*')
      .limit(1);
    
    if (tableError) {
      console.error('❌ Failed to query courses table:', tableError.message);
      return;
    }
    
    if (tableInfo && tableInfo.length > 0) {
      console.log('✅ Courses table accessible');
      console.log('Sample record structure:');
      Object.keys(tableInfo[0]).forEach(key => {
        console.log(`  - ${key}: ${typeof tableInfo[0][key]} = ${JSON.stringify(tableInfo[0][key]).substring(0, 50)}${JSON.stringify(tableInfo[0][key]).length > 50 ? '...' : ''}`);
      });
    } else {
      console.log('⚠️  Courses table is empty');
    }
    
    // Check published courses specifically
    console.log('\n3. Checking published courses...');
    const { data: publishedCourses, error: publishedError } = await supabase
      .from('courses')
      .select('*')
      .eq('is_published', true);
    
    if (publishedError) {
      console.error('❌ Failed to query published courses:', publishedError.message);
      return;
    }
    
    console.log(`✅ Found ${publishedCourses.length} published courses`);
    
    if (publishedCourses.length > 0) {
      console.log('\nPublished courses:');
      publishedCourses.forEach(course => {
        console.log(`  - ${course.title} (${course.category}) - Published: ${course.is_published}`);
      });
    }
    
    // Check for any constraints or issues
    console.log('\n4. Checking for common issues...');
    
    // Check if there are courses with null is_published
    const { data: nullPublished, error: nullError } = await supabase
      .from('courses')
      .select('title, is_published')
      .is('is_published', null);
    
    if (nullError) {
      console.error('❌ Failed to check for null is_published values:', nullError.message);
    } else if (nullPublished.length > 0) {
      console.log(`⚠️  Found ${nullPublished.length} courses with null is_published:`);
      nullPublished.forEach(course => {
        console.log(`  - ${course.title}`);
      });
    } else {
      console.log('✅ No courses with null is_published values');
    }
    
  } catch (error) {
    console.error('💥 Unexpected error during debugging:', error.message);
    console.error(error.stack);
  }
}

debugCourses();