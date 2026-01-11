/**
 * Verification script for FTP-based frontend deployment setup
 * This script checks if all necessary files for frontend deployment are in place
 */

const fs = require('fs');
const path = require('path');

// Files that should exist for deployment
const requiredFiles = [
  '.github/workflows/deploy-frontend.yml',
  'DEPLOYMENT.md',
  'DEPLOYMENT_SUMMARY.md'
];

// Check if files exist
console.log('🔍 Verifying FTP-based frontend deployment setup...\n');

let allFilesExist = true;

requiredFiles.forEach(file => {
  const fullPath = path.join(__dirname, file);
  if (fs.existsSync(fullPath)) {
    console.log(`✅ ${file} - FOUND`);
  } else {
    console.log(`❌ ${file} - MISSING`);
    allFilesExist = false;
  }
});

// Check README updates
const frontendReadmePath = path.join(__dirname, 'lms-frontend', 'README.md');

if (fs.existsSync(frontendReadmePath)) {
  const frontendReadme = fs.readFileSync(frontendReadmePath, 'utf8');
  if (frontendReadme.includes('GitHub Actions Deployment')) {
    console.log('✅ lms-frontend/README.md - UPDATED with FTP deployment info');
  } else {
    console.log('❌ lms-frontend/README.md - MISSING FTP deployment info');
    allFilesExist = false;
  }
} else {
  console.log('❌ lms-frontend/README.md - NOT FOUND');
  allFilesExist = false;
}

console.log('\n' + '='.repeat(50));

if (allFilesExist) {
  console.log('🎉 All FTP-based frontend deployment files are in place!');
  console.log('\nNext steps:');
  console.log('1. Configure GitHub secrets for FTP as described in DEPLOYMENT.md');
  console.log('2. Set up your server with the required directory structure');
  console.log('3. Configure your web server for the subdomain');
  console.log('4. Push to GitHub to trigger automatic FTP deployment');
} else {
  console.log('⚠️  Some deployment files are missing. Please check the output above.');
}

console.log('\n' + '='.repeat(50));