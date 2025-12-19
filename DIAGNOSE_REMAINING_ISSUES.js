/**
 * Diagnose Remaining Issues Script
 * This script helps identify what's still causing the "Error Loading Course" issue
 */

console.log('🔍 Diagnosing Remaining Issues...');

// Test 1: Check if the CSP is being applied correctly
console.log('\n📋 Test 1: Checking CSP Policy');
const metaTags = document.querySelectorAll('meta[http-equiv="Content-Security-Policy"]');
if (metaTags.length > 0) {
  metaTags.forEach((tag, index) => {
    console.log(`📄 CSP Meta Tag ${index + 1}:`, tag.content);
    
    // Check if required domains are present
    if (tag.content.includes('uimdbodamoeyukrghchb.supabase.co')) {
      console.log('✅ Supabase domain found in CSP');
    } else {
      console.log('❌ Supabase domain missing from CSP');
    }
    
    if (tag.content.includes('js.puter.com')) {
      console.log('✅ Puter.js domain found in CSP');
    } else {
      console.log('❌ Puter.js domain missing from CSP');
    }
  });
} else {
  console.log('⚠️ No CSP meta tags found');
}

// Test 2: Check network requests to identify where the failure occurs
console.log('\n📋 Test 2: Monitoring Network Requests');
const originalFetch = window.fetch;
window.fetch = function(...args) {
  const url = args[0];
  console.log('📡 Fetch Request:', url);
  
  // Check if this is a Supabase request
  if (url.includes('uimdbodamoeyukrghchb.supabase.co')) {
    console.log('🔍 Supabase Request Detected');
  }
  
  return originalFetch.apply(this, args);
};

// Test 3: Check if we're using the correct course IDs
console.log('\n📋 Test 3: Checking Current Page Course ID');
const path = window.location.pathname;
console.log('📍 Current Path:', path);

if (path.includes('/course/')) {
  const courseId = path.split('/course/')[1];
  console.log('🆔 Course ID from URL:', courseId);
  
  // Validate if it's a UUID
  const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
  if (uuidRegex.test(courseId)) {
    console.log('✅ Course ID is valid UUID');
  } else {
    console.log('❌ Course ID is NOT a valid UUID');
    console.log('💡 This might be the issue - we need valid UUIDs, not mock IDs like "dm-1"');
  }
}

// Test 4: Try to manually fetch a course to see what happens
console.log('\n📋 Test 4: Manual Course Fetch Test');
const testCourseFetch = async () => {
  try {
    // First, let's get a list of real courses
    console.log('📚 Fetching real courses...');
    const coursesResponse = await fetch('https://uimdbodamoeyukrghchb.supabase.co/rest/v1/courses?select=id,title,is_published&is_published=eq.true&limit=3', {
      headers: {
        'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc'
      }
    });
    
    if (coursesResponse.ok) {
      const courses = await coursesResponse.json();
      console.log('✅ Successfully fetched courses:', courses);
      
      if (courses.length > 0) {
        const firstCourseId = courses[0].id;
        console.log('🎯 Testing with first course ID:', firstCourseId);
        
        // Try to fetch the specific course
        const courseResponse = await fetch(`https://uimdbodamoeyukrghchb.supabase.co/rest/v1/courses?select=*,modules(id,title,lessons(id,title))&id=eq.${firstCourseId}`, {
          headers: {
            'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc',
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc'
          }
        });
        
        if (courseResponse.ok) {
          const courseData = await courseResponse.json();
          console.log('✅ Successfully fetched specific course:', courseData[0]);
        } else {
          console.log('❌ Failed to fetch specific course:', courseResponse.status, courseResponse.statusText);
        }
      }
    } else {
      console.log('❌ Failed to fetch courses:', coursesResponse.status, coursesResponse.statusText);
    }
  } catch (error) {
    console.log('❌ Error during manual fetch test:', error.message);
  }
};

// Run the test
testCourseFetch();

console.log('\n🔍 Diagnosis Complete');
console.log('\n💡 Recommendations:');
console.log('1. Check if server-side headers are overriding CSP');
console.log('2. Verify that you\'re accessing courses with valid UUIDs, not mock IDs');
console.log('3. Check browser console for specific error messages');
console.log('4. Clear browser cache and try again');