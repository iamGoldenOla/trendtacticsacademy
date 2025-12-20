import { createClient } from '@supabase/supabase-js';

// Initialize Supabase client
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function checkVibeCodingCourse() {
  try {
    console.log('Checking if Vibe Coding course exists...');
    
    // Check if the specific Vibe Coding course exists
    const { data: specificCourse, error: specificError } = await supabase
      .from('courses')
      .select('*')
      .eq('id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890')
      .single();

    if (specificError) {
      console.error('Error fetching specific course:', specificError);
    } else if (specificCourse) {
      console.log('✅ Vibe Coding course found:');
      console.log('ID:', specificCourse.id);
      console.log('Title:', specificCourse.title);
      console.log('Published:', specificCourse.is_published);
    } else {
      console.log('❌ Vibe Coding course not found');
    }

    // Check all courses
    const { data: allCourses, error: allError } = await supabase
      .from('courses')
      .select('*');

    if (allError) {
      console.error('Error fetching all courses:', allError);
    } else {
      console.log(`\nTotal courses in database: ${allCourses.length}`);
      allCourses.forEach(course => {
        console.log(`- ${course.title} (${course.id}) - Published: ${course.is_published}`);
      });
    }

    // Check published courses
    const { data: publishedCourses, error: publishedError } = await supabase
      .from('courses')
      .select('*')
      .eq('is_published', true);

    if (publishedError) {
      console.error('Error fetching published courses:', publishedError);
    } else {
      console.log(`\nPublished courses: ${publishedCourses.length}`);
      publishedCourses.forEach(course => {
        console.log(`- ${course.title} (${course.id})`);
      });
    }

  } catch (err) {
    console.error('Unexpected error:', err);
  }
}

// Run the check
checkVibeCodingCourse();