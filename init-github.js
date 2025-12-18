#!/usr/bin/env node

// Script to initialize GitHub repository and push code
const { execSync } = require('child_process');
const readline = require('readline');

console.log('🐙 GitHub Repository Initialization Script');
console.log('========================================\n');

// Create readline interface for user input
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Function to execute command
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

// Function to ask user for input
function askQuestion(question) {
  return new Promise((resolve) => {
    rl.question(question, (answer) => {
      resolve(answer.trim());
    });
  });
}

// Function to initialize and push to GitHub
async function initGitHub() {
  try {
    // Check if we're already in a git repository
    try {
      execSync('git rev-parse --git-dir', { stdio: 'ignore' });
      console.log('✅ Git repository already initialized');
    } catch (error) {
      console.log('🔧 Initializing Git repository...');
      execCommand('git init');
    }
    
    // Check Git configuration
    try {
      const userName = execSync('git config user.name', { stdio: 'pipe' }).toString().trim();
      const userEmail = execSync('git config user.email', { stdio: 'pipe' }).toString().trim();
      console.log(`👤 Git user: ${userName} <${userEmail}>`);
    } catch (error) {
      console.log('ℹ️  Please configure your Git user information:');
      const userName = await askQuestion('Enter your Git username: ');
      const userEmail = await askQuestion('Enter your Git email: ');
      
      execCommand(`git config user.name "${userName}"`);
      execCommand(`git config user.email "${userEmail}"`);
    }
    
    // Add all files
    console.log('\n➕ Adding all files to Git...');
    execCommand('git add .');
    
    // Check if there are changes to commit
    try {
      execSync('git diff-index --quiet HEAD --', { stdio: 'ignore' });
      console.log('✅ No changes to commit');
    } catch (error) {
      // There are changes to commit
      console.log('📝 Creating initial commit...');
      execCommand('git commit -m "Initial commit: Interactive Learning Workspace"');
    }
    
    // Ask for GitHub repository URL
    console.log('\n🔗 GitHub Repository Setup');
    console.log('------------------------');
    console.log('Create a new repository on GitHub first, then provide the URL.');
    console.log('Example: https://github.com/username/repository.git');
    
    const repoUrl = await askQuestion('\nEnter your GitHub repository URL: ');
    
    if (!repoUrl) {
      console.log('❌ No repository URL provided. Please create a GitHub repository and run this script again.');
      rl.close();
      return;
    }
    
    // Add remote origin
    console.log('\n🔗 Setting remote repository...');
    try {
      execSync('git remote get-url origin', { stdio: 'ignore' });
      console.log('✅ Remote repository already set');
    } catch (error) {
      execCommand(`git remote add origin ${repoUrl}`);
      console.log('✅ Remote repository added');
    }
    
    // Set main branch
    console.log('\n🌿 Setting main branch...');
    execCommand('git branch -M main');
    
    // Push to GitHub
    console.log('\n📤 Pushing to GitHub...');
    console.log('💡 You may be prompted to enter your GitHub credentials');
    
    try {
      execCommand('git push -u origin main');
      console.log('✅ Code successfully pushed to GitHub!');
    } catch (pushError) {
      console.log('ℹ️  If you get authentication errors, you may need to:');
      console.log('   1. Use GitHub CLI: gh auth login');
      console.log('   2. Or use a personal access token');
      console.log('   3. Or set up SSH keys');
      
      const retry = await askQuestion('\nWould you like to try pushing again? (y/N): ');
      if (retry.toLowerCase() === 'y' || retry.toLowerCase() === 'yes') {
        execCommand('git push -u origin main');
        console.log('✅ Code successfully pushed to GitHub!');
      } else {
        console.log('⏭️  Skipping push. You can manually push later with: git push -u origin main');
      }
    }
    
    console.log('\n🎉 GitHub initialization completed!');
    console.log('📁 Next steps:');
    console.log('   1. Visit your repository on GitHub');
    console.log('   2. Set up GitHub Secrets for sensitive environment variables');
    console.log('   3. Configure your deployment platform (Vercel, Render, etc.)');
    console.log('   4. Deploy your application!');
    
  } catch (error) {
    console.error('❌ GitHub initialization failed:', error.message);
  } finally {
    rl.close();
  }
}

// Run the initialization
initGitHub();