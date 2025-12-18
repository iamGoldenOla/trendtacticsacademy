// Script to add sample lessons using Supabase models
const { Module, Lesson } = require('./lms-backend/src/utils/supabaseModels');

async function addLessonsUsingModels() {
  console.log('=== Adding Sample Lessons Using Models ===');
  
  try {
    // First, get all modules to see what we're working with
    // We'll need to query Supabase directly since we don't have a findAll method for modules
    const { createClient } = require('@supabase/supabase-js');
    
    // Supabase configuration
    const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
    const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';
    
    const supabase = createClient(supabaseUrl, supabaseAnonKey);
    
    // Get all modules
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
          order_index: 1,
          duration: '30 minutes'
        },
        {
          module_id: module.id,
          title: `Core Concepts of ${module.title}`,
          content: `<h2>${module.title} Core Concepts</h2><p>This lesson dives deep into the essential concepts of ${module.title}.</p><h3>Key Topics:</h3><ul><li>Concept 1: Basic principles</li><li>Concept 2: Implementation strategies</li><li>Concept 3: Best practices</li></ul><p>Take your time to understand each concept before moving forward.</p>`,
          order_index: 2,
          duration: '45 minutes'
        },
        {
          module_id: module.id,
          title: `Practical Application of ${module.title}`,
          content: `<h2>Putting ${module.title} into Practice</h2><p>Now that you understand the theory, let's apply it in real-world scenarios.</p><h3>Hands-on Exercise:</h3><ol><li>Create a sample project</li><li>Implement the core concepts</li><li>Test your implementation</li><li>Review and refine</li></ol><p>Remember to document your process and challenges encountered.</p>`,
          order_index: 3,
          duration: '60 minutes'
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
    console.error('Stack trace:', error.stack);
  }
  
  console.log('\n=== End Adding Sample Lessons ===');
}

// Run the script
addLessonsUsingModels();