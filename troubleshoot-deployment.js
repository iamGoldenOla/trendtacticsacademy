/**
 * Troubleshooting script for GitHub Actions deployment issues
 * This script helps diagnose common deployment problems
 */

const fs = require('fs');
const path = require('path');

console.log('🔍 Troubleshooting GitHub Actions Deployment Issues...\n');

// Check if workflow file exists
const workflowPath = '.github/workflows/deploy-frontend.yml';
if (fs.existsSync(workflowPath)) {
  console.log('✅ Deploy workflow file exists');
  
  // Check workflow content
  const workflowContent = fs.readFileSync(workflowPath, 'utf8');
  
  // Check for common issues
  if (workflowContent.includes('actions/checkout@v4')) {
    console.log('✅ Using latest checkout action (v4)');
  } else {
    console.log('⚠️  Consider updating to actions/checkout@v4');
  }
  
  if (workflowContent.includes('actions/setup-node@v4')) {
    console.log('✅ Using latest setup-node action (v4)');
  } else {
    console.log('⚠️  Consider updating to actions/setup-node@v4');
  }
  
  if (workflowContent.includes('SamKirkland/FTP-Deploy-Action@v4.3.5')) {
    console.log('✅ Using latest FTP deploy action (v4.3.5)');
  } else {
    console.log('⚠️  Consider updating to SamKirkland/FTP-Deploy-Action@v4.3.5');
  }
} else {
  console.log('❌ Deploy workflow file is missing');
}

// Check if required secrets are likely configured
console.log('\n🔐 Checking for required secrets (you need to verify these in GitHub):');
console.log('   - FTP_HOST: Your FTP server address');
console.log('   - FTP_USERNAME: Your FTP username');
console.log('   - FTP_PASSWORD: Your FTP password');
console.log('   - SUPABASE_URL: Your Supabase project URL');
console.log('   - SUPABASE_ANON_KEY: Your Supabase anonymous key');

// Check frontend directory
const frontendPath = 'lms-frontend';
if (fs.existsSync(frontendPath)) {
  console.log('\n✅ Frontend directory exists');
  
  // Check package.json
  const packageJsonPath = path.join(frontendPath, 'package.json');
  if (fs.existsSync(packageJsonPath)) {
    console.log('✅ Frontend package.json exists');
  } else {
    console.log('❌ Frontend package.json is missing');
  }
  
  // Check build script
  if (fs.existsSync(packageJsonPath)) {
    const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));
    if (packageJson.scripts && packageJson.scripts.build) {
      console.log('✅ Build script exists in package.json');
    } else {
      console.log('❌ Build script is missing from package.json');
    }
  }
} else {
  console.log('\n❌ Frontend directory is missing');
}

console.log('\n🔧 Troubleshooting Steps:');
console.log('1. Verify all required secrets are set in GitHub Repository Settings → Secrets and variables → Actions');
console.log('2. Check that your repository has the correct branch name (main or master)');
console.log('3. Ensure your FTP credentials are correct');
console.log('4. Verify that your FTP user has write permissions to /public_html/academy/');
console.log('5. Check GitHub Actions logs for more detailed error information');

console.log('\n📋 Common Solutions:');
console.log('- If "git failed with exit code 128", check your repository permissions and SSH keys');
console.log('- If "npm ci" fails, check your package-lock.json file');
console.log('- If "npm run build" fails, test locally with "npm run build" in the lms-frontend directory');
console.log('- If FTP deployment fails, verify your FTP credentials and directory permissions');

console.log('\n📊 For More Information:');
console.log('Check the detailed logs in GitHub → Your Repository → Actions → Select the failed workflow run');