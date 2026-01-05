#!/usr/bin/env powershell
# Simplified Deployment Diagnostic
# Tests connectivity and checks file status

param(
    [string]$FtpHost = "academy.trendtacticsdigital.com",
    [string]$FtpUser = "",
    [string]$FtpPass = "",
    [int]$FtpPort = 21
)

Write-Host "════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  SIMPLIFIED DEPLOYMENT DIAGNOSTIC" -ForegroundColor Cyan
Write-Host "════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# Validate inputs
if ($FtpUser -eq "" -or $FtpPass -eq "") {
    Write-Host "ERROR: FTP credentials not provided" -ForegroundColor Red
    Write-Host ""
    Write-Host "Usage:" -ForegroundColor Yellow
    Write-Host ".\SIMPLE-DEPLOYMENT-CHECK.ps1 -FtpUser 'username' -FtpPass 'password'" -ForegroundColor Yellow
    exit 1
}

Write-Host "Testing FTP Connection..." -ForegroundColor Yellow
Write-Host "FTP Host: $FtpHost" -ForegroundColor Cyan
Write-Host "FTP User: $FtpUser" -ForegroundColor Cyan
Write-Host ""

# Try simpler approach with error handling
try {
    Write-Host "Attempting connection (may take 10 seconds)..." -ForegroundColor Gray
    
    $FtpRequest = [System.Net.FtpWebRequest]::Create("ftp://$FtpHost/")
    $FtpRequest.Credentials = New-Object System.Net.NetworkCredential($FtpUser, $FtpPass)
    $FtpRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
    $FtpRequest.Timeout = 10000
    
    $Response = $FtpRequest.GetResponse()
    $Response.Close()
    
    Write-Host "✅ FTP Connection: SUCCESS" -ForegroundColor Green
    Write-Host ""
    Write-Host "Good news! Your FTP credentials are working." -ForegroundColor Green
    Write-Host ""
    
    # Now check what's in the academy subdirectory
    Write-Host "Checking files in /public_html/academy.trendtacticsdigital.com/..." -ForegroundColor Yellow
    
    try {
        $FtpRequest2 = [System.Net.FtpWebRequest]::Create("ftp://$FtpHost/public_html/academy.trendtacticsdigital.com/")
        $FtpRequest2.Credentials = New-Object System.Net.NetworkCredential($FtpUser, $FtpPass)
        $FtpRequest2.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
        $FtpRequest2.Timeout = 10000
        
        $Response2 = $FtpRequest2.GetResponse()
        $StreamReader = New-Object System.IO.StreamReader($Response2.GetResponseStream())
        $files = @()
        
        while ($line = $StreamReader.ReadLine()) {
            if ($line) {
                $files += $line
            }
        }
        
        $StreamReader.Close()
        $Response2.Close()
        
        if ($files.Count -gt 0) {
            Write-Host "✅ Found $($files.Count) items in remote directory:" -ForegroundColor Green
            $files | ForEach-Object {
                Write-Host "   • $_" -ForegroundColor White
            }
            
            # Check if index.html exists
            if ($files -contains "index.html") {
                Write-Host ""
                Write-Host "✅ index.html EXISTS on server" -ForegroundColor Green
                Write-Host "   This means files HAVE been deployed." -ForegroundColor Green
            } else {
                Write-Host ""
                Write-Host "❌ index.html NOT FOUND" -ForegroundColor Red
                Write-Host "   Files may not have been uploaded yet." -ForegroundColor Yellow
            }
        } else {
            Write-Host "❌ Directory is empty or doesn't exist" -ForegroundColor Red
        }
    }
    catch {
        Write-Host "⚠️  Could not list remote directory: $_" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "❌ FTP Connection: FAILED" -ForegroundColor Red
    Write-Host "Error: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Possible causes:" -ForegroundColor Yellow
    Write-Host "  1. FTP username/password is incorrect" -ForegroundColor White
    Write-Host "  2. FTP port is blocked (try 990 for SFTP)" -ForegroundColor White
    Write-Host "  3. FTP server is temporarily unavailable" -ForegroundColor White
    Write-Host "  4. Network connectivity issue" -ForegroundColor White
    Write-Host ""
    Write-Host "What to check:" -ForegroundColor Cyan
    Write-Host "  • Go to cPanel → FTP Accounts" -ForegroundColor White
    Write-Host "  • Verify FTP username and password" -ForegroundColor White
    Write-Host "  • Check if FTP account is ACTIVE" -ForegroundColor White
    Write-Host "  • Try connecting with FileZilla or another FTP client" -ForegroundColor White
}

Write-Host ""
Write-Host "════════════════════════════════════════════════════" -ForegroundColor Gray
Write-Host ""
Write-Host "NEXT STEPS:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. If FTP connection WORKS:" -ForegroundColor Green
Write-Host "   • Files ARE on your server" -ForegroundColor White
Write-Host "   • Clear browser cache (Ctrl+Shift+Delete)" -ForegroundColor White
Write-Host "   • Hard refresh (Ctrl+Shift+R)" -ForegroundColor White
Write-Host "   • Try incognito/private browsing" -ForegroundColor White
Write-Host ""
Write-Host "2. If FTP connection FAILS:" -ForegroundColor Red
Write-Host "   • Check cPanel FTP credentials" -ForegroundColor White
Write-Host "   • Verify FTP account is enabled" -ForegroundColor White
Write-Host "   • Check GitHub Actions workflow for errors" -ForegroundColor White
Write-Host "   • Re-deploy using manual upload script" -ForegroundColor White
Write-Host ""
