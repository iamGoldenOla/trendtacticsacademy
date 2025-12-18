#!/usr/bin/env node

// Script to help update the Supabase service role key in the .env file
console.log('🔧 Service Role Key Update Helper');
console.log('================================\n');

console.log('To fix the "Error Loading Course" issue, you need to update the service role key in your .env file.\n');

console.log('Steps to get your actual service role key:');
console.log('1. Go to your Supabase project dashboard');
console.log('2. Navigate to Settings → API');
console.log('3. Find the "Service Role Key" (different from the anon key)');
console.log('4. Copy the full key (it should be a long string starting with eyJ...)\n');

console.log('Then update your .env file:');
console.log('File location: c:\\Users\\Akinola Olujobi\\Documents\\Trendtactics Academy\\lms-backend\\.env');
console.log('Find line 12 and replace:');
console.log('  SUPABASE_SERVICE_ROLE_KEY=your_actual_service_role_key_here.your_actual_service_role_key_here.P6hgDhsXyPSwbzgb69YvYNFsoZJGiRVTiWHlgtPZeVY');
console.log('With your actual key:');
console.log('  SUPABASE_SERVICE_ROLE_KEY=your_actual_service_role_key_here.your_actual_service_role_key_here.P6hgDhsXyPSwbzgb69YvYNFsoZJGiRVTiWHlgtPZeVY\n');

console.log('After updating, save the file and run:');
console.log('node add-sample-lessons.js\n');

console.log('Alternatively, you can run the GitHub Actions workflow which already has access to your service role key.');