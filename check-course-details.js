// Script to check course details and structure
const { createClient } = require('@supabase/supabase-js');

// Supabase configuration
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function checkCourseDetails() {
  console.log('=== Course Details Check ===');
  
  try {
    // Fetch all courses with their structure
    const { data: courses, error } = await supabase
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
      .eq('is_published', true);
    
    if (error) {
      console.error('❌ Error fetching courses:', error.message);
      return;
    }
    
    console.log(`✅ Found ${courses.length} published courses:`);
    
    courses.forEach((course, index) => {
      console.log(`\n--- Course ${index + 1}: ${course.title} ---`);
      console.log(`ID: ${course.id}`);
      console.log(`Category: ${course.category}`);
      console.log(`Level: ${course.level}`);
      console.log(`Duration: ${course.duration}`);
      console.log(`Price: $${course.price}`);
      console.log(`Modules: ${course.modules ? course.modules.length : 0}`);
      
      if (course.modules && course.modules.length > 0) {
        course.modules.forEach((module, moduleIndex) => {
          console.log(`  Module ${moduleIndex + 1}: ${module.title}`);
          console.log(`    Lessons: ${module.lessons ? module.lessons.length : 0}`);
          
          if (module.lessons && module.lessons.length > 0) {
            module.lessons.forEach((lesson, lessonIndex) => {
              console.log(`      Lesson ${lessonIndex + 1}: ${lesson.title}`);
            });
          }
        });
      }
    });
    
    // Try to fetch a specific course by ID to test the getCourseById function
    if (courses.length > 0) {
      console.log('\n--- Testing specific course fetch ---');
      const firstCourseId = courses[0].id;
      
      const { data: specificCourse, error: specificError } = await supabase
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
        .eq('id', firstCourseId)
        .eq('is_published', true)
        .single();
      
      if (specificError) {
        console.error('❌ Error fetching specific course:', specificError.message);
      } else {
        console.log(`✅ Successfully fetched course: ${specificCourse.title}`);
        console.log(`ID: ${specificCourse.id}`);
        console.log(`Modules: ${specificCourse.modules ? specificCourse.modules.length : 0}`);
      }
    }
    
  } catch (error) {
    console.error('❌ Failed to check course details:', error.message);
  }
  
  console.log('\n=== End Course Details Check ===');
}

// Run the check
checkCourseDetails();