@echo off
echo ========================================
echo Security Cleanup Script
echo ========================================
echo.

echo 🔍 Checking for potential security issues...

REM Check if service key is hardcoded in run-with-service-key.bat
findstr /C:"SUPABASE_SERVICE_ROLE_KEY=" "run-with-service-key.bat" >nul
if %errorlevel% == 0 (
    echo ⚠️  Warning: Service key may be hardcoded in run-with-service-key.bat
    echo    Please ensure you only pass the key as a parameter
) else (
    echo ✅ run-with-service-key.bat is secure
)

echo.
echo 🧹 Cleaning up temporary files...
del /Q "*.log" 2>nul
del /Q "*.tmp" 2>nul

echo.
echo 🔒 Security recommendations:
echo 1. Always pass service keys as parameters, never hardcode them
echo 2. Use environment variables for local development
echo 3. Never commit keys to version control
echo 4. Rotate keys periodically

echo.
echo ✅ Security cleanup completed
echo ========================================
pause