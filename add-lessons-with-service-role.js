// Script to add sample lessons using service role key
const { createClient } = require('@supabase/supabase-js');

// Supabase configuration with service role key (higher privileges)
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
// Using service role key instead of anon key for higher privileges
const supabaseServiceRoleKey = 'your_actual_service_role_key_here_should_be_long_like_the_anon_key';

// Check if service role key is available
if (supabaseServiceRoleKey === 'your_actual_service_role_key_here_should_be_long_like_the_anon_key') {
  console.log('⚠️  Warning: Service role key not configured. Please update the script with actual service role key.');
  console.log('   You can find it in your Supabase project settings -> API -> Service Role Key');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceRoleKey, {
  auth: {
    persistSession: false,
    autoRefreshToken: false
  }
});

async function addSampleLessonsWithServiceRole() {
  console.log('=== Adding Sample Lessons (Service Role) ===');
  console.log('Using service role key for elevated privileges');
  
  try {
    // First, get all modules to see what we're working with
    const { data: modules, error: modulesError } = await supabase
      .from('modules')
      .select('*');
    
    if (modulesError) {
      console.error('❌ Error fetching modules:', modulesError.message);
      return;
    }
    
    console.log(`✅ Found ${modules.length} modules`);
    
    // Create sample lessons for each module
    for (const module of modules) {
      console.log(`\n--- Adding lessons to module: ${module.title} ---`);
      
      // Sample lessons for each module
      const sampleLessons = [
        {
          module_id: module.id,
          title: `Introduction to ${module.title}`,
          content: `<h2>Welcome to ${module.title}</h2><p>In this lesson, you'll learn the fundamental concepts of ${module.title}.</p><p>By the end of this lesson, you will be able to:</p><ul><li>Understand the core principles</li><li>Identify key components</li><li>Apply basic techniques</li></ul>`,
          ordering: 1,
          duration: '30 minutes'
        },
        {
          module_id: module.id,
          title: `Core Concepts of ${module.title}`,
          content: `<h2>${module.title} Core Concepts</h2><p>This lesson dives deep into the essential concepts of ${module.title}.</p><h3>Key Topics:</h3><ul><li>Concept 1: Basic principles</li><li>Concept 2: Implementation strategies</li><li>Concept 3: Best practices</li></ul><p>Take your time to understand each concept before moving forward.</p>`,
          ordering: 2,
          duration: '45 minutes'
        },
        {
          module_id: module.id,
          title: `Practical Application of ${module.title}`,
          content: `<h2>Putting ${module.title} into Practice</h2><p>Now that you understand the theory, let's apply it in real-world scenarios.</p><h3>Hands-on Exercise:</h3><ol><li>Create a sample project</li><li>Implement the core concepts</li><li>Test your implementation</li><li>Review and refine</li></ol><p>Remember to document your process and challenges encountered.</p>`,
          ordering: 3,
          duration: '60 minutes'
        }
      ];
      
      // Insert lessons for this module using service role
      const { data: lessonsData, error: lessonsError } = await supabase
        .from('lessons')
        .insert(sampleLessons)
        .select();
      
      if (lessonsError) {
        console.error(`❌ Error inserting lessons for module ${module.title}:`, lessonsError.message);
      } else {
        console.log(`✅ Successfully added ${lessonsData.length} lessons to module ${module.title}`);
        lessonsData.forEach(lesson => {
          console.log(`  - ${lesson.title}`);
        });
      }
    }
    
    // Verify lessons were added
    console.log('\n--- Verifying lessons ---');
    const { data: lessons, error: verifyError } = await supabase
      .from('lessons')
      .select('*');
    
    if (verifyError) {
      console.error('❌ Error verifying lessons:', verifyError.message);
    } else {
      console.log(`✅ Total lessons in database: ${lessons.length}`);
      if (lessons.length > 0) {
        lessons.slice(0, 5).forEach(lesson => {
          console.log(`  - ${lesson.title} (Module ID: ${lesson.module_id})`);
        });
      }
    }
    
  } catch (error) {
    console.error('❌ Failed to add sample lessons:', error.message);
  }
  
  console.log('\n=== End Adding Sample Lessons ===');
}

// Run the script
addSampleLessonsWithServiceRole();