# TrendTactics Academy - Activate New Pages Script
# Run this after npm install completes

Write-Host "🚀 Activating new modern pages..." -ForegroundColor Cyan

# Navigate to frontend directory
Set-Location "lms-frontend/src/pages"

# Activate new Courses page
if (Test-Path "Courses.new.tsx") {
    Write-Host "✅ Activating new Courses page..." -ForegroundColor Green
    if (Test-Path "Courses.tsx") {
        Remove-Item "Courses.tsx" -Force
    }
    Move-Item "Courses.new.tsx" "Courses.tsx"
    Write-Host "   Courses page activated!" -ForegroundColor Green
}

# Activate new CourseDetail page
if (Test-Path "CourseDetail.new.tsx") {
    Write-Host "✅ Activating new CourseDetail page..." -ForegroundColor Green
    if (Test-Path "CourseDetail.tsx") {
        Remove-Item "CourseDetail.tsx" -Force
    }
    Move-Item "CourseDetail.new.tsx" "CourseDetail.tsx"
    Write-Host "   CourseDetail page activated!" -ForegroundColor Green
}

# Go back to root
Set-Location "../../.."

Write-Host ""
Write-Host "🎉 All pages activated successfully!" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Run 'npm start' in lms-frontend directory" -ForegroundColor White
Write-Host "2. Test the application" -ForegroundColor White
Write-Host "3. Push to GitHub for auto-deployment" -ForegroundColor White
Write-Host ""

