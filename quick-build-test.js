/**
 * Quick build test to verify frontend builds locally
 */

const { spawn } = require('child_process');
const path = require('path');

console.log('🔨 Quick Frontend Build Test\n');

// Change to frontend directory
const frontendDir = path.join(__dirname, 'lms-frontend');

console.log('📂 Testing in directory:', frontendDir);
console.log('📦 Running npm ci...\n');

// Run npm ci
const npmCi = spawn('npm', ['ci'], { cwd: frontendDir, shell: true });

npmCi.stdout.on('data', (data) => {
  console.log(`stdout: ${data}`);
});

npmCi.stderr.on('data', (data) => {
  console.log(`stderr: ${data}`);
});

npmCi.on('close', (code) => {
  console.log(`npm ci exited with code ${code}`);
  
  if (code !== 0) {
    console.log('❌ Dependency installation failed');
    return;
  }
  
  console.log('\n🏗️  Running npm run build...\n');
  
  // Run npm run build
  const npmBuild = spawn('npm', ['run', 'build'], { cwd: frontendDir, shell: true });
  
  npmBuild.stdout.on('data', (data) => {
    console.log(`stdout: ${data}`);
  });
  
  npmBuild.stderr.on('data', (data) => {
    console.log(`stderr: ${data}`);
  });
  
  npmBuild.on('close', (code) => {
    console.log(`npm run build exited with code ${code}`);
    
    if (code === 0) {
      console.log('\n✅ Build successful! Your frontend should deploy correctly.');
    } else {
      console.log('\n❌ Build failed. Check the errors above.');
      console.log('\n🔧 Troubleshooting tips:');
      console.log('1. Check for syntax errors in your React components');
      console.log('2. Verify all imports are correct');
      console.log('3. Ensure all required dependencies are in package.json');
    }
  });
});