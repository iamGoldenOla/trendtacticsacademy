const fs = require('fs');

const path = 'C:/Users/Akinola Olujobi/Documents/Trendtactics Academy/trendtactics-academy-1/temp_mockdata.ts';
const content = fs.readFileSync(path, 'utf8');

// We want to parse the typescript file. Since we can transpile or run JS, let's write a small node script
// that reads temp_mockdata.ts, extracts the courses variable, and inspects each course.
// Wait, we can do it by compiling/running via a small ts-node replacement or simply using regex on the file contents!
// Let's transpile temp_mockdata.ts to a temporary js file by replacing TypeScript types.
let jsContent = content
  .replace(/export interface [^{]+{[^}]+}/g, '')
  .replace(/:\s*(Course|Category|QuizQuestion|CourseSection)\[\]/g, '')
  .replace(/import [^;]+;/g, '')
  .replace(/export const/g, 'const')
  .replace(/export default/g, '')
  .replace(/const stats =/g, 'const stats =')
  .replace(/\.\.\.microsoftCourses/g, ''); // Remove spread of microsoftCourses if not defined

jsContent += '\nmodule.exports = { courses };';

fs.writeFileSync('C:/Users/Akinola Olujobi/Documents/Trendtactics Academy/temp_mockdata.js', jsContent);

const { courses } = require('C:/Users/Akinola Olujobi/Documents/Trendtactics Academy/temp_mockdata.js');

console.log("Loaded courses count:", courses.length);

courses.forEach(c => {
  console.log(`\nCourse: ${c.title} (ID: ${c.id})`);
  let quizCount = 0;
  let activityCount = 0;
  let nigerianCount = 0;
  
  c.sections?.forEach(s => {
    s.lectures?.forEach(l => {
      if (l.quizQuestions && l.quizQuestions.length > 0) {
        quizCount += l.quizQuestions.length;
      }
      if (l.body && l.body.includes('Practical Activity')) {
        activityCount++;
      }
      if (l.body && l.body.includes('Nigerian Business')) {
        nigerianCount++;
      }
    });
  });
  
  console.log(`  Quizzes: ${quizCount} questions`);
  console.log(`  Practical Activities: ${activityCount}`);
  console.log(`  Nigerian Examples: ${nigerianCount}`);
});
