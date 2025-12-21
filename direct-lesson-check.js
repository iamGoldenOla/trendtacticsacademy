const { createClient } = require('@supabase/supabase-js');

// Supabase credentials
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

console.log('🔍 Direct lesson check in Supabase...');
console.log('Supabase URL:', supabaseUrl);

// Create Supabase client
const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function directLessonCheck() {
  try {
    console.log('\n1. Counting all lessons in database...');
    
    // Count all lessons
    const { count: totalCount, error: countError } = await supabase
      .from('lessons')
      .select('*', { count: 'exact', head: true });

    if (countError) {
      console.log('❌ Error counting lessons:', countError.message);
      return;
    }

    console.log(`✅ Total lessons in database: ${totalCount}`);

    console.log('\n2. Checking lessons for Vibe Coding course modules...');
    
    // Check lessons for each specific module
    const modules = [
      { id: 'b2c3d4e5-f6a7-8901-bcde-f01234567891', name: 'Understanding Vibe Coding' },
      { id: 'c3d4e5f6-a7b8-9012-cdef-012345678912', name: 'Thinking Before Coding' },
      { id: 'd4e5f6a7-b8c9-0123-def0-123456789123', name: 'Working with AI as a Creative Partner' },
      { id: 'e5f6a7b8-c9d0-1234-ef01-234567891234', name: 'Vibe Coding in Real Life' },
      { id: 'f6a7b8c9-d0e1-2345-f012-345678912345', name: 'Exploring and Building with Confidence' }
    ];

    let totalFoundLessons = 0;
    for (const module of modules) {
      console.log(`\n   Checking module: ${module.name} (${module.id})`);
      
      // Get actual lesson data, not just count
      const { data: lessonsData, error: lessonsError } = await supabase
        .from('lessons')
        .select('*')
        .eq('module_id', module.id)
        .limit(10); // Limit to avoid huge responses

      if (lessonsError) {
        console.log(`   ❌ Error fetching lessons:`, lessonsError.message);
        continue;
      }

      console.log(`   ✅ Found ${lessonsData.length} lessons`);
      totalFoundLessons += lessonsData.length;
      
      // Show first few lessons
      if (lessonsData.length > 0) {
        console.log(`   Sample lessons:`);
        lessonsData.slice(0, Math.min(3, lessonsData.length)).forEach((lesson, index) => {
          console.log(`     ${index + 1}. ${lesson.title}`);
        });
      }
    }

    console.log(`\n📊 Total lessons found: ${totalFoundLessons}`);

    console.log('\n3. Checking with service role key (admin access)...');
    
    // Try with service role key to see if there's a permissions issue
    const supabaseServiceKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NTQ1NjAzOSwiZXhwIjoyMDgxMDMyMDM5fQ.P6hgDhsXyPSwbzgb69YvYNFsoZJGiRVTiWHlgtPZeVY';
    const adminSupabase = createClient(supabaseUrl, supabaseServiceKey, {
      auth: {
        autoRefreshToken: false,
        persistSession: false
      }
    });

    const { count: adminCount, error: adminCountError } = await adminSupabase
      .from('lessons')
      .select('*', { count: 'exact', head: true });

    if (adminCountError) {
      console.log('❌ Error with admin count:', adminCountError.message);
    } else {
      console.log(`✅ Admin count of lessons: ${adminCount}`);
    }

    console.log('\n📋 Summary:');
    console.log(`   Public access count: ${totalCount}`);
    console.log(`   Direct query found: ${totalFoundLessons}`);
    console.log(`   Admin access count: ${adminCount || 'N/A'}`);

  } catch (error) {
    console.log('❌ Unexpected error:', error.message);
    console.log('Stack trace:', error.stack);
  }
}

// Run the check
directLessonCheck();