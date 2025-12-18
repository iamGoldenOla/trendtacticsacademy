// Test script to check course data in Supabase
import { createClient } from '@supabase/supabase-js';

// Supabase configuration
const supabaseUrl = process.env.REACT_APP_SUPABASE_URL || 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = process.env.REACT_APP_SUPABASE_ANON_KEY || 'your-anon-key';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function testCourseData() {
  console.log('Testing course data retrieval from Supabase...');
  
  try {
    // Test 1: Get all courses
    console.log('\n--- Test 1: Fetching all courses ---');
    const { data: allCourses, error: allCoursesError } = await supabase
      .from('courses')
      .select('*')
      .eq('is_published', true);
    
    if (allCoursesError) {
      console.error('Error fetching all courses:', allCoursesError);
    } else {
      console.log(`Found ${allCourses.length} published courses`);
      allCourses.forEach(course => {
        console.log(`- ${course.id}: ${course.title}`);
      });
    }
    
    // Test 2: Get a specific course with modules and lessons
    console.log('\n--- Test 2: Fetching course with modules and lessons ---');
    const { data: courseWithContent, error: courseWithError } = await supabase
      .from('courses')
      .select(`
        *,
        modules (
          id,
          title,
          description,
          ordering,
          duration,
          lessons (
            id,
            title,
            ordering,
            duration
          )
        )
      `)
      .eq('is_published', true)
      .limit(1);
    
    if (courseWithError) {
      console.error('Error fetching course with content:', courseWithError);
    } else if (courseWithContent && courseWithContent.length > 0) {
      const course = courseWithContent[0];
      console.log(`Course: ${course.id} - ${course.title}`);
      console.log(`Modules: ${course.modules ? course.modules.length : 0}`);
      
      if (course.modules) {
        course.modules.forEach(module => {
          console.log(`  Module: ${module.id} - ${module.title} (${module.lessons ? module.lessons.length : 0} lessons)`);
          if (module.lessons) {
            module.lessons.forEach(lesson => {
              console.log(`    Lesson: ${lesson.id} - ${lesson.title}`);
            });
          }
        });
      }
    } else {
      console.log('No courses found with modules and lessons');
    }
    
    // Test 3: Check if specific course IDs exist
    console.log('\n--- Test 3: Checking specific course IDs ---');
    const testCourseIds = ['dm-1', 'dm-2', 'ai-1', 'ai-2', 'ai-3'];
    
    for (const courseId of testCourseIds) {
      const { data: course, error } = await supabase
        .from('courses')
        .select('*')
        .eq('id', courseId)
        .single();
      
      if (error) {
        console.log(`Course ${courseId}: Error - ${error.message}`);
      } else if (course) {
        console.log(`Course ${courseId}: Found - ${course.title}`);
      } else {
        console.log(`Course ${courseId}: Not found`);
      }
    }
    
    console.log('\n--- Test Complete ---');
  } catch (error) {
    console.error('Unexpected error during testing:', error);
  }
}

// Run the test
testCourseData();

export default testCourseData;