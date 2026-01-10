# Authentication Fix Deployment Instructions

## What was fixed:
- Removed problematic API call to localhost:5000 in authService.js
- Fixed signup/login to use direct Supabase authentication only
- Built new production files with the fix

## How to deploy the fix:

### Option 1: cPanel File Manager (Recommended)
1. Log in to your cPanel at https://trendtacticsdigital.com:2083
2. Username: trendtacticsdigital
3. Password: Dreycol123456789@
4. Navigate to "File Manager"
5. Go to the `/public_html/academy.trendtacticsdigital.com` directory (this is your subdomain web root)
6. Delete all existing files in the directory (you can backup first if needed)
7. Click "Upload" and select the `trendtactics-auth-fix.zip` file
8. After upload completes, click "Extract" to extract all files to the current directory
9. The files will now be in your subdomain web root and ready to use

### Option 2: FTP Client (Alternative)
1. Use an FTP client like FileZilla
2. Connect to:
   - Host: 193.227.129.17
   - Username: trendta1
   - Password: 2jWO6x][Oa6M4x
   - Port: 21
3. Navigate to the `/public_html/academy.trendtacticsdigital.com` directory
4. Delete existing files
5. Upload all files from the ZIP (after extracting it)

### Option 3: Command Line Deployment (Recommended)
Run the following command in your project directory to deploy directly:
```
cd "c:\Users\Akinola Olujobi\Documents\Trendtactics Academy"; $env:FTP_HOST="193.227.129.17"; $env:FTP_USER="trendta1"; $env:FTP_PASS="2jWO6x][Oa6M4x"; $env:FTP_PATH="/public_html/academy.trendtacticsdigital.com"; node deploy-to-cpanel.js
```

## After deployment:
1. Clear your browser cache (Ctrl+Shift+R or Cmd+Shift+R)
2. Try signing up again on academy.trendtacticsdigital.com
3. The signup should now work without the "Signup failed. Please try again." error

## Why this fixes the issue:
- The error was caused by a fetch call trying to connect to http://localhost:5000/api/auth/register
- This call was blocked by Content Security Policy since you're on academy.trendtacticsdigital.com
- The authentication now uses direct Supabase calls only, which don't require backend API
- With email confirmation disabled in Supabase, users can sign up and sign in immediately