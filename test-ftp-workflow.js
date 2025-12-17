/**
 * Test script to verify FTP frontend workflow configuration
 * This script checks if the GitHub Actions frontend workflow is properly configured for FTP deployment
 */

const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

// Workflow file to check
const workflowFile = '.github/workflows/deploy-frontend.yml';

console.log('🔍 Testing FTP frontend workflow configuration...\n');

let workflowValid = true;

const fullPath = path.join(__dirname, workflowFile);

if (fs.existsSync(fullPath)) {
  try {
    // Read the YAML file
    const fileContents = fs.readFileSync(fullPath, 'utf8');
    
    // Parse the YAML
    const workflow = yaml.load(fileContents);
    
    // Check if the workflow uses FTP deployment
    let usesFTP = false;
    let hasFTPAction = false;
    
    // Check jobs
    if (workflow.jobs && typeof workflow.jobs === 'object') {
      for (const jobName in workflow.jobs) {
        const job = workflow.jobs[jobName];
        
        // Check steps
        if (job.steps && Array.isArray(job.steps)) {
          for (const step of job.steps) {
            // Check if step uses FTP deploy action
            if (step.uses && step.uses.includes('FTP-Deploy-Action')) {
              hasFTPAction = true;
              
              // Check if required FTP parameters are present
              if (step.with) {
                if (step.with.server && step.with.username && step.with.password) {
                  usesFTP = true;
                }
              }
            }
          }
        }
      }
    }
    
    if (hasFTPAction && usesFTP) {
      console.log(`✅ ${workflowFile} - PROPERLY CONFIGURED for FTP deployment`);
    } else if (hasFTPAction) {
      console.log(`⚠️  ${workflowFile} - HAS FTP action but missing required parameters`);
      workflowValid = false;
    } else {
      console.log(`❌ ${workflowFile} - DOES NOT use FTP deployment`);
      workflowValid = false;
    }
    
  } catch (error) {
    console.log(`❌ ${workflowFile} - INVALID YAML format: ${error.message}`);
    workflowValid = false;
  }
} else {
  console.log(`❌ ${workflowFile} - NOT FOUND`);
  workflowValid = false;
}

console.log('\n' + '='.repeat(60));

if (workflowValid) {
  console.log('🎉 Frontend workflow is properly configured for FTP deployment!');
  console.log('\nNext steps:');
  console.log('1. Configure the required GitHub secrets:');
  console.log('   - FTP_HOST');
  console.log('   - FTP_USERNAME'); 
  console.log('   - FTP_PASSWORD');
  console.log('   - SUPABASE_URL');
  console.log('   - SUPABASE_ANON_KEY');
  console.log('2. Push your changes to GitHub to trigger automatic deployment');
} else {
  console.log('⚠️  The frontend workflow needs attention. Please check the output above.');
}

console.log('\n' + '='.repeat(60));