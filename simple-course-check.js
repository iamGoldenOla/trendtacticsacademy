// Simple script to check courses without embedded relationships
const { createClient } = require('@supabase/supabase-js');

// Supabase configuration
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function simpleCourseCheck() {
  console.log('=== Simple Course Check ===');
  
  try {
    // Fetch all courses
    const { data: courses, error } = await supabase
      .from('courses')
      .select('*')
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
      console.log(`Created: ${course.created_at}`);
    });
    
    // Try to fetch a specific course by ID
    if (courses.length > 0) {
      console.log('\n--- Testing specific course fetch ---');
      const firstCourseId = courses[0].id;
      
      const { data: specificCourse, error: specificError } = await supabase
        .from('courses')
        .select('*')
        .eq('id', firstCourseId)
        .eq('is_published', true)
        .single();
      
      if (specificError) {
        console.error('❌ Error fetching specific course:', specificError.message);
      } else {
        console.log(`✅ Successfully fetched course: ${specificCourse.title}`);
        console.log(`ID: ${specificCourse.id}`);
      }
    }
    
    // Check modules separately
    console.log('\n--- Checking modules ---');
    const { data: modules, error: modulesError } = await supabase
      .from('modules')
      .select('*')
      .limit(5);
    
    if (modulesError) {
      console.error('❌ Error fetching modules:', modulesError.message);
    } else {
      console.log(`✅ Found ${modules.length} modules:`);
      modules.forEach(module => {
        console.log(`  - ${module.title} (Course ID: ${module.course_id})`);
      });
    }
    
    // Check lessons separately
    console.log('\n--- Checking lessons ---');
    const { data: lessons, error: lessonsError } = await supabase
      .from('lessons')
      .select('*')
      .limit(5);
    
    if (lessonsError) {
      console.error('❌ Error fetching lessons:', lessonsError.message);
    } else {
      console.log(`✅ Found ${lessons.length} lessons:`);
      lessons.forEach(lesson => {
        console.log(`  - ${lesson.title} (Module ID: ${lesson.module_id})`);
      });
    }
    
  } catch (error) {
    console.error('❌ Failed to check courses:', error.message);
  }
  
  console.log('\n=== End Simple Course Check ===');
}

// Run the check
simpleCourseCheck();