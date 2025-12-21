const { createClient } = require('@supabase/supabase-js');

// Get Supabase credentials from environment variables
const supabaseUrl = process.env.SUPABASE_URL || 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseServiceRoleKey) {
  console.log('❌ Error: SUPABASE_SERVICE_ROLE_KEY environment variable is not set');
  console.log('\nPlease set your Supabase Service Role Key as an environment variable:');
  console.log('On Mac/Linux: export SUPABASE_SERVICE_ROLE_KEY=your_key_here');
  console.log('On Windows: set SUPABASE_SERVICE_ROLE_KEY=your_key_here');
  console.log('Or run: node populate-lessons-with-key.js YOUR_SERVICE_ROLE_KEY');
  process.exit(1);
}

console.log('🔧 Populating lessons for Vibe Coding course...');
console.log('Supabase URL:', supabaseUrl);

// Create Supabase client with service role key (admin access)
const supabase = createClient(supabaseUrl, supabaseServiceRoleKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
});

// Lessons data
const lessons = [
  // Module 1: Understanding Vibe Coding (3 lessons)
  { id: '1a2b3c4d-5e6f-7890-abcd-ef1234567890', module_id: 'b2c3d4e5-f6a7-8901-bcde-f01234567891', title: 'What Is Vibe Coding?', content: '{}', ordering: 1, duration: '30 minutes' },
  { id: '2b3c4d5e-6f78-9012-bcde-f01234567891', module_id: 'b2c3d4e5-f6a7-8901-bcde-f01234567891', title: 'Why Vibe Coding Exists', content: '{}', ordering: 2, duration: '30 minutes' },
  { id: '3c4d5e6f-7890-1234-cdef-012345678912', module_id: 'b2c3d4e5-f6a7-8901-bcde-f01234567891', title: 'How Vibe Coding Is Different from Traditional Coding', content: '{}', ordering: 3, duration: '30 minutes' },
  
  // Module 2: Thinking Before Coding (3 lessons)
  { id: '4d5e6f78-9012-3456-def0-123456789123', module_id: 'c3d4e5f6-a7b8-9012-cdef-012345678912', title: 'Learning to Think in Ideas, Not Code', content: '{}', ordering: 1, duration: '30 minutes' },
  { id: '5e6f7890-1234-5678-ef01-234567891234', module_id: 'c3d4e5f6-a7b8-9012-cdef-012345678912', title: 'Turning Simple Ideas into Digital Instructions', content: '{}', ordering: 2, duration: '30 minutes' },
  { id: '6f789012-3456-7890-f012-345678912345', module_id: 'c3d4e5f6-a7b8-9012-cdef-012345678912', title: 'Understanding \'Intent\' in Vibe Coding', content: '{}', ordering: 3, duration: '30 minutes' },
  
  // Module 3: Working with AI as a Creative Partner (3 lessons)
  { id: '78901234-5678-9012-0123-456789123456', module_id: 'd4e5f6a7-b8c9-0123-def0-123456789123', title: 'What AI Really Is (In Simple Terms)', content: '{}', ordering: 1, duration: '30 minutes' },
  { id: '89012345-6789-0123-1234-567891234567', module_id: 'd4e5f6a7-b8c9-0123-def0-123456789123', title: 'How AI Helps in Vibe Coding', content: '{}', ordering: 2, duration: '30 minutes' },
  { id: '90123456-7890-1234-2345-678912345678', module_id: 'd4e5f6a7-b8c9-0123-def0-123456789123', title: 'Talking to AI Clearly and Effectively', content: '{}', ordering: 3, duration: '30 minutes' },
  
  // Module 4: Vibe Coding in Real Life (3 lessons)
  { id: '01234567-8901-2345-3456-789123456789', module_id: 'e5f6a7b8-c9d0-1234-ef01-234567891234', title: 'Real Examples of Vibe Coding', content: '{}', ordering: 1, duration: '30 minutes' },
  { id: '12345678-9012-3456-4567-891234567890', module_id: 'e5f6a7b8-c9d0-1234-ef01-234567891234', title: 'Building Simple Things Without Fear', content: '{}', ordering: 2, duration: '30 minutes' },
  { id: '23456789-0123-4567-5678-912345678901', module_id: 'e5f6a7b8-c9d0-1234-ef01-234567891234', title: 'Common Beginner Mistakes and How to Avoid Them', content: '{}', ordering: 3, duration: '30 minutes' },
  
  // Module 5: Exploring and Building with Confidence (3 lessons)
  { id: '34567890-1234-5678-6789-123456789012', module_id: 'f6a7b8c9-d0e1-2345-f012-345678912345', title: 'Using a Playground to Experiment Safely', content: '{}', ordering: 1, duration: '30 minutes' },
  { id: '45678901-2345-6789-7890-234567890123', module_id: 'f6a7b8c9-d0e1-2345-f012-345678912345', title: 'Improving Your Ideas Step by Step', content: '{}', ordering: 2, duration: '30 minutes' },
  { id: '56789012-3456-7890-8901-345678901234', module_id: 'f6a7b8c9-d0e1-2345-f012-345678912345', title: 'Your First Complete Vibe-Coded Project', content: '{}', ordering: 3, duration: '45 minutes' }
];

