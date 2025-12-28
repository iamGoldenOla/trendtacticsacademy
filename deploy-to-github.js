const { execSync } = require('child_process');
const path = require('path');

async function deployToGitHub() {
    try {
        console.log('🚀 Starting deployment to GitHub...');
        
        // Change to the project directory
        const projectDir = 'c:/Users/Akinola Olujobi/Documents/Trendtactics Academy';
        process.chdir(projectDir);
        console.log(`Changed to directory: ${projectDir}`);
        
        // Check current branch
        const currentBranch = execSync('git branch --show-current', { encoding: 'utf-8' }).trim();
        console.log(`Current branch: ${currentBranch}`);
        
        // If not on master branch, switch to master
        if (currentBranch !== 'master') {
            console.log('Switching to master branch...');
            execSync('git checkout master', { stdio: 'inherit' });
        }
        
        // Add all changes
        console.log('Adding all changes...');
        execSync('git add .', { stdio: 'inherit' });
        
        // Check for changes
        const diffOutput = execSync('git status --porcelain', { encoding: 'utf-8' });
        if (!diffOutput.trim()) {
            console.log('✅ No changes to commit');
            return;
        }
        
        // Create commit
        console.log('Creating commit...');
        execSync('git commit -m "feat: update Supabase Anon Key for authentication fix"', { stdio: 'inherit' });
        
        // Push to GitHub
        console.log('Pushing to GitHub...');
        execSync('git push origin master', { stdio: 'inherit' });
        
        console.log('✅ Deployment completed successfully!');
        console.log('Your changes have been pushed to the master branch.');
        console.log('The subdomain should update shortly at: https://academy.trendtacticsdigital.com');
        
    } catch (error) {
        console.error('❌ Deployment failed:', error.message);
        if (error.stdout) console.error('STDOUT:', error.stdout.toString());
        if (error.stderr) console.error('STDERR:', error.stderr.toString());
        throw error;
    }
}

// Run the deployment
deployToGitHub().catch(error => {
    console.error('Deployment process failed:', error);
    process.exit(1);
});