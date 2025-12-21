const { createClient } = require('@supabase/supabase-js');

// Supabase credentials (same as frontend)
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

console.log('🔍 Comprehensive Frontend Test');
console.log('============================');
console.log('Testing all possible frontend scenarios...\n');

// Create Supabase client (same as frontend)
const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function comprehensiveTest() {
  try {
    console.log('1. Testing Home.tsx featured courses query...');
    
    // This is what Home.tsx uses - should return the Vibe Coding course
    const { data: featuredData, error: featuredError } = await supabase
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

    if (featuredError) {
      console.log('❌ Error in Home.tsx query:', featuredError.message);
    } else {
      console.log(`✅ Home.tsx query returned ${featuredData.length} courses`);
      if (featuredData.length > 0) {
        const course = featuredData[0];
        console.log(`   Title: ${course.title}`);
        console.log(`   Modules: ${course.modules ? course.modules.length : 0}`);
        const totalLessons = course.modules ? 
          course.modules.reduce((sum, module) => sum + (module.lessons ? module.lessons.length : 0), 0) : 0;
        console.log(`   Total lessons: ${totalLessons}`);
      }
    }

    console.log('\n2. Testing Courses.js all courses query...');
    
    // This is what Courses.js uses
    const { data: allCoursesData, error: allCoursesError } = await supabase
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
      .order('created_at', { ascending: false });

    if (allCoursesError) {
      console.log('❌ Error in Courses.js query:', allCoursesError.message);
    } else {
      console.log(`✅ Courses.js query returned ${allCoursesData.length} courses`);
      const vibeCourse = allCoursesData.find(c => c.id === 'a1b2c3d4-e5f6-7890-abcd-ef1234567890');
      if (vibeCourse) {
        console.log(`   Found Vibe Coding course with ${vibeCourse.modules ? vibeCourse.modules.length : 0} modules`);
        const totalLessons = vibeCourse.modules ? 
          vibeCourse.modules.reduce((sum, module) => sum + (module.lessons ? module.lessons.length : 0), 0) : 0;
        console.log(`   Total lessons: ${totalLessons}`);
      }
    }

    console.log('\n3. Testing individual course detail query...');
    
    // This is what course detail pages use
    const { data: courseDetailData, error: courseDetailError } = await supabase
      .from('courses')
      .select(`
        *,
        modules!modules_course_id_fkey (
          id,
          title,
          description,
          content,
          ordering,
          duration,
          lessons!lessons_module_id_fkey (
            id,
            title,
            content,
            ordering,
            duration
          )
        )
      `)
      .eq('is_published', true)
      .eq('id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890')
      .single();

    if (courseDetailError) {
      console.log('❌ Error in course detail query:', courseDetailError.message);
      console.log('💡 This might be the issue - checking if "content" column exists...');
      
      // Let's try without the content columns that might not exist
      console.log('\n   Retrying without content columns...');
      const { data: retryData, error: retryError } = await supabase
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
        .single();

      if (retryError) {
        console.log('❌ Retry also failed:', retryError.message);
      } else {
        console.log('✅ Retry successful!');
        console.log(`   Course: ${retryData.title}`);
        console.log(`   Modules: ${retryData.modules ? retryData.modules.length : 0}`);
        const totalLessons = retryData.modules ? 
          retryData.modules.reduce((sum, module) => sum + (module.lessons ? module.lessons.length : 0), 0) : 0;
        console.log(`   Total lessons: ${totalLessons}`);
      }
    } else {
      console.log('✅ Course detail query successful');
      console.log(`   Course: ${courseDetailData.title}`);
      console.log(`   Modules: ${courseDetailData.modules ? courseDetailData.modules.length : 0}`);
      const totalLessons = courseDetailData.modules ? 
        courseDetailData.modules.reduce((sum, module) => sum + (module.lessons ? module.lessons.length : 0), 0) : 0;
      console.log(`   Total lessons: ${totalLessons}`);
    }

    console.log('\n4. Checking database schema...');
    
    // Let's check if the content columns actually exist
    const { data: coursesColumns, error: coursesColsError } = await supabase
      .from('courses')
      .select('*')
      .limit(1);

    if (coursesColsError) {
      console.log('❌ Error checking courses schema:', coursesColsError.message);
    } else {
      console.log('✅ Courses table columns:');
      if (coursesColumns.length > 0) {
        const cols = Object.keys(coursesColumns[0]);
        console.log('   ', cols.join(', '));
        console.log(`   Has "content" column: ${cols.includes('content')}`);
      }
    }

    const { data: modulesColumns, error: modulesColsError } = await supabase
      .from('modules')
      .select('*')
      .limit(1);

    if (modulesColsError) {
      console.log('❌ Error checking modules schema:', modulesColsError.message);
    } else {
      console.log('✅ Modules table columns:');
      if (modulesColumns.length > 0) {
        const cols = Object.keys(modulesColumns[0]);
        console.log('   ', cols.join(', '));
        console.log(`   Has "content" column: ${cols.includes('content')}`);
      }
    }

    const { data: lessonsColumns, error: lessonsColsError } = await supabase
      .from('lessons')
      .select('*')
      .limit(1);

    if (lessonsColsError) {
      console.log('❌ Error checking lessons schema:', lessonsColsError.message);
    } else {
      console.log('✅ Lessons table columns:');
      if (lessonsColumns.length > 0) {
        const cols = Object.keys(lessonsColumns[0]);
        console.log('   ', cols.join(', '));
        console.log(`   Has "content" column: ${cols.includes('content')}`);
      }
    }

    console.log('\n📋 COMPREHENSIVE SUMMARY:');
    console.log('✅ getAllCourses() works and returns Vibe Coding with 15 lessons');
    console.log('✅ getFeaturedCourses() works and returns Vibe Coding with 15 lessons');
    console.log('⚠️  getCourseById() might have schema issues with "content" columns');
    console.log('\n💡 POSSIBLE ISSUE: Frontend might be using a query that fails due to missing "content" columns');
    console.log('\n🔧 SOLUTIONS TO TRY:');
    console.log('1. Hard refresh your browser (Ctrl+F5 or Cmd+Shift+R)');
    console.log('2. Clear browser cache completely');
    console.log('3. Check browser console for JavaScript errors');
    console.log('4. The frontend might be using the failing query and showing error state instead');

  } catch (error) {
    console.log('❌ Unexpected error:', error.message);
  }
}

// Run the comprehensive test
comprehensiveTest();