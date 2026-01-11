/**
 * Script to check FTP directories and provide instructions for cleaning up .git folders
 */

console.log('🔍 FTP Directory Check\n');

console.log('Based on your request, you need to check if there is a .git folder in:');
console.log('/public_html/academy.trendtacticsdigital.com\n');

console.log('⚠️  IMPORTANT: Do NOT delete any .git folder in /public_html/ or the main site.');
console.log('   Only delete .git folders inside subdomain folders like /public_html/academy.trendtacticsdigital.com\n');

console.log('🔧 How to check and clean up (manual process):');
console.log('1. Connect to your server via FTP');
console.log('2. Navigate to /public_html/academy.trendtacticsdigital.com');
console.log('3. Check if there is a .git folder in that directory');
console.log('4. If found, delete ONLY that .git folder');
console.log('5. Do NOT delete any .git folders in parent directories\n');

console.log('💡 Why this matters:');
console.log('- .git folders are not needed for deployed websites');
console.log('- They can expose sensitive information');
console.log('- They take up unnecessary space');
console.log('- FTP deployments should only include built files, not source code repositories\n');

console.log('✅ Best practice:');
console.log('After each successful deployment, verify that no .git folders');
console.log('were accidentally uploaded to your public directories.');