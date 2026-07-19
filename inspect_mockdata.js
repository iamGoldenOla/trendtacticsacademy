const fs = require('fs');

const path = 'C:/Users/Akinola Olujobi/Documents/Trendtactics Academy/trendtactics-academy-1/src/data/mockData.ts';
const content = fs.readFileSync(path, 'utf8');

const regex = /id:\s*['"]([^'"]+)['"],\s*title:\s*['"]([^'"]+)['"]/g;
let match;
while ((match = regex.exec(content)) !== null) {
  console.log(`ID: ${match[1]}, Title: ${match[2]}`);
}
