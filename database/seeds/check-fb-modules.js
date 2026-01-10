const course = require('../../src/data/facebook-ads-course.json');

console.log('Facebook Ads Course Module Structure:\n');

const modules = [...new Set(course.map(l => l.module_title))];
modules.forEach((m, i) => {
  const lessonCount = course.filter(l => l.module_title === m).length;
  console.log(`${i+1}. ${m} (${lessonCount} lessons)`);
});

console.log(`\nTotal unique modules: ${modules.length}`);
console.log(`Total lessons: ${course.length}`);

