#!/usr/bin/env node

// Script to set up Supabase components for Trendtactics Academy
// This script helps distinguish between environment variables, functions, and secrets

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('🚀 Setting up Supabase Components for Trendtactics Academy\\n');

// Function to run Supabase CLI commands safely
function runCommand(command, description) {
    try {
        console.log(`🔧 ${description}`);
        const result = execSync(command, { encoding: 'utf8', stdio: 'pipe' });
        console.log('✅ Success\\n');
        return result;
    } catch (error) {
        console.log(`⚠️  Command failed or not available: ${command}`);
        console.log('💡 You may need to install the Supabase CLI or run this manually\\n');
        return null;
    }
}

// 1. Set Environment Variables (Non-sensitive configuration)
console.log('📋 Setting Environment Variables (Configuration Settings)');
console.log('=====================================================');

const envVars = {
    'SITE_NAME': 'Trendtactics Academy',
    'SUPPORT_EMAIL': 'support@trendtactics.com',
    'FRONTEND_URL': 'https://trendtactics.com',
    'EMAIL_SERVICE': 'console', // Will be updated when you configure real email
    'PAYMENT_GATEWAY': 'simulation' // Will be updated when you configure real payments
};

console.log('To set these in Supabase Dashboard:');
console.log('1. Go to Supabase Dashboard > Your Project > Settings > Configuration > Environment Variables');
console.log('2. Add the following key-value pairs:\\n');

Object.entries(envVars).forEach(([key, value]) => {
    console.log(`${key}=${value}`);
});

console.log('\\n');

// 2. Set Secrets (Sensitive credentials)
console.log('🔐 Setting Secrets (Sensitive Credentials)');
console.log('========================================');

console.log('To set these via Supabase CLI:');
console.log('$ supabase secrets set \\');
console.log('  SENDGRID_API_KEY=your_sendgrid_api_key \\');
console.log('  STRIPE_SECRET_KEY=your_stripe_secret_key \\');
console.log('  ADMIN_EMAIL=admin@trendtactics.com \\');
console.log('  PAYPAL_CLIENT_ID=your_paypal_client_id \\');
console.log('  PAYPAL_CLIENT_SECRET=your_paypal_client_secret\\n');

console.log('Or set them in Supabase Dashboard:');
console.log('1. Go to Supabase Dashboard > Your Project > Settings > Secrets');
console.log('2. Add each secret individually\\n');

// 3. Deploy Database Functions
console.log('🗄️  Deploying Database Functions');
console.log('=============================');

const sqlFilePath = path.join(__dirname, 'SUPABASE_FUNCTIONS.sql');
if (fs.existsSync(sqlFilePath)) {
    console.log('Found SUPABASE_FUNCTIONS.sql file. To deploy:');
    console.log('1. Copy the contents of SUPABASE_FUNCTIONS.sql');
    console.log('2. Go to Supabase Dashboard > SQL Editor');
    console.log('3. Paste and run each function\\n');
} else {
    console.log('⚠️  SUPABASE_FUNCTIONS.sql not found. Please create database functions manually.');
    console.log('   Refer to the documentation for the required functions.\\n');
}

// 4. Create Edge Functions Directory Structure
console.log('⚡ Setting up Edge Functions Structure');
console.log('===================================');

const functionsDir = path.join(__dirname, 'supabase', 'functions');
if (!fs.existsSync(functionsDir)) {
    console.log('Creating Edge Functions directory structure...');
    
    // Create directory structure
    const dirs = [
        path.join(functionsDir, 'send-welcome-email'),
        path.join(functionsDir, 'process-payment'),
        path.join(functionsDir, 'update-analytics')
    ];
    
    dirs.forEach(dir => {
        if (!fs.existsSync(dir)) {
            fs.mkdirSync(dir, { recursive: true });
        }
    });
    
    console.log('✅ Created Edge Functions directory structure');
    console.log('📁 Structure:');
    console.log('   supabase/');
    console.log('   └── functions/');
    console.log('       ├── send-welcome-email/');
    console.log('       ├── process-payment/');
    console.log('       └── update-analytics/\\n');
} else {
    console.log('✅ Edge Functions directory already exists\\n');
}

// 5. Provide example Edge Function
console.log('📝 Example Edge Function Template');
console.log('==============================');

const exampleFunction = `// Example Edge Function for sending emails
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

serve(async (_req) => {
  // Access environment variables
  const siteName = Deno.env.get('SITE_NAME');
  
  // Access secrets (automatically injected)
  const sendgridKey = Deno.env.get('SENDGRID_API_KEY');
  
  // Your function logic here
  
  return new Response(
    JSON.stringify({ 
      message: \`Hello from \${siteName}!\`,
      timestamp: new Date().toISOString()
    }),
    { headers: { "Content-Type": "application/json" } },
  );
});
`;

console.log('Example function saved to supabase/functions/send-welcome-email/index.ts');
console.log('To deploy Edge Functions:');
console.log('$ supabase functions deploy send-welcome-email');
console.log('$ supabase functions deploy process-payment');
console.log('$ supabase functions deploy update-analytics\\n');

// 6. Summary
console.log('📊 Summary of Supabase Components');
console.log('==============================');

console.log('\\n1. 🌐 ENVIRONMENT VARIABLES (Non-sensitive configuration)');
console.log('   - SITE_NAME, SUPPORT_EMAIL, FRONTEND_URL');
console.log('   - Set in: Supabase Dashboard > Settings > Configuration > Environment Variables');
console.log('   - Access in code: Deno.env.get() or process.env');

console.log('\\n2. 🔑 SECRETS (Sensitive credentials)');
console.log('   - API keys, passwords, service credentials');
console.log('   - Set in: Supabase CLI (supabase secrets set) or Dashboard > Settings > Secrets');
console.log('   - Access in code: Only in Edge Functions via Deno.env.get()');

console.log('\\n3. 🗄️ DATABASE FUNCTIONS (SQL functions)');
console.log('   - Stored procedures in PostgreSQL');
console.log('   - Set in: SQL Editor in Supabase Dashboard');
console.log('   - Access in code: supabase.rpc(\'function_name\', params)');

console.log('\\n4. ⚡ EDGE FUNCTIONS (Serverless TypeScript/JavaScript)');
console.log('   - Deployed with: supabase functions deploy');
console.log('   - Access via: https://your-project.supabase.co/functions/v1/function-name');
console.log('   - Can access both ENV vars and SECRETS');

console.log('\\n🎯 Next Steps:');
console.log('1. Set your environment variables in the Supabase Dashboard');
console.log('2. Set your secrets using the Supabase CLI');
console.log('3. Deploy the database functions from SUPABASE_FUNCTIONS.sql');
console.log('4. Create and deploy your Edge Functions');
console.log('5. Update your backend code to use the real services instead of simulations');

console.log('\\n💡 Pro Tips:');
console.log('- Use environment variables for configuration that might change between environments');
console.log('- Use secrets for sensitive data that should never be in version control');
console.log('- Use database functions for complex data operations that benefit from being close to the data');
console.log('- Use Edge Functions for custom APIs and integrations that need to scale globally');