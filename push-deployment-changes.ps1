# Script to push all deployment-related changes to GitHub

Write-Host "🚀 Pushing deployment changes to GitHub..." -ForegroundColor Green

# Add all deployment-related files
git add .github/workflows/
git add DEPLOYMENT.md
git add README_DEPLOYMENT.md
git add DEPLOYMENT_SUMMARY.md
git add deploy.sh
git add deploy.ps1
git add verify-deployment-setup.js
git add push-deployment-changes.ps1

# Add updated README files
git add lms-frontend/README.md
git add lms-backend/README.md

# Commit the changes
git commit -m "feat: Add automatic deployment setup for academy.trendtacticsdigital.com

- Add GitHub Actions workflows for frontend, backend, and full deployment
- Add comprehensive deployment documentation
- Add local deployment scripts for Windows and Linux/Mac
- Add verification script to check deployment setup
- Update README files with deployment information
- Add deployment summary document"

# Push to GitHub
Write-Host "📤 Pushing changes to GitHub..." -ForegroundColor Yellow
git push origin main

Write-Host "✅ Deployment changes pushed to GitHub!" -ForegroundColor Green
Write-Host "🎉 Your repository is now ready for automatic deployment to academy.trendtacticsdigital.com" -ForegroundColor Cyan