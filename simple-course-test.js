// Simple test to check if courses are loading
console.log('Testing course loading...');

// Simulate what the frontend does
const fetch = require('node-fetch');

async function testCoursesEndpoint() {
  try {
    console.log('Fetching courses from API...');
    
    // Since the frontend uses direct Supabase calls, let's check if we can access the courses
    const response = await fetch('https://uimdbodamoeyukrghchb.supabase.co/rest/v1/courses?select=*', {
      headers: {
        'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc'
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