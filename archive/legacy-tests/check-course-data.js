const { createClient } = require('@supabase/supabase-js');

// Supabase credentials (replace with your actual values)
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';
console.log('🔍 Checking course data in Supabase...');
console.log('Supabase URL:', supabaseUrl);

// Create Supabase client
const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function checkCourseData() {
  try {
    console.log('\n1. Checking if Vibe Coding course exists...');
    
    // Check if the specific course exists
    const { data: courseData, error: courseError } = await supabase
      .from('courses')
      .select('*')
      .eq('id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890')
      .single();

    if (courseError) {
      console.log('❌ Error fetching course:', courseError.message);
      return;
    }

    if (!courseData) {
      console.log('❌ Vibe Coding course not found in database');
      return;
    }

    console.log('✅ Vibe Coding course found:');
    console.log('   Title:', courseData.title);
    console.log('   Published:', courseData.is_published);
    console.log('   Created:', courseData.created_at);

    console.log('\n2. Checking course modules...');
    
    // Check modules for this course
    const { data: modulesData, error: modulesError } = await supabase
      .from('modules')
      .select('*')
      .eq('course_id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890')
      .order('ordering');

    if (modulesError) {
      console.log('❌ Error fetching modules:', modulesError.message);
      return;
    }

    console.log(`✅ Found ${modulesData.length} modules:`);
    modulesData.forEach((module, index) => {
      console.log(`   ${index + 1}. ${module.title} (${module.id})`);
    });

    console.log('\n3. Checking lessons for each module...');
    
    // Check lessons for each module
    for (const module of modulesData) {
      const { data: lessonsData, error: lessonsError } = await supabase
        .from('lessons')
        .select('*')
        .eq('module_id', module.id)
        .order('ordering');

      if (lessonsError) {
        console.log(`❌ Error fetching lessons for module ${module.title}:`, lessonsError.message);
        continue;
      }

      console.log(`   Module "${module.title}" has ${lessonsData.length} lessons:`);
      lessonsData.forEach((lesson, index) => {
        console.log(`     ${index + 1}. ${lesson.title} (${lesson.id})`);
      });
    }

    console.log('\n4. Testing the exact query used by frontend...');
    
    // Test the exact query used by the frontend
    const { data: frontendQueryData, error: frontendQueryError } = await supabase
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
      .eq('id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890')
      .order('created_at', { ascending: false });

    if (frontendQueryError) {
      console.log('❌ Error with frontend query:', frontendQueryError.message);
      return;
    }

    console.log('✅ Frontend query successful');
    console.log('   Courses returned:', frontendQueryData.length);
    
    if (frontendQueryData.length > 0) {
      const course = frontendQueryData[0];
      console.log('   Course title:', course.title);
      console.log('   Modules count:', course.modules ? course.modules.length : 0);
      
      if (course.modules && course.modules.length > 0) {
        course.modules.forEach((module, index) => {
          console.log(`     Module ${index + 1}: ${module.title}`);
          console.log(`       Lessons count: ${module.lessons ? module.lessons.length : 0}`);
        });
      }
    }

  } catch (error) {
    console.log('❌ Unexpected error:', error.message);
  }
}

// Run the check
checkCourseData();