#!/usr/bin/env node

// Script to help set up the Supabase service role key
console.log('🔧 Setting up Supabase Service Role Key');
console.log('=====================================\n');

console.log('To properly configure the VIBE CODING course creation, you need to:');
console.log('');
console.log('1. Get your Supabase Service Role Key:');
console.log('   - Go to your Supabase project dashboard');
console.log('   - Navigate to Settings → API');
console.log('   - Find the "Service Role Key" (not the anon key)');
console.log('   - Copy the full key (it should be a long string starting with eyJ...)');
console.log('');
console.log('2. Update your environment file:');
console.log('   - Open c:\\Users\\Akinola Olujobi\\Documents\\Trendtactics Academy\\lms-backend\\.env');
console.log('   - Replace the line:');
console.log('     SUPABASE_SERVICE_ROLE_KEY=your_actual_service_role_key_here_should_be_long_like_the_anon_key');
console.log('   - With your actual service role key:');
console.log('     SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.your_actual_key_here');
console.log('');
console.log('3. After updating, run the course creation script:');
console.log('   node create-vibe-course-with-service-role.js');
console.log('');
console.log('🔐 Security Note:');
console.log('   - Never share your service role key publicly');
console.log('   - For production deployments, store it in GitHub Secrets or environment variables');
console.log('   - The service role key has full access to your database');
console.log('');
console.log('Need help finding your service role key?');
console.log('Check the SETUP_SUPABASE.md file in your project for detailed instructions.');

// Also create a simple script to add sample lessons to existing courses
console.log('\n\n📝 Alternative Approach:');
console.log('======================');
console.log('If you prefer to add sample lessons to existing courses instead:');
console.log('');
console.log('Run: node add-sample-lessons.js');
console.log('');
console.log('This will add sample lessons to existing courses in your database.');