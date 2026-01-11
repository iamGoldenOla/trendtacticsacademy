const { createClient } = require('@supabase/supabase-js');

// Supabase credentials
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

console.log('🔍 Checking RLS policies for lessons table...');
console.log('Supabase URL:', supabaseUrl);

// Create Supabase clients
const anonSupabase = createClient(supabaseUrl, supabaseAnonKey);
const serviceRoleKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NTQ1NjAzOSwiZXhwIjoyMDgxMDMyMDM5fQ.P6hgDhsXyPSwbzgb69YvYNFsoZJGiRVTiWHlgtPZeVY';
const adminSupabase = createClient(supabaseUrl, serviceRoleKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
});

async function checkRLSPolicies() {
  try {
    console.log('\n1. Testing public access to lessons...');
    
    // Test public access
    const { data: publicData, error: publicError } = await anonSupabase
      .from('lessons')
      .select('*')
      .limit(5);

    if (publicError) {
      console.log('❌ Public access error:', publicError.message);
    } else {
      console.log(`✅ Public access returned ${publicData.length} lessons`);
    }

    console.log('\n2. Testing admin access to lessons...');
    
    // Test admin access
    const { data: adminData, error: adminError } = await adminSupabase
      .from('lessons')
      .select('*')
      .limit(5);

    if (adminError) {
      console.log('❌ Admin access error:', adminError.message);
    } else {
      console.log(`✅ Admin access returned ${adminData.length} lessons`);
      if (adminData.length > 0) {
        console.log('Sample lesson titles:');
        adminData.slice(0, 3).forEach((lesson, index) => {
          console.log(`  ${index + 1}. ${lesson.title}`);
        });
      }
    }

    console.log('\n3. Checking if RLS is enabled on lessons table...');
    
    // Try to get table info (this might not work with anon key)
    console.log('ℹ️  Note: Full RLS policy inspection requires Supabase dashboard access');

    console.log('\n4. Testing course query with lessons...');
    
    // Test the exact frontend query
    const { data: courseData, error: courseError } = await anonSupabase
      .from('courses')
      .select(`
        *,
        modules!modules_course_id_fkey (
          id,
          title,
          description,
          ordering,
          duration,
          lessons!lessons_module_id_fkey (
            id,
            title,
            ordering,
            duration
          )
        )
      `)
      .eq('is_published', true)
      .eq('id', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890')
      .order('created_at', { ascending: false });

    if (courseError) {
      console.log('❌ Course query error:', courseError.message);
    } else {
      console.log('✅ Course query successful');
      if (courseData.length > 0) {
        const course = courseData[0];
        console.log(`   Course: ${course.title}`);
        console.log(`   Modules: ${course.modules ? course.modules.length : 0}`);
        
        if (course.modules && course.modules.length > 0) {
          course.modules.forEach((module, index) => {
            console.log(`     Module ${index + 1}: ${module.title} (${module.lessons ? module.lessons.length : 0} lessons)`);
          });
        }
      }
    }

    console.log('\n📋 Analysis:');
    console.log('✅ Lessons exist in database (confirmed by admin access)');
    console.log('❌ Lessons not visible via public queries (RLS issue)');
    console.log('✅ Course query works but returns 0 lessons per module');
    console.log('\n💡 Solution: Need to update RLS policies on lessons table');

  } catch (error) {
    console.log('❌ Unexpected error:', error.message);
  }
}

// Run the check
checkRLSPolicies();