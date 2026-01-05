#!/usr/bin/env powershell
# Manual FTP Upload - Direct Build Files Upload to cPanel
# Use this if GitHub Actions deployment is failing

param(
    [string]$FtpHost = "academy.trendtacticsdigital.com",
    [string]$FtpUser = "",
    [string]$FtpPass = "",
    [string]$LocalBuildPath = ".\lms-frontend\build",
    [string]$RemotePath = "/public_html/academy.trendtacticsdigital.com/",
    [int]$FtpPort = 21
)

Write-Host "╔════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   MANUAL FTP BUILD UPLOAD                          ║" -ForegroundColor Cyan
Write-Host "║   Direct File Transfer to cPanel                   ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Validate inputs
if ($FtpUser -eq "" -or $FtpPass -eq "") {
    Write-Host "❌ ERROR: FTP credentials not provided" -ForegroundColor Red
    Write-Host ""
    Write-Host "Usage:" -ForegroundColor Yellow
    Write-Host ".\manual-upload-build.ps1 -FtpUser 'username' -FtpPass 'password'" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

# Check build directory
if (-not (Test-Path $LocalBuildPath)) {
    Write-Host "❌ ERROR: Build directory not found" -ForegroundColor Red
    Write-Host "Path: $LocalBuildPath" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please run: npm run build" -ForegroundColor Yellow
    Write-Host "From directory: lms-frontend" -ForegroundColor Yellow
    exit 1
}

Write-Host "📦 Build Directory: $LocalBuildPath" -ForegroundColor Cyan
Write-Host "🌐 FTP Host: $FtpHost" -ForegroundColor Cyan
Write-Host "📁 Remote Path: $RemotePath" -ForegroundColor Cyan
Write-Host ""

# Get all files to upload
$files = Get-ChildItem -Path $LocalBuildPath -Recurse -File
$totalFiles = $files.Count
$successCount = 0
$failCount = 0

Write-Host "📊 Total files to upload: $totalFiles" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host ""

# FTP upload function
function Upload-FileToFtp {
    param(
        [string]$LocalFile,
        [string]$RemoteFile,
        [string]$Host,
        [string]$User,
        [string]$Pass,
        [int]$Port
    )
    
    try {
        $FtpRequest = [System.Net.FtpWebRequest]::Create("ftp://$Host`:$Port$RemoteFile")
        $FtpRequest.Credentials = New-Object System.Net.NetworkCredential($User, $Pass)
        $FtpRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
        $FtpRequest.UseBinary = $true
        $FtpRequest.KeepAlive = $false
        $FtpRequest.Timeout = 10000
        
        # Read file
        $FileContent = [System.IO.File]::ReadAllBytes($LocalFile)
        
        # Upload
        $RequestStream = $FtpRequest.GetRequestStream()
        $RequestStream.Write($FileContent, 0, $FileContent.Length)
        $RequestStream.Close()
        
        # Get response
        $Response = $FtpRequest.GetResponse()
        $Response.Close()
        
        return $true
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
        return $false
    }
}

# Create directories on FTP if needed
function Create-FtpDirectory {
    param(
        [string]$Host,
        [string]$User,
        [string]$Pass,
        [string]$RemotePath,
        [int]$Port
    )
    
    try {
        $FtpRequest = [System.Net.FtpWebRequest]::Create("ftp://$Host`:$Port$RemotePath")
        $FtpRequest.Credentials = New-Object System.Net.NetworkCredential($User, $Pass)
        $FtpRequest.Method = [System.Net.WebRequestMethods+Ftp]::MakeDirectory
        $FtpRequest.Timeout = 5000
        
        $Response = $FtpRequest.GetResponse()
        $Response.Close()
        return $true
    }
    catch {
        # Directory might already exist, ignore
        return $false
    }
}

# Upload each file
$uploadedFiles = @()

foreach ($file in $files) {
    # Calculate relative path
    $relativePath = $file.FullName.Substring($LocalBuildPath.Length + 1)
    $relativePathForward = $relativePath -replace '\\', '/'
    $ftpPath = "$RemotePath$relativePathForward"
    
    # Create directory structure on FTP
    $parentDir = [System.IO.Path]::GetDirectoryName($ftpPath) -replace '\\', '/'
    if ($parentDir -ne $RemotePath.TrimEnd('/')) {
        Create-FtpDirectory -Host $FtpHost -User $FtpUser -Pass $FtpPass -RemotePath $parentDir -Port $FtpPort
    }
    
    # Upload file
    $progressPercent = [math]::Round(($uploadedFiles.Count / $totalFiles) * 100)
    Write-Host "[$progressPercent%] Uploading: $relativePathForward..." -ForegroundColor Yellow
    
    $success = Upload-FileToFtp -LocalFile $file.FullName `
                                -RemoteFile $ftpPath `
                                -Host $FtpHost `
                                -User $FtpUser `
                                -Pass $FtpPass `
                                -Port $FtpPort
    
    if ($success) {
        Write-Host "       ✅ Success" -ForegroundColor Green
        $uploadedFiles += $relativePathForward
        $successCount++
    } else {
        Write-Host "       ❌ Failed" -ForegroundColor Red
        $failCount++
    }
    
    # Small delay to prevent overwhelming the server
    Start-Sleep -Milliseconds 100
}

# Summary
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host "╔════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   UPLOAD SUMMARY                                   ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "Total Files: $totalFiles" -ForegroundColor White
Write-Host "✅ Successful: $successCount" -ForegroundColor Green
Write-Host "❌ Failed: $failCount" -ForegroundColor $(if ($failCount -eq 0) { "Green" } else { "Red" })
Write-Host ""

if ($failCount -eq 0) {
    Write-Host "🎉 ALL FILES UPLOADED SUCCESSFULLY!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next Steps:" -ForegroundColor Yellow
    Write-Host "1. ✅ Hard refresh browser: Ctrl + Shift + Delete" -ForegroundColor White
    Write-Host "2. 🌐 Visit: https://academy.trendtacticsdigital.com/" -ForegroundColor White
    Write-Host "3. 🧹 Clear browser cache and cookies" -ForegroundColor White
    Write-Host "4. 🔄 Refresh page multiple times" -ForegroundColor White
    Write-Host ""
    Write-Host "Changes should now be visible on cPanel!" -ForegroundColor Green
} else {
    Write-Host "⚠️  SOME FILES FAILED TO UPLOAD" -ForegroundColor Red
    Write-Host ""
    Write-Host "Possible causes:" -ForegroundColor Yellow
    Write-Host "• FTP credentials are incorrect" -ForegroundColor White
    Write-Host "• FTP user doesn't have write permissions" -ForegroundColor White
    Write-Host "• Network connection issues" -ForegroundColor White
    Write-Host "• cPanel FTP server is temporarily down" -ForegroundColor White
    Write-Host ""
    Write-Host "Try again with valid credentials or check cPanel FTP settings" -ForegroundColor Yellow
}

Write-Host ""
