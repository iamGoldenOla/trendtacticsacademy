@echo off
echo 📦 Creating deployment ZIP file for Trendtactics Academy...
echo.

cd /d "c:\Users\Akinola Olujobi\Documents\Trendtactics Academy\lms-frontend"

REM Check if build folder exists
if not exist "build" (
    echo ❌ Error: Build folder not found!
    echo Please run 'npm run build' first
    pause
    exit /b 1
)

REM Remove existing ZIP file if it exists
if exist "..\trendtactics-academy-deployment.zip" (
    del "..\trendtactics-academy-deployment.zip"
    echo 🗑️ Removed existing ZIP file
)

REM Create ZIP file using PowerShell command
powershell -Command "Compress-Archive -Path 'build\*' -DestinationPath '..\trendtactics-academy-deployment.zip'"

REM Verify ZIP file was created
if exist "..\trendtactics-academy-deployment.zip" (
    echo ✅ Successfully created ZIP file!
    echo 📁 File: trendtactics-academy-deployment.zip
    echo 📍 Location: c:\Users\Akinola Olujobi\Documents\Trendtactics Academy\
    echo.
    echo 🚀 Ready for CPANEL deployment!
    echo Next steps:
    echo 1. Upload the ZIP file to your CPANEL File Manager
    echo 2. Extract it to your website root directory
    echo 3. Run the SQL scripts in Supabase
) else (
    echo ❌ Error: Failed to create ZIP file!
    pause
    exit /b 1
)

pause