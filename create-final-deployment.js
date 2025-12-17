/**
 * Script to create the final deployment workflow after secrets are verified
 */

console.log('✅ Creating Final Deployment Workflow\n');
console.log('==================================\n');

// First, let's clean up any existing deployment workflow
console.log('🧹 Cleaning up existing deployment workflow...\n');

// Create the final deployment workflow
const fs = require('fs');

const deploymentWorkflow = `name: Deploy Frontend to Academy Subdomain

on:
  push:
    branches: [ master ]
  workflow_dispatch:

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    env:
      REACT_APP_SUPABASE_URL: \${{ secrets.SUPABASE_URL }}
      REACT_APP_SUPABASE_ANON_KEY: \${{ secrets.SUPABASE_ANON_KEY }}

    steps:
      # Step 1: Checkout repo
      - name: Checkout repository
        uses: actions/checkout@v4

      # Step 2: Set up Node.js
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
          cache-dependency-path: 'lms-frontend/package-lock.json'

      # Step 3: Install dependencies
      - name: Install frontend dependencies
        working-directory: lms-frontend
        run: npm ci

      # Step 4: Build React app
      - name: Build frontend
        working-directory: lms-frontend
        run: npm run build
        env:
          CI: false

      # Step 5: Debug - List build files
      - name: List build files
        working-directory: lms-frontend
        run: |
          echo "📁 Build directory contents:"
          ls -la build/
          echo "📄 Index.html exists:"
          if [ -f "build/index.html" ]; then
            echo "✅ index.html found"
          else
            echo "❌ index.html NOT found"
            exit 1
          fi

      # Step 6: Deploy via FTP
      - name: Deploy via FTP
        uses: SamKirkland/FTP-Deploy-Action@v4.3.5
        with:
          server: \${{ secrets.FTP_HOST }}
          username: \${{ secrets.FTP_USERNAME }}
          password: \${{ secrets.FTP_PASSWORD }}
          server-dir: /public_html/academy.trendtacticsdigital.com/
          local-dir: lms-frontend/build/
          exclude: |
            .git
            .git/**

      # Step 7: Success notification
      - name: Deployment Success
        run: |
          echo "✅ Deployment completed successfully!"
          echo "🌐 Website should be live at: https://academy.trendtacticsdigital.com"
          echo "⏱️ It may take a few minutes for changes to appear"
`;

// Write the deployment workflow to file
fs.writeFileSync('.github/workflows/deploy-frontend.yml', deploymentWorkflow);

console.log('✅ Final deployment workflow created successfully!');
console.log('📁 File saved as: .github/workflows/deploy-frontend.yml\n');

console.log('🔧 Next Steps:');
console.log('============\n');

console.log('1. Add the deployment workflow to git:');
console.log('   git add .github/workflows/deploy-frontend.yml\n');

console.log('2. Commit the changes:');
console.log('   git commit -m "Add final deployment workflow"\n');

console.log('3. Push to GitHub:');
console.log('   git push origin master\n');

console.log('4. Monitor deployment at: https://github.com/iamGoldenOla/trendtacticsacademy/actions\n');

console.log('✅ Success Indicators:');
console.log('===================\n');

console.log('When deployment runs successfully:');
console.log('• All steps show green checkmarks');
console.log('• No "server" or "exit code 128" errors');
console.log('• Website updates at https://academy.trendtacticsdigital.com');
console.log('• Deployment completes in 5-10 minutes\n');

console.log('💡 Pro Tips:');
console.log('==========\n');

console.log('• The workflow includes debugging steps to catch issues early');
console.log('• .git folders are excluded to prevent deployment conflicts');
console.log('• Build verification ensures files are generated correctly');
console.log('• Check GitHub Actions logs for detailed deployment information');