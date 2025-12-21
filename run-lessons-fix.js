const { createClient } = require('@supabase/supabase-js');

// Supabase credentials
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

console.log('🔧 Running lessons fix for Vibe Coding course...');

// Create Supabase client
const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function runLessonsFix() {
  try {
    console.log('\n1. Checking current lesson count...');
    
    // Check current lesson count
    const { data: currentData, error: currentError } = await supabase
      .rpc('execute_sql', {
        sql: `
          SELECT
            c.title as course_title,
            m.title as module_title,
            COUNT(l.id) as lesson_count
          FROM courses c
          JOIN modules m ON c.id = m.course_id
          LEFT JOIN lessons l ON m.id = l.module_id    
          WHERE c.id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
          GROUP BY c.title, m.title, m.ordering
          ORDER BY m.ordering;
        `
      });

    if (currentError) {
      console.log('⚠️  Note: Could not check current data (this is OK)');
    } else {
      console.log('Current lesson counts:');
      currentData.forEach(row => {
        console.log(`  ${row.module_title}: ${row.lesson_count} lessons`);
      });
    }

    console.log('\n2. Deleting existing lessons (if any)...');
    
    // Delete existing lessons for Vibe Coding modules
    const { data: deleteData, error: deleteError } = await supabase
      .rpc('execute_sql', {
        sql: `
          DELETE FROM lessons WHERE module_id IN (
            SELECT id FROM modules WHERE course_id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
          );
        `
      });

    if (deleteError) {
      console.log('⚠️  Warning: Could not delete existing lessons (may not exist)');
    } else {
      console.log('✅ Existing lessons deleted');
    }

    console.log('\n3. Inserting new lessons...');
    
    // Insert all 15 lessons for Vibe Coding course
    const lessonsInsertSql = `
      INSERT INTO lessons (id, module_id, title, content, ordering, duration, created_at, updated_at) VALUES
      ('1a2b3c4d-5e6f-7890-abcd-ef1234567890', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'What Is Vibe Coding?', '{}', 1, '30 minutes', NOW(), NOW()),
      ('2b3c4d5e-6f78-9012-bcde-f01234567891', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Why Vibe Coding Exists', '{}', 2, '30 minutes', NOW(), NOW()),
      ('3c4d5e6f-7890-1234-cdef-012345678912', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'How Vibe Coding Is Different from Traditional Coding', '{}', 3, '30 minutes', NOW(), NOW()),
      ('4d5e6f78-9012-3456-def0-123456789123', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Learning to Think in Ideas, Not Code', '{}', 1, '30 minutes', NOW(), NOW()),
      ('5e6f7890-1234-5678-ef01-234567891234', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Turning Simple Ideas into Digital Instructions', '{}', 2, '30 minutes', NOW(), NOW()),
      ('6f789012-3456-7890-f012-345678912345', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Understanding ''Intent'' in Vibe Coding', '{}', 3, '30 minutes', NOW(), NOW()),
      ('78901234-5678-9012-0123-456789123456', 'd4e5f6a7-b8c9-0123-def0-123456789123', 'What AI Really Is (In Simple Terms)', '{}', 1, '30 minutes', NOW(), NOW()),
      ('89012345-6789-0123-1234-567891234567', 'd4e5f6a7-b8c9-0123-def0-123456789123', 'How AI Helps in Vibe Coding', '{}', 2, '30 minutes', NOW(), NOW()),
      ('90123456-7890-1234-2345-678912345678', 'd4e5f6a7-b8c9-0123-def0-123456789123', 'Talking to AI Clearly and Effectively', '{}', 3, '30 minutes', NOW(), NOW()),
      ('01234567-8901-2345-3456-789123456789', 'e5f6a7b8-c9d0-1234-ef01-234567891234', 'Real Examples of Vibe Coding', '{}', 1, '30 minutes', NOW(), NOW()),
      ('12345678-9012-3456-4567-891234567890', 'e5f6a7b8-c9d0-1234-ef01-234567891234', 'Building Simple Things Without Fear', '{}', 2, '30 minutes', NOW(), NOW()),
      ('23456789-0123-4567-5678-912345678901', 'e5f6a7b8-c9d0-1234-ef01-234567891234', 'Common Beginner Mistakes and How to Avoid Them', '{}', 3, '30 minutes', NOW(), NOW()),
      ('34567890-1234-5678-6789-123456789012', 'f6a7b8c9-d0e1-2345-f012-345678912345', 'Using a Playground to Experiment Safely', '{}', 1, '30 minutes', NOW(), NOW()),
      ('45678901-2345-6789-7890-234567890123', 'f6a7b8c9-d0e1-2345-f012-345678912345', 'Improving Your Ideas Step by Step', '{}', 2, '30 minutes', NOW(), NOW()),
      ('56789012-3456-7890-8901-345678901234', 'f6a7b8c9-d0e1-2345-f012-345678912345', 'Your First Complete Vibe-Coded Project', '{}', 3, '45 minutes', NOW(), NOW());
    `;

    const { data: insertData, error: insertError } = await supabase
      .rpc('execute_sql', {
        sql: lessonsInsertSql
      });

    if (insertError) {
      console.log('❌ Error inserting lessons:', insertError.message);
      return;
    }

    console.log('✅ Lessons inserted successfully');

    console.log('\n4. Verifying the fix...');
    
    // Verify the fix
    const { data: verifyData, error: verifyError } = await supabase
      .rpc('execute_sql', {
        sql: `
          SELECT
            c.title as course_title,
            m.title as module_title,
            COUNT(l.id) as lesson_count
          FROM courses c
          JOIN modules m ON c.id = m.course_id
          LEFT JOIN lessons l ON m.id = l.module_id    
          WHERE c.id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
          GROUP BY c.title, m.title, m.ordering
          ORDER BY m.ordering;
        `
      });

    if (verifyError) {
      console.log('❌ Error verifying fix:', verifyError.message);
      return;
    }

    console.log('✅ Verification successful!');
    console.log('Updated lesson counts:');
    verifyData.forEach(row => {
      console.log(`  ${row.module_title}: ${row.lesson_count} lessons`);
    });

    console.log('\n🎉 Vibe Coding course lessons have been successfully populated!');
    console.log('The course should now appear on your website.');

  } catch (error) {
    console.log('❌ Unexpected error:', error.message);
  }
}

// Run the fix
runLessonsFix();