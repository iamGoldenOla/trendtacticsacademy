/**
 * Debug Script for Frontend Course Display Issues
 * This script helps identify why courses aren't showing on the homepage
 */

// Simulate the courseService.getAllCourses function to see what data is being returned
async function debugCourseFetch() {
    console.log('🔍 Debugging course fetch from frontend...\n');
    
    try {
        // Import the actual course service
        const { createClient } = await import('@supabase/supabase-js');
        
        // Use the same credentials as in your frontend
        const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
        const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';
        
        const supabase = createClient(supabaseUrl, supabaseAnonKey);
        
        console.log('🔌 Fetching courses with the same query as frontend...');
        
        // Execute the exact same query as in courseService.getAllCourses()
        // Fixed the relationship syntax based on the error message
        const { data, error } = await supabase
            .from('courses')
            .select(`
                *,
                modules!fk_modules_course_id (
                    id,
                    title,
                    description,
                    ordering,
                    duration,
                    lessons!fk_lessons_module_id (
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
            console.error('❌ Supabase query error:', error);
            return;
        }
        
        console.log(`✅ Successfully fetched ${data.length} courses\n`);
        
        if (data.length > 0) {
            console.log('📋 First course details:');
            const firstCourse = data[0];
            console.log(`  Title: ${firstCourse.title}`);
            console.log(`  ID: ${firstCourse.id}`);
            console.log(`  Type of ID: ${typeof firstCourse.id}`);
            console.log(`  Is valid UUID: ${/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(firstCourse.id)}`);
            console.log(`  Modules: ${firstCourse.modules ? firstCourse.modules.length : 0}`);
            
            if (firstCourse.modules && firstCourse.modules.length > 0) {
                console.log('  First module:');
                const firstModule = firstCourse.modules[0];
                console.log(`    Title: ${firstModule.title}`);
                console.log(`    ID: ${firstModule.id}`);
                console.log(`    Lessons: ${firstModule.lessons ? firstModule.lessons.length : 0}`);
            }
        }
        
        // Test the UUID validation logic from FIXED_Home.js
        console.log('\n🧪 Testing UUID validation logic...');
        const validCourses = data.filter(course => {
            return course.id && /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(course.id);
        });
        
        console.log(`  Valid courses with proper UUIDs: ${validCourses.length}`);
        console.log(`  Total courses: ${data.length}`);
        console.log(`  Validation passed: ${validCourses.length === data.length ? '✅ YES' : '❌ NO'}`);
        
        if (validCourses.length !== data.length) {
            console.log('  ⚠️  Some courses failed UUID validation!');
            data.forEach((course, index) => {
                const isValid = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(course.id);
                if (!isValid) {
                    console.log(`    Invalid course ${index + 1}: ${course.title} (ID: ${course.id})`);
                }
            });
        }
        
        // Check if we're in development mode (which might cause issues)
        console.log('\n🖥️  Environment check...');
        console.log(`  REACT_APP_ENV: ${process.env.REACT_APP_ENV || 'not set'}`);
        console.log(`  NODE_ENV: ${process.env.NODE_ENV || 'not set'}`);
        
        console.log('\n✅ Debug complete!');
        console.log('Summary:');
        console.log(`  - Database has ${data.length} published courses`);
        console.log(`  - All courses have valid UUIDs: ${validCourses.length === data.length ? 'YES' : 'NO'}`);
        console.log(`  - Courses should display on homepage: ${validCourses.length > 0 ? 'YES' : 'NO'}`);
        
    } catch (error) {
        console.error('💥 Unexpected error during debug:', error.message);
        console.error('Stack trace:', error.stack);
    }
}

debugCourseFetch();