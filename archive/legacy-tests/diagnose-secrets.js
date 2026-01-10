/**
 * Diagnostic script to help verify GitHub secrets configuration
 * This script provides detailed instructions for setting up secrets correctly
 */

console.log('🔐 GitHub Secrets Diagnostic Tool\n');

console.log('🔧 Required Secrets for Deployment:');
console.log('=====================================\n');

const secrets = [
  {
    name: 'FTP_HOST',
    description: 'FTP server address',
    example: 'ftp.trendtacticsdigital.com',
    required: true
  },
  {
    name: 'FTP_USERNAME',
    description: 'FTP username',
    example: 'your-ftp-username',
    required: true
  },
  {
    name: 'FTP_PASSWORD',
    description: 'FTP password',
    example: 'your-ftp-password',
    required: true
  },
  {
    name: 'SUPABASE_URL',
    description: 'Supabase project URL',
    example: 'https://your-project.supabase.co',
    required: true
  },
  {
    name: 'SUPABASE_ANON_KEY',
    description: 'Supabase anonymous key',
    example: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
    required: true
  }
];

secrets.forEach((secret, index) => {
  const requiredText = secret.required ? '(REQUIRED)' : '(OPTIONAL)';
  console.log(`${index + 1}. ${secret.name} ${requiredText}`);
  console.log(`   Description: ${secret.description}`);
  console.log(`   Example: ${secret.example}\n`);
});

console.log('📋 How to Set Up Secrets in GitHub:');
console.log('====================================\n');

console.log('1. Go to your GitHub repository');
console.log('2. Click "Settings" tab');
console.log('3. In the left sidebar, click "Secrets and variables" → "Actions"');
console.log('4. Click "New repository secret"');
console.log('5. Enter the secret name and value');
console.log('6. Click "Add secret"\n');

console.log('⚠️  Important Notes:');
console.log('====================\n');

console.log('- Secret names are case-sensitive');
console.log('- Never share actual secret values');
console.log('- If you change a secret, you must re-run the workflow');
console.log('- Make sure your FTP user has write permissions to /public_html/academy/\n');

console.log('✅ Verification Steps:');
console.log('=====================\n');

console.log('1. Check that ALL required secrets are present');
console.log('2. Verify secret names match exactly (case-sensitive)');
console.log('3. Confirm FTP credentials work with an FTP client');
console.log('4. Ensure your Supabase keys are correct\n');

console.log('🔄 To Re-run a Failed Workflow:');
console.log('===============================\n');

console.log('1. Go to your GitHub repository');
console.log('2. Click "Actions" tab');
console.log('3. Select the failed workflow run');
console.log('4. Click "Re-run jobs" button\n');

console.log('📞 If Issues Persist:');
console.log('====================\n');

console.log('1. Check GitHub Status: https://www.githubstatus.com');
console.log('2. Review detailed logs in the Actions tab');
console.log('3. Verify your repository has the correct branch name (main or master)');
console.log('4. Ensure package-lock.json is committed to your repository');