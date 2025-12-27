// Simple test to check if courses are loading
console.log('Testing course loading...');

// Simulate what the frontend does
const fetch = require('node-fetch');

async function testCoursesEndpoint() {
  try {
    console.log('Fetching courses from API...');
    
    // Since the frontend uses direct Supabase calls, let's check if we can access the courses
    const ANON_KEY = process.env.SUPABASE_ANON_KEY;
    if (!ANON_KEY) {
      console.error('Missing SUPABASE_ANON_KEY environment variable. Aborting request.');
      return;
    }
    const response = await fetch('https://uimdbodamoeyukrghchb.supabase.co/rest/v1/courses?select=*', {
      headers: {
        'apikey': ANON_KEY,
        'Authorization': 'Bearer ' + ANON_KEY
      }
    });
    
    if (!response.ok) {
      console.error('Failed to fetch courses:', response.status, response.statusText);
      return;
    }
    
    const courses = await response.json();
    console.log(`Found ${courses.length} courses`);
    
    if (courses.length > 0) {
      console.log('Sample courses:');
      courses.slice(0, 3).forEach(course => {
        console.log(`- ${course.title} (${course.category})`);
      });
    }
  } catch (error) {
    console.error('Error:', error.message);
  }
}

testCoursesEndpoint();