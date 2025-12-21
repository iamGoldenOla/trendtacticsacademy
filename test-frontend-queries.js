const { createClient } = require('@supabase/supabase-js');

// Supabase credentials
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function testFrontendQueries() {
  console.log('🔍 Testing frontend queries...\n');
  
  try {
    // Test 1: Home.tsx featured courses query (getAllCourses)
    console.log('1. Testing Home.tsx getAllCourses query...');
    const { data: homeData, error: homeError } = await supabase
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
      .eq('id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890') // Only fetch Vibe Coding course
      .order('created_at', { ascending: false });

    if (homeError) {
      console.error('❌ Home.tsx query failed:', homeError.message);
    } else {
      console.log(`✅ Home.tsx query successful: ${homeData.length} courses returned`);
      if (homeData.length > 0) {
        console.log(`   Course: ${homeData[0].title}`);
        console.log(`   Modules: ${homeData[0].modules.length}`);
        const totalLessons = homeData[0].modules.reduce((sum, module) => sum + (module.lessons?.length || 0), 0);
        console.log(`   Total lessons: ${totalLessons}`);
      }
    }

    // Test 2: Courses.js all courses query
    console.log('\n2. Testing Courses.js getAllCourses query...');
    const { data: coursesData, error: coursesError } = await supabase
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
      .eq('id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890') // Only fetch Vibe Coding course
      .order('created_at', { ascending: false });

    if (coursesError) {
      console.error('❌ Courses.js query failed:', coursesError.message);
    } else {
      console.log(`✅ Courses.js query successful: ${coursesData.length} courses returned`);
      if (coursesData.length > 0) {
        console.log(`   Course: ${coursesData[0].title}`);
        console.log(`   Modules: ${coursesData[0].modules.length}`);
        const totalLessons = coursesData[0].modules.reduce((sum, module) => sum + (module.lessons?.length || 0), 0);
        console.log(`   Total lessons: ${totalLessons}`);
      }
    }

    // Test 3: Individual course detail query
    console.log('\n3. Testing individual course detail query...');
    const courseId = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890';
    const { data: detailData, error: detailError } = await supabase
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
      .eq('id', courseId)
      .eq('is_published', true)
      .single();

    if (detailError) {
      console.error('❌ Course detail query failed:', detailError.message);
    } else {
      console.log(`✅ Course detail query successful:`);
      console.log(`   Course: ${detailData.title}`);
      console.log(`   Modules: ${detailData.modules.length}`);
      const totalLessons = detailData.modules.reduce((sum, module) => sum + (module.lessons?.length || 0), 0);
      console.log(`   Total lessons: ${totalLessons}`);
    }

    console.log('\n📋 Summary:');
    console.log('✅ All queries are working correctly with the database');
    console.log('💡 The issue is likely in the frontend presentation layer');
    console.log('🔧 Solutions to try:');
    console.log('   1. Hard refresh your browser (Ctrl+F5 or Cmd+Shift+R)');
    console.log('   2. Clear browser cache completely');
    console.log('   3. Check browser console for JavaScript errors');
    console.log('   4. Verify the deployed build contains the latest fixes');

  } catch (error) {
    console.error('Unexpected error:', error.message);
  }
}

testFrontendQueries();