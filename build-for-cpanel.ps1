# Build Script for cPanel Deployment
# Run this script to build the React app for production

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  TrendTactics Academy - Build Script  " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Navigate to frontend directory
Write-Host "📁 Navigating to lms-frontend..." -ForegroundColor Yellow
Set-Location -Path "lms-frontend"

# Check if node_modules exists
if (!(Test-Path "node_modules")) {
    Write-Host "📦 Installing dependencies..." -ForegroundColor Yellow
    npm install
}

# Build the app
Write-Host "🔨 Building React app for production..." -ForegroundColor Yellow
npm run build

# Check if build was successful
if (Test-Path "build") {
    Write-Host ""
    Write-Host "✅ BUILD SUCCESSFUL!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📂 Build folder location:" -ForegroundColor Cyan
    Write-Host "   $(Get-Location)\build" -ForegroundColor White
    Write-Host ""
    Write-Host "📤 NEXT STEPS:" -ForegroundColor Yellow
    Write-Host "   1. Login to your cPanel" -ForegroundColor White
    Write-Host "   2. Go to File Manager" -ForegroundColor White
    Write-Host "   3. Navigate to public_html" -ForegroundColor White
    Write-Host "   4. DELETE all old files" -ForegroundColor White
    Write-Host "   5. Upload all files from the 'build' folder" -ForegroundColor White
    Write-Host "   6. Clear your browser cache (Ctrl+Shift+R)" -ForegroundColor White
    Write-Host ""
    Write-Host "🌐 Your website will be live at:" -ForegroundColor Cyan
    Write-Host "   https://academy.trendtacticsdigital.com" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "❌ BUILD FAILED!" -ForegroundColor Red
    Write-Host "   Check the error messages above" -ForegroundColor White
    Write-Host ""
}

# Return to root directory
Set-Location -Path ".."

