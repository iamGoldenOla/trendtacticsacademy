// Fix Homepage Featured Courses - Set all courses as featured
const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function setAllCoursesAsFeatured() {
    try {
        console.log('🔍 Checking current courses...');

        // Get all courses
        const { data: courses, error: fetchError } = await supabase
            .from('courses')
            .select('id, title, is_featured, is_published');

        if (fetchError) {
            console.error('❌ Error fetching courses:', fetchError.message);
            return;
        }

        console.log('\n📊 Current courses:');
        courses.forEach((course, i) => {
            console.log(`${i + 1}. ${course.title}`);
            console.log(`   Featured: ${course.is_featured}, Published: ${course.is_published}`);
        });

        // Update all courses to be featured and published
        console.log('\n🔧 Updating all courses to be featured and published...');

        const { data: updated, error: updateError } = await supabase
            .from('courses')
            .update({
                is_featured: true,
                is_published: true
            })
            .neq('id', '00000000-0000-0000-0000-000000000000') // Update all courses
            .select();

        if (updateError) {
            console.error('❌ Error updating courses:', updateError.message);
            return;
        }

        console.log(`\n✅ Successfully updated ${updated.length} courses!`);

        // Verify the update
        console.log('\n🔍 Verifying updates...');
        const { data: verifyData } = await supabase
            .from('courses')
            .select('id, title, is_featured, is_published')
            .order('created_at', { ascending: false });

        console.log('\n📊 Updated courses:');
        verifyData.forEach((course, i) => {
            const status = course.is_featured && course.is_published ? '✅' : '❌';
            console.log(`${status} ${i + 1}. ${course.title} (Featured: ${course.is_featured}, Published: ${course.is_published})`);
        });

        const allFeatured = verifyData.every(c => c.is_featured && c.is_published);
        if (allFeatured) {
            console.log('\n🎉 SUCCESS! All courses are now featured and published!');
            console.log('The homepage should now show all 4 courses.');
        } else {
            console.log('\n⚠️ Warning: Some courses may not be featured/published');
        }

    } catch (err) {
        console.error('❌ Error:', err.message);
    }
}

// Run the script
setAllCoursesAsFeatured();
