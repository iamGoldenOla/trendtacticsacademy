# Trendtactics Academy FTP Deployment Script
Write-Host "================================" -ForegroundColor Cyan
Write-Host "Trendtactics Academy FTP Deployment" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# Get FTP credentials from user
Write-Host "`nPlease enter your FTP deployment details:" -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray

$ftpHost = Read-Host "FTP Host (e.g., ftp.yoursite.com)"
if ([string]::IsNullOrEmpty($ftpHost)) {
    Write-Host "ERROR: FTP Host is required." -ForegroundColor Red
    Pause
    exit 1
}

$ftpUser = Read-Host "FTP Username"
if ([string]::IsNullOrEmpty($ftpUser)) {
    Write-Host "ERROR: FTP Username is required." -ForegroundColor Red
    Pause
    exit 1
}

$ftpPass = Read-Host "FTP Password" -AsSecureString
if ([string]::IsNullOrEmpty($ftpPass)) {
    Write-Host "ERROR: FTP Password is required." -ForegroundColor Red
    Pause
    exit 1
}

$ftpPath = Read-Host "FTP Path (e.g., /public_html/academy.trendtacticsdigital.com/)"
if ([string]::IsNullOrEmpty($ftpPath)) {
    Write-Host "ERROR: FTP Path is required." -ForegroundColor Red
    Pause
    exit 1
}

# Convert secure string to plain text
$ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($ftpPass)
$ftpPassPlain = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($ptr)
[System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptr)

Write-Host "`nDeploying files via FTP..." -ForegroundColor Green
Write-Host "--------------------------" -ForegroundColor Gray

try {
    # Create WebClient for FTP operations
    $webClient = New-Object System.Net.WebClient
    $webClient.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPassPlain)
    
    # Get list of files in current directory
    $files = Get-ChildItem -Path "." -Recurse | Where-Object { !$_.PSIsContainer }
    
    $successCount = 0
    $failCount = 0
    
    foreach ($file in $files) {
        try {
            # Calculate relative path
            $relativePath = $file.FullName.Substring((Get-Location).Path.Length + 1)
            
            # Create FTP URI
            $ftpUri = "ftp://$ftpHost$ftpPath$relativePath"
            
            # Create directory structure on FTP server
            $directoryPath = Split-Path $relativePath -Parent
            if ($directoryPath -and $directoryPath -ne ".") {
                # For simplicity, we'll rely on the FTP server to create directories
            }
            
            # Upload file
            Write-Host "Uploading: $relativePath" -ForegroundColor Gray
            $webClient.UploadFile($ftpUri, $file.FullName)
            $successCount++
        }
        catch {
            Write-Host "Failed to upload: $relativePath" -ForegroundColor Red
            Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
            $failCount++
        }
    }
    
    Write-Host "`n================================" -ForegroundColor Cyan
    if ($failCount -eq 0) {
        Write-Host "FTP DEPLOYMENT SUCCESSFUL!" -ForegroundColor Green
        Write-Host "================================" -ForegroundColor Cyan
        Write-Host "`nSuccessfully deployed $successCount files." -ForegroundColor Green
        Write-Host "Your site has been deployed via FTP." -ForegroundColor Green
        Write-Host "`nSite URL: https://$ftpHost$ftpPath" -ForegroundColor Yellow
    } else {
        Write-Host "FTP DEPLOYMENT COMPLETED WITH ERRORS" -ForegroundColor Yellow
        Write-Host "================================" -ForegroundColor Cyan
        Write-Host "`nSuccessfully deployed $successCount files." -ForegroundColor Green
        Write-Host "Failed to deploy $failCount files." -ForegroundColor Red
        Write-Host "Check error messages above for details." -ForegroundColor Yellow
    }
}
catch {
    Write-Host "`n================================" -ForegroundColor Cyan
    Write-Host "FTP DEPLOYMENT FAILED" -ForegroundColor Red
    Write-Host "================================" -ForegroundColor Cyan
    Write-Host "`nError occurred during FTP deployment." -ForegroundColor Red
    Write-Host "Please check your FTP credentials and connection." -ForegroundColor Red
    Write-Host "`nError details: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`nPress any key to exit..." -ForegroundColor Gray
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")