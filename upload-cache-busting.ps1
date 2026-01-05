#!/usr/bin/env powershell
# Upload .htaccess files to cPanel to enable cache busting

param(
    [string]$FtpHost = "academy.trendtacticsdigital.com",
    [string]$FtpUser = "",
    [string]$FtpPass = "",
    [int]$FtpPort = 21
)

Write-Host "════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  UPLOADING CACHE-BUSTING .HTACCESS FILES" -ForegroundColor Cyan
Write-Host "════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

if ($FtpUser -eq "" -or $FtpPass -eq "") {
    Write-Host "ERROR: FTP credentials required" -ForegroundColor Red
    exit 1
}

# Files to upload
$files = @(
    @{
        LocalPath = ".\lms-frontend\build\.htaccess"
        RemotePath = "/public_html/academy.trendtacticsdigital.com/.htaccess"
    }
)

function Upload-FileToFtp {
    param(
        [string]$LocalFile,
        [string]$RemoteFile,
        [string]$FtpServer,
        [string]$User,
        [string]$Pass,
        [int]$Port
    )
    
    try {
        if (-not (Test-Path $LocalFile)) {
            Write-Host "File not found: $LocalFile" -ForegroundColor Red
            return $false
        }
        
        $FtpRequest = [System.Net.FtpWebRequest]::Create("ftp://$FtpServer`:$Port$RemoteFile")
        $FtpRequest.Credentials = New-Object System.Net.NetworkCredential($User, $Pass)
        $FtpRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
        $FtpRequest.UseBinary = $false  # Text file
        
        $FileContent = [System.IO.File]::ReadAllBytes($LocalFile)
        $RequestStream = $FtpRequest.GetRequestStream()
        $RequestStream.Write($FileContent, 0, $FileContent.Length)
        $RequestStream.Close()
        
        $Response = $FtpRequest.GetResponse()
        $Response.Close()
        
        return $true
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
        return $false
    }
}

$successCount = 0
$failCount = 0

foreach ($file in $files) {
    Write-Host "Uploading: $($file.LocalPath)..." -ForegroundColor Yellow
    
    $success = Upload-FileToFtp -LocalFile $file.LocalPath `
                                -RemoteFile $file.RemotePath `
                                -FtpServer $FtpHost `
                                -User $FtpUser `
                                -Pass $FtpPass `
                                -Port $FtpPort
    
    if ($success) {
        Write-Host "  ✅ Uploaded to $($file.RemotePath)" -ForegroundColor Green
        $successCount++
    } else {
        Write-Host "  ❌ Failed" -ForegroundColor Red
        $failCount++
    }
}

Write-Host ""
Write-Host "════════════════════════════════════════════════════" -ForegroundColor Gray
Write-Host "Success: $successCount | Failed: $failCount" -ForegroundColor $(if ($failCount -eq 0) { "Green" } else { "Red" })
Write-Host ""

if ($failCount -eq 0) {
    Write-Host "✅ Cache-busting enabled!" -ForegroundColor Green
    Write-Host ""
    Write-Host "What this does:" -ForegroundColor Cyan
    Write-Host "  • HTML files will NOT be cached (always fresh)" -ForegroundColor White
    Write-Host "  • JavaScript/CSS files ARE cached for performance" -ForegroundColor White
    Write-Host "  • Images are cached for performance" -ForegroundColor White
    Write-Host ""
    Write-Host "Next step: Clear your browser cache and refresh" -ForegroundColor Yellow
    Write-Host "  1. Press Ctrl+Shift+Delete" -ForegroundColor White
    Write-Host "  2. Press Ctrl+Shift+R to hard refresh" -ForegroundColor White
    Write-Host "  3. Visit https://academy.trendtacticsdigital.com" -ForegroundColor White
} else {
    Write-Host "Some files failed to upload. Check your FTP credentials." -ForegroundColor Red
}

Write-Host ""
