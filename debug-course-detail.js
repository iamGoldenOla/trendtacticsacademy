// Debug script to check course detail loading issues
const { createClient } = require('@supabase/supabase-js');

// Use your actual Supabase credentials
const supabaseUrl = process.env.SUPABASE_URL || 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseKey);

async function debugCourseDetail() {
  console.log('🔍 Debugging course detail loading...');
  
  try {
    // First, let's get all courses to see what IDs we have
    console.log('\n1. Getting all courses...');
    const { data: allCourses, error: allCoursesError } = await supabase
      .from('courses')
      .select('id, title, is_published')
      .limit(10);
    
    if (allCoursesError) {
      console.error('❌ Failed to fetch courses:', allCoursesError.message);
      return;
    }
    
    console.log(`✅ Found ${allCourses.length} courses:`);
    allCourses.forEach(course => {
      console.log(`  - ID: ${course.id}, Title: ${course.title}, Published: ${course.is_published}`);
    });
    
    if (allCourses.length > 0) {
      // Try to fetch the first course by ID using our fixed approach
      const firstCourseId = allCourses[0].id;
      console.log(`\n2. Testing fetch of course with ID: ${firstCourseId}`);
      
      // First, get the course data
      const { data: courseData, error: courseError } = await supabase
        .from('courses')
        .select('*')
        .eq('id', firstCourseId)
        .eq('is_published', true)
        .single();

      if (courseError) {
        console.error('❌ Failed to fetch course by ID:', courseError.message);
      } else if (!courseData) {
        console.error('❌ Course not found');
      } else {
        console.log(`✅ Successfully fetched course: ${courseData.title}`);
        
        // Then, get modules for this course
        const { data: modulesData, error: modulesError } = await supabase
          .from('modules')
          .select('*')
          .eq('course_id', firstCourseId)
          .order('ordering', { ascending: true });

        if (modulesError) {
          console.warn('⚠️  Error fetching modules:', modulesError.message);
          // Continue without modules if there's an error
          courseData.modules = [];
        } else {
          console.log(`✅ Found ${modulesData.length} modules for this course`);
          
          // For each module, get its lessons
          const modulesWithLessons = [];
          for (const module of modulesData || []) {
            const { data: lessonsData, error: lessonsError } = await supabase
              .from('lessons')
              .select('id, title, ordering, duration')
              .eq('module_id', module.id)
              .order('ordering', { ascending: true });
              
            if (lessonsError) {
              console.warn(`⚠️  Error fetching lessons for module ${module.id}:`, lessonsError.message);
              module.lessons = [];
            } else {
              module.lessons = lessonsData || [];
              console.log(`   Module "${module.title}" has ${module.lessons.length} lessons`);
            }
            
            modulesWithLessons.push(module);
          }
          
          courseData.modules = modulesWithLessons;
        }
      }
    }
    
  } catch (error) {
    console.error('💥 Unexpected error during debugging:', error.message);
    console.error(error.stack);
  }
}

debugCourseDetail();