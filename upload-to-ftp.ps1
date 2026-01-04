# FTP Upload Script for Trendtactics Academy
# This script uploads the latest course files to your cPanel FTP server

# FTP Configuration
$FtpHost = "academy.trendtacticsdigital.com"  # Change if different
$FtpUser = "your_ftp_username"                # CHANGE THIS
$FtpPass = "your_ftp_password"                # CHANGE THIS
$FtpPort = 21                                 # Change to 990 if using SFTP

# Local files to upload
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

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "FTP Upload Script" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Verify FTP credentials are set
if ($FtpUser -eq "your_ftp_username" -or $FtpPass -eq "your_ftp_password") {
    Write-Host "ERROR: Please update FTP credentials in this script!" -ForegroundColor Red
    Write-Host "Edit the script and set:" -ForegroundColor Yellow
    Write-Host "  - `$FtpUser = 'your_actual_ftp_username'" -ForegroundColor Yellow
    Write-Host "  - `$FtpPass = 'your_actual_ftp_password'" -ForegroundColor Yellow
    exit 1
}

# Create FTP connection function
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

# Upload all files
$SuccessCount = 0
$FailCount = 0

foreach ($File in $FilesToUpload) {
    Write-Host "Uploading: $($File.LocalPath)..." -ForegroundColor Yellow
    
    if (Test-Path $File.LocalPath) {
        $Success = Upload-FileToFtp -LocalFile $File.LocalPath `
                                    -RemoteFile $File.RemotePath `
                                    -Host $FtpHost `
                                    -User $FtpUser `
                                    -Pass $FtpPass `
                                    -Port $FtpPort
        
        if ($Success) {
            Write-Host "  ✓ Uploaded to $($File.RemotePath)" -ForegroundColor Green
            $SuccessCount++
        } else {
            Write-Host "  ✗ Failed to upload $($File.RemotePath)" -ForegroundColor Red
            $FailCount++
        }
    } else {
        Write-Host "  ✗ Local file not found: $($File.LocalPath)" -ForegroundColor Red
        $FailCount++
    }
}

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Upload Summary" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Success: $SuccessCount files" -ForegroundColor Green
Write-Host "Failed: $FailCount files" -ForegroundColor $(if ($FailCount -eq 0) { "Green" } else { "Red" })
Write-Host ""

if ($FailCount -eq 0) {
    Write-Host "✓ All files uploaded successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Hard refresh your browser: Ctrl + Shift + Delete" -ForegroundColor White
    Write-Host "2. Go to: https://academy.trendtacticsdigital.com/course-detail" -ForegroundColor White
    Write-Host "3. You should see the instructor profile and 'Enroll & Pay' button" -ForegroundColor White
} else {
    Write-Host "✗ Some files failed. Check the errors above." -ForegroundColor Red
}
