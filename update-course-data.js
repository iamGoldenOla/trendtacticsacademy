const fs = require('fs').promises;
const path = require('path');

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

async function generateCompleteCourseData() {
  try {
    console.log('🔧 Generating complete course data from JSON files...');
    
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
    
    // Generate the complete course structure for lesson-viewer.html
    const completeCourses = {
      "vibe-coding": {
        title: "Vibe Coding: Building Real Software with AI",
        lessons: vibeLessons.map((lesson, index) => {
          // Map the lesson structure to match what lesson-viewer.html expects
          return {
            id: index + 1,
            module: lesson.module_title || `Module ${Math.floor(index/2) + 1}`,
            title: lesson.lesson_title,
            duration: "10-15 min",
            intro: lesson.introduction || "Welcome to this lesson!",
            bigIdea: lesson.big_idea || "An important concept from this lesson.",
            steps: lesson.steps || ["Step 1", "Step 2", "Step 3"],
            example: lesson.real_world_example || "An example of this concept in action.",
            video: lesson.resources?.video?.url || "",
            reflection: lesson.reflection_question || "Think about how this applies to your goals.",
            quiz: lesson.quiz && lesson.quiz.questions && lesson.quiz.answers ? lesson.quiz.questions.map((q, idx) => ({
              q: q,
              a: lesson.quiz.answers[idx],
              opts: [lesson.quiz.answers[idx], "Option 2", "Option 3", "Option 4"] // Simplified - in a real scenario, you might have options in your data
            })) : [{ q: "What did you learn?", a: "Something valuable", opts: ["Option 1", "Option 2", "Option 3", "Option 4"] }],
            summary: lesson.summary || "This lesson covered important concepts."
          };
        })
      },
      "prompt-engineering": {
        title: "Prompt Engineering Mastery",
        lessons: promptEngLessons.map((lesson, index) => {
          // Map the lesson structure to match what lesson-viewer.html expects
          return {
            id: index + 1,
            module: lesson.module_title || `Module ${Math.floor(index/3) + 1}`,
            title: lesson.lesson_title,
            duration: "10-15 min",
            intro: lesson.introduction || "Welcome to this lesson!",
            bigIdea: lesson.big_idea || "An important concept from this lesson.",
            steps: lesson.steps || ["Step 1", "Step 2", "Step 3"],
            example: lesson.real_world_example || "An example of this concept in action.",
            video: lesson.resources?.video?.url || "",
            reflection: lesson.reflection_question || "Think about how this applies to your goals.",
            quiz: lesson.quiz && lesson.quiz.questions && lesson.quiz.answers ? lesson.quiz.questions.map((q, idx) => ({
              q: q,
              a: lesson.quiz.answers[idx],
              opts: [lesson.quiz.answers[idx], "Option 2", "Option 3", "Option 4"] // Simplified - in a real scenario, you might have options in your data
            })) : [{ q: "What did you learn?", a: "Something valuable", opts: ["Option 1", "Option 2", "Option 3", "Option 4"] }],
            summary: lesson.summary || "This lesson covered important concepts."
          };
        })
      }
    };
    
    // Update the lesson-viewer.html file with the new course data
    const lessonViewerPath = path.join(__dirname, 'lesson-viewer.html');
    let lessonViewerContent = await fs.readFile(lessonViewerPath, 'utf8');
    
    // Find the COURSES variable and replace it with the new data
    const coursesRegex = /const COURSES=\{.*?\};/s;
    const newCoursesData = `const COURSES=${JSON.stringify(completeCourses, null, 2)};`;
    
    if (coursesRegex.test(lessonViewerContent)) {
      lessonViewerContent = lessonViewerContent.replace(coursesRegex, newCoursesData);
      console.log('✅ Updated lesson-viewer.html with new course data');
    } else {
      // If COURSES variable is not found, we'll need to add it
      console.log('⚠️ Could not find COURSES variable in lesson-viewer.html');
    }
    
    // Write the updated content back to the file
    await fs.writeFile(lessonViewerPath, lessonViewerContent);
    
    // Also update the dashboard to use the same courses instead of fallback
    const dashboardPath = path.join(__dirname, 'dashboard.html');
    let dashboardContent = await fs.readFile(dashboardPath, 'utf8');
    
    // Replace the fallback courses with dynamic loading
    const fallbackRegex = /const FALLBACK_COURSES = \[.*?\];/s;
    const newFallbackData = `const FALLBACK_COURSES = [
      {
        id: 'vibe-coding',
        title: '${completeCourses['vibe-coding'].title}',
        description: 'A beginner-friendly approach to creating digital products by focusing on ideas, intention, creativity, and guidance with AI assistance.',
        level: 'Beginner',
        duration: '4-6 weeks',
        category: 'Programming'
      },
      {
        id: 'prompt-engineering',
        title: '${completeCourses['prompt-engineering'].title}',
        description: 'Master the art of communicating with AI. Learn to craft effective prompts that get better results from AI tools like ChatGPT, Claude, and more.',
        level: 'Beginner',
        duration: '2-3 weeks',
        category: 'AI Skills'
      }
    ];`;
    
    if (fallbackRegex.test(dashboardContent)) {
      dashboardContent = dashboardContent.replace(fallbackRegex, newFallbackData);
      console.log('✅ Updated dashboard.html with new course titles');
    } else {
      console.log('⚠️ Could not find FALLBACK_COURSES in dashboard.html');
    }
    
    // Write the updated content back to the file
    await fs.writeFile(dashboardPath, dashboardContent);
    
    console.log('\n🎉 Course data has been updated in both lesson-viewer.html and dashboard.html!');
    console.log('The courses should now display with the actual content from the JSON files.');
    console.log('\n🔄 Please refresh your website to see the changes.');

  } catch (error) {
    console.log('❌ Unexpected error:', error.message);
    console.log('Stack trace:', error.stack);
  }
}

// Run the update
generateCompleteCourseData();