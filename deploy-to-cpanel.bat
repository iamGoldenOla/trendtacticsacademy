@echo off
echo Building React app...
cd lms-frontend
npm run build
cd ..

if exist "lms-frontend\build" (
    echo Starting FTP deployment...
    node deploy-to-cpanel.js
) else (
    echo Build failed or build directory does not exist!
    pause
)