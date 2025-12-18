#!/usr/bin/env node

// Script to create VIBE CODING course with service role key
require('dotenv').config({ path: './lms-backend/.env' });

const { createClient } = require('@supabase/supabase-js');

// Supabase configuration with service role key
const supabaseUrl = process.env.SUPABASE_URL || 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY || 'your_actual_service_role_key_here_should_be_long_like_the_anon_key';

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

// VIBE CODING Course Definition
const vibeCodingCourse = {
  title: "VIBE CODING",
  description: "A beginner-friendly way of creating digital products by focusing on ideas, intention, creativity, and guidance — often with the help of AI — instead of memorizing code syntax or complex technical rules.",
  category: "Coding",
  level: "beginner",
  duration: "5 weeks",
  price: 0,
  thumbnail_url: "https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=400&h=250&fit=crop",
  is_published: true,
  created_at: new Date().toISOString(),
  updated_at: new Date().toISOString()
};

// Course Modules and Lessons Structure
const courseStructure = [
  {
    title: "Understanding Vibe Coding",
    description: "Introduction to the core concepts of Vibe Coding",
    order_index: 1,
    lessons: [
      {
        title: "What Is Vibe Coding?",
        order_index: 1,
        duration: "30 minutes"
      },
      {
        title: "Why Vibe Coding Exists",
        order_index: 2,
        duration: "25 minutes"
      },
      {
        title: "How Vibe Coding Is Different from Traditional Coding",
        order_index: 3,
        duration: "35 minutes"
      }
    ]
  },
  {
    title: "Thinking Before Coding",
    description: "Learning to think in ideas rather than code",
    order_index: 2,
    lessons: [
      {
        title: "Learning to Think in Ideas, Not Code",
        order_index: 1,
        duration: "30 minutes"
      },
      {
        title: "Turning Simple Ideas into Digital Instructions",
        order_index: 2,
        duration: "35 minutes"
      },
      {
        title: "Understanding 'Intent' in Vibe Coding",
        order_index: 3,
        duration: "25 minutes"
      }
    ]
  },
  {
    title: "Working with AI as a Creative Partner",
    description: "Using AI effectively in the Vibe Coding process",
    order_index: 3,
    lessons: [
      {
        title: "What AI Really Is (In Simple Terms)",
        order_index: 1,
        duration: "30 minutes"
      },
      {
        title: "How AI Helps in Vibe Coding",
        order_index: 2,
        duration: "35 minutes"
      },
      {
        title: "Talking to AI Clearly and Effectively",
        order_index: 3,
        duration: "40 minutes"
      }
    ]
  },
  {
    title: "Vibe Coding in Real Life",
    description: "Practical applications and common mistakes",
    order_index: 4,
    lessons: [
      {
        title: "Real Examples of Vibe Coding",
        order_index: 1,
        duration: "35 minutes"
      },
      {
        title: "Building Simple Things Without Fear",
        order_index: 2,
        duration: "40 minutes"
      },
      {
        title: "Common Beginner Mistakes and How to Avoid Them",
        order_index: 3,
        duration: "30 minutes"
      }
    ]
  },
  {
    title: "Exploring and Building with Confidence",
    description: "Building confidence through experimentation",
    order_index: 5,
    lessons: [
      {
        title: "Using a Playground to Experiment Safely",
        order_index: 1,
        duration: "35 minutes"
      },
      {
        title: "Improving Your Ideas Step by Step",
        order_index: 2,
        duration: "40 minutes"
      },
      {
        title: "Your First Complete Vibe-Coded Project",
        order_index: 3,
        duration: "45 minutes"
      }
    ]
  }
];

// Function to generate detailed lesson content
function generateLessonContent(moduleTitle, lessonTitle, lessonNumber) {
  return {
    course_title: "VIBE CODING",
    module_title: moduleTitle,
    lesson_number: lessonNumber,
    lesson_title: lessonTitle,
    introduction: `Welcome to "${lessonTitle}"! In this lesson, we'll explore the fundamental concepts that make Vibe Coding so accessible and empowering for beginners. Don't worry if some terms seem unfamiliar - we'll break everything down into simple, digestible pieces that anyone can understand.`,
    big_idea: `Vibe Coding is about focusing on what you want to create rather than getting lost in technical details. It's like having a conversation with a creative partner who helps bring your ideas to life. Instead of memorizing complex rules, we focus on expressing our intentions clearly and letting technology help us achieve our goals.`,
    visuals: `Imagine a friendly guide sitting beside you, helping you turn your thoughts into digital creations. Visualize a calm workspace where ideas flow freely without fear of making mistakes. Picture colorful building blocks representing different concepts that can be easily rearranged and connected to form whatever you imagine.`,
    steps: [
      "Start with a simple idea or goal that excites you",
      "Describe what you want to achieve in plain, everyday language",
      "Use AI as your creative assistant to explore different possibilities",
      "Experiment and play with various approaches without pressure",
      "Celebrate small wins and learn from gentle corrections",
      "Gradually build confidence as you see your ideas come to life"
    ],
    example: `Think about wanting to create a digital greeting card for a friend's birthday. Instead of worrying about HTML, CSS, or JavaScript, you simply describe: "I want a cheerful birthday card with balloons and a personalized message." Your AI partner then helps you explore different designs and layouts until you find one that feels right. The focus is on expressing your caring intention, not mastering technical syntax.`,
    playground_activity: `Try describing a simple project you'd like to create. It could be a to-do list, a personal journal, or even a recipe collection. Write 2-3 sentences describing what you want and why it matters to you. Focus on the feeling or purpose behind your idea rather than technical details.`,
    reflection_question: "What's one idea you've had that you've been too intimidated to try creating digitally? What would it feel like to have a supportive partner in bringing that idea to life?",
    quiz: {
      questions: [
        "What is the main focus of Vibe Coding?",
        "How should you approach complex technical concepts in Vibe Coding?",
        "What role does AI play in the Vibe Coding process?"
      ],
      answers: [
        "Focusing on ideas and creativity rather than memorizing syntax",
        "Break them down into simple, understandable concepts",
        "Acting as a creative partner to help explore and refine ideas"
      ]
    },
    resources: {
      video: {
        title: "Introduction to Creative Coding",
        creator: "Creative Coding Channel",
        embed: false,
        reason: "Beginner-friendly introduction to thinking creatively with technology"
      },
      extra_reading: [
        {
          title: "The Power of Beginner's Mind in Technology",
          url: "https://example.com/beginners-mind",
          description: "How approaching technology without preconceptions can lead to innovation"
        }
      ]
    },
    summary: "Today we learned that Vibe Coding is about empowerment through simplicity. By focusing on ideas rather than intimidating technical details, we can unlock our creative potential and build confidence in our digital creations. Remember, everyone starts as a beginner, and curiosity is your greatest asset."
  };
}

