@echo off
echo ========================================
echo Trendtactics Academy - One-Click Deployment
echo ========================================
echo.

REM Check if git is installed
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Git is not installed on your system.
    echo Please install Git from https://git-scm.com/downloads
    echo.
    pause
    exit /b 1
)

echo Please enter your GitHub repository URL:
echo (Format: https://github.com/YOUR_USERNAME/REPO_NAME.git)
set /p repo_url="Repository URL: "

if "%repo_url%"=="" (
    echo ERROR: No repository URL provided.
    echo.
    pause
    exit /b 1
)

echo.
echo Initializing deployment...

REM Initialize git repository
git init
if %errorlevel% neq 0 (
    echo ERROR: Failed to initialize git repository.
    echo.
    pause
    exit /b 1
)

REM Add all files
git add .
if %errorlevel% neq 0 (
    echo ERROR: Failed to add files to repository.
    echo.
    pause
    exit /b 1
)

REM Commit files
git commit -m "Initial commit: Vibe Coding course deployment"
if %errorlevel% neq 0 (
    echo ERROR: Failed to commit files.
    echo.
    pause
    exit /b 1
)

REM Add remote origin
git remote add origin %repo_url%
if %errorlevel% neq 0 (
    echo ERROR: Failed to set remote repository.
    echo.
    pause
    exit /b 1
)

REM Push to GitHub
echo.
echo Pushing to GitHub... (you may be prompted for credentials)
git push -u origin main
if %errorlevel% neq 0 (
    echo ERROR: Failed to push to GitHub.
    echo You may need to use a Personal Access Token instead of password.
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo DEPLOYMENT SUCCESSFUL!
echo ========================================
echo.
echo Your site will be available at:
echo https://[YOUR_USERNAME].github.io/[REPO_NAME]/
echo.
echo It may take 2-3 minutes for the site to be live.
echo.
echo Future updates will automatically deploy when you push to the main branch.
echo.
pause