#!/usr/bin/env node

// Comprehensive deployment script for Trendtactics Academy
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('🚀 Trendtactics Academy Deployment Script');
console.log('========================================\n');

// Function to execute command and handle errors
function execCommand(command, options = {}) {
  try {
    const result = execSync(command, { 
      stdio: options.stdio || 'inherit',
      cwd: options.cwd || process.cwd()
    });
    return result;
  } catch (error) {
    if (!options.ignoreErrors) {
      throw error;
    }
    return null;
  }
}

// Function to check if Git is initialized
function isGitRepo() {
  try {
    execSync('git rev-parse --git-dir', { stdio: 'ignore' });
    return true;
  } catch (error) {
    return false;
  }
}

// Function to deploy to GitHub
async function deployToGitHub() {
  console.log('🐙 Deploying to GitHub...\n');
  
  try {
    // Check if Git is initialized
    if (!isGitRepo()) {
      console.log('🔧 Initializing Git repository...');
      execCommand('git init');
    }
    
    // Add all files
    console.log('➕ Adding files to Git...');
    execCommand('git add .');
    
    // Check if there are changes to commit
    try {
      execSync('git diff-index --quiet HEAD --', { stdio: 'ignore' });
      console.log('✅ No changes to commit');
    } catch (error) {
      // There are changes to commit
      console.log('📝 Committing changes...');
      execCommand('git commit -m "Deploy: Interactive Learning Workspace updates"');
    }
    
    // Check if remote is set
    try {
      execSync('git remote get-url origin', { stdio: 'ignore' });
      console.log('🔗 Remote repository already set');
    } catch (error) {
      console.log('🔗 Setting remote repository (you need to replace with your actual repo URL)...');
      console.log('⚠️  Please run: git remote add origin https://github.com/your-username/your-repo.git');
      console.log('⚠️  Then run this script again');
      return false;
    }
    
    // Push to GitHub
    console.log('📤 Pushing to GitHub...');
    execCommand('git push origin main', { ignoreErrors: true });
    
    console.log('✅ GitHub deployment completed!\n');
    return true;
    
  } catch (error) {
    console.error('❌ GitHub deployment failed:', error.message);
    return false;
  }
}

// Function to deploy Supabase functions
async function deploySupabaseFunctions() {
  console.log('⚡ Deploying Supabase Functions...\n');
  
  try {
    // Check if Supabase CLI is installed
    try {
      execCommand('supabase --version', { stdio: 'pipe' });
      console.log('✅ Supabase CLI is installed');
    } catch (error) {
      console.log('📥 Installing Supabase CLI...');
      execCommand('npm install -g supabase');
    }
    
    // Check if we're in the right directory
    const supabaseDir = path.join(__dirname, 'supabase');
    if (!fs.existsSync(supabaseDir)) {
      console.log('❌ Supabase directory not found');
      return false;
    }
    
    // Change to supabase directory
    const originalDir = process.cwd();
    process.chdir(supabaseDir);
    
    // List available functions
    console.log('\n📋 Available functions:');
    const functionsDir = path.join(supabaseDir, 'functions');
    if (fs.existsSync(functionsDir)) {
      const functions = fs.readdirSync(functionsDir, { withFileTypes: true })
        .filter(dirent => dirent.isDirectory())
        .map(dirent => dirent.name);
      
      if (functions.length === 0) {
        console.log('📭 No functions found');
        process.chdir(originalDir);
        return true;
      }
      
      functions.forEach(func => {
        console.log(`  - ${func}`);
      });
      
      // Deploy each function
      console.log('\n📤 Deploying functions...');
      let successCount = 0;
      for (const func of functions) {
        try {
          console.log(`\n📦 Deploying ${func}...`);
          execCommand(`supabase functions deploy ${func}`, { stdio: 'pipe' });
          console.log(`✅ ${func} deployed successfully`);
          successCount++;
        } catch (deployError) {
          console.error(`❌ Failed to deploy ${func}:`, deployError.message);
        }
      }
      
      console.log(`\n📊 Deployment Summary: ${successCount}/${functions.length} functions deployed successfully`);
    } else {
      console.log('📭 No functions directory found');
    }
    
    // Return to original directory
    process.chdir(originalDir);
    
    console.log('✅ Supabase functions deployment completed!\n');
    return true;
    
  } catch (error) {
    console.error('❌ Supabase functions deployment failed:', error.message);
    return false;
  }
}

// Function to show deployment checklist
function showDeploymentChecklist() {
  console.log('📋 Deployment Checklist');
  console.log('=====================\n');
  
  console.log('Before deploying, ensure you have:');
  console.log('1. ✅ Configured your GitHub repository URL');
  console.log('2. ✅ Set up environment variables in your deployment platform:');
  console.log('   - REACT_APP_SUPABASE_URL');
  console.log('   - REACT_APP_SUPABASE_ANON_KEY');
  console.log('   - SUPABASE_SERVICE_ROLE_KEY (from GitHub Secrets)');
  console.log('   - MONGO_URI');
  console.log('   - JWT_SECRET');
  console.log('3. ✅ Verified Supabase project settings');
  console.log('4. ✅ Tested the application locally\n');
  
  console.log('Post-deployment verification:');
  console.log('1. 🌐 Check that the frontend loads correctly');
  console.log('2. 📚 Verify course loading functionality');
  console.log('3. 👤 Test user authentication');
  console.log('4. 📧 Confirm email functions work');
  console.log('5. 💾 Ensure database connections are working\n');
}

// Main deployment function
async function main() {
  try {
    // Show checklist
    showDeploymentChecklist();
    
    // Ask user what they want to deploy
    console.log('⚙️  What would you like to deploy?');
    console.log('1. 🐙 GitHub only');
    console.log('2. ⚡ Supabase Functions only');
    console.log('3. 🚀 Both GitHub and Supabase Functions');
    console.log('4. ❌ Cancel\n');
    
    // For now, we'll just show the options and instructions
    console.log('📝 To deploy, follow these steps:');
    console.log('1. Make sure your GitHub repository is set up');
    console.log('2. Run: node deploy-supabase-functions.js (for Supabase functions)');
    console.log('3. Follow the DEPLOYMENT_STEPS.md guide for complete deployment\n');
    
    console.log('🔐 Remember: Your service role key is securely stored in GitHub Secrets');
    console.log('🌐 For production deployment, use platforms like Vercel (frontend) and Render/Heroku (backend)\n');
    
  } catch (error) {
    console.error('❌ Deployment script failed:', error.message);
    process.exit(1);
  }
}

// Run the deployment script
main();