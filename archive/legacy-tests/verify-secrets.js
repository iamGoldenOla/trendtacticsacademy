/**
 * Script to verify required GitHub secrets
 * Note: This script cannot actually check your GitHub secrets,
 * but it lists what you need to verify in your GitHub repository
 */

console.log('🔐 GitHub Secrets Verification Guide\n');

console.log('Please verify these secrets are set in your GitHub repository:');
console.log('-------------------------------------------------------------');

console.log('\n1. Go to your GitHub repository');
console.log('2. Click "Settings" tab');
console.log('3. Click "Secrets and variables" → "Actions" in the left sidebar');
console.log('4. Verify the following secrets exist (or create them if missing):\n');

const requiredSecrets = [
  {
    name: 'FTP_HOST',
    description: 'Your FTP server address',
    example: 'ftp.trendtacticsdigital.com'
  },
  {
    name: 'FTP_USERNAME',
    description: 'Your FTP username',
    example: 'your-ftp-username'
  },
  {
    name: 'FTP_PASSWORD',
    description: 'Your FTP password',
    example: 'your-ftp-password'
  },
  {
    name: 'SUPABASE_URL',
    description: 'Your Supabase project URL',
    example: 'https://your-project.supabase.co'
  },
  {
    name: 'SUPABASE_ANON_KEY',
    description: 'Your Supabase anonymous key',
    example: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'
  }
];

requiredSecrets.forEach((secret, index) => {
  console.log(`${index + 1}. ${secret.name}`);
  console.log(`   Description: ${secret.description}`);
  console.log(`   Example: ${secret.example}\n`);
});

console.log('⚠️  Important Notes:');
console.log('- Never share your actual secret values with anyone');
console.log('- Make sure your FTP credentials have write access to /public_html/academy/');
console.log('- Ensure your Supabase keys are the correct ones from your Supabase dashboard');
console.log('- If you recently changed any secrets, you may need to re-run the failed workflow');

console.log('\n🔄 To re-run a failed workflow:');
console.log('1. Go to your GitHub repository');
console.log('2. Click "Actions" tab');
console.log('3. Select the failed workflow run');
console.log('4. Click "Re-run jobs" button');