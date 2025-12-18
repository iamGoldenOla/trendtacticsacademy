// Diagnostic script to check Supabase connection and table structure
const { createClient } = require('@supabase/supabase-js');

// Supabase configuration
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function diagnoseSupabase() {
  console.log('=== Supabase Diagnostics ===');
  console.log('URL:', supabaseUrl);
  console.log('Anon Key exists:', !!supabaseAnonKey);
  
  try {
    // Test connection by listing tables
    console.log('\n--- Testing connection ---');
    const { data: tables, error: tablesError } = await supabase
      .from('courses')
      .select('id')
      .limit(1);
    
    if (tablesError) {
      console.error('❌ Connection test failed:', tablesError.message);
      console.log('Error details:', tablesError);
      return;
    }
    
    console.log('✅ Connection successful!');
    
    // Check if tables exist
    console.log('\n--- Checking table structure ---');
    
    // Check courses table
    try {
      const { data: courses, error: coursesError } = await supabase
        .from('courses')
        .select('count()', { count: 'exact' });
      
      if (coursesError) {
        console.log('❌ Courses table error:', coursesError.message);
      } else {
        console.log(`✅ Courses table exists. Row count: ${courses[0].count}`);
      }
    } catch (e) {
      console.log('❌ Error checking courses table:', e.message);
    }
    
    // Check modules table
    try {
      const { data: modules, error: modulesError } = await supabase
        .from('modules')
        .select('count()', { count: 'exact' });
      
      if (modulesError) {
        console.log('❌ Modules table error:', modulesError.message);
      } else {
        console.log(`✅ Modules table exists. Row count: ${modules[0].count}`);
      }
    } catch (e) {
      console.log('❌ Error checking modules table:', e.message);
    }
    
    // Check lessons table
    try {
      const { data: lessons, error: lessonsError } = await supabase
        .from('lessons')
        .select('count()', { count: 'exact' });
      
      if (lessonsError) {
        console.log('❌ Lessons table error:', lessonsError.message);
      } else {
        console.log(`✅ Lessons table exists. Row count: ${lessons[0].count}`);
      }
    } catch (e) {
      console.log('❌ Error checking lessons table:', e.message);
    }
    
    // Try to fetch actual course data
    console.log('\n--- Fetching sample data ---');
    const { data: sampleCourses, error: sampleError } = await supabase
      .from('courses')
      .select('*')
      .limit(3);
    
    if (sampleError) {
      console.log('❌ Error fetching sample courses:', sampleError.message);
    } else {
      console.log(`✅ Successfully fetched ${sampleCourses.length} sample courses:`);
      sampleCourses.forEach(course => {
        console.log(`  - ${course.title} (${course.id})`);
      });
    }
    
  } catch (error) {
    console.error('❌ Diagnostic failed with error:', error.message);
    console.error('Stack trace:', error.stack);
  }
  
  console.log('\n=== End Diagnostics ===');
}

// Run diagnostics
diagnoseSupabase();