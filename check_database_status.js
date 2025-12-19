import { createClient } from '@supabase/supabase-js';

// Supabase credentials - replace with your actual values
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function checkDatabaseStatus() {
    console.log('🔍 Checking database status...\n');
    
    try {
        // Check if we can connect to Supabase
        console.log('🔌 Testing Supabase connection...');
        const { data: healthData, error: healthError } = await supabase
            .from('courses')
            .select('id')
            .limit(1);
            
        if (healthError) {
            console.error('❌ Connection failed:', healthError.message);
            return;
        }
        console.log('✅ Supabase connection successful\n');
        
        // Get total number of courses
        console.log('📚 Checking courses...');
        const { data: coursesData, error: coursesError } = await supabase
            .from('courses')
            .select('id');
            
        if (coursesError) {
            console.error('❌ Error fetching courses:', coursesError.message);
            return;
        }
        const totalCourses = coursesData.length;
        console.log(`📊 Total courses in database: ${totalCourses}\n`);
        
        // Get published courses
        console.log('📰 Checking published courses...');
        const { data: publishedCourses, error: publishedError } = await supabase
            .from('courses')
            .select('id, title, is_published')
            .eq('is_published', true)
            .order('created_at', { ascending: false });
            
        if (publishedError) {
            console.error('❌ Error fetching published courses:', publishedError.message);
            return;
        }
        
        console.log(`📰 Published courses: ${publishedCourses.length}\n`);
        
        if (publishedCourses.length > 0) {
            console.log('📋 Published course details:');
            publishedCourses.forEach((course, index) => {
                console.log(`  ${index + 1}. ${course.title} (ID: ${course.id})`);
            });
        } else {
            console.log('⚠️  No published courses found');
        }
        
        // Check modules
        console.log('\n📂 Checking modules...');
        const { data: modulesData, error: modulesError } = await supabase
            .from('modules')
            .select('id');
            
        if (modulesError) {
            console.error('❌ Error fetching modules:', modulesError.message);
            return;
        }
        const totalModules = modulesData.length;
        console.log(`📊 Total modules in database: ${totalModules}\n`);
        
        // Check lessons
        console.log('📖 Checking lessons...');
        const { data: lessonsData, error: lessonsError } = await supabase
            .from('lessons')
            .select('id');
            
        if (lessonsError) {
            console.error('❌ Error fetching lessons:', lessonsError.message);
            return;
        }
        const totalLessons = lessonsData.length;
        console.log(`📊 Total lessons in database: ${totalLessons}\n`);
        
        // Check RLS policies
        console.log('🔐 Checking RLS policies...');
        console.log('ℹ️  Anonymous users should be able to read published courses, modules, and lessons');
        console.log('ℹ️  If you\'re seeing permission errors, check your Row Level Security policies\n');
        
        // Summary
        console.log('✅ Database Status Check Complete');
        console.log('================================');
        console.log(`Total Courses: ${totalCourses}`);
        console.log(`Published Courses: ${publishedCourses.length}`);
        console.log(`Total Modules: ${totalModules}`);
        console.log(`Total Lessons: ${totalLessons}`);
        
        if (totalCourses === 0) {
            console.log('\n⚠️  Recommendation: Add some courses to your database');
        } else if (publishedCourses.length === 0) {
            console.log('\n⚠️  Recommendation: Publish some courses (set is_published = true)');
        } else {
            console.log('\n🎉 Your database looks good! Published courses are available.');
        }
        
    } catch (error) {
        console.error('💥 Unexpected error:', error.message);
        console.error('Stack trace:', error.stack);
    }
}

checkDatabaseStatus();