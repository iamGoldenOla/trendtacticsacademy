# Deployment script for Trendtactics Academy
# This script builds and deploys both frontend and backend to your server

Write-Host "Starting deployment process for Trendtactics Academy..."

# Check if required environment variables are set
if (-not $env:DEPLOY_HOST -or -not $env:DEPLOY_USER -or -not $env:DEPLOY_KEY) {
    Write-Host "Error: Please set DEPLOY_HOST, DEPLOY_USER, and DEPLOY_KEY environment variables"
    Write-Host "Example:"
    Write-Host "  `$env:DEPLOY_HOST=`"your-server-ip`""
    Write-Host "  `$env:DEPLOY_USER=`"your-username`""
    Write-Host "  `$env:DEPLOY_KEY=`"C:\path\to\your\private\key`""
    exit 1
}

# Build frontend
Write-Host "Building frontend..."
Set-Location lms-frontend
npm run build
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Frontend build failed"
    exit 1
}
Set-Location ..

# Build backend
Write-Host "Building backend..."
Set-Location lms-backend
npm run build
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Backend build failed"
    exit 1
}
Set-Location ..

# Deploy frontend
Write-Host "Deploying frontend to $env:DEPLOY_HOST..."
# Using scp command (requires SSH to be installed on Windows)
scp -i $env:DEPLOY_KEY -r lms-frontend/build/* $env:DEPLOY_USER@$env:DEPLOY_HOST:/var/www/academy.trendtacticsdigital.com

# Deploy backend
Write-Host "Deploying backend to $env:DEPLOY_HOST..."
scp -i $env:DEPLOY_KEY -r lms-backend/* $env:DEPLOY_USER@$env:DEPLOY_HOST:/var/www/api.academy.trendtacticsdigital.com

# Configure and restart services
Write-Host "Configuring and restarting services..."
# This would typically be done with SSH, but PowerShell doesn't have a built-in SSH client
Write-Host "Please manually connect to your server and run the following commands:"
Write-Host "1. cd /var/www/api.academy.trendtacticsdigital.com"
Write-Host "2. npm ci --production"
Write-Host "3. pm2 reload academy-api || pm2 start app.js --name academy-api"
Write-Host "4. sudo systemctl reload nginx"

Write-Host "Deployment process completed!"