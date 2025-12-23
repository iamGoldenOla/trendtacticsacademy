Write-Host "Building React app..." -ForegroundColor Green
Set-Location -Path "lms-frontend"
npm run build
Set-Location -Path ".."

if (Test-Path "lms-frontend\build") {
    Write-Host "Starting FTP deployment..." -ForegroundColor Green
    node deploy-to-cpanel.js
} else {
    Write-Host "Build failed or build directory does not exist!" -ForegroundColor Red
    Read-Host "Press any key to continue..."
}