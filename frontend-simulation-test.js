const { createClient } = require('@supabase/supabase-js');

// Supabase credentials (same as frontend)
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

console.log('🔍 Frontend Simulation Test');
console.log('==========================');
console.log('Simulating exactly what the frontend does...\n');

// Create Supabase client (same as frontend)
const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function simulateFrontend() {
  try {
    console.log('1. Testing getAllCourses() - exactly like frontend...');
    
    // This is the EXACT query used by the frontend's getAllCourses()
    const { data, error } = await supabase
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

    if (error) {
      console.log('❌ Error in getAllCourses():', error.message);
      return;
    }

    console.log(`✅ getAllCourses() returned ${data.length} courses`);
    
    if (data.length > 0) {
      const vibeCoding = data.find(course => course.id === 'a1b2c3d4-e5f6-7890-abcd-ef1234567890');
      if (vibeCoding) {
        console.log(`\n🎯 Found Vibe Coding course:`);
        console.log(`   Title: ${vibeCoding.title}`);
        console.log(`   Modules: ${vibeCoding.modules ? vibeCoding.modules.length : 0}`);
        
        if (vibeCoding.modules && vibeCoding.modules.length > 0) {
          vibeCoding.modules.forEach((module, index) => {
            console.log(`     Module ${index + 1}: ${module.title} (${module.lessons ? module.lessons.length : 0} lessons)`);
          });
        }
        
        // Check if course should be displayed
        const totalLessons = vibeCoding.modules ? 
          vibeCoding.modules.reduce((sum, module) => sum + (module.lessons ? module.lessons.length : 0), 0) : 0;
          
        console.log(`\n📊 Total lessons in course: ${totalLessons}`);
        
        if (totalLessons > 0) {
          console.log('✅ Course has lessons and should display');
        } else {
          console.log('❌ Course has no lessons and will NOT display');
        }
      } else {
        console.log('❌ Vibe Coding course not found in results');
      }
    } else {
      console.log('❌ No courses returned');
    }

    console.log('\n2. Testing getCourseById() - exactly like frontend...');
    
    // This is the EXACT query used by the frontend's getCourseById()
    const { data: singleData, error: singleError } = await supabase
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
      .eq('id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890') // Only fetch Vibe Coding course
      .order('created_at', { ascending: false });

    if (singleError) {
      console.log('❌ Error in getCourseById():', singleError.message);
      return;
    }

    console.log(`✅ getCourseById() returned ${singleData.length} courses`);
    
    if (singleData.length > 0) {
      const course = singleData[0];
      console.log(`\n🎯 Vibe Coding course details:`);
      console.log(`   Title: ${course.title}`);
      console.log(`   Modules: ${course.modules ? course.modules.length : 0}`);
      
      if (course.modules && course.modules.length > 0) {
        course.modules.forEach((module, index) => {
          console.log(`     Module ${index + 1}: ${module.title} (${module.lessons ? module.lessons.length : 0} lessons)`);
        });
      }
    }

    console.log('\n3. Testing direct module-lesson relationships...');
    
    // Test if modules can see their lessons directly
    const { data: modulesData, error: modulesError } = await supabase
      .from('modules')
      .select(`
        id,
        title,
        lessons!lessons_module_id_fkey (
          id,
          title
        )
      `)
      .eq('course_id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890')
      .order('ordering');

    if (modulesError) {
      console.log('❌ Error fetching modules with lessons:', modulesError.message);
    } else {
      console.log(`✅ Found ${modulesData.length} modules with lessons:`);
      modulesData.forEach((module, index) => {
        console.log(`     Module ${index + 1}: ${module.title} (${module.lessons ? module.lessons.length : 0} lessons)`);
      });
    }

    console.log('\n📋 SUMMARY:');
    console.log('If all tests above show lessons, but course still not appearing on website:');
    console.log('1. Check browser cache - hard refresh (Ctrl+F5 or Cmd+Shift+R)');
    console.log('2. Check browser console for JavaScript errors');
    console.log('3. Verify frontend code is using the same Supabase credentials');
    console.log('4. Check if there are any frontend filtering conditions');

  } catch (error) {
    console.log('❌ Unexpected error:', error.message);
  }
}

// Run the simulation
simulateFrontend();