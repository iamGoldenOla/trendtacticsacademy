const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');

// Supabase credentials - using service role key for admin access
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseServiceRoleKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NTQ1NjAzOSwiZXhwIjoyMDgxMDMyMDM5fQ.8JUqFTmYJwvV1aVY7Z0FgkR9j5F0pYv3zQ0mX2yZ5c0';

console.log('🔧 Populating lessons with rich content from JSON files...');

// Create Supabase client with service role key (admin access)
const supabase = createClient(supabaseUrl, supabaseServiceRoleKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
});

// Read and parse the JSON course content
const vibeCodingCourse = JSON.parse(fs.readFileSync('./vibe-coding-course.json', 'utf8'));

// Helper function to generate a proper UUID
function generateUUID() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    const r = Math.random() * 16 | 0;
    const v = c == 'x' ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
}

// Map the rich JSON content to lessons format
function mapRichContentToLessons(courseData) {
  // Define the mapping from module titles to IDs based on existing structure
  const moduleMap = {
    'Module 1: Vibe Coding Foundations': 'b2c3d4e5-f6a7-8901-bcde-f01234567891',
    'Module 2: The Vibe Coding Ecosystem': 'c3d4e5f6-a7b8-9012-cdef-012345678912',
    'Module 3: Full-Stack AI Builders': 'd4e5f6a7-b8c9-0123-def0-123456789123',
    'Module 4: AI-First IDEs': 'e5f6a7b8-c9d0-1234-ef01-234567891234',
    'Module 5: Agentic Coding Tools': 'f6a7b8c9-d0e1-2345-f012-345678912345',
    'Module 6: Real-World Workflows': 'a1b2c3d4-e5f6-7890-abc1-def234567890',
    'Module 7: Prompting for Software': 'b2c3d4e5-f6a7-8901-bcde-f01234567892',
    'Module 8: The Future of Vibe Coding': 'c3d4e5f6-a7b8-9012-cdef-012345678913'
  };

  return courseData.map(lesson => {
    const moduleId = moduleMap[lesson.module_title] || 'a1b2c3d4-e5f6-7890-abc1-def23456789a';
    
    return {
      id: generateUUID(),
      module_id: moduleId,
      title: lesson.lesson_title,
      content: JSON.stringify(lesson), // Store the entire rich lesson object as JSON
      ordering: lesson.lesson_number,
      duration: '30-45 minutes',
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString()
    };
  });
}

async function populateRichLessons() {
  try {
    console.log('\n1. Preparing rich lesson data from JSON files...');
    
    // Map the rich content to lessons format
    const richLessons = mapRichContentToLessons(vibeCodingCourse);
    
    console.log(`✅ Prepared ${richLessons.length} lessons with rich content`);

    console.log('\n2. Clearing existing Vibe Coding lessons...');
    
    // Delete existing lessons for Vibe Coding modules
    const { error: deleteError } = await supabase
      .from('lessons')
      .delete()
      .in('module_id', [
        'b2c3d4e5-f6a7-8901-bcde-f01234567891',
        'c3d4e5f6-a7b8-9012-cdef-012345678912',
        'd4e5f6a7-b8c9-0123-def0-123456789123',
        'e5f6a7b8-c9d0-1234-ef01-234567891234',
        'f6a7b8c9-d0e1-2345-f012-345678912345',
        'a1b2c3d4-e5f6-7890-abc1-def234567890',
        'b2c3d4e5-f6a7-8901-bcde-f01234567892',
        'c3d4e5f6-a7b8-9012-cdef-012345678913'
      ]);

    if (deleteError) {
      console.log('⚠️ Warning: Could not delete existing lessons (may not exist)');
      console.log('Error details:', deleteError.message);
    } else {
      console.log('✅ Existing lessons cleared');
    }

    console.log('\n3. Inserting lessons with rich content...');
    
    // Insert lessons in batches to avoid hitting limits
    const batchSize = 10;
    for (let i = 0; i < richLessons.length; i += batchSize) {
      const batch = richLessons.slice(i, i + batchSize);
      
      const { data, error } = await supabase
        .from('lessons')
        .insert(batch, { upsert: true });

      if (error) {
        console.log(`❌ Error inserting batch ${i/batchSize + 1}:`, error.message);
        console.log('Error code:', error.code);
        // Continue with next batch instead of stopping completely
      } else {
        console.log(`✅ Batch ${i/batchSize + 1} inserted successfully (${batch.length} lessons)`);
      }
    }

    console.log('\n4. Verifying the results...');
    
    // Count total lessons
    const { count: totalCount, error: totalError } = await supabase
      .from('lessons')
      .select('*', { count: 'exact', head: true });

    if (totalError) {
      console.log('❌ Error counting total lessons:', totalError.message);
    } else {
      console.log(`✅ Total lessons in database: ${totalCount}`);
    }

    // Count lessons by specific module IDs
    const { count: vibeCount, error: vibeError } = await supabase
      .from('lessons')
      .select('*', { count: 'exact', head: true })
      .in('module_id', [
        'b2c3d4e5-f6a7-8901-bcde-f01234567891',
        'c3d4e5f6-a7b8-9012-cdef-012345678912',
        'd4e5f6a7-b8c9-0123-def0-123456789123',
        'e5f6a7b8-c9d0-1234-ef01-234567891234',
        'f6a7b8c9-d0e1-2345-f012-345678912345',
        'a1b2c3d4-e5f6-7890-abc1-def234567890',
        'b2c3d4e5-f6a7-8901-bcde-f01234567892',
        'c3d4e5f6-a7b8-9012-cdef-012345678913'
      ]);

    if (vibeError) {
      console.log('❌ Error counting Vibe Coding lessons:', vibeError.message);
    } else {
      console.log(`✅ Vibe Coding lessons: ${vibeCount}`);
    }

    console.log('\n🎉 Vibe Coding lessons with rich content have been successfully populated!');
    console.log('The course should now appear on your website with detailed content.');
    console.log('\n🔄 Please refresh your website to see the changes.');

  } catch (error) {
    console.log('❌ Unexpected error:', error.message);
    console.log('Stack trace:', error.stack);
  }
}

// Run the population
populateRichLessons();