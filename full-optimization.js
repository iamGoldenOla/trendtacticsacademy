/**
 * Full Performance Optimization for Trendtactics Academy
 * Addresses all large files across the entire project
 */

const fs = require('fs');
const path = require('path');

console.log('🚀 Starting full performance optimization...');

// Function to find all files matching a pattern
function findAllFiles(pattern) {
  const results = [];
  const walkSync = (dir) => {
    const files = fs.readdirSync(dir);
    files.forEach(file => {
      const filePath = path.join(dir, file);
      const stat = fs.statSync(filePath);
      
      if (stat.isDirectory()) {
        // Skip node_modules to avoid unnecessary processing
        if (file !== 'node_modules' && !file.startsWith('.')) {
          walkSync(filePath);
        }
      } else {
        if (file.toLowerCase().includes(pattern.toLowerCase())) {
          results.push({
            name: file,
            path: filePath,
            size: stat.size,
            sizeKB: Math.round(stat.size / 1024)
          });
        }
      }
    });
  };
  
  walkSync('.');
  return results;
}

// Function to remove files
function removeFile(filePath) {
  try {
    fs.unlinkSync(filePath);
    return true;
  } catch (err) {
    console.log(`⚠️  Could not remove ${filePath}: ${err.message}`);
    return false;
  }
}

// Large problematic files to remove
const filesToRemove = [
  'node.exe',
  'T\'s Kitchen Advert.mp4'
];

// Large images that need attention
const largeImages = [
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

console.log('\n🗑️  Removing problematic large files...');
let removalCount = 0;

filesToRemove.forEach(fileName => {
  const files = findAllFiles(fileName);
  files.forEach(file => {
    if (removeFile(file.path)) {
      console.log(`✅ Removed: ${file.path} (${file.sizeKB} KB)`);
      removalCount++;
    }
  });
});

console.log(`\n📊 Summary of removals: ${removalCount} files removed`);

console.log('\n🖼️  Identifying large images for compression...');
const allLargeImages = [];

largeImages.forEach(imgName => {
  const files = findAllFiles(imgName);
  files.forEach(file => {
    if (file.sizeKB > 500) { // Images larger than 500KB
      allLargeImages.push(file);
      console.log(`📸 Large image: ${file.path} (${file.sizeKB} KB)`);
    }
  });
});

console.log(`\n📈 Found ${allLargeImages.length} large images (>500KB) that need compression`);

// Calculate potential savings
const potentialSavingsKB = allLargeImages.reduce((sum, img) => sum + Math.floor(img.sizeKB * 0.7), 0);
console.log(`💰 Potential savings: ~${Math.round(potentialSavingsKB/1024)} MB if images are compressed by 70%`);

// Create a recommendations file
const recommendations = {
  "optimizationSummary": {
    "filesRemoved": removalCount,
    "largeImagesDetected": allLargeImages.length,
    "potentialSavingsMB": Math.round(potentialSavingsKB/1024),
    "optimizationDate": new Date().toISOString()
  },
  "imageOptimizationRecommendations": allLargeImages.map(img => ({
    "file": img.path,
    "sizeKB": img.sizeKB,
    "recommendedTargetKB": Math.max(100, Math.round(img.sizeKB * 0.3)), // Target 30% of original size
    "compressionNeeded": true
  })),
  "additionalOptimizations": [
    "Convert large JPG images to WebP format for 25-35% size reduction",
    "Implement responsive images with srcset for different screen sizes",
    "Add lazy loading to images that are below the fold",
    "Consider hosting large media files on a CDN or external service",
    "Minify CSS and JavaScript files",
    "Enable GZIP compression on the web server"
  ],
  "implementationGuide": {
    "immediateActions": [
      "Remove remaining large files identified in this analysis",
      "Compress images using online tools like TinyPNG or Squoosh",
      "Replace large images with optimized versions"
    ],
    "shortTermGoals": [
      "Implement WebP format with fallbacks",
      "Add image lazy loading",
      "Optimize JSON data loading"
    ],
    "longTermGoals": [
      "Set up automated image optimization in build process",
      "Implement CDN for static assets",
      "Add advanced caching strategies"
    ]
  }
};

try {
  fs.writeFileSync('./full-optimization-report.json', JSON.stringify(recommendations, null, 2));
  console.log('\n✅ Full optimization report generated: full-optimization-report.json');
} catch (err) {
  console.log(`⚠️  Could not create optimization report: ${err.message}`);
}

console.log('\n🎯 Next Steps:');
console.log('1. Compress all images listed in the report using an image optimization tool');
console.log('2. Consider converting large images to WebP format with fallbacks');
console.log('3. Implement lazy loading for images below the fold');
console.log('4. Minify CSS and JavaScript files');
console.log('5. Test performance improvements with Google PageSpeed Insights');

console.log('\n✨ Optimization scan complete!');
console.log(`Total large files identified for optimization: ${allLargeImages.length + removalCount}`);