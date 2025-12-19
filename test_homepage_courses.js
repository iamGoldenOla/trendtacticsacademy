// Test script to check what's happening with homepage course display
const { createClient } = require('@supabase/supabase-js');

// Initialize Supabase client with the same configuration as the frontend
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function testHomepageCourses() {
  console.log('🔍 Testing homepage course display...\n');
  
  try {
    // Simulate what the Home.js component does
    console.log('1. Fetching all courses (as Home.js does)...');
    const { data, error } = await supabase
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

    if (error) {
      console.error('❌ Error fetching courses:', error);
      return;
    }
    
    console.log(`✅ Successfully fetched ${data.length} courses`);
    
    // Apply the same filtering as in Home.js
    console.log('\n2. Applying UUID validation filter (as Home.js does)...');
    const validCourses = data.filter(course => {
      // Check if course.id looks like a UUID
      return course.id && /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(course.id);
    });
    
    console.log(`✅ After UUID validation: ${validCourses.length} valid courses`);
    
    if (validCourses.length > 0) {
      console.log('\n📋 Valid courses:');
      validCourses.slice(0, 3).forEach(course => {
        console.log(`   - ${course.title} (${course.id})`);
        const moduleCount = course.modules ? course.modules.length : 0;
        let lessonCount = 0;
        if (course.modules) {
          course.modules.forEach(module => {
            lessonCount += module.lessons ? module.lessons.length : 0;
          });
        }
        console.log(`     Modules: ${moduleCount}, Lessons: ${lessonCount}`);
      });
    } else {
      console.log('❌ No valid courses found after UUID filtering');
      console.log('\n📋 All fetched courses:');
      data.slice(0, 5).forEach(course => {
        console.log(`   - ${course.title} (${course.id}) - Valid UUID: ${/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(course.id)}`);
      });
    }
    
    // Check a specific course by ID (simulate clicking "View Course")
    if (validCourses.length > 0) {
      console.log('\n3. Testing specific course fetch (as CourseDetail.js does)...');
      const testCourseId = validCourses[0].id;
      console.log(`   Testing with course ID: ${testCourseId}`);
      
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

      if (courseError) {
        console.error('❌ Error fetching specific course:', courseError);
      } else if (courseData) {
        console.log(`✅ Successfully fetched course: ${courseData.title}`);
        console.log(`   Modules: ${courseData.modules ? courseData.modules.length : 0}`);
        if (courseData.modules) {
          courseData.modules.forEach(module => {
            console.log(`   - Module: ${module.title} (${module.lessons ? module.lessons.length : 0} lessons)`);
          });
        }
      } else {
        console.log('❌ Course not found');
      }
    }
    
    console.log('\n✅ Homepage course test complete!');
    
  } catch (error) {
    console.error('💥 Unexpected error during test:', error.message);
  }
}

testHomepageCourses();