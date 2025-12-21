@echo off
TITLE Trendtactics Academy - FTP Deployment

echo ================================
echo Trendtactics Academy FTP Deployment
echo ================================

REM Check if WinSCP is installed (for FTP deployment)
echo Checking for FTP deployment tools...

REM Get FTP credentials from user
echo Please enter your FTP deployment details:
echo.

set /p ftp_host="FTP Host (e.g., ftp.yoursite.com): "
if "%ftp_host%"=="" (
    echo ERROR: FTP Host is required.
    echo.
    pause
    exit /b 1
)

set /p ftp_user="FTP Username: "
if "%ftp_user%"=="" (
    echo ERROR: FTP Username is required.
    echo.
    pause
    exit /b 1
)

set /p ftp_pass="FTP Password: "
if "%ftp_pass%"=="" (
    echo ERROR: FTP Password is required.
    echo.
    pause
    exit /b 1
)

set /p ftp_path="FTP Path (e.g., /public_html/academy.trendtacticsdigital.com/): "
if "%ftp_path%"=="" (
    echo ERROR: FTP Path is required.
    echo.
    pause
    exit /b 1
)

echo.
echo Deploying files via FTP...
echo.

REM Create WinSCP script for deployment
echo open %ftp_user%@%ftp_host%:%ftp_pass% > ftp-script.tmp
echo cd %ftp_path% >> ftp-script.tmp
echo option transfer binary >> ftp-script.tmp
echo synchronize remote . -delete >> ftp-script.tmp
echo close >> ftp-script.tmp
echo exit >> ftp-script.tmp

REM Execute FTP deployment using WinSCP (if available)
winscp.com /script=ftp-script.tmp > ftp-deploy.log 2>&1

if %errorlevel% equ 0 (
    echo.
    echo ================================
    echo FTP DEPLOYMENT SUCCESSFUL!
    echo ================================
    echo.
    echo Your site has been deployed via FTP.
    echo.
    echo Site URL: https://%ftp_host%%ftp_path%
    echo.
) else (
    echo.
    echo ================================
    echo FTP DEPLOYMENT FAILED
    echo ================================
    echo.
    echo Error occurred during FTP deployment.
    echo Please check your FTP credentials and connection.
    echo.
    echo Error log saved to ftp-deploy.log
    echo.
)

REM Clean up temporary files
del ftp-script.tmp >nul 2>&1

echo Press any key to exit...
pause >nul