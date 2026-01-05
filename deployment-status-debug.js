#!/usr/bin/env node
/**
 * Deployment Status Debugger
 * Checks GitHub Actions workflow status and backend connectivity
 */

const https = require('https');

// Color codes for terminal output
const colors = {
  reset: '\x1b[0m',
  cyan: '\x1b[36m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  magenta: '\x1b[35m',
  gray: '\x1b[90m',
};

const log = {
  header: (text) => console.log(`\n${colors.cyan}${text}${colors.reset}`),
  success: (text) => console.log(`${colors.green}✅ ${text}${colors.reset}`),
  error: (text) => console.log(`${colors.red}❌ ${text}${colors.reset}`),
  warning: (text) => console.log(`${colors.yellow}⚠️  ${text}${colors.reset}`),
  info: (text) => console.log(`${colors.cyan}ℹ️  ${text}${colors.reset}`),
  step: (num, text) => console.log(`\n${colors.magenta}Step ${num}️⃣  ${text}${colors.reset}`),
  divider: () => console.log(`${colors.gray}${'━'.repeat(50)}${colors.reset}`),
};

async function makeRequest(url) {
  return new Promise((resolve, reject) => {
    https.get(url, (res) => {
      let data = '';
      res.on('data', (chunk) => data += chunk);
      res.on('end', () => resolve({ status: res.statusCode, data: JSON.parse(data) }));
    }).on('error', reject);
  });
}

async function diagnoseDeployment() {
  console.log(`\n${colors.cyan}╔════════════════════════════════════════════════════╗${colors.reset}`);
  console.log(`${colors.cyan}║   DEPLOYMENT STATUS DEBUGGER                       ║${colors.reset}`);
  console.log(`${colors.cyan}║   Check What's Happening With Your Deployment      ║${colors.reset}`);
  console.log(`${colors.cyan}╚════════════════════════════════════════════════════╝${colors.reset}`);

  // Configuration
  const config = {
    supabaseUrl: process.env.REACT_APP_SUPABASE_URL || 'https://your-project.supabase.co',
    supabaseKey: process.env.REACT_APP_SUPABASE_ANON_KEY || '',
    websiteUrl: 'https://academy.trendtacticsdigital.com',
    apiUrl: 'https://academy.trendtacticsdigital.com/api',
  };

  log.step(1, 'Testing Website Accessibility');
  log.divider();
  
  try {
    const response = await makeRequest(`${config.websiteUrl}/index.html`);
    log.success(`Website is accessible (Status: ${response.status})`);
    log.info(`Timestamp: ${new Date().toISOString()}`);
  } catch (err) {
    log.error(`Website is NOT accessible: ${err.message}`);
    log.warning(`The website may be down or DNS is not resolving correctly`);
  }

  log.step(2, 'Testing Supabase Connection');
  log.divider();

  if (!config.supabaseKey) {
    log.error(`Supabase key not found in environment variables`);
    log.warning(`Make sure REACT_APP_SUPABASE_ANON_KEY is set`);
  } else {
    try {
      const response = await makeRequest(`${config.supabaseUrl}/rest/v1/courses?select=id,title&limit=1`);
      log.success(`Supabase is accessible`);
      log.info(`Sample response: ${JSON.stringify(response.data).substring(0, 100)}...`);
    } catch (err) {
      log.error(`Supabase connection failed: ${err.message}`);
    }
  }

  log.step(3, 'Checking Course Data');
  log.divider();

  log.info(`You need to verify:`)
  console.log(`   1. Go to: Supabase Console`);
  console.log(`   2. Select: Your project`);
  console.log(`   3. Check: courses table has data`);
  console.log(`   4. Check: course_details table exists with instructor info`);
  console.log(`   5. Verify: updated_at timestamps are recent`);

  log.step(4, 'GitHub Actions Workflow Status');
  log.divider();

  console.log(`\n${colors.yellow}To check your deployment status:${colors.reset}`);
  console.log(`   1. Go to: https://github.com/YourUsername/YourRepo/actions`);
  console.log(`   2. Find: "Deploy Frontend to Academy Subdomain"`);
  console.log(`   3. Look for: ${colors.red}Red (Failed)${colors.reset} or ${colors.green}Green (Success)${colors.reset}`);
  console.log(`   4. Click the workflow to see logs`);
  console.log(`\n${colors.yellow}Common issues in GitHub Actions logs:${colors.reset}`);
  console.log(`   • ❌ "FTP connection failed" → Check FTP_HOST, FTP_USERNAME, FTP_PASSWORD secrets`);
  console.log(`   • ❌ "npm build failed" → Check your React code for errors`);
  console.log(`   • ❌ "index.html not found" → npm run build didn't complete successfully`);
  console.log(`   • ✅ "Deployment completed" → Check if files actually uploaded to cPanel`);

  log.step(5, 'CRITICAL CHECKS');
  log.divider();

  console.log(`\n${colors.magenta}Are your GitHub Secrets configured?${colors.reset}`);
  console.log(`   Repo → Settings → Secrets and variables → Actions`);
  console.log(`\n${colors.yellow}Required secrets:${colors.reset}`);
  console.log(`   • FTP_HOST = academy.trendtacticsdigital.com`);
  console.log(`   • FTP_USERNAME = (from cPanel)`);
  console.log(`   • FTP_PASSWORD = (from cPanel)`);
  console.log(`   • SUPABASE_URL = (from Supabase settings)`);
  console.log(`   • SUPABASE_ANON_KEY = (from Supabase settings)`);

  log.step(6, 'What to Do Next');
  log.divider();

  console.log(`\n${colors.green}Option 1: Re-run GitHub Actions Workflow${colors.reset}`);
  console.log(`   1. Go to GitHub Actions`);
  console.log(`   2. Click "Deploy Frontend to Academy Subdomain"`);
  console.log(`   3. Click "Run workflow" → "Run workflow" button`);
  console.log(`   4. Wait for completion and check logs\n`);

  console.log(`${colors.green}Option 2: Use Manual FTP Upload${colors.reset}`);
  console.log(`   1. Run: npm run build (in lms-frontend folder)`);
  console.log(`   2. Run: .\\manual-upload-build.ps1 -FtpUser "user" -FtpPass "pass"`);
  console.log(`   3. Clear browser cache`);
  console.log(`   4. Check website\n`);

  console.log(`${colors.green}Option 3: Run Diagnostics${colors.reset}`);
  console.log(`   1. Run: .\\URGENT-DEPLOYMENT-FIX.ps1 -FtpUser "user" -FtpPass "pass"`);
  console.log(`   2. Review the output`);
  console.log(`   3. Follow the recommended fixes\n`);

  log.divider();
  console.log(`\n${colors.cyan}For detailed information, run the PowerShell scripts with your FTP credentials.${colors.reset}\n`);
}

// Run diagnostics
diagnoseDeployment().catch(err => {
  console.error(`Fatal error: ${err.message}`);
  process.exit(1);
});
