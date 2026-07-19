const fs = require('fs');

function printHeaders(filePath, name) {
  const content = fs.readFileSync(filePath, 'utf8');
  console.log(`\n=== Headers in ${name} ===`);
  const matches = content.match(/###\s+(.+)/g);
  if (matches) {
    console.log(`Found ${matches.length} headers.`);
    console.log(matches.slice(0, 15));
  } else {
    console.log("No ### headers found.");
  }
}

printHeaders('C:/Users/Akinola Olujobi/Documents/Trendtactics Academy/trendtactics-academy-1/src/data/vibeCoursebook.ts', 'Vibe Coding');
printHeaders('C:/Users/Akinola Olujobi/Documents/Trendtactics Academy/trendtactics-academy-1/src/data/fbCoursebook.ts', 'Facebook Ads');
printHeaders('C:/Users/Akinola Olujobi/Documents/Trendtactics Academy/trendtactics-academy-1/src/data/promptCoursebook.ts', 'Prompt Engineering');
