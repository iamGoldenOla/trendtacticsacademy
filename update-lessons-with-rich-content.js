// This script attempts to update existing lessons with rich content from JSON files
const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');

// Supabase credentials - using service role key for admin access
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseServiceRoleKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NTQ1NjAzOSwiZXhwIjoyMDgxMDMyMDM5fQ.8JUqFTmYJwvV1aVY7Z0FgkR9j5F0pYv3zQ0mX2yZ5c0';

console.log('🔧 Updating lessons with rich content from JSON files...');

// Create Supabase client with service role key (admin access)
const supabase = createClient(supabaseUrl, supabaseServiceRoleKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
});

// Read and parse the JSON course content
const vibeCodingCourse = JSON.parse(fs.readFileSync('./vibe-coding-course.json', 'utf8'));

// Helper function to get lesson by title
async function getLessonByTitle(title) {
  const { data, error } = await supabase
    .from('lessons')
    .select('id, title')
    .ilike('title', `%${title}%`) // Using ilike to do partial matching
    .limit(1);
  
  if (error) {
    console.log(`Error finding lesson with title '${title}':`, error.message);
    return null;
  }
  
  return data && data.length > 0 ? data[0] : null;
}

async function updateLessonsWithRichContent() {
  try {
    console.log('\n1. Updating lessons with rich content...');
    
    let updatedCount = 0;
    
    for (const lessonData of vibeCodingCourse) {
      console.log(`\nProcessing lesson: ${lessonData.lesson_title}`);
      
      // Find the lesson in the database by title
      const dbLesson = await getLessonByTitle(lessonData.lesson_title);
      
      if (dbLesson) {
        console.log(`Found lesson in DB with ID: ${dbLesson.id}, updating content...`);
        
        // Update the lesson with rich content
        const { error: updateError } = await supabase
          .from('lessons')
          .update({ 
            content: JSON.stringify(lessonData)
          })
          .eq('id', dbLesson.id);
        
        if (updateError) {
          console.log(`❌ Error updating lesson '${lessonData.lesson_title}':`, updateError.message);
        } else {
          console.log(`✅ Updated lesson '${lessonData.lesson_title}' with rich content`);
          updatedCount++;
        }
      } else {
        console.log(`⚠️ Lesson '${lessonData.lesson_title}' not found in database`);
      }
    }
    
    console.log(`\n✅ Successfully updated ${updatedCount} lessons with rich content!`);
    
  } catch (error) {
    console.log('❌ Unexpected error:', error.message);
    console.log('Stack trace:', error.stack);
  }
}

// Run the update
updateLessonsWithRichContent();