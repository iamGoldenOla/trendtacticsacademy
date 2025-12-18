# Deployment Script for Interactive Learning Workspace
# This script commits and pushes all changes to GitHub

# Navigate to the project directory
cd "c:\Users\Akinola Olujobi\Documents\Trendtactics Academy"

# Add all new and modified files
Write-Host "Adding files to git..." -ForegroundColor Green
git add .

# Commit the changes with a descriptive message
Write-Host "Committing changes..." -ForegroundColor Green
git commit -m "Implement Interactive Learning Workspace: Enhanced course experience with three-panel layout, sandboxed playground, and AI-assisted course creation"

# Push to GitHub
Write-Host "Pushing to GitHub..." -ForegroundColor Green
git push origin master

# Also push the frontend submodule if it exists
if (Test-Path "lms-frontend\.git") {
    Write-Host "Updating frontend submodule..." -ForegroundColor Green
    cd "lms-frontend"
    git add .
    git commit -m "Update frontend for Interactive Learning Workspace"
    git push origin master
    cd ..
}

# Also push the backend submodule if it exists
if (Test-Path "lms-backend\.git") {
    Write-Host "Updating backend submodule..." -ForegroundColor Green
    cd "lms-backend"
    git add .
    git commit -m "Update backend for Interactive Learning Workspace"
    git push origin master
    cd ..
}

Write-Host "Deployment complete!" -ForegroundColor Green
Write-Host "The Interactive Learning Workspace has been successfully deployed to GitHub." -ForegroundColor Yellow