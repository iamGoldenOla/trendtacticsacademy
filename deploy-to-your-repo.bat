@echo off
TITLE Deploy to Trendtactics Academy GitHub Repo

echo ================================
echo Deploying to GitHub Repository
echo ================================
echo Repository: https://github.com/iamGoldenOla/trendtacticsacademy
echo.

REM Check if Git is installed
echo Checking Git installation...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Git is not installed!
    echo Please install Git from https://git-scm.com/downloads
    echo.
    pause
    exit /b 1
)

echo Git found. Proceeding with deployment...
echo.

REM Initialize Git repository if not already initialized
echo Initializing Git repository...
if not exist ".git" (
    git init
    echo Git repository initialized.
) else (
    echo Git repository already exists.
)

echo.

REM Add all files
echo Adding files to Git...
git add .
echo Files added successfully.

echo.

REM Commit changes
echo Creating commit...
git commit -m "Auto-deploy: Update Trendtactics Academy site"
if %errorlevel% neq 0 (
    echo No changes to commit. Site is already up to date.
    goto deploy
)

echo Commit created successfully.

echo.

:deploy
REM Set remote origin to your specific repository
echo Setting up remote repository...
git remote add origin https://github.com/iamGoldenOla/trendtacticsacademy.git 2>nul
if %errorlevel% neq 0 (
    echo Remote origin already exists. Updating remote URL...
    git remote set-url origin https://github.com/iamGoldenOla/trendtacticsacademy.git
)

echo Remote repository configured.

echo.

REM Push to GitHub
echo Pushing to GitHub...
echo You may be prompted for your GitHub credentials.
echo If using two-factor authentication, use a Personal Access Token as password.
git push -u origin main --force
if %errorlevel% neq 0 (
    echo Trying with master branch...
    git push -u origin master --force
    if %errorlevel% neq 0 (
        echo ERROR: Failed to push to GitHub.
        echo Please check your credentials and repository permissions.
        echo.
        pause
        exit /b 1
    )
)

echo.

echo ================================
echo DEPLOYMENT SUCCESSFUL!
echo ================================
echo.
echo Your site has been deployed to:
echo https://github.com/iamGoldenOla/trendtacticsacademy
echo.
echo To enable GitHub Pages:
echo 1. Go to your repository Settings
echo 2. Navigate to Pages section
echo 3. Select "Deploy from a branch"
echo 4. Choose your branch (main or master)
echo 5. Select root folder
echo 6. Click Save
echo.
echo Your site will be available at:
echo https://iamGoldenOla.github.io/trendtacticsacademy/
echo.
echo Future updates will automatically deploy when you run this script.
echo.
pause