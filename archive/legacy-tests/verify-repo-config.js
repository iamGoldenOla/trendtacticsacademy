/**
 * Script to verify repository configuration for GitHub Actions
 */

const { spawn } = require('child_process');
const fs = require('fs');

console.log('🔍 Repository Configuration Verification\n');

// Check if we're in a git repository
if (!fs.existsSync('.git')) {
  console.log('❌ This directory is not a git repository');
  console.log('Please run this script from the root of your git repository');
  process.exit(1);
}

console.log('✅ Git repository detected');

// Check git remote
console.log('\n📡 Checking git remote...\n');

const gitRemote = spawn('git', ['remote', '-v'], { shell: true });

let remoteOutput = '';

gitRemote.stdout.on('data', (data) => {
  remoteOutput += data.toString();
});

gitRemote.stderr.on('data', (data) => {
  console.log(`stderr: ${data}`);
});

gitRemote.on('close', (code) => {
  if (code === 0) {
    console.log('Git remotes:');
    console.log(remoteOutput);
    
    if (remoteOutput.includes('github.com')) {
      console.log('✅ GitHub remote detected');
    } else {
      console.log('⚠️  No GitHub remote detected');
    }
  } else {
    console.log('❌ Failed to get git remotes');
  }
  
  // Check current branch
  console.log('\n🌿 Checking current branch...\n');
  
  const gitBranch = spawn('git', ['branch', '--show-current'], { shell: true });
  
  gitBranch.stdout.on('data', (data) => {
    const branch = data.toString().trim();
    console.log(`Current branch: ${branch}`);
    
    if (branch === 'main' || branch === 'master') {
      console.log('✅ Valid branch for deployment');
    } else {
      console.log('⚠️  Current branch may not trigger deployment');
      console.log('Deployment workflow triggers on main and master branches');
    }
  });
  
  gitBranch.stderr.on('data', (data) => {
    console.log(`stderr: ${data}`);
  });
  
  // Check workflow files
  console.log('\n📋 Checking workflow files...\n');
  
  const workflowDir = '.github/workflows';
  if (fs.existsSync(workflowDir)) {
    const files = fs.readdirSync(workflowDir);
    console.log('Workflow files found:');
    files.forEach(file => {
      console.log(`  - ${file}`);
    });
    
    if (files.includes('deploy-frontend.yml')) {
      console.log('✅ deploy-frontend.yml workflow found');
    } else {
      console.log('❌ deploy-frontend.yml workflow not found');
    }
  } else {
    console.log('❌ Workflow directory not found');
  }
  
  console.log('\n🔧 Recommendations:');
  console.log('1. Ensure your repository is on GitHub');
  console.log('2. Verify your branch is named "main" or "master"');
  console.log('3. Confirm deploy-frontend.yml exists in .github/workflows/');
  console.log('4. Check that all required secrets are set in GitHub');
});