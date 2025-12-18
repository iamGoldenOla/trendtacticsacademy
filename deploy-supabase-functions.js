#!/usr/bin/env node

// Script to deploy Supabase functions
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

// Check if Supabase CLI is installed
try {
  execSync('supabase --version', { stdio: 'pipe' });
  console.log('✅ Supabase CLI is installed');
} catch (error) {
  console.log('❌ Supabase CLI not found. Installing...');
  try {
    execSync('npm install -g supabase', { stdio: 'inherit' });
    console.log('✅ Supabase CLI installed successfully');
  } catch (installError) {
    console.error('❌ Failed to install Supabase CLI:', installError.message);
    process.exit(1);
  }
}

// Function to deploy Supabase functions
async function deploySupabaseFunctions() {
  console.log('🚀 Deploying Supabase Functions...');
  
  try {
    // Check if we're in the right directory
    const supabaseDir = path.join(__dirname, 'supabase');
    if (!fs.existsSync(supabaseDir)) {
      console.error('❌ Supabase directory not found');
      process.exit(1);
    }
    
    // Change to supabase directory
    process.chdir(supabaseDir);
    
    // List available functions
    console.log('\n📋 Available functions:');
    const functionsDir = path.join(supabaseDir, 'functions');
    if (fs.existsSync(functionsDir)) {
      const functions = fs.readdirSync(functionsDir, { withFileTypes: true })
        .filter(dirent => dirent.isDirectory())
        .map(dirent => dirent.name);
      
      if (functions.length === 0) {
        console.log('No functions found');
        return;
      }
      
      functions.forEach(func => {
        console.log(`  - ${func}`);
      });
      
      // Deploy each function
      console.log('\n📤 Deploying functions...');
      for (const func of functions) {
        try {
          console.log(`\n📦 Deploying ${func}...`);
          execSync(`supabase functions deploy ${func}`, { stdio: 'inherit' });
          console.log(`✅ ${func} deployed successfully`);
        } catch (deployError) {
          console.error(`❌ Failed to deploy ${func}:`, deployError.message);
        }
      }
    } else {
      console.log('No functions directory found');
    }
    
    console.log('\n🎉 Supabase functions deployment completed!');
    
  } catch (error) {
    console.error('❌ Deployment failed:', error.message);
    process.exit(1);
  }
}

// Run the deployment
deploySupabaseFunctions();