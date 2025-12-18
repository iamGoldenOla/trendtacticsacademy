/**
 * Post-Deployment Test Script
 * Run this script in your browser console after deployment to verify everything is working
 */

console.log('🚀 Starting Post-Deployment Verification...');

// Test 1: Check if we can connect to Supabase
console.log('\n📋 Test 1: Supabase Connection');
fetch('https://uimdbodamoeyukrghchb.supabase.co/rest/v1/courses?select=id,title,is_published&limit=3', {
  headers: {
    'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc'
  }
})
.then(response => {
  if (response.ok) {
    console.log('✅ Test 1 PASSED: Successfully connected to Supabase');
    return response.json();
  } else {
    throw new Error(`HTTP ${response.status}: ${response.statusText}`);
  }
})
.then(data => {
  console.log('📚 Courses found:', data.length);
  data.forEach(course => {
    console.log(`   • ${course.title} (${course.id}) - Published: ${course.is_published}`);
  });
  
  // Test 2: Check if we can load a specific course (if any exist)
  if (data.length > 0) {
    const courseId = data[0].id;
    console.log(`\n📋 Test 2: Loading specific course (${courseId})`);
    
    fetch(`https://uimdbodamoeyukrghchb.supabase.co/rest/v1/courses?select=*,modules(id,title,lessons(id,title))&id=eq.${courseId}`, {
      headers: {
        'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc'
      }
    })
    .then(response => {
      if (response.ok) {
        console.log('✅ Test 2 PASSED: Successfully loaded specific course');
        return response.json();
      } else {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
    })
    .then(courseData => {
      console.log('📖 Course details:', courseData[0].title);
      if (courseData[0].modules && courseData[0].modules.length > 0) {
        console.log('📦 Modules found:', courseData[0].modules.length);
        courseData[0].modules.forEach(module => {
          console.log(`   • ${module.title}`);
          if (module.lessons && module.lessons.length > 0) {
            console.log(`     └─ Lessons: ${module.lessons.length}`);
          }
        });
      } else {
        console.log('⚠️  No modules found for this course');
      }
    })
    .catch(error => {
      console.error('❌ Test 2 FAILED:', error);
    });
  }
})
.catch(error => {
  console.error('❌ Test 1 FAILED:', error);
});

// Test 3: Check if Puter.js would load (we can't actually load it in this context)
console.log('\n📋 Test 3: Puter.js Availability Check');
console.log('ℹ️  Puter.js should load from https://js.puter.com/v2/');
console.log('ℹ️  Check Network tab to verify successful loading');

console.log('\n🎉 Verification complete! Check results above.');

// Additional helpful information
console.log('\n💡 Tips:');
console.log('• Check the Network tab for any failed requests');
console.log('• Look for CSP violations in the Console tab');
console.log('• Verify all resources load with status 200');