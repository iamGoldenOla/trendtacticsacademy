// Diagnostic script to check course data in Supabase
const { createClient } = require('@supabase/supabase-js');

// Initialize Supabase client
const supabaseUrl = process.env.REACT_APP_SUPABASE_URL || 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = process.env.REACT_APP_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function diagnoseCourses() {
  console.log('🔍 Diagnosing course data...\n');
  
  try {
    // Check courses table
    console.log('1. Checking courses table...');
    const { data: courses, error: coursesError, count: coursesCount } = await supabase
      .from('courses')
      .select('*', { count: 'exact' });
    
    if (coursesError) {
      console.error('❌ Error fetching courses:', coursesError.message);
      return;
    }
    
    console.log(`✅ Found ${coursesCount} courses`);
    
    if (courses.length > 0) {
      console.log('\n📋 Sample courses:');
      courses.slice(0, 3).forEach(course => {
        console.log(`   - ${course.title} (${course.id})`);
        console.log(`     Published: ${course.is_published ? 'Yes' : 'No'}`);
        console.log(`     Modules: ${course.modules_count || 0}`);
      });
    }
    
    // Check published courses specifically
    console.log('\n2. Checking published courses...');
    const { data: publishedCourses, error: publishedError, count: publishedCount } = await supabase
      .from('courses')
      .select('*', { count: 'exact' })
      .eq('is_published', true);
    
    if (publishedError) {
      console.error('❌ Error fetching published courses:', publishedError.message);
      return;
    }
    
    console.log(`✅ Found ${publishedCount} published courses`);
    
    // Check modules
    console.log('\n3. Checking modules...');
    const { data: modules, error: modulesError, count: modulesCount } = await supabase
      .from('modules')
      .select('*', { count: 'exact' });
    
    if (modulesError) {
      console.error('❌ Error fetching modules:', modulesError.message);
      return;
    }
    
    console.log(`✅ Found ${modulesCount} modules`);
    
    // Check lessons
    console.log('\n4. Checking lessons...');
    const { data: lessons, error: lessonsError, count: lessonsCount } = await supabase
      .from('lessons')
      .select('*', { count: 'exact' });
    
    if (lessonsError) {
      console.error('❌ Error fetching lessons:', lessonsError.message);
      return;
    }
    
    console.log(`✅ Found ${lessonsCount} lessons`);
    
    // Check relationships
    console.log('\n5. Checking course-module-lesson relationships...');
    const { data: courseDetails, error: detailsError } = await supabase
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
      .limit(3);
    
    if (detailsError) {
      console.error('❌ Error fetching course details:', detailsError.message);
      return;
    }
    
    console.log('✅ Course structure verification:');
    courseDetails.forEach(course => {
      const moduleCount = course.modules ? course.modules.length : 0;
      let lessonCount = 0;
      if (course.modules) {
        course.modules.forEach(module => {
          lessonCount += module.lessons ? module.lessons.length : 0;
        });
      }
      console.log(`   - ${course.title}: ${moduleCount} modules, ${lessonCount} lessons`);
    });
    
    console.log('\n✅ Diagnosis complete!');
    
  } catch (error) {
    console.error('💥 Unexpected error during diagnosis:', error.message);
  }
}

diagnoseCourses();