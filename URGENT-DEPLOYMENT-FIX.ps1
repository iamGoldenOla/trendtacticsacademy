# URGENT DEPLOYMENT FIX - Course Details Not Reflecting on cPanel
# This script diagnoses and fixes deployment issues

param(
    [string]$FtpHost = "academy.trendtacticsdigital.com",
    [string]$FtpUser = "",
    [string]$FtpPass = "",
    [string]$CpanelPath = "/public_html/academy.trendtacticsdigital.com"
)

Write-Host "╔════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   DEPLOYMENT DIAGNOSTICS & FIX                     ║" -ForegroundColor Cyan
Write-Host "║   Course Details Not Reflecting Issue              ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Step 1: Validate inputs
if ($FtpUser -eq "" -or $FtpPass -eq "") {
    Write-Host "❌ ERROR: FTP credentials not provided" -ForegroundColor Red
    Write-Host ""
    Write-Host "Usage: .\URGENT-DEPLOYMENT-FIX.ps1 -FtpUser 'username' -FtpPass 'password'" -ForegroundColor Yellow
    exit 1
}

# Step 2: Test FTP Connection
Write-Host "Step 1️⃣  Testing FTP Connection..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

function Test-FtpConnection {
    param(
        [string]$FtpServer,
        [string]$User,
        [string]$Pass,
        [int]$Port = 21
    )
    
    try {
        $FtpRequest = [System.Net.FtpWebRequest]::Create("ftp://$FtpServer`:$Port/")
        $FtpRequest.Credentials = New-Object System.Net.NetworkCredential($User, $Pass)
        $FtpRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
        $FtpRequest.Timeout = 5000
        
        $Response = $FtpRequest.GetResponse()
        $Response.Close()
        return $true
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
        return $false
    }
}

$ftpConnected = Test-FtpConnection -FtpServer $FtpHost -User $FtpUser -Pass $FtpPass

if ($ftpConnected) {
    Write-Host "✅ FTP Connection: SUCCESS" -ForegroundColor Green
} else {
    Write-Host "❌ FTP Connection: FAILED" -ForegroundColor Red
    Write-Host "   Check credentials and ensure FTP is enabled on cPanel" -ForegroundColor Yellow
    exit 1
}

# Step 3: Check what's currently on the server
Write-Host ""
Write-Host "Step 2️⃣  Checking Remote Files on cPanel..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

function Get-FtpFileList {
    param(
        [string]$FtpServer,
        [string]$User,
        [string]$Pass,
        [string]$RemotePath = "/",
        [int]$Port = 21
    )
    
    try {
        $FtpRequest = [System.Net.FtpWebRequest]::Create("ftp://$FtpServer`:$Port$RemotePath")
        $FtpRequest.Credentials = New-Object System.Net.NetworkCredential($User, $Pass)
        $FtpRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
        $FtpRequest.Timeout = 5000
        
        $Response = $FtpRequest.GetResponse()
        $StreamReader = New-Object System.IO.StreamReader($Response.GetResponseStream())
        $files = @()
        
        while ($line = $StreamReader.ReadLine()) {
            if ($line) {
                $files += $line
            }
        }
        
        $StreamReader.Close()
        $Response.Close()
        
        return $files
    }
    catch {
        Write-Host "Error listing files: $_" -ForegroundColor Red
        return @()
    }
}

$remoteFiles = Get-FtpFileList -FtpServer $FtpHost -User $FtpUser -Pass $FtpPass -RemotePath $CpanelPath

if ($remoteFiles.Count -gt 0) {
    Write-Host "✅ Found $($remoteFiles.Count) files/folders on remote server:" -ForegroundColor Green
    $remoteFiles | ForEach-Object {
        Write-Host "   • $_"
    }
} else {
    Write-Host "⚠️  No files found in $CpanelPath" -ForegroundColor Yellow
    Write-Host "   This suggests the deployment hasn't uploaded files yet" -ForegroundColor Yellow
}

# Step 4: Check index.html modification date
Write-Host ""
Write-Host "Step 3️⃣  Checking index.html Freshness..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

function Get-FtpFileTime {
    param(
        [string]$FtpServer,
        [string]$User,
        [string]$Pass,
        [string]$RemoteFile,
        [int]$Port = 21
    )
    
    try {
        $FtpRequest = [System.Net.FtpWebRequest]::Create("ftp://$FtpServer`:$Port$RemoteFile")
        $FtpRequest.Credentials = New-Object System.Net.NetworkCredential($User, $Pass)
        $FtpRequest.Method = [System.Net.WebRequestMethods+Ftp]::GetDateTimestamp
        $FtpRequest.Timeout = 5000
        
        $Response = $FtpRequest.GetResponse()
        $fileTime = $Response.LastModified
        $Response.Close()
        
        return $fileTime
    }
    catch {
        return $null
    }
}

