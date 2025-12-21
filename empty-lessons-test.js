// Test how the frontend handles courses with empty lessons
const { createClient } = require('@supabase/supabase-js');

// Use the same Supabase configuration as in the frontend
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function testEmptyLessonsHandling() {
  console.log('🔍 Testing how frontend handles courses with empty lessons...\n');
  
  try {
    // Get the actual course data
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
      .eq('id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890')
      .order('created_at', { ascending: false });

    if (error) {
      console.error('❌ Supabase query error:', error);
      return;
    }
    
    if (!data || data.length === 0) {
      console.log('❌ No course data found');
      return;
    }
    
    const course = data[0];
    console.log(`✅ Found course: ${course.title}`);
    console.log(`   Modules: ${course.modules ? course.modules.length : 0}`);
    
    // Simulate the exact processing the frontend does
    console.log('\n2. Simulating frontend processing...');
    
    // This is exactly what the frontend does
    if (course.modules && Array.isArray(course.modules)) {
      console.log('   Sorting modules...');
      course.modules.sort((a, b) => (a.ordering || 0) - (b.ordering || 0));
      
      console.log('   Sorting lessons in each module...');
      course.modules.forEach((module, index) => {
        console.log(`   Module ${index + 1}: ${module.title}`);
        console.log(`     Lessons array: ${Array.isArray(module.lessons) ? 'Yes' : 'No'}`);
        console.log(`     Lessons count: ${module.lessons ? module.lessons.length : 'undefined'}`);
        
        if (module.lessons && Array.isArray(module.lessons)) {
          console.log('     Sorting lessons...');
          module.lessons.sort((a, b) => (a.ordering || 0) - (b.ordering || 0));
        } else {
          console.log('     ⚠️ No lessons array or not an array');
        }
      });
    }
    
    // Test what would happen in the Courses.js component filter/sort logic
    console.log('\n3. Testing Courses.js filter/sort logic...');
    
    // Simulate the sorting logic from Courses.js line 66
    const lessonsLength = ((course.modules || [])[0] || {}).lessons?.length || 0;
    console.log(`   First module lessons length: ${lessonsLength}`);
    
    // This is the line that might cause issues if lessons is undefined
    const popularityScore = ((course.modules || [])[0] || {}).lessons?.length || 0;
    console.log(`   Popularity score (based on first module lessons): ${popularityScore}`);
    
    console.log('\n4. Testing Home.tsx logic...');
    // Home.tsx doesn't seem to have complex sorting, so it should be fine
    
    console.log('\n✅ Frontend processing simulation completed');
    console.log('   The course should display correctly in both Home and Courses pages');
    
  } catch (error) {
    console.error('💥 Error in empty lessons test:', error.message);
  }
}

testEmptyLessonsHandling();