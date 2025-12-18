#!/usr/bin/env node

// Script to fix the security issue by removing exposed credentials
const fs = require('fs');
const path = require('path');

console.log('🛡️ Security Fix Tool');
console.log('==================\n');

// Files that might contain exposed credentials
const filesToCheck = [
  'update-service-role-key.js'
];

// Patterns to look for (parts of sensitive credentials)
const sensitivePatterns = [
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
  'eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NTQ1NjAzOSwiZXhwIjoyMDgxMDMyMDM5fQ'
];

console.log('🔍 Checking for exposed credentials...\n');

let issuesFound = false;

for (const file of filesToCheck) {
  const filePath = path.join(__dirname, file);
  
  if (fs.existsSync(filePath)) {
    let content = fs.readFileSync(filePath, 'utf8');
    let originalContent = content;
    
    for (const pattern of sensitivePatterns) {
      if (content.includes(pattern)) {
        console.log(`⚠️  Found exposed credential in ${file}`);
        issuesFound = true;
        
        // Replace with placeholder
        content = content.replace(pattern, 'your_actual_service_role_key_here');
        
        // Also replace the full key if it's longer
        const fullKeyPattern = new RegExp(pattern + '[A-Za-z0-9_-]*', 'g');
        content = content.replace(fullKeyPattern, 'your_actual_service_role_key_here');
      }
    }
    
    // If we made changes, write back to file
    if (content !== originalContent) {
      fs.writeFileSync(filePath, content, 'utf8');
      console.log(`✅ Cleaned up ${file}`);
    }
  }
}

if (!issuesFound) {
  console.log('✅ No exposed credentials found in checked files');
}

console.log('\n🔐 Security Recommendations:');
console.log('========================');
console.log('1. Remove the actual service role key from any files in your codebase');
console.log('2. Regenerate your Supabase service role key immediately');
console.log('3. Store sensitive credentials only in secure environment variables');
console.log('4. Never commit actual credentials to version control');
console.log('5. Use GitHub Secrets for deployment credentials');

console.log('\n🔄 Next Steps:');
console.log('=============');
console.log('1. Go to your Supabase dashboard and regenerate the service role key');
console.log('2. Update your lms-backend/.env file with the NEW service role key');
console.log('3. Make sure the .env file is in your .gitignore');
console.log('4. Commit the cleaned files to your repository');