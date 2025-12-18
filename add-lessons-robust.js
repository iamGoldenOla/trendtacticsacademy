#!/usr/bin/env node

// Robust script to add lessons using service role key
require('dotenv').config({ path: './lms-backend/.env' });

const { createClient } = require('@supabase/supabase-js');

// Supabase configuration
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

console.log('🔧 Robust Lesson Addition Tool');
console.log('==========================\n');

// Validate environment variables
if (!supabaseUrl) {
  console.error('❌ Error: SUPABASE_URL not found in environment variables');
  process.exit(1);
}

if (!supabaseServiceRoleKey) {
  console.error('❌ Error: SUPABASE_SERVICE_ROLE_KEY not found in environment variables');
  process.exit(1);
}

console.log('✅ Environment variables loaded successfully');

// Create Supabase client with service role key (admin privileges)
const supabase = createClient(supabaseUrl, supabaseServiceRoleKey, {
  auth: {
    persistSession: false,
    autoRefreshToken: false
  }
});

// Function to add lessons to all modules
async function addLessonsToAllModules() {
  try {
    console.log('1. Fetching all courses and modules...');
    
    // Get all courses
    const { data: courses, error: coursesError } = await supabase
      .from('courses')
      .select('id, title');
    
    if (coursesError) {
      console.error('❌ Error fetching courses:', coursesError.message);
      return;
    }
    
    console.log(`✅ Found ${courses.length} courses`);
    
    let totalLessonsAdded = 0;
    
    // Process each course
    for (const [courseIndex, course] of courses.entries()) {
      console.log(`\n--- Processing Course ${courseIndex + 1}/${courses.length}: ${course.title} ---`);
      
      // Get modules for this course
      const { data: modules, error: modulesError } = await supabase
        .from('modules')
        .select('id, title')
        .eq('course_id', course.id)
        .order('created_at', { ascending: true });
      
      if (modulesError) {
        console.error(`❌ Error fetching modules for course ${course.title}:`, modulesError.message);
        continue;
      }
      
      console.log(`✅ Found ${modules.length} modules for this course`);
      
      // Process each module
      for (const [moduleIndex, module] of modules.entries()) {
        console.log(`\n  📝 Adding lessons to Module ${moduleIndex + 1}/${modules.length}: ${module.title}`);
        
        // Create sample lessons
        const lessons = [
          {
            module_id: module.id,
            title: `Getting Started with ${module.title}`,
            content: JSON.stringify({
              "course_title": course.title,
              "module_title": module.title,
              "lesson_number": 1,
              "lesson_title": `Getting Started with ${module.title}`,
              "introduction": `Welcome to this lesson on ${module.title}! In this lesson, we'll introduce you to the fundamental concepts and get you started with hands-on practice.`,
              "big_idea": `Understanding the core principles of ${module.title} is essential for building a strong foundation in this subject.`,
              "visuals": `Imagine ${module.title} as building blocks. Each concept is like a block that fits together with others to create something amazing.`,
              "steps": [
                "Understand the basic concepts",
                "See real-world examples",
                "Practice with guided exercises",
                "Apply what you've learned"
              ],
              "example": `For example, if you were learning about ${module.title}, you would first understand what it is, then see how it's used in real applications, practice with simple exercises, and finally create your own project.`,
              "playground_activity": `Think of one thing you'd like to accomplish using the concepts from this lesson. Write down a brief description of what you want to create and why it matters to you.`,
              "reflection_question": "What excites you most about learning this topic?",
              "quiz": {
                "questions": [
                  "What is the main focus of this lesson?",
                  "Why is understanding fundamentals important?",
                  "How will you apply what you've learned?"
                ],
                "answers": [
                  "Introduction to core concepts",
                  "Builds a strong foundation",
                  "Through practice and projects"
                ]
              },
              "resources": {
                "video": {
                  "title": "Introduction to the Topic",
                  "creator": "Educational Channel",
                  "embed": false,
                  "reason": "Beginner-friendly introduction"
                },
                "extra_reading": [
                  {
                    "title": "Complete Guide to Basics",
                    "url": "https://example.com/guide",
                    "description": "Detailed explanation of fundamental concepts"
                  }
                ]
              },
              "summary": "In this lesson, we covered the basics of the topic and prepared you for more advanced concepts. Remember, everyone starts as a beginner, and practice is key to mastery."
            }),
            order_index: 1,
            duration: '30 minutes',
            is_published: true,
            created_at: new Date().toISOString(),
            updated_at: new Date().toISOString()
          },
          {
            module_id: module.id,
            title: `Core Principles of ${module.title}`,
            content: JSON.stringify({
              "course_title": course.title,
              "module_title": module.title,
              "lesson_number": 2,
              "lesson_title": `Core Principles of ${module.title}`,
              "introduction": `In this lesson, we'll dive deeper into the essential principles of ${module.title}. You'll gain a solid understanding of how everything works together.`,
              "big_idea": `${module.title} is built on a few key principles that, when understood, make everything else much easier to grasp.`,
              "visuals": `Picture ${module.title} as a puzzle. Each principle is a piece that connects to others, forming a complete picture when assembled correctly.`,
              "steps": [
                "Learn the foundational principles",
                "See how principles interconnect",
                "Work through practical examples",
                "Test your understanding"
              ],
              "example": `Just like learning to cook, understanding the principles of ${module.title} helps you adapt to any situation and create your own variations.`,
              "playground_activity": `Choose one principle from this lesson and explain it in your own words as if you were teaching it to a friend.`,
              "reflection_question": "Which principle resonated most with you and why?",
              "quiz": {
                "questions": [
                  "What are the core principles covered?",
                  "How do principles interconnect?",
                  "Why is understanding important?"
                ],
                "answers": [
                  "Fundamental concepts of the topic",
                  "They build upon each other",
                  "Creates deeper comprehension"
                ]
              },
              "resources": {
                "video": {
                  "title": "Deep Dive into Core Principles",
                  "creator": "Expert Instructor",
                  "embed": false,
                  "reason": "Detailed explanation of key concepts"
                },
                "extra_reading": [
                  {
                    "title": "Advanced Principles Guide",
                    "url": "https://example.com/advanced-principles",
                    "description": "Comprehensive breakdown of advanced topics"
                  }
                ]
              },
              "summary": "Today we explored the core principles that form the foundation of this topic. With these principles in mind, you're well-equipped to tackle more complex concepts."
            }),
            order_index: 2,
            duration: '45 minutes',
            is_published: true,
            created_at: new Date().toISOString(),
            updated_at: new Date().toISOString()
          }
        ];
        
        // Insert lessons
        console.log(`    Adding ${lessons.length} lessons...`);
        const { data: insertedLessons, error: lessonsError } = await supabase
          .from('lessons')
          .insert(lessons)
          .select();
        
        if (lessonsError) {
          console.error(`    ❌ Error inserting lessons for ${module.title}:`, lessonsError.message);
        } else {
          console.log(`    ✅ Successfully added ${insertedLessons.length} lessons`);
          totalLessonsAdded += insertedLessons.length;
        }
      }
    }
    
    console.log(`\n🎉 Total lessons added: ${totalLessonsAdded}`);
    
    // Update modules to be published
    console.log('\n2. Publishing modules...');
    const { error: publishError } = await supabase
      .from('modules')
      .update({ is_published: true })
      .neq('is_published', true);
    
    if (publishError) {
      console.error('❌ Error publishing modules:', publishError.message);
    } else {
      console.log('✅ All modules published');
    }
    
    // Verify lessons were added
    console.log('\n3. Verifying lessons were added...');
    const { count: totalLessons, error: countError } = await supabase
      .from('lessons')
      .select('*', { count: 'exact', head: true });
    
    if (countError) {
      console.error('❌ Error counting lessons:', countError.message);
    } else {
      console.log(`📊 Final lesson count: ${totalLessons}`);
      
      if (totalLessons > 0) {
        console.log('\n🎉 Success! Lessons have been added to the database.');
        console.log('🔄 Refresh your course page - the "Error Loading Course" message should now be gone.');
      } else {
        console.log('\n⚠️  No lessons were added. There may be a database permission issue.');
      }
    }
    
  } catch (error) {
    console.error('❌ Unexpected error:', error.message);
  }
}

// Run the function
addLessonsToAllModules();