$indexPath = "$CpanelPath/index.html"
$indexTime = Get-FtpFileTime -FtpServer $FtpHost -User $FtpUser -Pass $FtpPass -RemoteFile $indexPath

if ($indexTime) {
    $timeDiff = (Get-Date) - $indexTime
    Write-Host "✅ index.html found" -ForegroundColor Green
    Write-Host "   Last Modified: $indexTime" -ForegroundColor Cyan
    Write-Host "   Age: $($timeDiff.Hours) hours, $($timeDiff.Minutes) minutes" -ForegroundColor Cyan
    
    if ($timeDiff.TotalHours -gt 2) {
        Write-Host "   ⚠️  File is OLD - deployment may not have completed!" -ForegroundColor Yellow
    }
} else {
    Write-Host "❌ index.html NOT found on server" -ForegroundColor Red
    Write-Host "   Deployment has not successfully uploaded files" -ForegroundColor Yellow
}

# Step 5: Check local build
Write-Host ""
Write-Host "Step 4️⃣  Checking Local Build Files..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

$buildPath = ".\lms-frontend\build"
if (Test-Path $buildPath) {
    Write-Host "✅ Build directory exists" -ForegroundColor Green
    
    $buildFiles = Get-ChildItem $buildPath -Recurse | Where-Object {$_.PSIsContainer -eq $false}
    Write-Host "   Total files: $($buildFiles.Count)" -ForegroundColor Cyan
    
    if (Test-Path "$buildPath\index.html") {
        $indexFile = Get-Item "$buildPath\index.html"
        Write-Host "   index.html size: $($indexFile.Length) bytes" -ForegroundColor Cyan
        Write-Host "   Built: $($indexFile.LastWriteTime)" -ForegroundColor Cyan
    }
} else {
    Write-Host "❌ Build directory not found at: $buildPath" -ForegroundColor Red
    Write-Host "   Run: npm run build in lms-frontend directory" -ForegroundColor Yellow
}

# Step 6: CRITICAL FIXES TO TRY
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║   RECOMMENDED FIXES (Execute in Order)            ║" -ForegroundColor Magenta
Write-Host "╚════════════════════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""

Write-Host "FIX #1: Clear Browser Cache & Server Cache" -ForegroundColor Yellow
Write-Host "   ├─ Press: Ctrl + Shift + Delete in browser" -ForegroundColor White
Write-Host "   ├─ Clear: Cached images and files" -ForegroundColor White
Write-Host "   └─ Visit: https://academy.trendtacticsdigital.com/?nocache=$([datetime]::Now.Ticks)" -ForegroundColor White
Write-Host ""

Write-Host "FIX #2: Force GitHub Actions to Re-deploy" -ForegroundColor Yellow
Write-Host "   ├─ Go to: GitHub Repo → Actions" -ForegroundColor White
Write-Host "   ├─ Select: Deploy Frontend to Academy Subdomain" -ForegroundColor White
Write-Host "   ├─ Click: Run workflow" -ForegroundColor White
Write-Host "   └─ Monitor: The deployment logs for errors" -ForegroundColor White
Write-Host ""

Write-Host "FIX #3: Check GitHub Secrets Are Correct" -ForegroundColor Yellow
Write-Host "   ├─ Go to: Repo Settings → Secrets and variables → Actions" -ForegroundColor White
Write-Host "   ├─ Verify:" -ForegroundColor White
Write-Host "   │  ├─ FTP_HOST = academy.trendtacticsdigital.com" -ForegroundColor White
Write-Host "   │  ├─ FTP_USERNAME = (check with cPanel)" -ForegroundColor White
Write-Host "   │  ├─ FTP_PASSWORD = (check with cPanel)" -ForegroundColor White
Write-Host "   │  ├─ SUPABASE_URL = correct URL" -ForegroundColor White
Write-Host "   │  └─ SUPABASE_ANON_KEY = correct key" -ForegroundColor White
Write-Host ""

Write-Host "FIX #4: Manually Upload Build Files (If Auto-Deployment Fails)" -ForegroundColor Yellow
Write-Host "   └─ Run the provided manual-upload-build.ps1 script" -ForegroundColor White
Write-Host ""

Write-Host "FIX #5: Check Course Data in Supabase" -ForegroundColor Yellow
Write-Host "   ├─ Go to: Supabase Console" -ForegroundColor White
Write-Host "   ├─ Check: courses table has correct data" -ForegroundColor White
Write-Host "   ├─ Check: course_details table has description, instructor, etc" -ForegroundColor White
Write-Host "   └─ Verify: Data was updated in the last deployment" -ForegroundColor White
Write-Host ""

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host "For more details, check the GitHub Actions workflow logs:" -ForegroundColor Cyan
Write-Host "https://github.com/YourRepo/actions" -ForegroundColor Cyan
Write-Host ""
Write-Host "Report what you see in the workflow logs for further debugging" -ForegroundColor Yellow
