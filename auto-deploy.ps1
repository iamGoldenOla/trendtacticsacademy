# Auto-Deploy Script - Pull from GitHub and Push After Changes
# This script automates the entire deployment workflow

param(
    [string]$CommitMessage = "Automated deployment: Update files from latest changes"
)

Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "Auto-Deploy to GitHub" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""

# Get repo directory
$RepoDir = "c:\Users\Akinola Olujobi\Documents\Trendtactics Academy"

# Step 1: Check if git repo exists
if (-not (Test-Path "$RepoDir\.git")) {
    Write-Host "ERROR: Not a git repository!" -ForegroundColor Red
    Write-Host "Directory: $RepoDir" -ForegroundColor Yellow
    exit 1
}

Write-Host "[1/4] Pulling latest from GitHub..." -ForegroundColor Yellow
cd $RepoDir
$PullOutput = git pull origin master 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Successfully pulled from GitHub" -ForegroundColor Green
    Write-Host "$PullOutput" -ForegroundColor Gray
} else {
    Write-Host "✗ Pull failed!" -ForegroundColor Red
    Write-Host "$PullOutput" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[2/4] Checking for changes..." -ForegroundColor Yellow
$StatusOutput = git status --porcelain

if ([string]::IsNullOrWhiteSpace($StatusOutput)) {
    Write-Host "✓ No changes to commit - everything is up to date" -ForegroundColor Green
    Write-Host ""
    Write-Host "===========================================" -ForegroundColor Cyan
    Write-Host "Status: Repository is synchronized" -ForegroundColor Green
    Write-Host "===========================================" -ForegroundColor Cyan
    exit 0
}

Write-Host "✓ Found changes:" -ForegroundColor Green
Write-Host "$StatusOutput" -ForegroundColor Gray

Write-Host ""
Write-Host "[3/4] Staging all changes..." -ForegroundColor Yellow
git add .

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Staged all changes" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to stage changes" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[4/4] Committing and pushing to GitHub..." -ForegroundColor Yellow
git commit -m "$CommitMessage"

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Committed changes" -ForegroundColor Green
    
    $PushOutput = git push origin master 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Pushed to GitHub successfully" -ForegroundColor Green
        Write-Host "$PushOutput" -ForegroundColor Gray
    } else {
        Write-Host "✗ Push failed!" -ForegroundColor Red
        Write-Host "$PushOutput" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "✗ Commit failed" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "✓ Deployment Complete!" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  • Pulled latest from GitHub" -ForegroundColor White
Write-Host "  • Staged all changes" -ForegroundColor White
Write-Host "  • Committed with message:" -ForegroundColor White
Write-Host "    '$CommitMessage'" -ForegroundColor Yellow
Write-Host "  • Pushed to master branch" -ForegroundColor White
Write-Host ""
Write-Host "Next: Upload to FTP using QUICK_FTP_UPLOAD.md" -ForegroundColor Green
Write-Host ""
