// Comprehensive test to simulate exactly what the frontend is doing
const { createClient } = require('@supabase/supabase-js');

// Use the exact same configuration as the frontend
const supabaseUrl = process.env.REACT_APP_SUPABASE_URL || 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = process.env.REACT_APP_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

console.log('🔧 Testing with Supabase URL:', supabaseUrl);
console.log('🔧 Testing with Supabase Anon Key:', supabaseAnonKey.substring(0, 20) + '...');

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function comprehensiveFrontendTest() {
  console.log('\n🔍 Comprehensive Frontend Simulation Test\n');
  
  try {
    // Test 1: Exact simulation of courseService.getAllCourses()
    console.log('1. Simulating courseService.getAllCourses()...');
    const { data: allCourses, error: allCoursesError } = await supabase
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

    if (allCoursesError) {
      console.error('❌ Error in getAllCourses simulation:', allCoursesError);
      return;
    }
    
    console.log(`✅ getAllCourses successful - ${allCourses.length} courses fetched`);
    
    // Apply exact same processing as in courseService.js
    if (allCourses && Array.isArray(allCourses)) {
      const processedData = allCourses.map(course => {
        // Ensure modules exist and are sorted
        if (course.modules && Array.isArray(course.modules)) {
          course.modules.sort((a, b) => (a.ordering || 0) - (b.ordering || 0));
          
          // Ensure lessons within each module are sorted
          course.modules.forEach(module => {
            if (module.lessons && Array.isArray(module.lessons)) {
              module.lessons.sort((a, b) => (a.ordering || 0) - (b.ordering || 0));
            }
          });
        }
        return course;
      });
      
      console.log(`✅ Processed ${processedData.length} courses`);
      
      // Apply exact same filtering as in Home.js
      const validCourses = processedData.filter(course => {
        // Check if course.id looks like a UUID
        return course.id && /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(course.id);
      });
      
      console.log(`✅ After UUID validation: ${validCourses.length} valid courses`);
      
      if (validCourses.length > 0) {
        console.log('\n📋 First 3 valid courses:');
        validCourses.slice(0, 3).forEach((course, index) => {
          console.log(`   ${index + 1}. ${course.title} (${course.id})`);
          console.log(`      Modules: ${course.modules ? course.modules.length : 0}`);
          let totalLessons = 0;
          if (course.modules) {
            course.modules.forEach(module => {
              totalLessons += module.lessons ? module.lessons.length : 0;
            });
          }
          console.log(`      Total Lessons: ${totalLessons}`);
        });
      } else {
        console.log('❌ No valid courses after UUID filtering');
        console.log('📋 All fetched courses:');
        processedData.slice(0, 5).forEach((course, index) => {
          console.log(`   ${index + 1}. ${course.title} (${course.id})`);
          console.log(`      Valid UUID: ${/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(course.id)}`);
        });
      }
      
      // Test 2: Simulate course detail page with first valid course
      if (validCourses.length > 0) {
        console.log('\n2. Simulating CourseDetail page with first valid course...');
        const testCourseId = validCourses[0].id;
        console.log(`   Testing with course ID: ${testCourseId}`);
        
        // Exact simulation of courseService.getCourseById()
        const { data: courseData, error: courseError } = await supabase
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

        console.log('   Supabase response received');
        
        if (courseError) {
          console.error('❌ Error in getCourseById simulation:', courseError);
        } else if (!courseData) {
          console.log('❌ Course not found for ID:', testCourseId);
        } else {
          console.log(`✅ Course detail fetch successful: ${courseData.title}`);
          
          // Apply exact same processing as in courseService.js
          if (courseData.modules && Array.isArray(courseData.modules)) {
            courseData.modules.sort((a, b) => (a.ordering || 0) - (b.ordering || 0));
            
            // Ensure lessons within each module are sorted by ordering
            courseData.modules.forEach(module => {
              if (module.lessons && Array.isArray(module.lessons)) {
                module.lessons.sort((a, b) => (a.ordering || 0) - (b.ordering || 0));
              }
            });
          }
          
          console.log(`   Modules: ${courseData.modules ? courseData.modules.length : 0}`);
          if (courseData.modules) {
            courseData.modules.forEach((module, index) => {
              console.log(`   Module ${index + 1}: ${module.title} (${module.lessons ? module.lessons.length : 0} lessons)`);
            });
          }
          console.log('✅ Course detail page simulation successful!');
        }
      }
    }
    
    console.log('\n🎉 Comprehensive frontend simulation complete!');
    console.log('If all tests passed, the issue may be with the deployed frontend not having the latest code.');
    
  } catch (error) {
    console.error('💥 Unexpected error during comprehensive test:', error.message);
    console.error('Stack trace:', error.stack);
  }
}

comprehensiveFrontendTest();