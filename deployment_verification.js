// Script to verify deployment status and identify issues
const fs = require('fs');
const path = require('path');

console.log('🔍 Deployment Verification Script\n');

// Check 1: Verify local build files exist and are recent
console.log('1. Checking local build files...');
const buildDir = path.join(__dirname, 'lms-frontend', 'build');
const indexPath = path.join(buildDir, 'index.html');

if (fs.existsSync(indexPath)) {
  const stats = fs.statSync(indexPath);
  const mtime = stats.mtime;
  console.log(`✅ index.html exists (last modified: ${mtime.toLocaleString()})`);
  
  // Check if the file contains our CSP fixes
  const indexContent = fs.readFileSync(indexPath, 'utf8');
  if (indexContent.includes('Content-Security-Policy')) {
    console.log('✅ CSP meta tag found in index.html');
  } else {
    console.log('❌ CSP meta tag NOT found in index.html');
  }
} else {
  console.log('❌ index.html NOT found in build directory');
}

// Check 2: Verify courseService.js has the correct foreign key references
console.log('\n2. Checking courseService.js for foreign key references...');
const courseServicePath = path.join(__dirname, 'lms-frontend', 'src', 'services', 'courseService.js');

if (fs.existsSync(courseServicePath)) {
  const courseServiceContent = fs.readFileSync(courseServicePath, 'utf8');
  
  if (courseServiceContent.includes('modules!fk_modules_course_id')) {
    console.log('✅ modules!fk_modules_course_id found in courseService.js');
  } else {
    console.log('❌ modules!fk_modules_course_id NOT found in courseService.js');
  }
  
  if (courseServiceContent.includes('lessons!fk_lessons_module_id')) {
    console.log('✅ lessons!fk_lessons_module_id found in courseService.js');
  } else {
    console.log('❌ lessons!fk_lessons_module_id NOT found in courseService.js');
  }
} else {
  console.log('❌ courseService.js NOT found');
}

// Check 3: Verify Git status
console.log('\n3. Checking Git status...');
const { execSync } = require('child_process');

try {
  const gitStatus = execSync('git status --porcelain', { cwd: __dirname, encoding: 'utf8' });
  if (gitStatus.trim() === '') {
    console.log('✅ No uncommitted changes');
  } else {
    console.log('⚠️  Uncommitted changes detected:');
    console.log(gitStatus);
  }
  
  const gitBranch = execSync('git rev-parse --abbrev-ref HEAD', { cwd: __dirname, encoding: 'utf8' });
  console.log(`✅ Current branch: ${gitBranch.trim()}`);
  
  const gitCommit = execSync('git rev-parse HEAD', { cwd: __dirname, encoding: 'utf8' });
  console.log(`✅ Current commit: ${gitCommit.trim().substring(0, 8)}`);
  
  const gitRemote = execSync('git remote -v', { cwd: __dirname, encoding: 'utf8' });
  console.log('✅ Git remotes configured');
} catch (error) {
  console.log('❌ Error checking Git status:', error.message);
}

// Check 4: Verify environment variables
console.log('\n4. Checking environment variables...');
const envPath = path.join(__dirname, 'lms-frontend', '.env');

if (fs.existsSync(envPath)) {
  const envContent = fs.readFileSync(envPath, 'utf8');
  if (envContent.includes('REACT_APP_SUPABASE_URL')) {
    console.log('✅ REACT_APP_SUPABASE_URL found in .env');
  } else {
    console.log('❌ REACT_APP_SUPABASE_URL NOT found in .env');
  }
  
  if (envContent.includes('REACT_APP_SUPABASE_ANON_KEY')) {
    console.log('✅ REACT_APP_SUPABASE_ANON_KEY found in .env');
  } else {
    console.log('❌ REACT_APP_SUPABASE_ANON_KEY NOT found in .env');
  }
} else {
  console.log('❌ .env file NOT found');
}

// Check 5: Simulate what the deployed site should be doing
console.log('\n5. Simulating deployed site behavior...');

// Read the built index.html to see what's actually deployed
if (fs.existsSync(indexPath)) {
  const builtIndex = fs.readFileSync(indexPath, 'utf8');
  
  // Check if it contains references to the main JS bundle
  const jsBundleMatch = builtIndex.match(/src="\/static\/js\/main\.[a-z0-9]+\.js"/);
  if (jsBundleMatch) {
    console.log(`✅ Main JS bundle reference found: ${jsBundleMatch[0]}`);
  } else {
    console.log('❌ Main JS bundle reference NOT found');
  }
  
  // Check if it contains references to the main CSS bundle
  const cssBundleMatch = builtIndex.match(/href="\/static\/css\/main\.[a-z0-9]+\.css"/);
  if (cssBundleMatch) {
    console.log(`✅ Main CSS bundle reference found: ${cssBundleMatch[0]}`);
  } else {
    console.log('❌ Main CSS bundle reference NOT found');
  }
} else {
  console.log('❌ Cannot check built index.html');
}

console.log('\n📋 Summary of findings:');
console.log('=====================');
console.log('If all checks passed, the issue is likely one of the following:');
console.log('1. Deployment workflow has not completed yet (wait a few more minutes)');
console.log('2. Browser cache needs to be cleared');
console.log('3. FTP deployment may have failed silently');
console.log('4. Server-side caching needs to be cleared');

console.log('\n🔧 Recommended next steps:');
console.log('1. Wait 5-10 minutes for deployment to complete if recently pushed');
console.log('2. Clear browser cache (Ctrl+Shift+Delete) and hard refresh (Ctrl+F5)');
console.log('3. Check GitHub Actions for deployment status');
console.log('4. If still not working, contact hosting provider to check FTP deployment logs');