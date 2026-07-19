const fs = require('fs');

const path = 'C:/Users/Akinola Olujobi/Documents/Trendtactics Academy/trendtactics-academy-1/src/data/promptCoursebook.ts';
const lines = fs.readFileSync(path, 'utf8').split('\n');

let currentMod = '';
lines.forEach((l, idx) => {
  if (l.includes('=== MODULE')) {
    currentMod = l.trim();
  }
  const m = l.match(/"(30000000-[^"]+)"/);
  if (m) {
    console.log(`Line ${idx+1}: ${m[1]} -> ${currentMod}`);
  }
});
