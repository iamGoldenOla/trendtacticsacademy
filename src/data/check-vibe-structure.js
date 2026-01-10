const course = require('./vibe-coding-course.json');

console.log(`Total lessons: ${course.length}\n`);

course.forEach((lesson, index) => {
  console.log(`${index + 1}. ${lesson.module_title}`);
  console.log(`   Lesson: ${lesson.lesson_title}\n`);
});

