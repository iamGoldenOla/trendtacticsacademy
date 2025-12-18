# Deployment Script for Course Workspace Debugging
# This script commits and pushes all debugging changes to GitHub

# Navigate to the project root directory
Set-Location -Path "C:\Users\Akinola Olujobi\Documents\Trendtactics Academy"

# Add all changes to git
Write-Host "Adding all changes to git..." -ForegroundColor Green
git add .

# Commit the changes with a descriptive message
Write-Host "Committing changes..." -ForegroundColor Green
git commit -m "Add debugging tools for Interactive Learning Workspace: CourseDebug page and test scripts to troubleshoot course routing issues"

# Push changes to GitHub
Write-Host "Pushing changes to GitHub..." -ForegroundColor Green
git push origin master

# Update the frontend submodule
Write-Host "Updating frontend submodule..." -ForegroundColor Green
Set-Location -Path "lms-frontend"
git add .
git commit -m "Add debugging tools for Interactive Learning Workspace: CourseDebug page and test scripts"
git push origin master

# Return to main directory
Set-Location -Path ".."

# Update the backend submodule
Write-Host "Updating backend submodule..." -ForegroundColor Green
Set-Location -Path "lms-backend"
git add .
git commit -m "Update backend with debugging support for course workspace"
git push origin master

# Return to main directory
Set-Location -Path ".."

Write-Host "Deployment complete! All debugging tools have been pushed to GitHub." -ForegroundColor Yellow
Write-Host "You can now test the course routing by visiting /course-debug/:courseId" -ForegroundColor Yellow