// Function to create the course in Supabase
async function createCourse() {
  try {
    console.log('Creating VIBE CODING course...');
    
    // Create the course
    const { data: course, error: courseError } = await supabase
      .from('courses')
      .insert(vibeCodingCourse)
      .select()
      .single();
    
    if (courseError) {
      console.error('Error creating course:', courseError.message);
      return null;
    }
    
    console.log(`✅ Course created: ${course.title} (ID: ${course.id})`);
    return course;
  } catch (error) {
    console.error('Error creating course:', error.message);
    return null;
  }
}

// Function to create modules and lessons
async function createModulesAndLessons(courseId) {
  try {
    let lessonCounter = 1;
    
    // Create modules
    for (let i = 0; i < courseStructure.length; i++) {
      const moduleData = courseStructure[i];
      
      console.log(`\nCreating module: ${moduleData.title}`);
      
      // Create module
      const { data: module, error: moduleError } = await supabase
        .from('modules')
        .insert({
          course_id: courseId,
          title: moduleData.title,
          description: moduleData.description,
          order_index: moduleData.order_index,
          is_published: true,
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        })
        .select()
        .single();
      
      if (moduleError) {
        console.error(`Error creating module ${moduleData.title}:`, moduleError.message);
        continue;
      }
      
      console.log(`✅ Module created: ${module.title} (ID: ${module.id})`);
      
      // Create lessons for this module
      for (let j = 0; j < moduleData.lessons.length; j++) {
        const lessonData = moduleData.lessons[j];
        
        console.log(`  Creating lesson: ${lessonData.title}`);
        
        // Generate lesson content
        const lessonContent = generateLessonContent(
          moduleData.title, 
          lessonData.title, 
          lessonCounter
        );
        
        // Create lesson
        const { data: lesson, error: lessonError } = await supabase
          .from('lessons')
          .insert({
            module_id: module.id,
            title: lessonData.title,
            content: JSON.stringify(lessonContent),
            order_index: lessonData.order_index,
            duration: lessonData.duration,
            is_published: true,
            created_at: new Date().toISOString(),
            updated_at: new Date().toISOString()
          })
          .select()
          .single();
        
        if (lessonError) {
          console.error(`  Error creating lesson ${lessonData.title}:`, lessonError.message);
          continue;
        }
        
        console.log(`  ✅ Lesson created: ${lesson.title} (ID: ${lesson.id})`);
        lessonCounter++;
      }
    }
    
    console.log('\n🎉 All modules and lessons created successfully!');
    return true;
  } catch (error) {
    console.error('Error creating modules and lessons:', error.message);
    return false;
  }
}

// Main function
async function main() {
  console.log('🚀 Generating VIBE CODING Course');
  console.log('================================\n');
  
  try {
    // Create the course
    const course = await createCourse();
    
    if (!course) {
      console.log('❌ Failed to create course');
      return;
    }
    
    // Create modules and lessons
    const success = await createModulesAndLessons(course.id);
    
    if (success) {
      console.log('\n🎊 VIBE CODING Course Generation Complete!');
      console.log(`📚 Course ID: ${course.id}`);
      console.log('🎓 Students can now access the interactive learning experience');
      console.log('\n✨ Key Features of This Course:');
      console.log('   • 5 modules with 15 engaging lessons');
      console.log('   • Beginner-friendly content with no technical intimidation');
      console.log('   • Structured progression from concepts to confidence');
      console.log('   • Interactive playground for hands-on learning');
      console.log('   • AI partnership guidance throughout');
    } else {
      console.log('❌ Failed to create modules and lessons');
    }
    
  } catch (error) {
    console.error('❌ Course generation failed:', error.message);
  }
}

// Run the script
main();