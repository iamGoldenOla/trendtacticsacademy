// Script to verify courses in Supabase database
// Run this in your browser console or as a Node.js script

async function verifySupabaseCourses() {
    const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
    const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';
    
    console.log('🔍 Checking Supabase courses...');
    
    try {
        // Test 1: Get all courses
        console.log('\n📋 Fetching all courses...');
        const coursesResponse = await fetch(`${supabaseUrl}/rest/v1/courses?select=*`, {
            headers: {
                'apikey': supabaseKey,
                'Authorization': `Bearer ${supabaseKey}`
            }
        });
        
        if (!coursesResponse.ok) {
            throw new Error(`HTTP error! status: ${coursesResponse.status}`);
        }
        
        const courses = await coursesResponse.json();
        console.log(`✅ Found ${courses.length} courses:`);
        courses.forEach((course, index) => {
            console.log(`  ${index + 1}. ID: ${course.id} | Title: "${course.title}" | Published: ${course.is_published}`);
        });
        
        // Test 2: Get courses with modules and lessons
        console.log('\n📚 Fetching courses with modules and lessons...');
        const detailedResponse = await fetch(`${supabaseUrl}/rest/v1/courses?select=*,modules(id,title,lessons(id,title))&limit=3`, {
            headers: {
                'apikey': supabaseKey,
                'Authorization': `Bearer ${supabaseKey}`
            }
        });
        
        if (!detailedResponse.ok) {
            throw new Error(`HTTP error! status: ${detailedResponse.status}`);
        }
        
        const detailedCourses = await detailedResponse.json();
        console.log('✅ Detailed course structure:');
        detailedCourses.forEach(course => {
            console.log(`  Course: ${course.title} (${course.id})`);
            if (course.modules && course.modules.length > 0) {
                course.modules.forEach(module => {
                    console.log(`    ├── Module: ${module.title}`);
                    if (module.lessons && module.lessons.length > 0) {
                        module.lessons.forEach(lesson => {
                            console.log(`    │   └── Lesson: ${lesson.title} (${lesson.id})`);
                        });
                    } else {
                        console.log(`    │   └── No lessons`);
                    }
                });
            } else {
                console.log(`    └── No modules`);
            }
        });
        
        // Test 3: Try to fetch a specific course (like dm-1)
        console.log('\n🔎 Testing invalid course ID (dm-1)...');
        const invalidResponse = await fetch(`${supabaseUrl}/rest/v1/courses?id=eq.dm-1`, {
            headers: {
                'apikey': supabaseKey,
                'Authorization': `Bearer ${supabaseKey}`
            }
        });
        
        const invalidResult = await invalidResponse.json();
        if (invalidResult.length === 0) {
            console.log('✅ Correctly returned no results for invalid ID "dm-1"');
        } else {
            console.log('⚠️  Unexpectedly found results for "dm-1"');
            console.log(invalidResult);
        }
        
        console.log('\n🎉 Supabase verification complete!');
        console.log('\n💡 Next steps:');
        console.log('1. Use the real course IDs shown above in your URLs');
        console.log('2. Update your frontend to use real Supabase data instead of mock data');
        console.log('3. Clear your browser cache and test again');
        
    } catch (error) {
        console.error('❌ Error verifying Supabase courses:', error);
        console.log('\n🔧 Troubleshooting tips:');
        console.log('1. Check your internet connection');
        console.log('2. Verify the Supabase URL and API key are correct');
        console.log('3. Ensure your Supabase project is not paused or deleted');
    }
}

// Run the verification
verifySupabaseCourses();

// Export for Node.js usage
if (typeof module !== 'undefined' && module.exports) {
    module.exports = verifySupabaseCourses;
}