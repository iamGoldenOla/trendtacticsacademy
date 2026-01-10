const fs = require('fs');
const path = require('path');

console.log('🌱 Generating lessons seed SQL from course JSON files...\n');

// Load course data
const vibeCourse = require('../../src/data/vibe-coding-course.json');
const fbCourse = require('../../src/data/facebook-ads-course.json');
const promptCourse = require('../../src/data/prompt-engineering-course.json');

// Module ID mappings
const moduleMap = {
  // Vibe Coding modules
  'Module 1: Vibe Coding Foundations': 'vc-mod-01',
  'Module 2: The Vibe Coding Ecosystem': 'vc-mod-02',
  'Module 3: Full-Stack AI Builders': 'vc-mod-03',
  'Module 4: AI-First IDEs': 'vc-mod-04',
  'Module 5: Agentic Coding Tools': 'vc-mod-05',
  'Module 6: Real-World Workflows': 'vc-mod-06',
  'Module 7: Prompting for Software': 'vc-mod-07',
  'Module 8: The Future of Vibe Coding': 'vc-mod-08',
  'Module 9: Testing and Debugging with AI': 'vc-mod-09',
  'Module 10: Version Control and Collaboration': 'vc-mod-10',
  'Module 11: Building Real Projects': 'vc-mod-11',
  'Module 12: Advanced Vibe Coding Techniques': 'vc-mod-12',
  'Module 13: Course Conclusion': 'vc-mod-13',
  
  // Facebook Ads modules
  'Module 1: Facebook Ads Foundations': 'fb-mod-01',
  'Module 2: Campaign Structure and Strategy': 'fb-mod-02',
  'Module 3: Audience Targeting': 'fb-mod-03',
  'Module 4: Creative Strategy': 'fb-mod-04',
  'Module 5: Budgeting and Bidding': 'fb-mod-05',
  'Module 6: The Facebook Pixel': 'fb-mod-06',
  'Module 7: Campaign Optimization': 'fb-mod-07',
  'Module 8: Scaling Campaigns': 'fb-mod-08',
  'Module 9: Retargeting and Remarketing': 'fb-mod-09',
  'Module 10: Advanced Targeting': 'fb-mod-10',
  'Module 11: Troubleshooting and Problem-Solving': 'fb-mod-11',
  'Module 12: Advanced Strategies': 'fb-mod-12',
  'Module 13: AI and Automation': 'fb-mod-13',
  
  // Prompt Engineering modules
  'Module 1: Prompt Engineering Foundations': 'pe-mod-01',
  'Module 2: Prompt Structure & Control': 'pe-mod-02',
  'Intermediate Prompt Techniques': 'pe-mod-03',
  'Advanced Prompt Techniques': 'pe-mod-04',
  'Specialized Applications': 'pe-mod-05',
  'Troubleshooting and Best Practices': 'pe-mod-06',
  'Course Conclusion': 'pe-mod-06'
};

// Function to escape SQL strings
function escapeSql(str) {
  if (!str) return '';
  return str.replace(/'/g, "''").replace(/\\/g, '\\\\');
}

// Function to generate INSERT statement for a lesson
function generateLessonInsert(lesson, coursePrefix) {
  const moduleId = moduleMap[lesson.module_title];
  if (!moduleId) {
    console.warn(`⚠️  Warning: No module mapping for "${lesson.module_title}"`);
    return '';
  }
  
  const lessonId = `${coursePrefix}-lesson-${String(lesson.lesson_number).padStart(2, '0')}`;
  
  // Extract content sections
  const introduction = escapeSql(lesson.introduction || '');
  const bigIdea = escapeSql(lesson.big_idea || '');
  const whyItMatters = escapeSql(lesson.why_it_matters || '');
  const keyConcepts = lesson.key_concepts ? escapeSql(JSON.stringify(lesson.key_concepts)) : '[]';
  const realWorldExample = escapeSql(lesson.real_world_example || '');
  const practicalApplication = escapeSql(lesson.practical_application || '');
  const reflectionQuestion = escapeSql(lesson.reflection_question || '');
  const actionableTakeaway = escapeSql(lesson.actionable_takeaway || '');
  
  // Quiz data
  const quizQuestions = lesson.quiz?.questions ? escapeSql(JSON.stringify(lesson.quiz.questions)) : '[]';
  const quizAnswers = lesson.quiz?.answers ? escapeSql(JSON.stringify(lesson.quiz.answers)) : '[]';
  
  // Resources
  const resources = lesson.resources ? escapeSql(JSON.stringify(lesson.resources)) : '{}';
  
  return `('${lessonId}', '${moduleId}', '${escapeSql(lesson.lesson_title)}', '${introduction}', '${bigIdea}', '${whyItMatters}', '${keyConcepts}', '${realWorldExample}', '${practicalApplication}', '${reflectionQuestion}', '${actionableTakeaway}', '${quizQuestions}', '${quizAnswers}', '${resources}', ${lesson.lesson_number}, false, NOW(), NOW())`;
}

// Generate SQL file
let sql = `-- ============================================================================
-- SEED SCRIPT: Lessons
-- ============================================================================
-- This script seeds the lessons table for all 3 courses
-- Run this AFTER 002_seed_modules.sql
-- Generated automatically from course JSON files
-- ============================================================================

`;

// Add Vibe Coding lessons
sql += `-- ============================================================================
-- VIBE CODING LESSONS (26 lessons)
-- ============================================================================

INSERT INTO lessons (
  id, module_id, title, introduction, big_idea, why_it_matters, 
  key_concepts, real_world_example, practical_application, 
  reflection_question, actionable_takeaway, quiz_questions, 
  quiz_answers, resources, ordering, ai_generated, created_at, updated_at
) VALUES\n`;

const vibeInserts = vibeCourse.map(lesson => generateLessonInsert(lesson, 'vc')).filter(Boolean);
sql += vibeInserts.join(',\n');
sql += '\nON CONFLICT (id) DO UPDATE SET\n';
sql += '  title = EXCLUDED.title,\n';
sql += '  introduction = EXCLUDED.introduction,\n';
sql += '  updated_at = NOW();\n\n';

console.log(`✅ Generated ${vibeInserts.length} Vibe Coding lesson inserts`);

// Save to file
const outputPath = path.join(__dirname, '003_seed_lessons.sql');
fs.writeFileSync(outputPath, sql);

console.log(`\n✅ Lessons seed SQL generated: ${outputPath}`);
console.log(`📊 Total lessons: ${vibeInserts.length}`);
console.log('\n⚠️  Note: This script only generated Vibe Coding lessons.');
console.log('Facebook Ads and Prompt Engineering lessons will be added in the next step.');

