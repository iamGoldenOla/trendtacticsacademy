const { createClient } = require('@supabase/supabase-js');

// Use the same configuration as the frontend
require('dotenv').config();
const supabaseUrl = process.env.SUPABASE_URL || 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY;
if (!supabaseAnonKey) {
  console.error('Missing SUPABASE_ANON_KEY. Set in environment (.env) and never hardcode.');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function testSupabaseConnection() {
  console.log('🔍 Testing Supabase connection...\n');
  
  try {
    // Test 1: Simple connection test
    console.log('1. Testing basic connection...');
    const { data, error } = await supabase
      .from('courses')
      .select('id, title')
      .limit(1);

    if (error) {
      console.error('❌ Connection test failed:', error.message);
      return;
    }

    console.log('✅ Connection successful!');
    console.log(`📊 Found ${data.length} courses in database`);
    
    if (data.length > 0) {
      console.log(`📚 Sample course: ${data[0].title}`);
    }
    
    // Test 2: Check for published courses
    console.log('\n2. Checking for published courses...');
    const { data: publishedCourses, error: publishedError } = await supabase
      .from('courses')
      .select('id, title, is_published')
      .eq('is_published', true)
      .limit(5);

    if (publishedError) {
      console.error('❌ Published courses query failed:', publishedError.message);
      return;
    }

    console.log(`✅ Found ${publishedCourses.length} published courses`);
    
    if (publishedCourses.length > 0) {
      console.log('📋 Published courses:');
      publishedCourses.forEach(course => {
        console.log(`   - ${course.title}`);
      });
    } else {
      console.log('⚠️  No published courses found');
    }
    
    // Test 3: Check course structure with relationships
    console.log('\n3. Testing course structure with relationships...');
    const { data: courseWithRelations, error: relationsError } = await supabase
      .from('courses')
      .select(`
        id,
        title,
        modules!fk_modules_course_id (
          id,
          title,
          lessons!fk_lessons_module_id (
            id,
            title
          )
        )
      `)
      .eq('is_published', true)
      .limit(1);

    if (relationsError) {
      console.error('❌ Course relationships query failed:', relationsError.message);
      console.log('💡 This might indicate missing foreign key constraints or RLS policies');
      return;
    }

    console.log('✅ Course relationships query successful!');
    
    if (courseWithRelations.length > 0) {
      const course = courseWithRelations[0];
      console.log(`📚 Course: ${course.title}`);
      console.log(`📂 Modules: ${course.modules ? course.modules.length : 0}`);
      
      if (course.modules && course.modules.length > 0) {
        const module = course.modules[0];
        console.log(`   📖 First module: ${module.title}`);
        console.log(`   📝 Lessons: ${module.lessons ? module.lessons.length : 0}`);
      }
    }
    
    console.log('\n🎉 All tests completed successfully!');
    console.log('If these tests pass, the issue is likely with the CSP configuration on the deployed site.');
    
  } catch (error) {
    console.error('💥 Unexpected error during testing:', error.message);
  }
}

testSupabaseConnection();