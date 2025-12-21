@echo off
echo ========================================
echo Supabase Lessons Population Script
echo ========================================
echo.

REM Check if service role key is provided as argument
IF "%1"=="" (
    echo ❌ Error: Please provide your Supabase Service Role Key as an argument
    echo.
    echo Usage: run-with-service-key.bat YOUR_SERVICE_ROLE_KEY_HERE
    echo.
    echo To get your service role key:
    echo 1. Go to https://app.supabase.com/
    echo 2. Select your project
    echo 3. Go to Project Settings ^> API
    echo 4. Copy the SERVICE ROLE KEY
    echo.
    pause
    exit /b 1
)

echo 🔧 Setting up environment with your service role key...
set SUPABASE_SERVICE_ROLE_KEY=%1

echo 🔍 Current directory: %cd%
echo 📁 Looking for script...

REM Save current directory
set ORIGINAL_DIR=%cd%

REM Check if we're in the right directory or need to adjust
IF NOT EXIST "final-populate-lessons.js" (
    IF EXIST "%ORIGINAL_DIR%\final-populate-lessons.js" (
        REM We're in a subdirectory, file is in parent
        cd /d "%ORIGINAL_DIR%"
    ) ELSE (
        echo ❌ Error: Could not find final-populate-lessons.js
        echo Please run this batch file from the same directory as the script
        pause
        exit /b 1
    )
)

echo ✅ Found script, running...
echo.
node "final-populate-lessons.js"

echo.
echo ========================================
echo Script execution completed
echo ========================================
pause