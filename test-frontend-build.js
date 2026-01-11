/**
 * Test script to verify frontend can build locally
 * This helps determine if build issues are local or deployment-related
 */

const { exec } = require('child_process');
const path = require('path');

console.log('🔨 Testing Frontend Build Locally...\n');

// Change to frontend directory and run build
const frontendDir = path.join(__dirname, 'lms-frontend');

console.log('📂 Changing to frontend directory...');
console.log('📦 Installing dependencies (if needed)...');

exec('npm ci', { cwd: frontendDir }, (error, stdout, stderr) => {
  if (error) {
    console.log('❌ Dependency installation failed:');
    console.log(stderr);
    return;
  }
  
  console.log('✅ Dependencies installed successfully');
  console.log('🏗️  Building frontend...');
  
  exec('npm run build', { cwd: frontendDir }, (error, stdout, stderr) => {
    if (error) {
      console.log('❌ Build failed:');
      console.log(stderr);
      console.log('\n🔧 Troubleshooting tips:');
      console.log('1. Check for syntax errors in your React components');
      console.log('2. Verify all imports are correct');
      console.log('3. Ensure all environment variables are properly set');
      console.log('4. Check that all required dependencies are installed');
      return;
    }
    
    console.log('✅ Frontend built successfully!');
    console.log('📁 Build output is in the "build" directory');
    console.log('\n🚀 Your frontend is ready for deployment!');
  });
});