#!/usr/bin/env node

// Script to add lessons to existing modules using proper authentication
require('dotenv').config({ path: './lms-backend/.env' });

const { createClient } = require('@supabase/supabase-js');

// Supabase configuration with service role key
const supabaseUrl = process.env.SUPABASE_URL || 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

// Check if service role key is properly configured
if (!supabaseServiceRoleKey) {
  console.log('❌ Error: Service role key not found in environment variables.');
  console.log('   Please make sure SUPABASE_SERVICE_ROLE_KEY is set in your lms-backend/.env file');
  console.log('   You can find it in your Supabase project settings -> API -> Service Role Key');
  process.exit(1);
}

// Create Supabase client with service role key (admin privileges)
const supabase = createClient(supabaseUrl, supabaseServiceRoleKey, {
  auth: {
    persistSession: false,
    autoRefreshToken: false
  }
});

async function addLessonsToModules() {
  console.log('=== Adding Lessons to Existing Modules ===\n');
  
  try {
    // Get all modules
    console.log('1. Fetching all modules...');
    const { data: modules, error: modulesError } = await supabase
      .from('modules')
      .select('id, title, course_id')
      .order('course_id', { ascending: true })
      .order('order_index', { ascending: true });
    
    if (modulesError) {
      console.error('❌ Error fetching modules:', modulesError.message);
      return;
    }
    
    console.log(`✅ Found ${modules.length} modules\n`);
    
    // Create lessons for each module
    let lessonCounter = 1;
    for (const module of modules) {
      console.log(`--- Adding lessons to: ${module.title} ---`);
      
      // Create 3 sample lessons for each module
      const lessons = [
        {
          module_id: module.id,
          title: `Getting Started with ${module.title}`,
          content: JSON.stringify({
            "course_title": "Sample Course",
            "module_title": module.title,
            "lesson_number": lessonCounter,
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
            "course_title": "Sample Course",
            "module_title": module.title,
            "lesson_number": lessonCounter + 1,
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
        },
        {
          module_id: module.id,
          title: `Putting ${module.title} into Practice`,
          content: JSON.stringify({
            "course_title": "Sample Course",
            "module_title": module.title,
            "lesson_number": lessonCounter + 2,
            "lesson_title": `Putting ${module.title} into Practice`,
            "introduction": `Now that you understand the theory, it's time to apply what you've learned! This hands-on lesson will guide you through creating your first project.`,
            "big_idea": `Practice transforms knowledge into skill. By applying what you've learned, you build confidence and deepen your understanding.`,
            "visuals": `Think of this lesson as a workshop where you get to build something with your own hands, guided by an experienced craftsman.`,
            "steps": [
              "Plan your approach",
              "Start with a simple version",
              "Iterate and improve",
              "Review and reflect"
            ],
            "example": `Like building furniture, applying ${module.title} concepts requires patience, attention to detail, and the willingness to learn from mistakes.`,
            "playground_activity": `Create a simple project using the concepts from this lesson. Don't worry about perfection - focus on learning and having fun!`,
            "reflection_question": "What challenges did you encounter and how did you overcome them?",
            "quiz": {
              "questions": [
                "What is the benefit of hands-on practice?",
                "How should you approach initial attempts?",
                "Why is iteration important?"
              ],
              "answers": [
                "Transforms theory into skills",
                "Start simple and build up",
                "Leads to continuous improvement"
              ]
            },
            "resources": {
              "video": {
                "title": "Hands-On Project Tutorial",
                "creator": "Project-Based Learning",
                "embed": false,
                "reason": "Step-by-step project walkthrough"
              },
              "extra_reading": [
                {
                  "title": "Best Practices for Implementation",
                  "url": "https://example.com/best-practices",
                  "description": "Tips and tricks for successful implementation"
                }
              ]
            },
            "summary": "Congratulations on completing your first hands-on project! Remember, every expert was once a beginner. Keep practicing and exploring."
          }),
          order_index: 3,
          duration: '60 minutes',
          is_published: true,
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        }
      ];
      
      // Insert lessons
      console.log(`  Creating ${lessons.length} lessons...`);
      const { data: insertedLessons, error: lessonsError } = await supabase
        .from('lessons')
        .insert(lessons)
        .select();
      
      if (lessonsError) {
        console.error(`  ❌ Error inserting lessons for ${module.title}:`, lessonsError.message);
      } else {
        console.log(`  ✅ Successfully added ${insertedLessons.length} lessons to ${module.title}`);
      }
      
      lessonCounter += 3;
    }
    
    // Verify lessons were added
    console.log('\n2. Verifying lessons were added...');
    const { count, error: countError } = await supabase
      .from('lessons')
      .select('*', { count: 'exact', head: true });
    
    if (countError) {
      console.error('❌ Error counting lessons:', countError.message);
    } else {
      console.log(`✅ Total lessons in database: ${count}`);
    }
    
    console.log('\n🎉 Lesson population complete!');
    console.log('🔄 Refresh your course page to see the new lessons.');
    
  } catch (error) {
    console.error('❌ Failed to add lessons:', error.message);
  }
  
  console.log('\n=== End Lesson Population ===');
}

// Run the script
addLessonsToModules();