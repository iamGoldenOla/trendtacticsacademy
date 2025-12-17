/**
 * Script to test FTP connection (requires manual input of credentials)
 */

console.log('🔌 FTP Connection Test\n');
console.log('====================\n');

console.log('⚠️  This script cannot automatically test your FTP connection');
console.log('   because your credentials are stored as GitHub secrets.\n');

console.log('🔧 How to Test FTP Connection Manually:');
console.log('=====================================\n');

console.log('Option 1: Using Command Line (Windows)');
console.log('-------------------------------------');
console.log('1. Open Command Prompt');
console.log('2. Type: ftp ftp.trendtacticsdigital.com');
console.log('3. Enter your username when prompted');
console.log('4. Enter your password when prompted');
console.log('5. If successful, you\'ll see a "ftp>" prompt\n');

console.log('Option 2: Using FileZilla (GUI)');
console.log('-------------------------------');
console.log('1. Download and install FileZilla Client');
console.log('2. Open FileZilla');
console.log('3. Enter the following information:');
console.log('   - Host: ftp.trendtacticsdigital.com');
console.log('   - Username: your-ftp-username');
console.log('   - Password: your-ftp-password');
console.log('   - Port: 21 (usually default)');
console.log('4. Click "Quickconnect"');
console.log('5. If successful, you\'ll see your server files on the right\n');

console.log('✅ Success Indicators:');
console.log('===================\n');

console.log('• Connected to ftp.trendtacticsdigital.com');
console.log('• Login successful');
console.log('• Able to list directory contents');
console.log('• Able to upload/download files\n');

console.log('❌ Failure Indicators:');
console.log('===================\n');

console.log('• "Unknown host" - Check FTP_HOST value');
console.log('• "Login failed" - Check FTP_USERNAME/FTP_PASSWORD values');
console.log('• "Connection timed out" - Check firewall/network settings');
console.log('• "Permission denied" - Check user permissions\n');

console.log('💡 Troubleshooting Tips:');
console.log('======================\n');

console.log('1. Double-check your FTP credentials');
console.log('2. Verify your FTP user has write permissions to /public_html/academy.trendtacticsdigital.com/');
console.log('3. Check if your hosting provider requires specific FTP settings');
console.log('4. Contact your hosting provider if issues persist');