// Test script to verify course service is working
const { createClient } = require('@supabase/supabase-js');

// Use the same Supabase configuration as in the frontend
require('dotenv').config();
const supabaseUrl = process.env.SUPABASE_URL || 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY;
if (!supabaseAnonKey) {
  console.error('Missing SUPABASE_ANON_KEY. Set in environment (.env) and never hardcode.');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function testCourseService() {
  console.log('🔍 Testing course service...');
  
  try {
    // Test connection to Supabase
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
    
    // Test fetching published courses
    console.log('\n2. Fetching published courses...');
    const { data: courses, error: courseError } = await supabase
      .from('courses')
      .select('*')
      .eq('is_published', true)
      .limit(5);
    
    if (courseError) {
      console.error('❌ Failed to fetch courses:', courseError.message);
      return;
    }
    
    console.log(`✅ Successfully fetched ${courses.length} published courses`);
    
    if (courses.length > 0) {
      console.log('\nSample courses:');
      courses.forEach(course => {
        console.log(`  - ${course.title} (${course.category}) - Published: ${course.is_published}`);
      });
    } else {
      console.log('⚠️  No published courses found');
    }
    
    // Test fetching all courses (including drafts)
    console.log('\n3. Fetching all courses (published and drafts)...');
    const { data: allCourses, error: allCoursesError } = await supabase
      .from('courses')
      .select('*')
      .limit(10);
    
    if (allCoursesError) {
      console.error('❌ Failed to fetch all courses:', allCoursesError.message);
      return;
    }
    
    console.log(`✅ Successfully fetched ${allCourses.length} total courses`);
    
    const publishedCount = allCourses.filter(c => c.is_published).length;
    const draftCount = allCourses.filter(c => !c.is_published).length;
    
    console.log(`  - Published courses: ${publishedCount}`);
    console.log(`  - Draft courses: ${draftCount}`);
    
  } catch (error) {
    console.error('💥 Unexpected error during testing:', error.message);
    console.error(error.stack);
  }
}

testCourseService();