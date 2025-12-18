#!/usr/bin/env node

// Secure script to add lessons using the service role key from .env file
require('dotenv').config({ path: './lms-backend/.env' });

const { createClient } = require('@supabase/supabase-js');

// Supabase configuration with service role key from .env
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

console.log('🔐 Secure Lesson Addition Tool');
console.log('==========================\n');

// Validate environment variables
if (!supabaseUrl) {
  console.error('❌ Error: SUPABASE_URL not found in environment variables');
  process.exit(1);
}

if (!supabaseServiceRoleKey) {
  console.error('❌ Error: SUPABASE_SERVICE_ROLE_KEY not found in environment variables');
  console.log('   Please make sure the service role key is properly set in lms-backend/.env');
  process.exit(1);
}

// Check if the service role key looks valid (basic validation)
if (!supabaseServiceRoleKey.startsWith('eyJ')) {
  console.error('❌ Error: SUPABASE_SERVICE_ROLE_KEY does not appear to be a valid JWT token');
  console.log('   Service role keys should start with "eyJ"');
  process.exit(1);
}

console.log('✅ Environment variables loaded successfully');
console.log(`✅ SUPABASE_URL: ${supabaseUrl}`);
console.log(`✅ SUPABASE_SERVICE_ROLE_KEY length: ${supabaseServiceRoleKey.length} characters`);

// Create Supabase client with service role key
const supabase = createClient(supabaseUrl, supabaseServiceRoleKey, {
  auth: {
    persistSession: false,
    autoRefreshToken: false
  }
});

// Function to add sample lessons
async function addSampleLessons() {
  try {
    console.log('\n🔍 Fetching modules...');
    
    // Get all modules
    const { data: modules, error: modulesError } = await supabase
      .from('modules')
      .select('id, title, course_id')
      .order('course_id', { ascending: true })
      .order('order_index', { ascending: true })
      .limit(5); // Limit to first 5 modules for testing
    
    if (modulesError) {
      console.error('❌ Error fetching modules:', modulesError.message);
      return;
    }
    
    console.log(`✅ Found ${modules.length} modules\n`);
    
    // Add lessons to each module
    let lessonCounter = 1;
    for (const module of modules) {
      console.log(`📝 Adding lessons to: ${module.title}`);
      
      // Create sample lessons
      const lessons = [
        {
          module_id: module.id,
          title: `Introduction to ${module.title}`,
          content: JSON.stringify({
            "course_title": "Sample Course",
            "module_title": module.title,
            "lesson_number": lessonCounter++,
            "lesson_title": `Introduction to ${module.title}`,
            "introduction": `Welcome to this lesson on ${module.title}! This is a sample lesson to demonstrate the course structure.`,
            "big_idea": `Understanding ${module.title} is fundamental to your learning journey.`,
            "visuals": "Imagine concepts as building blocks that fit together to create something amazing.",
            "steps": [
              "Understand the basic concepts",
              "See real-world examples",
              "Practice with guided exercises"
            ],
            "example": `Just like learning to cook, understanding ${module.title} requires practice and patience.`,
            "playground_activity": "Think of one application of this concept in your daily life.",
            "reflection_question": "What excites you most about learning this topic?",
            "quiz": {
              "questions": [
                "What is the main focus of this lesson?",
                "Why is understanding fundamentals important?"
              ],
              "answers": [
                "Introduction to core concepts",
                "Builds a strong foundation"
              ]
            },
            "resources": {
              "video": {
                "title": "Introduction Video",
                "creator": "Educational Channel",
                "embed": false,
                "reason": "Beginner-friendly introduction"
              },
              "extra_reading": []
            },
            "summary": "In this lesson, we covered the basics and prepared you for more advanced concepts."
          }),
          order_index: 1,
          duration: '30 minutes',
          is_published: true,
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        },
        {
          module_id: module.id,
          title: `Core Concepts of ${module.title}`,
          content: JSON.stringify({
            "course_title": "Sample Course",
            "module_title": module.title,
            "lesson_number": lessonCounter++,
            "lesson_title": `Core Concepts of ${module.title}`,
            "introduction": `In this lesson, we'll dive deeper into the essential principles of ${module.title}.`,
            "big_idea": `${module.title} is built on key principles that make everything easier to understand.`,
            "visuals": "Picture this topic as a puzzle where each piece connects to form a complete picture.",
            "steps": [
              "Learn foundational principles",
              "See how concepts interconnect",
              "Work through practical examples"
            ],
            "example": `Understanding the principles of ${module.title} helps you adapt to any situation.`,
            "playground_activity": "Explain one principle from this lesson in your own words.",
            "reflection_question": "Which principle resonates most with you and why?",
            "quiz": {
              "questions": [
                "What are the core principles covered?",
                "How do principles interconnect?"
              ],
              "answers": [
                "Fundamental concepts of the topic",
                "They build upon each other"
              ]
            },
            "resources": {
              "video": {
                "title": "Deep Dive into Core Principles",
                "creator": "Expert Instructor",
                "embed": false,
                "reason": "Detailed explanation of key concepts"
              },
              "extra_reading": []
            },
            "summary": "Today we explored core principles that form the foundation of this topic."
          }),
          order_index: 2,
          duration: '45 minutes',
          is_published: true,
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        }
      ];
      
      // Insert lessons
      const { data: insertedLessons, error: lessonsError } = await supabase
        .from('lessons')
        .insert(lessons)
        .select();
      
      if (lessonsError) {
        console.error(`❌ Error inserting lessons for ${module.title}:`, lessonsError.message);
      } else {
        console.log(`✅ Added ${insertedLessons.length} lessons to ${module.title}`);
      }
    }
    
    // Verify lessons were added
    console.log('\n🔍 Verifying lessons were added...');
    const { count, error: countError } = await supabase
      .from('lessons')
      .select('*', { count: 'exact', head: true });
    
    if (countError) {
      console.error('❌ Error counting lessons:', countError.message);
    } else {
      console.log(`✅ Total lessons in database: ${count}`);
      
      if (count > 0) {
        console.log('\n🎉 Success! The "Error Loading Course" issue should now be resolved.');
        console.log('🔄 Refresh your course page to see the new lessons.');
      }
    }
    
  } catch (error) {
    console.error('❌ Unexpected error:', error.message);
  }
}

// Run the function
addSampleLessons();