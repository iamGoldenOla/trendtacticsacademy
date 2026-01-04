# Advanced FTP Upload Script - Delete Old + Upload New + Clear Cache
# This script ensures the old template is completely removed and replaced

# FTP Configuration
$FtpHost = "academy.trendtacticsdigital.com"  # Change if different
$FtpUser = "your_ftp_username"                # CHANGE THIS
$FtpPass = "your_ftp_password"                # CHANGE THIS
$FtpPort = 21                                 # Change to 990 if using SFTP

# Files to manage
$FilesToUpload = @(
    @{
        LocalPath = "course-detail.html"
        RemotePath = "/public_html/academy.trendtacticsdigital.com/course-detail.html"
    },
    @{
        LocalPath = "checkout.html"
        RemotePath = "/public_html/academy.trendtacticsdigital.com/checkout.html"
    },
    @{
        LocalPath = "payment-success.html"
        RemotePath = "/public_html/academy.trendtacticsdigital.com/payment-success.html"
    },
    @{
        LocalPath = "api\verify-payment.php"
        RemotePath = "/public_html/academy.trendtacticsdigital.com/api/verify-payment.php"
    }
)

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "Advanced FTP Upload - Delete Old + Upload New" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

# Verify FTP credentials are set
if ($FtpUser -eq "your_ftp_username" -or $FtpPass -eq "your_ftp_password") {
    Write-Host "ERROR: Please update FTP credentials in this script!" -ForegroundColor Red
    Write-Host "Edit the script and set:" -ForegroundColor Yellow
    Write-Host "  - `$FtpUser = 'your_actual_ftp_username'" -ForegroundColor Yellow
    Write-Host "  - `$FtpPass = 'your_actual_ftp_password'" -ForegroundColor Yellow
    exit 1
}

# Delete file from FTP
function Delete-FileFromFtp {
    param(
        [string]$RemoteFile,
        [string]$Host,
        [string]$User,
        [string]$Pass,
        [int]$Port
    )
    
    try {
        # Create FTP request
        $FtpRequest = [System.Net.FtpWebRequest]::Create("ftp://$Host`:$Port$RemoteFile")
        $FtpRequest.Credentials = New-Object System.Net.NetworkCredential($User, $Pass)
        $FtpRequest.Method = [System.Net.WebRequestMethods+Ftp]::DeleteFile
        
        # Execute delete
        $Response = $FtpRequest.GetResponse()
        $Response.Close()
        
        return $true
    }
    catch {
        # File may not exist, which is OK
        return $false
    }
}

# Upload file to FTP
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
        # Create FTP request
        $FtpRequest = [System.Net.FtpWebRequest]::Create("ftp://$Host`:$Port$RemoteFile")
        $FtpRequest.Credentials = New-Object System.Net.NetworkCredential($User, $Pass)
        $FtpRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
        $FtpRequest.UseBinary = $true
        
        # Read local file
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
        Write-Host "ERROR uploading $LocalFile`: $_" -ForegroundColor Red
        return $false
    }
}

# Process all files
$SuccessCount = 0
$FailCount = 0

foreach ($File in $FilesToUpload) {
    Write-Host "Processing: $($File.LocalPath)" -ForegroundColor Yellow
    
    if (Test-Path $File.LocalPath) {
        # Step 1: Delete old file
        Write-Host "  [1/2] Deleting old file..." -ForegroundColor Gray
        $DeleteResult = Delete-FileFromFtp -RemoteFile $File.RemotePath `
                                           -Host $FtpHost `
                                           -User $FtpUser `
                                           -Pass $FtpPass `
                                           -Port $FtpPort
        
        if ($DeleteResult) {
            Write-Host "  ✓ Old file deleted" -ForegroundColor Green
        } else {
            Write-Host "  ℹ File didn't exist (OK)" -ForegroundColor Yellow
        }
        
        # Step 2: Upload new file
        Write-Host "  [2/2] Uploading new file..." -ForegroundColor Gray
        $UploadResult = Upload-FileToFtp -LocalFile $File.LocalPath `
                                         -RemoteFile $File.RemotePath `
                                         -Host $FtpHost `
                                         -User $FtpUser `
                                         -Pass $FtpPass `
                                         -Port $FtpPort
        
        if ($UploadResult) {
            Write-Host "  ✓ New file uploaded: $($File.RemotePath)" -ForegroundColor Green
            $SuccessCount++
        } else {
            Write-Host "  ✗ Failed to upload: $($File.RemotePath)" -ForegroundColor Red
            $FailCount++
        }
    } else {
        Write-Host "  ✗ Local file not found: $($File.LocalPath)" -ForegroundColor Red
        $FailCount++
    }
    
    Write-Host ""
}

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "Upload Summary" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "Success: $SuccessCount files" -ForegroundColor Green
Write-Host "Failed: $FailCount files" -ForegroundColor $(if ($FailCount -eq 0) { "Green" } else { "Red" })
Write-Host ""

if ($FailCount -eq 0) {
    Write-Host "✓ All files uploaded successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "IMPORTANT: Complete these steps to see changes:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. CLEAR BROWSER CACHE:" -ForegroundColor Yellow
    Write-Host "   Windows/Linux: Press Ctrl + Shift + Delete" -ForegroundColor White
    Write-Host "   Mac: Cmd + Shift + Delete" -ForegroundColor White
    Write-Host "   • Select 'All time'" -ForegroundColor White
    Write-Host "   • Check: Cookies, Cached images/files" -ForegroundColor White
    Write-Host "   • Click 'Clear data'" -ForegroundColor White
    Write-Host ""
    Write-Host "2. TRY INCOGNITO MODE:" -ForegroundColor Yellow
    Write-Host "   • Press Ctrl + Shift + N (or Cmd + Shift + N on Mac)" -ForegroundColor White
    Write-Host "   • Go to: https://academy.trendtacticsdigital.com/course-detail" -ForegroundColor White
    Write-Host ""
    Write-Host "3. VERIFY YOU SEE:" -ForegroundColor Yellow
    Write-Host "   ✓ Instructor profile (Akinola Olujobi)" -ForegroundColor White
    Write-Host "   ✓ 'Enroll & Pay' button (NOT 'Buy Now')" -ForegroundColor White
    Write-Host "   ✓ Professional course overview" -ForegroundColor White
    Write-Host ""
    Write-Host "4. IF STILL SHOWING OLD TEMPLATE:" -ForegroundColor Yellow
    Write-Host "   • Wait 5-10 minutes (server cache)" -ForegroundColor White
    Write-Host "   • Contact QServers support:" -ForegroundColor White
    Write-Host "     'Please clear CDN/server cache for academy.trendtacticsdigital.com'" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host "✗ Some files failed. Check the errors above." -ForegroundColor Red
    Write-Host ""
    Write-Host "TROUBLESHOOTING:" -ForegroundColor Yellow
    Write-Host "1. Verify FTP username and password" -ForegroundColor White
    Write-Host "2. Check if FTP host is correct" -ForegroundColor White
    Write-Host "3. Ensure /public_html/academy.trendtacticsdigital.com/ folder exists" -ForegroundColor White
    Write-Host "4. Contact QServers FTP support if problems persist" -ForegroundColor White
}

Write-Host ""
