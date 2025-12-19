// Test script to verify that the Vibe Coding course can be fetched properly
// This script simulates how the frontend would fetch course data

const testVibeCodingFetch = async () => {
  try {
    console.log('Testing Vibe Coding course fetch...');
    
    // Simulate the Supabase query that the frontend uses
    const response = await fetch('https://uimdbodamoeyukrghchb.supabase.co/rest/v1/courses?select=*,modules(*,lessons(*))&id=eq.a1b2c3d4-e5f6-7890-abcd-ef1234567890&is_published=eq.true', {
      method: 'GET',
      headers: {
        'apikey': 'YOUR_SUPABASE_ANON_KEY_HERE',
        'Authorization': 'Bearer YOUR_SUPABASE_ANON_KEY_HERE',
        'Content-Type': 'application/json',
      }
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    const data = await response.json();
    
    if (data && data.length > 0) {
      console.log('✅ Successfully fetched Vibe Coding course!');
      console.log(`Course Title: ${data[0].title}`);
      console.log(`Number of Modules: ${data[0].modules?.length || 0}`);
      
      // Count total lessons
      let totalLessons = 0;
      if (data[0].modules) {
        data[0].modules.forEach(module => {
          totalLessons += module.lessons?.length || 0;
        });
      }
      console.log(`Total Lessons: ${totalLessons}`);
      
      // Display module structure
      console.log('\n--- Course Structure ---');
      if (data[0].modules) {
        data[0].modules.forEach((module, index) => {
          console.log(`${index + 1}. ${module.title} (${module.lessons?.length || 0} lessons)`);
        });
      }
      
      return data[0];
    } else {
      console.log('❌ No course data found');
      return null;
    }
  } catch (error) {
    console.error('❌ Error fetching Vibe Coding course:', error.message);
    return null;
  }
};

// Run the test
testVibeCodingFetch();