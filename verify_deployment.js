// Script to verify that the deployment fixes are working
const { createClient } = require('@supabase/supabase-js');

// Use the same configuration as the frontend
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function verifyDeployment() {
  console.log('🔍 Verifying deployment fixes...\n');
  
  try {
    // Test 1: Check if we can fetch courses with the correct relationship syntax
    console.log('1. Testing course fetch with explicit foreign keys...');
    const { data: courses, error: coursesError } = await supabase
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

    if (coursesError) {
      console.error('❌ Error fetching courses with explicit foreign keys:', coursesError.message);
      console.log('💡 This indicates the fix may not be deployed yet.');
      return;
    }
    
    console.log(`✅ Successfully fetched course with explicit foreign keys`);
    if (courses.length > 0) {
      const course = courses[0];
      console.log(`   Course: ${course.title}`);
      console.log(`   Modules: ${course.modules ? course.modules.length : 0}`);
      if (course.modules && course.modules.length > 0) {
        const module = course.modules[0];
        console.log(`   First module: ${module.title}`);
        console.log(`   Lessons in first module: ${module.lessons ? module.lessons.length : 0}`);
      }
    }
    
    // Test 2: Simulate what the Home.js component does
    console.log('\n2. Simulating Home.js course fetch...');
    const { data: homeCourses, error: homeError } = await supabase
      .from('courses')
      .select(`
        *,
        modules!fk_modules_course_id (
          id,
          title,
          description,
          ordering,
          duration,
          lessons!fk_lessons_module_id (
            id,
            title,
            ordering,
            duration
          )
        )
      `)
      .eq('is_published', true)
      .order('created_at', { ascending: false });

    if (homeError) {
      console.error('❌ Error in Home.js simulation:', homeError.message);
      return;
    }
    
    console.log(`✅ Home.js simulation successful - ${homeCourses.length} courses fetched`);
    
    // Apply the same filtering as in Home.js
    const validCourses = homeCourses.filter(course => {
      return course.id && /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(course.id);
    });
    
    console.log(`✅ After UUID validation: ${validCourses.length} valid courses`);
    
    if (validCourses.length > 0) {
      console.log('✅ Homepage should now display courses correctly!');
    } else {
      console.log('⚠️  No valid courses found - check if courses have proper UUIDs');
    }
    
    // Test 3: Simulate CourseDetail.js with a real course ID
    if (validCourses.length > 0) {
      console.log('\n3. Simulating CourseDetail.js with real course ID...');
      const testCourseId = validCourses[0].id;
      
      const { data: courseDetail, error: detailError } = await supabase
        .from('courses')
        .select(`
          *,
          modules!fk_modules_course_id (
            id,
            title,
            description,
            ordering,
            duration,
            lessons!fk_lessons_module_id (
              id,
              title,
              ordering,
              duration
            )
          )
        `)
        .eq('id', testCourseId)
        .eq('is_published', true)
        .single();

      if (detailError) {
        console.error('❌ Error fetching course detail:', detailError.message);
      } else if (courseDetail) {
        console.log(`✅ Course detail fetch successful: ${courseDetail.title}`);
        console.log('✅ Course detail page should load correctly!');
      } else {
        console.log('❌ Course not found');
      }
    }
    
    console.log('\n🎉 Deployment verification complete!');
    console.log('If all tests passed, the fixes should be working on the live site.');
    console.log('Visit https://academy.trendtacticsdigital.com to verify.');
    
  } catch (error) {
    console.error('💥 Unexpected error during verification:', error.message);
  }
}

verifyDeployment();