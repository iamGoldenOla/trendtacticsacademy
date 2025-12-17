# Deployment Script for Trendtactics Academy Updates
# This script automates the deployment of recent fixes and improvements

Write-Host "🚀 Deploying Trendtactics Academy Updates" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

# 1. Git Operations - Add, commit, and push changes
Write-Host "`n1. Preparing code changes for deployment..." -ForegroundColor Yellow

# Add all changed files
git add .

# Commit changes with descriptive message
git commit -m "Fix: AI chat auto-popup, update course pricing, add SVG icons, redesign sign-in buttons, add AI courses"

# Push to GitHub repository
git push origin master

Write-Host "✅ Code changes pushed to GitHub" -ForegroundColor Green

# 2. Trigger deployment workflow
Write-Host "`n2. Triggering deployment workflow..." -ForegroundColor Yellow

# The GitHub Actions workflow will automatically deploy the frontend
# when changes are pushed to the master branch

Write-Host "🔄 Deployment workflow triggered automatically via GitHub Actions" -ForegroundColor Green

# 3. Display deployment status URL
Write-Host "`n3. Monitor deployment progress:" -ForegroundColor Yellow
Write-Host "   GitHub Actions: https://github.com/iamGoldenOla/trendtacticsacademy/actions" -ForegroundColor Cyan
Write-Host "   Live Site: https://academy.trendtacticsdigital.com" -ForegroundColor Cyan

# 4. Summary of deployed changes
Write-Host "`n📋 Summary of Deployed Changes:" -ForegroundColor Yellow
Write-Host "   • AI Assistant now defaults to hidden state" -ForegroundColor White
Write-Host "   • Replaced emoji icons with SVG icons on homepage" -ForegroundColor White
Write-Host "   • Redesigned sign-in/get started buttons for desktop" -ForegroundColor White
Write-Host "   • Updated course prices to start at $10" -ForegroundColor White
Write-Host "   • Replaced duplicate course with VIBE CODING" -ForegroundColor White
Write-Host "   • Added 3 new AI courses (Automation, Prompt Engineering, Content Creation)" -ForegroundColor White

Write-Host "`n✅ Deployment process initiated successfully!" -ForegroundColor Green
Write-Host "   The site will be updated within 5-10 minutes." -ForegroundColor Gray