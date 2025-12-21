// Comprehensive test to debug course loading issues
const { createClient } = require('@supabase/supabase-js');

// Use the same Supabase configuration as in the frontend
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function comprehensiveTest() {
  console.log('🔍 Starting comprehensive course service test...\n');
  
  try {
    // Test 1: Basic connection
    console.log('1. Testing basic Supabase connection...');
    const { data: healthCheck, error: healthError } = await supabase
      .from('courses')
      .select('*')
      .limit(1);
    
    if (healthError) {
      console.error('❌ Connection failed:', healthError.message);
      return;
    }
    console.log('✅ Supabase connection successful\n');
    
    // Test 2: Fetch all courses (without filtering)
    console.log('2. Fetching all courses (no filtering)...');
    const { data: allCourses, error: allCoursesError } = await supabase
      .from('courses')
      .select('*')
      .limit(5);
    
    if (allCoursesError) {
      console.error('❌ Failed to fetch all courses:', allCoursesError.message);
      return;
    }
    
    console.log(`✅ Successfully fetched ${allCourses.length} courses`);
    if (allCourses.length > 0) {
      console.log('Sample courses:');
      allCourses.forEach(course => {
        console.log(`  - ${course.title} (${course.id}) - Published: ${course.is_published}`);
      });
    }
    console.log('');
    
    // Test 3: Fetch published courses
    console.log('3. Fetching published courses...');
    const { data: publishedCourses, error: publishedError } = await supabase
      .from('courses')
      .select('*')
      .eq('is_published', true);
    
    if (publishedError) {
      console.error('❌ Failed to fetch published courses:', publishedError.message);
      return;
    }
    
    console.log(`✅ Successfully fetched ${publishedCourses.length} published courses`);
    if (publishedCourses.length > 0) {
      console.log('Published courses:');
      publishedCourses.forEach(course => {
        console.log(`  - ${course.title} (${course.id})`);
      });
    }
    console.log('');
    
    // Test 4: Fetch Vibe Coding course specifically
    console.log('4. Fetching Vibe Coding course specifically...');
    const vibeCodingId = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890';
    const { data: vibeCourse, error: vibeError } = await supabase
      .from('courses')
      .select('*')
      .eq('id', vibeCodingId)
      .single();
    
    if (vibeError) {
      console.error('❌ Failed to fetch Vibe Coding course:', vibeError.message);
    } else if (vibeCourse) {
      console.log('✅ Vibe Coding course found:');
      console.log(`  - ID: ${vibeCourse.id}`);
      console.log(`  - Title: ${vibeCourse.title}`);
      console.log(`  - Published: ${vibeCourse.is_published}`);
      console.log(`  - Created: ${vibeCourse.created_at}`);
    } else {
      console.log('⚠️ Vibe Coding course not found');
    }
    console.log('');
    
    // Test 5: Test the exact query used in courseService.getAllCourses()
    console.log('5. Testing exact courseService query with relationships...');
    const { data: serviceQueryData, error: serviceQueryError } = await supabase
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
      .eq('is_published', true)
      .eq('id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890') // Only fetch Vibe Coding course
      .order('created_at', { ascending: false });
    
    if (serviceQueryError) {
      console.error('❌ Service query failed:', serviceQueryError.message);
      console.error('Error details:', JSON.stringify(serviceQueryError, null, 2));
    } else {
      console.log('✅ Service query successful!');
      console.log(`  Number of courses returned: ${serviceQueryData ? serviceQueryData.length : 0}`);
      if (serviceQueryData && serviceQueryData.length > 0) {
        const course = serviceQueryData[0];
        console.log(`  Course title: ${course.title}`);
        console.log(`  Modules count: ${course.modules ? course.modules.length : 0}`);
        if (course.modules && course.modules.length > 0) {
          console.log('  First module:', course.modules[0].title);
          console.log(`  Lessons in first module: ${course.modules[0].lessons ? course.modules[0].lessons.length : 0}`);
        }
      }
    }
    console.log('');
    
    // Test 6: Check if there are any modules for the Vibe Coding course
    console.log('6. Checking modules for Vibe Coding course...');
    const { data: modulesData, error: modulesError } = await supabase
      .from('modules')
      .select('*')
      .eq('course_id', vibeCodingId)
      .order('ordering');
    
    if (modulesError) {
      console.error('❌ Failed to fetch modules:', modulesError.message);
    } else {
      console.log(`✅ Found ${modulesData.length} modules for Vibe Coding course`);
      if (modulesData.length > 0) {
        console.log('Modules:');
        modulesData.forEach(module => {
          console.log(`  - ${module.title} (Order: ${module.ordering})`);
        });
      }
    }
    console.log('');
    
  } catch (error) {
    console.error('💥 Unexpected error during testing:', error.message);
    console.error(error.stack);
  }
  
  console.log('🏁 Test completed');
}

// Run the test
comprehensiveTest();