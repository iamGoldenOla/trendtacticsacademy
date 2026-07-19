const fs = require('fs');
const path = require('path');

const vibePath = 'C:/Users/Akinola Olujobi/Documents/Trendtactics Academy/trendtactics-academy-1/src/data/vibeCoursebook.ts';
const fbPath = 'C:/Users/Akinola Olujobi/Documents/Trendtactics Academy/trendtactics-academy-1/src/data/fbCoursebook.ts';
const promptPath = 'C:/Users/Akinola Olujobi/Documents/Trendtactics Academy/trendtactics-academy-1/src/data/promptCoursebook.ts';

function parseFile(filePath, courseName) {
  const content = fs.readFileSync(filePath, 'utf8');
  console.log(`\n=== Parsing ${courseName} ===`);
  
  // Find all keys and their corresponding module blocks
  const lines = content.split('\n');
  let currentModule = 0;
  const lessons = [];

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    const modMatch = line.match(/\/\/ === MODULE (\d+) ===/i);
    if (modMatch) {
      currentModule = parseInt(modMatch[1], 10);
    }
    
    const keyMatch = line.match(/"([^"]+)":\s*`/);
    if (keyMatch) {
      const key = keyMatch[1];
      // Gather lines until closing backtick
      let bodyLines = [];
      let j = i;
      let firstLineOfBody = lines[j].substring(lines[j].indexOf('`') + 1);
      bodyLines.push(firstLineOfBody);
      j++;
      while (j < lines.length && !lines[j].includes('`')) {
        bodyLines.push(lines[j]);
        j++;
      }
      if (j < lines.length) {
        const lastLine = lines[j].substring(0, lines[j].indexOf('`'));
        bodyLines.push(lastLine);
      }
      
      const body = bodyLines.join('\n');
      // Extract first ### header
      const headerMatch = body.match(/###\s+(.+)/);
      const title = headerMatch ? headerMatch[1].trim() : `Lesson ${key}`;
      
      lessons.push({
        id: key,
        moduleNum: currentModule,
        title: title,
        bodyExcerpt: body.substring(0, 100).replace(/\n/g, ' ')
      });
    }
  }
  
  console.log(`Found ${lessons.length} lessons in ${courseName}.`);
  console.log("Sample lessons:");
  console.log(lessons.slice(0, 3));
  console.log(lessons.slice(-2));
}

try {
  parseFile(vibePath, "Vibe Coding");
  parseFile(fbPath, "Facebook Ads");
  parseFile(promptPath, "Prompt Engineering (Custom)");
} catch (e) {
  console.error(e);
}
