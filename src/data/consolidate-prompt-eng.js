// Consolidate all Prompt Engineering lessons into a single course file
const fs = require('fs');
const path = require('path');

console.log('📚 Consolidating Prompt Engineering lessons...');

const lessons = [];

// Read all 16 lesson files
for (let i = 1; i <= 16; i++) {
  const filePath = path.join(__dirname, `prompt-eng-lesson-${i}.json`);
  
  if (fs.existsSync(filePath)) {
    const lessonData = JSON.parse(fs.readFileSync(filePath, 'utf8'));
    lessons.push(lessonData);
    console.log(`✅ Loaded lesson ${i}: ${lessonData.lesson_title}`);
  } else {
    console.log(`⚠️  Missing lesson ${i}`);
  }
}

// Save consolidated course file
const outputPath = path.join(__dirname, 'prompt-engineering-course.json');
fs.writeFileSync(outputPath, JSON.stringify(lessons, null, 2));

console.log(`\n✅ Consolidated ${lessons.length} lessons into prompt-engineering-course.json`);
console.log('\nCourse structure:');

// Group by module
const modules = {};
lessons.forEach(lesson => {
  const moduleName = lesson.module_title;
  if (!modules[moduleName]) {
    modules[moduleName] = [];
  }
  modules[moduleName].push(lesson.lesson_title);
});

Object.keys(modules).forEach(moduleName => {
  console.log(`\n${moduleName} (${modules[moduleName].length} lessons):`);
  modules[moduleName].forEach((lessonTitle, index) => {
    console.log(`  ${index + 1}. ${lessonTitle}`);
  });
});

