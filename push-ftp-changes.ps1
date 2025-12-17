# Script to push all FTP frontend deployment-related changes to GitHub

Write-Host "🚀 Pushing FTP frontend deployment changes to GitHub..." -ForegroundColor Green

# Add all FTP deployment-related files
git add .github/workflows/deploy-frontend.yml
git add DEPLOYMENT.md
git add DEPLOYMENT_SUMMARY.md
git add verify-deployment-setup.js
git add test-ftp-workflow.js
git add push-ftp-changes.ps1

# Add updated README files
git add lms-frontend/README.md

# Commit the changes
git commit -m "feat: Update deployment setup for FTP-based frontend deployment

- Update documentation for FTP-based frontend deployment
- Add verification scripts for FTP frontend deployment
- Update README files with FTP frontend deployment information
- Focus on frontend deployment since backend is on Supabase"

# Push to GitHub
Write-Host "📤 Pushing changes to GitHub..." -ForegroundColor Yellow
git push origin main

Write-Host "✅ FTP frontend deployment changes pushed to GitHub!" -ForegroundColor Green
Write-Host "🎉 Your repository is now ready for automatic FTP frontend deployment to academy.trendtacticsdigital.com" -ForegroundColor Cyan