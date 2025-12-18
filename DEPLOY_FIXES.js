/**
 * Deployment Script for Fixes
 * This script automates the deployment of all fixes for CSP and course ID issues
 */

async function deployFixes() {
    console.log('🚀 Starting Deployment of Fixes...');
    
    // Step 1: Verify current working directory
    console.log('\n📁 Verifying working directory...');
    try {
        const fs = require('fs');
        const path = require('path');
        
        // Check if we're in the right directory
        if (!fs.existsSync(path.join(process.cwd(), 'lms-frontend'))) {
            console.error('❌ Error: Not in the correct project directory');
            console.log('Please run this script from the root of your project directory');
            return;
        }
        console.log('✅ Correct directory confirmed');
    } catch (error) {
        console.error('❌ Error checking directory:', error.message);
        return;
    }
    
    // Step 2: Update Home.js with fixed version
    console.log('\n📝 Updating Home.js...');
    try {
        const fs = require('fs');
        const path = require('path');
        
        // Read the fixed Home.js content
        const fixedHomePath = path.join(process.cwd(), 'FIXED_Home.js');
        const originalHomePath = path.join(process.cwd(), 'lms-frontend', 'src', 'pages', 'Home.js');
        
        if (fs.existsSync(fixedHomePath)) {
            const fixedContent = fs.readFileSync(fixedHomePath, 'utf8');
            fs.writeFileSync(originalHomePath, fixedContent, 'utf8');
            console.log('✅ Home.js updated successfully');
        } else {
            console.warn('⚠️  FIXED_Home.js not found, skipping Home.js update');
        }
    } catch (error) {
        console.error('❌ Error updating Home.js:', error.message);
    }
    
    // Step 3: Update CourseDetail.js with fixed version
    console.log('\n📝 Updating CourseDetail.js...');
    try {
        const fs = require('fs');
        const path = require('path');
        
        // Read the fixed CourseDetail.js content
        const fixedCourseDetailPath = path.join(process.cwd(), 'FIXED_CourseDetail.js');
        const originalCourseDetailPath = path.join(process.cwd(), 'lms-frontend', 'src', 'pages', 'CourseDetail.js');
        
        if (fs.existsSync(fixedCourseDetailPath)) {
            const fixedContent = fs.readFileSync(fixedCourseDetailPath, 'utf8');
            fs.writeFileSync(originalCourseDetailPath, fixedContent, 'utf8');
            console.log('✅ CourseDetail.js updated successfully');
        } else {
            console.warn('⚠️  FIXED_CourseDetail.js not found, skipping CourseDetail.js update');
        }
    } catch (error) {
        console.error('❌ Error updating CourseDetail.js:', error.message);
    }
    
    // Step 4: Verify CSP in index.html
    console.log('\n🛡️  Verifying CSP in index.html...');
    try {
        const fs = require('fs');
        const path = require('path');
        
        const indexPath = path.join(process.cwd(), 'lms-frontend', 'public', 'index.html');
        const indexContent = fs.readFileSync(indexPath, 'utf8');
        
        // Check if the CSP includes the necessary domains
        if (indexContent.includes('https://uimdbodamoeyukrghchb.supabase.co') && 
            indexContent.includes('https://js.puter.com')) {
            console.log('✅ CSP already includes necessary domains');
        } else {
            console.warn('⚠️  CSP may need updating');
        }
    } catch (error) {
        console.error('❌ Error verifying CSP:', error.message);
    }
    
    // Step 5: Build the frontend
    console.log('\n🏗️  Building frontend application...');
    try {
        const { exec } = require('child_process');
        const path = require('path');
        
        // Change to frontend directory
        const frontendDir = path.join(process.cwd(), 'lms-frontend');
        
        exec(`cd "${frontendDir}" && npm run build`, (error, stdout, stderr) => {
            if (error) {
                console.error('❌ Build failed:', error.message);
                return;
            }
            if (stderr) {
                console.warn('⚠️  Build warnings:', stderr);
            }
            console.log('✅ Frontend build completed successfully');
            console.log(stdout);
            
            // Step 6: Commit changes
            console.log('\n💾 Committing changes...');
            exec('git add .', (error, stdout, stderr) => {
                if (error) {
                    console.error('❌ Git add failed:', error.message);
                    return;
                }
                
                exec('git commit -m "Fix CSP issues and course ID validation"', (error, stdout, stderr) => {
                    if (error) {
                        console.error('❌ Git commit failed:', error.message);
                        return;
                    }
                    console.log('✅ Changes committed successfully');
                    
                    // Step 7: Push to GitHub
                    console.log('\n📤 Pushing to GitHub...');
                    exec('git push origin master', (error, stdout, stderr) => {
                        if (error) {
                            console.error('❌ Git push failed:', error.message);
                            return;
                        }
                        console.log('✅ Changes pushed to GitHub successfully');
                        console.log('🔄 Deployment workflow should start automatically');
                        
                        console.log('\n🎉 All fixes deployed successfully!');
                        console.log('\nNext steps:');
                        console.log('1. Wait for GitHub Actions deployment to complete (5-10 minutes)');
                        console.log('2. Clear your browser cache');
                        console.log('3. Visit your site and test the fixes');
                        console.log('4. Check browser console for any remaining errors');
                    });
                });
            });
        });
    } catch (error) {
        console.error('❌ Error during build/deploy process:', error.message);
    }
}

// Run the deployment
console.log('🔧 Fix Deployment Script');
console.log('========================');
deployFixes();