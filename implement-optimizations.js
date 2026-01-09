/**
 * Critical Performance Optimizations for Trendtactics Academy
 * This script implements the most critical optimizations immediately
 */

const fs = require('fs');
const path = require('path');

console.log('🚀 Starting critical performance optimizations...');

// List of problematic files to remove
const filesToRemove = [
  'node.exe',
  'T\'s Kitchen Advert.mp4'
];

// List of large images to flag for compression
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

// Function to find files in the project
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

// Remove problematic files
console.log('\n🗑️  Removing problematic files...');
filesToRemove.forEach(fileName => {
  const files = findFiles(fileName);
  files.forEach(file => {
    if (fs.existsSync(file.path)) {
      console.log(`❌ Removing: ${file.path} (${file.sizeKB} KB)`);
      try {
        fs.unlinkSync(file.path);
        console.log(`✅ Successfully removed: ${file.path}`);
      } catch (err) {
        console.log(`⚠️  Could not remove ${file.path}: ${err.message}`);
      }
    }
  });
});

// Flag large images for compression
console.log('\n🖼️  Analyzing large images...');
largeImages.forEach(imgName => {
  const files = findFiles(imgName);
  files.forEach(file => {
    if (file.sizeKB > 500) { // Flag images larger than 500KB
      console.log(`📸 Large image detected: ${file.path} (${file.sizeKB} KB)`);
      console.log(`💡 Compression needed: Target <200KB for images >1MB, <100KB for others`);
    }
  });
});

// Create a simple HTML optimization for faster loading
const indexPath = './index.html';
if (fs.existsSync(indexPath)) {
  console.log('\n🎨 Optimizing index.html for faster loading...');
  
  let htmlContent = fs.readFileSync(indexPath, 'utf8');
  
  // Add performance-enhancing attributes to the HTML
  if (!htmlContent.includes('loading="lazy"')) {
    // Add lazy loading to images (basic implementation)
    htmlContent = htmlContent.replace(
      /<img\s+([^>]*)src=/gi,
      '<img loading="lazy" $1src='
    );
  }
  
  // Add preload for critical resources if not already present
  if (!htmlContent.includes('rel="preload"') && htmlContent.includes('<link rel="stylesheet"')) {
    const cssMatch = htmlContent.match(/<link[^>]*href=["']([^"']*\.css)["'][^>]*>/i);
    if (cssMatch) {
      const preloadTag = `<link rel="preload" href="${cssMatch[1]}" as="style">`;
      htmlContent = htmlContent.replace('</head>', `  ${preloadTag}\n  </head>`);
    }
  }
  
  // Add async/defer to non-critical JavaScript if not already present
  htmlContent = htmlContent.replace(
    /<script\s+src=["']([^"']*\.js)["'](\s+[^>]*)?>/gi,
    (match, src, attrs = '') => {
      if (!attrs.includes('async') && !attrs.includes('defer') && !src.includes('critical')) {
        if (src.includes('footer') || src.includes('analytics')) {
          return `<script${attrs} src="${src}" defer>`;
        }
        return `<script${attrs} src="${src}" async>`;
      }
      return match;
    }
  );
  
  try {
    fs.writeFileSync(indexPath, htmlContent);
    console.log('✅ index.html optimized with performance enhancements');
  } catch (err) {
    console.log(`⚠️  Could not optimize index.html: ${err.message}`);
  }
}

// Create a basic service worker for caching (optional enhancement)
const swContent = `
// Service Worker for Trendtactics Academy
// Improves performance through caching

const CACHE_NAME = 'trendtactics-academy-v1';
const urlsToCache = [
  '/',
  '/index.html',
  '/styles.css',
  '/js/app.js',
  '/manifest.json'
];

self.addEventListener('install', function(event) {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(function(cache) {
        console.log('Opened cache');
        return cache.addAll(urlsToCache);
      })
  );
});

self.addEventListener('fetch', function(event) {
  event.respondWith(
    caches.match(event.request)
      .then(function(response) {
        // Return cached version or fetch from network
        if (response) {
          return response;
        }
        return fetch(event.request);
      }
    )
  );
});
`;

try {
  fs.writeFileSync('./sw.js', swContent.trim());
  console.log('✅ Service worker created for caching');
} catch (err) {
  console.log(`⚠️  Could not create service worker: ${err.message}`);
}

// Create a simple optimization manifest
const optimizationManifest = {
  "optimizationStatus": "Partially Implemented",
  "date": new Date().toISOString(),
  "criticalFilesRemoved": filesToRemove.filter(file => {
    const foundFiles = findFiles(file);
    return foundFiles.length === 0;
  }),
  "largeImagesFlagged": largeImages.map(img => {
    const files = findFiles(img);
    return {
      name: img,
      instances: files.length,
      totalSizeKB: files.reduce((sum, file) => sum + file.sizeKB, 0),
      needsCompression: files.some(file => file.sizeKB > 500)
    };
  }).filter(item => item.instances > 0),
  "recommendations": [
    "Continue compressing large images",
    "Implement WebP format with fallbacks",
    "Optimize JSON data loading",
    "Minify CSS and JavaScript files",
    "Consider using a CDN"
  ]
};

try {
  fs.writeFileSync('./optimization-report.json', JSON.stringify(optimizationManifest, null, 2));
  console.log('✅ Optimization report generated');
} catch (err) {
  console.log(`⚠️  Could not create optimization report: ${err.message}`);
}

console.log('\n✨ Critical optimizations completed!');
console.log('📋 Next steps:');
console.log('   1. Compress all flagged images using an online tool');
console.log('   2. Replace large JSON files with optimized versions');
console.log('   3. Consider hosting large media files externally (YouTube, Vimeo, CDN)');
console.log('   4. Test performance with Google PageSpeed Insights');