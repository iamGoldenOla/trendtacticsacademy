/**
 * Test script to verify course fetching functionality
 */

console.log('🔍 Testing Course Fetching\n');
console.log('========================\n');

// Test the course service
async function testCourseService() {
  try {
    console.log('📦 Loading course service...');
    
    // Dynamically import the course service
    const { default: courseService } = await import('./lms-frontend/src/services/courseService.js');
    
    console.log('✅ Course service loaded successfully\n');
    
    console.log('📚 Testing getAllCourses()...');
    
    // Test fetching all courses
    const courses = await courseService.getAllCourses();
    
    console.log('✅ getAllCourses() executed successfully');
    console.log(`📊 Found ${courses.length} courses`);
    
    if (courses.length > 0) {
      console.log('\n📋 First course details:');
      console.log(`   Title: ${courses[0].title}`);
      console.log(`   ID: ${courses[0].id}`);
      console.log(`   Published: ${courses[0].is_published}`);
    }
    
    console.log('\n🎉 All tests passed!');
    console.log('✅ Course service is working correctly');
    
  } catch (error) {
    console.error('❌ Test failed with error:');
    console.error(error);
    
    console.log('\n🔧 Troubleshooting steps:');
    console.log('1. Check Supabase credentials in .env file');
    console.log('2. Verify Supabase database has courses with is_published = true');
    console.log('3. Check network connectivity to Supabase');
    console.log('4. Verify Supabase table structure matches expected schema');
  }
}

// Run the test
testCourseService();