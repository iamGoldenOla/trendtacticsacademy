# Deployment Script for Interactive Learning Workspace
# This script commits and pushes all changes to GitHub

# Navigate to the project root directory
Set-Location -Path "C:\Users\Akinola Olujobi\Documents\Trendtactics Academy"

# Add all changes to git
Write-Host "Adding all changes to git..." -ForegroundColor Green
git add .

# Commit the changes with a descriptive message
Write-Host "Committing changes..." -ForegroundColor Green
git commit -m "Implement Interactive Learning Workspace: Enhanced course dashboard with three-panel layout, improved navigation, rich content support, and interactive playground. Also enhanced admin course creator with AI-powered content generation and rich text editing."

# Push changes to GitHub
Write-Host "Pushing changes to GitHub..." -ForegroundColor Green
git push origin master

# Update the frontend submodule
Write-Host "Updating frontend submodule..." -ForegroundColor Green
Set-Location -Path "lms-frontend"
git add .
git commit -m "Update frontend with Interactive Learning Workspace components"
git push origin master

# Return to main directory
Set-Location -Path ".."

# Update the backend submodule
Write-Host "Updating backend submodule..." -ForegroundColor Green
Set-Location -Path "lms-backend"
git add .
git commit -m "Update backend with Interactive Learning Workspace APIs"
git push origin master

# Return to main directory
Set-Location -Path ".."

Write-Host "Deployment complete! All changes have been pushed to GitHub." -ForegroundColor Yellow
Write-Host "The Interactive Learning Workspace is now live." -ForegroundColor Yellow