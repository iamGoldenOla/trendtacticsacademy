const { createClient } = require('@supabase/supabase-js');
const fs = require('fs').promises;
const path = require('path');

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

console.log('🔧 Populating lessons for Vibe Coding and Prompt Engineering courses...');
console.log('Supabase URL:', supabaseUrl);

// Create Supabase client with service role key (admin access)
const supabase = createClient(supabaseUrl, supabaseServiceRoleKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
});

async function loadLessonContent(courseType, lessonNumber) {
  try {
    const fileName = courseType === 'vibe' 
      ? `vibe-lesson-${lessonNumber}.json` 
      : `prompt-eng-lesson-${lessonNumber}.json`;
    
    const filePath = path.join(__dirname, fileName);
    const content = await fs.readFile(filePath, 'utf8');
    return JSON.parse(content);
  } catch (error) {
    console.log(`⚠️ Could not load ${courseType} lesson ${lessonNumber}:`, error.message);
    return null;
  }
}

async function populateCompleteCourses() {
  try {
    console.log('\n1. Loading lesson content from JSON files...');
    
    // Load Vibe Coding lessons (1-15)
    const vibeLessons = [];
    for (let i = 1; i <= 15; i++) {
      const lesson = await loadLessonContent('vibe', i);
      if (lesson) {
        vibeLessons.push(lesson);
      }
    }
    
    // Load Prompt Engineering lessons (1-16)
    const promptEngLessons = [];
    for (let i = 1; i <= 16; i++) {
      const lesson = await loadLessonContent('prompt-eng', i);
      if (lesson) {
        promptEngLessons.push(lesson);
      }
    }
    
    console.log(`✅ Loaded ${vibeLessons.length} Vibe Coding lessons`);
    console.log(`✅ Loaded ${promptEngLessons.length} Prompt Engineering lessons`);
    
    // First, make sure the courses exist
    console.log('\n2. Ensuring courses exist in the database...');
    
    // Insert or update Vibe Coding course
    let { data: vibeCourse, error: vibeCourseError } = await supabase
      .from('courses')
      .select('id')
      .eq('title', 'Vibe Coding: Building Real Software with AI')
      .single();
    
    let vibeCourseId;
    if (vibeCourseError || !vibeCourse) {
      console.log('   Creating Vibe Coding course...');
      const { data, error } = await supabase
        .from('courses')
        .insert([{
          id: 'vibe-coding-course-id',
          title: 'Vibe Coding: Building Real Software with AI',
          description: 'A beginner-friendly approach to creating digital products by focusing on ideas, intention, creativity, and guidance with AI assistance.',
          level: 'Beginner',
          duration: '4-6 weeks',
          price_usd: 3,
          price_ngn: 5000,
          image_url: '/images/vibe-coding.jpg',
          created_at: new Date().toISOString()
        }])
        .select('id')
        .single();
      
      if (error) {
        console.log('❌ Error creating Vibe Coding course:', error.message);
      } else {
        vibeCourseId = data.id;
        console.log('   ✅ Vibe Coding course created');
      }
    } else {
      vibeCourseId = vibeCourse.id;
      console.log('   ✅ Vibe Coding course already exists');
    }
    
    // Insert or update Prompt Engineering course
    let { data: promptEngCourse, error: promptEngCourseError } = await supabase
      .from('courses')
      .select('id')
      .eq('title', 'Prompt Engineering Mastery')
      .single();
    
    let promptEngCourseId;
    if (promptEngCourseError || !promptEngCourse) {
      console.log('   Creating Prompt Engineering course...');
      const { data, error } = await supabase
        .from('courses')
        .insert([{
          id: 'prompt-eng-course-id',
          title: 'Prompt Engineering Mastery',
          description: 'Master the art of communicating with AI. Learn to write effective prompts that get consistent, high-quality results.',
          level: 'Beginner',
          duration: '2-3 weeks',
          price_usd: 3,
          price_ngn: 5000,
          image_url: '/images/prompt-engineering.jpg',
          created_at: new Date().toISOString()
        }])
        .select('id')
        .single();
      
      if (error) {
        console.log('❌ Error creating Prompt Engineering course:', error.message);
      } else {
        promptEngCourseId = data.id;
        console.log('   ✅ Prompt Engineering course created');
      }
    } else {
      promptEngCourseId = promptEngCourse.id;
      console.log('   ✅ Prompt Engineering course already exists');
    }
    
    // Create modules for Vibe Coding
    console.log('\n3. Creating modules for Vibe Coding...');
    const vibeModules = [
      { id: 'vibe-mod-1', title: 'Vibe Coding Foundations', course_id: vibeCourseId, order_index: 1 },
      { id: 'vibe-mod-2', title: 'The Vibe Coding Ecosystem', course_id: vibeCourseId, order_index: 2 },
      { id: 'vibe-mod-3', title: 'Full-Stack AI Builders', course_id: vibeCourseId, order_index: 3 },
      { id: 'vibe-mod-4', title: 'AI-First IDEs', course_id: vibeCourseId, order_index: 4 },
      { id: 'vibe-mod-5', title: 'Agentic Coding Tools', course_id: vibeCourseId, order_index: 5 },
      { id: 'vibe-mod-6', title: 'Real-World Workflows', course_id: vibeCourseId, order_index: 6 },
      { id: 'vibe-mod-7', title: 'Prompting for Software', course_id: vibeCourseId, order_index: 7 },
      { id: 'vibe-mod-8', title: 'The Future of Vibe Coding', course_id: vibeCourseId, order_index: 8 }
    ];
    
    for (const module of vibeModules) {
      const { error } = await supabase
        .from('modules')
        .insert([module])
        .onConflict('id')
        .merge();
      
      if (error && !error.message.includes('duplicate key value')) {
        console.log(`❌ Error creating Vibe Coding module "${module.title}":`, error.message);
      } else {
        console.log(`   ✅ Vibe Coding module "${module.title}" created/updated`);
      }
    }
    
    // Create modules for Prompt Engineering
    console.log('\n4. Creating modules for Prompt Engineering...');
    const promptEngModules = [
      { id: 'prompt-mod-1', title: 'Introduction to Prompt Engineering', course_id: promptEngCourseId, order_index: 1 },
      { id: 'prompt-mod-2', title: 'Crafting Effective Prompts', course_id: promptEngCourseId, order_index: 2 },
      { id: 'prompt-mod-3', title: 'Advanced Techniques', course_id: promptEngCourseId, order_index: 3 },
      { id: 'prompt-mod-4', title: 'Practical Applications', course_id: promptEngCourseId, order_index: 4 },
      { id: 'prompt-mod-5', title: 'Mastering Prompt Engineering', course_id: promptEngCourseId, order_index: 5 },
      { id: 'prompt-mod-6', title: 'Specialized Domains', course_id: promptEngCourseId, order_index: 6 },
      { id: 'prompt-mod-7', title: 'The Future of Prompt Engineering', course_id: promptEngCourseId, order_index: 7 }
    ];
    
    for (const module of promptEngModules) {
      const { error } = await supabase
        .from('modules')
        .insert([module])
        .onConflict('id')
        .merge();
      
      if (error && !error.message.includes('duplicate key value')) {
        console.log(`❌ Error creating Prompt Engineering module "${module.title}":`, error.message);
      } else {
        console.log(`   ✅ Prompt Engineering module "${module.title}" created/updated`);
      }
    }
    
    // Clear existing lessons for both courses
    console.log('\n5. Clearing existing lessons...');
    
    // Delete existing Vibe Coding lessons
    const { error: deleteVibeError } = await supabase
      .from('lessons')
      .delete()
      .ilike('id', 'vibe-lesson-%');
    
    if (deleteVibeError) {
      console.log('⚠️ Warning: Could not delete existing Vibe Coding lessons:', deleteVibeError.message);
    } else {
      console.log('   ✅ Existing Vibe Coding lessons cleared');
    }
    
    // Delete existing Prompt Engineering lessons
    const { error: deletePromptError } = await supabase
      .from('lessons')
      .delete()
      .ilike('id', 'prompt-eng-lesson-%');
    
    if (deletePromptError) {
      console.log('⚠️ Warning: Could not delete existing Prompt Engineering lessons:', deletePromptError.message);
    } else {
      console.log('   ✅ Existing Prompt Engineering lessons cleared');
    }
    
    // Insert Vibe Coding lessons
    console.log('\n6. Inserting Vibe Coding lessons...');
    let vibeSuccessCount = 0;
    for (let i = 0; i < vibeLessons.length; i++) {
      const lesson = vibeLessons[i];
      // Assign to appropriate module based on lesson number
      let moduleId;
      if (i < 2) moduleId = 'vibe-mod-1'; // Lessons 1-2: Vibe Coding Foundations
      else if (i < 4) moduleId = 'vibe-mod-2'; // Lessons 3-4: The Vibe Coding Ecosystem
      else if (i < 6) moduleId = 'vibe-mod-3'; // Lessons 5-6: Full-Stack AI Builders
      else if (i < 8) moduleId = 'vibe-mod-4'; // Lessons 7-8: AI-First IDEs
      else if (i < 10) moduleId = 'vibe-mod-5'; // Lessons 9-10: Agentic Coding Tools
      else if (i < 12) moduleId = 'vibe-mod-6'; // Lessons 11-12: Real-World Workflows
      else if (i < 14) moduleId = 'vibe-mod-7'; // Lessons 13-14: Prompting for Software
      else moduleId = 'vibe-mod-8'; // Lesson 15: The Future of Vibe Coding
      
      const lessonRecord = {
        id: `vibe-lesson-${i+1}`,
        module_id: moduleId,
        lesson_number: i + 1,
        title: lesson.lesson_title || `Vibe Coding Lesson ${i+1}`,
        content: JSON.stringify(lesson),
        duration: '10-15 minutes',
        created_at: new Date().toISOString()
      };
      
      console.log(`   Inserting Vibe Coding lesson ${i+1}: "${lessonRecord.title}"`);
      
      const { error } = await supabase
        .from('lessons')
        .insert([lessonRecord]);
      
      if (error) {
        console.log(`   ❌ Error inserting Vibe Coding lesson ${i+1}:`, error.message);
      } else {
        vibeSuccessCount++;
        console.log(`   ✅ Vibe Coding lesson ${i+1} inserted successfully`);
      }
    }
    
    // Insert Prompt Engineering lessons
    console.log('\n7. Inserting Prompt Engineering lessons...');
    let promptEngSuccessCount = 0;
    for (let i = 0; i < promptEngLessons.length; i++) {
      const lesson = promptEngLessons[i];
      // Assign to appropriate module based on lesson number
      let moduleId;
      if (i < 3) moduleId = 'prompt-mod-1'; // Lessons 1-3: Introduction to Prompt Engineering
      else if (i < 6) moduleId = 'prompt-mod-2'; // Lessons 4-6: Crafting Effective Prompts
      else if (i < 9) moduleId = 'prompt-mod-3'; // Lessons 7-9: Advanced Techniques
      else if (i < 12) moduleId = 'prompt-mod-4'; // Lessons 10-12: Practical Applications
      else if (i < 15) moduleId = 'prompt-mod-5'; // Lessons 13-15: Mastering Prompt Engineering
      else moduleId = 'prompt-mod-7'; // Lesson 16: The Future of Prompt Engineering
      
      const lessonRecord = {
        id: `prompt-eng-lesson-${i+1}`,
        module_id: moduleId,
        lesson_number: i + 1,
        title: lesson.lesson_title || `Prompt Engineering Lesson ${i+1}`,
        content: JSON.stringify(lesson),
        duration: '10-15 minutes',
        created_at: new Date().toISOString()
      };
      
      console.log(`   Inserting Prompt Engineering lesson ${i+1}: "${lessonRecord.title}"`);
      
      const { error } = await supabase
        .from('lessons')
        .insert([lessonRecord]);
      
      if (error) {
        console.log(`   ❌ Error inserting Prompt Engineering lesson ${i+1}:`, error.message);
      } else {
        promptEngSuccessCount++;
        console.log(`   ✅ Prompt Engineering lesson ${i+1} inserted successfully`);
      }
    }
    
    console.log(`\n📊 Results: Successfully inserted ${vibeSuccessCount} Vibe Coding lessons and ${promptEngSuccessCount} Prompt Engineering lessons`);
    
    console.log('\n8. Verifying the results...');
    
    // Verify Vibe Coding lessons
    const { count: vibeCount, error: vibeCountError } = await supabase
      .from('lessons')
      .select('*', { count: 'exact', head: true })
      .ilike('id', 'vibe-lesson-%');
    
    if (vibeCountError) {
      console.log('❌ Error counting Vibe Coding lessons:', vibeCountError.message);
    } else {
      console.log(`✅ Vibe Coding lessons: ${vibeCount} lessons`);
    }
    
    // Verify Prompt Engineering lessons
    const { count: promptCount, error: promptCountError } = await supabase
      .from('lessons')
      .select('*', { count: 'exact', head: true })
      .ilike('id', 'prompt-eng-lesson-%');
    
    if (promptCountError) {
      console.log('❌ Error counting Prompt Engineering lessons:', promptCountError.message);
    } else {
      console.log(`✅ Prompt Engineering lessons: ${promptCount} lessons`);
    }
    
    console.log('\n🎉 All courses and lessons have been successfully populated!');
    console.log('The courses should now appear on your website.');
    console.log('\n🔄 Please refresh your website to see the changes.');

  } catch (error) {
    console.log('❌ Unexpected error:', error.message);
    console.log('Stack trace:', error.stack);
  }
}

// Run the population
populateCompleteCourses();