async function populateLessons() {
  try {
    console.log('\n1. Clearing existing lessons for Vibe Coding modules...');
    
    // Delete existing lessons for Vibe Coding modules
    const { error: deleteError } = await supabase
      .from('lessons')
      .delete()
      .in('module_id', [
        'b2c3d4e5-f6a7-8901-bcde-f01234567891',
        'c3d4e5f6-a7b8-9012-cdef-012345678912',
        'd4e5f6a7-b8c9-0123-def0-123456789123',
        'e5f6a7b8-c9d0-1234-ef01-234567891234',
        'f6a7b8c9-d0e1-2345-f012-345678912345'
      ]);

    if (deleteError) {
      console.log('⚠️ Warning: Could not delete existing lessons (may not exist)');
      console.log('Error details:', deleteError.message);
    } else {
      console.log('✅ Existing lessons cleared');
    }

    console.log('\n2. Inserting new lessons...');
    
    // Insert all lessons one by one to avoid potential issues
    let successCount = 0;
    for (const lesson of lessons) {
      const { data, error } = await supabase
        .from('lessons')
        .insert([lesson]);

      if (error) {
        console.log(`❌ Error inserting lesson "${lesson.title}":`, error.message);
      } else {
        successCount++;
      }
    }

    console.log(`✅ Successfully inserted ${successCount} out of ${lessons.length} lessons`);

    console.log('\n3. Verifying the results...');
    
    // Verify by counting lessons per module
    const modules = [
      { id: 'b2c3d4e5-f6a7-8901-bcde-f01234567891', name: 'Understanding Vibe Coding' },
      { id: 'c3d4e5f6-a7b8-9012-cdef-012345678912', name: 'Thinking Before Coding' },
      { id: 'd4e5f6a7-b8c9-0123-def0-123456789123', name: 'Working with AI as a Creative Partner' },
      { id: 'e5f6a7b8-c9d0-1234-ef01-234567891234', name: 'Vibe Coding in Real Life' },
      { id: 'f6a7b8c9-d0e1-2345-f012-345678912345', name: 'Exploring and Building with Confidence' }
    ];

    for (const module of modules) {
      const { count, error: countError } = await supabase
        .from('lessons')
        .select('*', { count: 'exact', head: true })
        .eq('module_id', module.id);

      if (countError) {
        console.log(`❌ Error counting lessons for ${module.name}:`, countError.message);
      } else {
        console.log(`✅ ${module.name}: ${count} lessons`);
      }
    }

    console.log('\n🎉 Vibe Coding course lessons have been successfully populated!');
    console.log('The course should now appear on your website.');
    console.log('\n🔄 Please refresh your website to see the changes.');

  } catch (error) {
    console.log('❌ Unexpected error:', error.message);
    console.log('Stack trace:', error.stack);
  }
}

// Run the population
populateLessons();