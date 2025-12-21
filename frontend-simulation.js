// Simulate exactly what the frontend does
const { createClient } = require('@supabase/supabase-js');

// Use the same Supabase configuration as in the frontend
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function simulateFrontend() {
  console.log('🔍 Simulating frontend course loading...\n');
  
  try {
    console.log('1. Calling courseService.getAllCourses() equivalent...');
    
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
      .eq('id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890') // Only fetch Vibe Coding course
      .order('created_at', { ascending: false });

    if (error) {
      console.error('❌ Supabase query error:', error);
      throw error;
    }
    
    // Process the data exactly like the frontend does
    console.log('2. Processing data like frontend...');
    
    if (data && Array.isArray(data)) {
      const processedData = data.map(course => {
        // Ensure modules exist and are sorted
        if (course.modules && Array.isArray(course.modules)) {
          course.modules.sort((a, b) => (a.ordering || 0) - (b.ordering || 0));
          
          // Ensure lessons within each module are sorted
          course.modules.forEach(module => {
            if (module.lessons && Array.isArray(module.lessons)) {
              module.lessons.sort((a, b) => (a.ordering || 0) - (b.ordering || 0));
            }
          });
        }
        return course;
      });
      
      console.log('✅ Successfully processed courses:', processedData.length);
      
      if (processedData.length > 0) {
        const course = processedData[0];
        console.log(`\nCourse Details:`);
        console.log(`  Title: ${course.title}`);
        console.log(`  ID: ${course.id}`);
        console.log(`  Modules: ${course.modules ? course.modules.length : 0}`);
        
        if (course.modules && course.modules.length > 0) {
          console.log(`\nFirst Module:`);
          const firstModule = course.modules[0];
          console.log(`  Title: ${firstModule.title}`);
          console.log(`  ID: ${firstModule.id}`);
          console.log(`  Lessons: ${firstModule.lessons ? firstModule.lessons.length : 0}`);
          
          if (firstModule.lessons && firstModule.lessons.length > 0) {
            console.log(`\nFirst Lesson:`);
            const firstLesson = firstModule.lessons[0];
            console.log(`  Title: ${firstLesson.title}`);
            console.log(`  ID: ${firstLesson.id}`);
          }
        }
        
        // Simulate what the frontend components would receive
        console.log('\n3. Simulating component rendering...');
        console.log(`  Courses page would receive: ${processedData.length} courses`);
        console.log(`  Home page featured courses would receive: ${processedData.length} courses`);
        
        // Check for potential issues
        if (processedData.length === 0) {
          console.log('⚠️ ISSUE: No courses to display - this would show "No courses found"');
        } else {
          console.log('✅ Would display course in both Courses page and Home page');
          
          // Check if modules have lessons
          const courseHasLessons = course.modules.some(module => 
            module.lessons && module.lessons.length > 0
          );
          
          if (!courseHasLessons) {
            console.log('⚠️ NOTE: Course modules have no lessons - this might affect some UI elements');
          }
        }
      }
      
      return processedData;
    }
    
    console.log('⚠️ No data returned from query');
    return [];
    
  } catch (error) {
    console.error('💥 Error in frontend simulation:', error.message);
    return [];
  }
}

// Run the simulation
simulateFrontend().then(courses => {
  console.log(`\n🏁 Simulation completed. Frontend would display ${courses.length} courses.`);
});