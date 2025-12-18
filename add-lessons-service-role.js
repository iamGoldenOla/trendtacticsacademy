// Script to add sample lessons using service role key
require('dotenv').config({ path: './lms-backend/.env' });

const { createClient } = require('@supabase/supabase-js');

// Supabase configuration - using service role key for elevated privileges
const supabaseUrl = process.env.SUPABASE_URL || 'https://uimdbodamoeyukrghchb.supabase.co';
// Using service role key instead of anon key
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY || 'your_actual_service_role_key_here_should_be_long_like_the_anon_key';

console.log('Supabase URL:', supabaseUrl);
console.log('Service Role Key exists:', !!supabaseServiceRoleKey);

// Check if service role key is properly configured
if (!supabaseServiceRoleKey || supabaseServiceRoleKey === 'your_actual_service_role_key_here_should_be_long_like_the_anon_key') {
  console.log('⚠️  Warning: Service role key not properly configured.');
  console.log('   Please update the SUPABASE_SERVICE_ROLE_KEY in your lms-backend/.env file');
  console.log('   You can find it in your Supabase project settings -> API -> Service Role Key');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceRoleKey, {
  auth: {
    persistSession: false,
    autoRefreshToken: false
  }
});

async function addLessonsWithServiceRole() {
  console.log('=== Adding Sample Lessons (Service Role Key) ===');
  console.log('Using service role key for elevated privileges');
  
  try {
    // Get all modules
    const { data: modules, error: modulesError } = await supabase
      .from('modules')
      .select('*');
    
    if (modulesError) {
      console.error('❌ Error fetching modules:', modulesError.message);
      return;
    }
    
    console.log(`✅ Found ${modules.length} modules`);
    
    // Track how many lessons we've added
    let totalLessonsAdded = 0;
    
    // Create sample lessons for each module (limit to first 5 modules to avoid overwhelming)
    const modulesToProcess = modules.slice(0, 5);
    for (const module of modulesToProcess) {
      console.log(`\n--- Adding lessons to module: ${module.title} ---`);
      
      // Sample lessons for each module
      const sampleLessons = [
        {
          module_id: module.id,
          title: `Introduction to ${module.title}`,
          content: `<h2>Welcome to ${module.title}</h2><p>In this lesson, you'll learn the fundamental concepts of ${module.title}.</p><p>By the end of this lesson, you will be able to:</p><ul><li>Understand the core principles</li><li>Identify key components</li><li>Apply basic techniques</li></ul>`,
          order_index: 1,
          duration: '30 minutes'
        },
        {
          module_id: module.id,
          title: `Core Concepts of ${module.title}`,
          content: `<h2>${module.title} Core Concepts</h2><p>This lesson dives deep into the essential concepts of ${module.title}.</p><h3>Key Topics:</h3><ul><li>Concept 1: Basic principles</li><li>Concept 2: Implementation strategies</li><li>Concept 3: Best practices</li></ul><p>Take your time to understand each concept before moving forward.</p>`,
          order_index: 2,
          duration: '45 minutes'
        }
      ];
      
      // Insert lessons for this module
      const { data: lessonsData, error: lessonsError } = await supabase
        .from('lessons')
        .insert(sampleLessons)
        .select();
      
      if (lessonsError) {
        console.error(`❌ Error inserting lessons for module ${module.title}:`, lessonsError.message);
      } else {
        console.log(`✅ Successfully added ${lessonsData.length} lessons to module ${module.title}`);
        totalLessonsAdded += lessonsData.length;
        lessonsData.forEach(lesson => {
          console.log(`  - ${lesson.title}`);
        });
      }
    }
    
    console.log(`\n🎉 Total lessons added: ${totalLessonsAdded}`);
    
    // Verify lessons were added
    console.log('\n--- Verifying lessons ---');
    const { data: lessons, error: verifyError } = await supabase
      .from('lessons')
      .select('*')
      .limit(10);
    
    if (verifyError) {
      console.error('❌ Error verifying lessons:', verifyError.message);
    } else {
      console.log(`✅ Total lessons in database: ${lessons.length}`);
      if (lessons.length > 0) {
        lessons.forEach(lesson => {
          console.log(`  - ${lesson.title} (Module ID: ${lesson.module_id})`);
        });
      }
    }
    
  } catch (error) {
    console.error('❌ Failed to add sample lessons:', error.message);
    console.error('Stack trace:', error.stack);
  }
  
  console.log('\n=== End Adding Sample Lessons ===');
}

// Run the script
addLessonsWithServiceRole();