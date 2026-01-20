/**
 * Check existing courses in Supabase
 */

const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

async function checkCourses() {
    console.log('🔍 Checking Existing Courses\n');

    try {
        const response = await fetch(`${SUPABASE_URL}/rest/v1/courses?select=*`, {
            method: 'GET',
            headers: {
                'apikey': SUPABASE_KEY,
                'Authorization': `Bearer ${SUPABASE_KEY}`,
                'Content-Type': 'application/json'
            }
        });

        if (response.ok) {
            const courses = await response.json();
            console.log(`✅ Found ${courses.length} courses:`);

            courses.forEach(course => {
                console.log(`\n📚 Course: ${course.title} (ID: ${course.id})`);
                console.log(`   Status: ${course.is_published ? 'Published' : 'Draft'}`);
                console.log(`   Instructor: ${course.instructor_id}`);
                console.log(`   Created: ${course.created_at}`);
            });

            // Check for modules and lessons for each course
            for (const course of courses) {
                console.log(`\n🔍 Checking modules for course: ${course.title}`);

                const modulesResponse = await fetch(`${SUPABASE_URL}/rest/v1/modules?course_id=eq.${course.id}&select=*`, {
                    method: 'GET',
                    headers: {
                        'apikey': SUPABASE_KEY,
                        'Authorization': `Bearer ${SUPABASE_KEY}`,
                        'Content-Type': 'application/json'
                    }
                });

                if (modulesResponse.ok) {
                    const modules = await modulesResponse.json();
                    console.log(`   📁 ${modules.length} modules found`);

                    for (const module of modules) {
                        const lessonsResponse = await fetch(`${SUPABASE_URL}/rest/v1/lessons?module_id=eq.${module.id}&select=*`, {
                            method: 'GET',
                            headers: {
                                'apikey': SUPABASE_KEY,
                                'Authorization': `Bearer ${SUPABASE_KEY}`,
                                'Content-Type': 'application/json'
                            }
                        });

                        if (lessonsResponse.ok) {
                            const lessons = await lessonsResponse.json();
                            console.log(`      📄 Module "${module.title}": ${lessons.length} lessons`);
                        }
                    }
                }
            }

        } else {
            console.log(`❌ Error fetching courses: ${response.status} ${response.statusText}`);
        }

    } catch (error) {
        console.log(`❌ Error: ${error.message}`);
    }
}

checkCourses();