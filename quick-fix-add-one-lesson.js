#!/usr/bin/env node

// Quick fix script to add one sample lesson to resolve the "Error Loading Course" issue
const { createClient } = require('@supabase/supabase-js');

// Use the anon key but target a specific module that we know exists
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function addOneLesson() {
  console.log('🔍 Quick Fix: Adding One Sample Lesson');
  console.log('====================================\n');
  
  try {
    // First, let's get the first module to add a lesson to
    console.log('1. Finding a module to add lesson to...');
    const { data: modules, error: modulesError } = await supabase
      .from('modules')
      .select('id, title')
      .limit(1);
    
    if (modulesError) {
      console.error('❌ Error fetching modules:', modulesError.message);
      return;
    }
    
    if (modules.length === 0) {
      console.log('📭 No modules found in database');
      return;
    }
    
    const module = modules[0];
    console.log(`✅ Found module: ${module.title} (ID: ${module.id})\n`);
    
    // Try to insert a simple lesson (this might fail due to RLS, but let's try)
    console.log('2. Attempting to add sample lesson...');
    const sampleLesson = {
      module_id: module.id,
      title: "Welcome to Your First Lesson",
      content: JSON.stringify({
        "course_title": "Sample Course",
        "module_title": module.title,
        "lesson_number": 1,
        "lesson_title": "Welcome to Your First Lesson",
        "introduction": "Welcome to your learning journey! This is your first lesson in this course.",
        "big_idea": "Learning should be enjoyable and accessible to everyone.",
        "visuals": "Imagine a friendly guide helping you discover new concepts.",
        "steps": [
          "Start with curiosity",
          "Embrace the learning process",
          "Celebrate small wins"
        ],
        "example": "Just like learning to ride a bike, learning new skills takes practice and patience.",
        "playground_activity": "Think of one thing you're excited to learn about. Write it down!",
        "reflection_question": "What are you most looking forward to learning in this course?",
        "quiz": {
          "questions": [
            "What is the most important part of learning?",
            "How should you approach challenges?"
          ],
          "answers": [
            "Curiosity and persistence",
            "As opportunities to grow"
          ]
        },
        "resources": {
          "video": {
            "title": "Introduction to Learning",
            "creator": "Learning Experts",
            "embed": false,
            "reason": "Beginner-friendly introduction"
          },
          "extra_reading": []
        },
        "summary": "Congratulations on taking your first step in this learning journey!"
      }),
      order_index: 1,
      duration: '15 minutes',
      is_published: true
    };
    
    // Try to insert the lesson
    const { data: lesson, error: lessonError } = await supabase
      .from('lessons')
      .insert(sampleLesson)
      .select()
      .single();
    
    if (lessonError) {
      console.log('⚠️  Could not insert lesson due to database permissions (RLS).');
      console.log('   This is expected in production environments.\n');
      
      // Let's try a different approach - check if any lessons exist now
      console.log('3. Checking current lesson count...');
      const { count, error: countError } = await supabase
        .from('lessons')
        .select('*', { count: 'exact', head: true });
      
      if (countError) {
        console.log('❌ Could not check lesson count:', countError.message);
      } else {
        console.log(`📊 Current lesson count: ${count}`);
        
        if (count > 0) {
          console.log('✅ Great! There are lessons in the database now.');
          console.log('   The "Error Loading Course" issue should be resolved.');
        } else {
          console.log('ℹ️  No lessons found. The database permissions prevent adding lessons.');
          console.log('   You may need to use the service role key or adjust RLS policies.');
        }
      }
    } else {
      console.log(`✅ Successfully added lesson: ${lesson.title} (ID: ${lesson.id})`);
      console.log('🎉 The "Error Loading Course" issue should now be resolved!');
    }
    
    console.log('\n💡 Solution Options:');
    console.log('====================');
    console.log('1. Update your lms-backend/.env file with the actual SUPABASE_SERVICE_ROLE_KEY');
    console.log('2. Or contact your database administrator to adjust RLS policies');
    console.log('3. Or use the GitHub Actions workflow that has access to the service role key');
    
  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

// Run the script
addOneLesson();