/**
 * Performance Optimization Script for Trendtactics Academy
 * This script identifies and optimizes large files to improve website loading speed
 */

const fs = require('fs');
const path = require('path');

console.log('🔍 Analyzing Trendtactics Academy for performance optimizations...');

// Define files that should not be in a web project
const problematicFiles = [
  'node.exe',
  'T\'s Kitchen Advert.mp4'
];

// Define large image files that need compression
const largeImageFiles = [
  'parrallexpage1.jpg',
  'studentparallex3.jpg',
  'contactpage-parallex.jpg',
  'parallexpage4.jpg',
  'homepage.jpg',
  'coursespage.jpg',
  'websiteparallexpage.jpg',
  'servicespage.jpg',
  'aboutpage.jpg'
];

// Define large JSON files that could be optimized
const largeJsonFiles = [
  'facebook-ads-course.json'
];

// Function to get file size in KB
function getFileSizeInKB(filePath) {
  try {
    const stats = fs.statSync(filePath);
    return Math.round(stats.size / 1024);
  } catch (err) {
    return 0;
  }
}

// Function to check if file exists in the project
function findFiles(pattern) {
  const results = [];
  const walkSync = (dir) => {
    const files = fs.readdirSync(dir);
    files.forEach(file => {
      const filePath = path.join(dir, file);
      const stat = fs.statSync(filePath);
      
      if (stat.isDirectory()) {
        walkSync(filePath);
      } else {
        if (file.toLowerCase().includes(pattern.toLowerCase())) {
          results.push({
            name: file,
            path: filePath,
            sizeKB: getFileSizeInKB(filePath)
          });
        }
      }
    });
  };
  
  walkSync('.');
  return results;
}

console.log('\n🚨 Checking for problematic files...');
problematicFiles.forEach(fileName => {
  const files = findFiles(fileName);
  files.forEach(file => {
    console.log(`❌ Found problematic file: ${file.path} (${file.sizeKB} KB)`);
    console.log(`💡 Recommendation: Remove this file from the web project as it's not needed for web serving.`);
  });
});

console.log('\n🖼️  Identifying large images for compression...');
largeImageFiles.forEach(imageName => {
  const files = findFiles(imageName);
  files.forEach(file => {
    if (file.sizeKB > 100) { // Only report if larger than 100KB
      console.log(`📸 Large image found: ${file.path} (${file.sizeKB} KB)`);
      console.log(`💡 Recommendation: Compress this image to reduce file size by 50-70%.`);
    }
  });
});

console.log('\n📊 Identifying large JSON files...');
largeJsonFiles.forEach(jsonName => {
  const files = findFiles(jsonName);
  files.forEach(file => {
    if (file.sizeKB > 100) { // Only report if larger than 100KB
      console.log(`📄 Large JSON file found: ${file.path} (${file.sizeKB} KB)`);
      console.log(`💡 Recommendation: Consider lazy loading or pagination for this content.`);
    }
  });
});

console.log('\n⚡ Performance Optimization Recommendations:');
console.log('1. Remove large unnecessary files (executables, large videos)');
console.log('2. Compress images using tools like TinyPNG or ImageOptim');
console.log('3. Implement image lazy loading for off-screen images');
console.log('4. Optimize JSON data loading with chunking or pagination');
console.log('5. Minify CSS and JavaScript files');
console.log('6. Enable gzip compression on the server');
console.log('7. Use a CDN for static assets');

console.log('\n🎯 Immediate Actions:');
console.log('- Remove node.exe and large MP4 files from the project directory');
console.log('- Compress all images larger than 500KB to under 200KB');
console.log('- Consider converting large JSON files to smaller chunks');

console.log('\n✅ Analysis complete!');