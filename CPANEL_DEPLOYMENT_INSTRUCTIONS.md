<<<<<<< HEAD
# CPANEL Deployment Instructions for Trendtactics Academy

## Prerequisites
- You have a CPANEL hosting account
- You have FTP/SFTP access to your hosting account
- You have the `trendtactics-academy-deployment.zip` file (36.8MB)

## Deployment Steps

### 1. Extract the Deployment Package
First, extract the contents of `trendtactics-academy-deployment.zip` to a local folder. You should see the following structure:
```
build/
├── index.html
├── static/
│   ├── css/
│   └── js/
├── images/
├── partners/
├── payments/
└── videos/
```

### 2. Upload Files to CPANEL
1. Log in to your CPANEL dashboard
2. Navigate to the File Manager
3. Go to your document root directory (usually `public_html` or `www`)
4. If you have an existing `academy.trendtacticsdigital.com` directory, back it up first
5. Delete the contents of the `academy.trendtacticsdigital.com` directory (but not the directory itself)
6. Upload all files from the extracted `build` folder to the `academy.trendtacticsdigital.com` directory

### 3. Verify Deployment
1. Visit your website: https://academy.trendtacticsdigital.com
2. You should see the Trendtactics Academy homepage with the "Vibe Coding" course displayed
3. Navigate to the Courses page to verify the course is listed
4. Click on the "Vibe Coding" course to view its details

## Troubleshooting

### If the Course Still Doesn't Appear:
1. **Hard Refresh**: Press Ctrl+F5 (Windows) or Cmd+Shift+R (Mac) to force refresh
2. **Clear Browser Cache**: Clear your browser's cache completely
3. **Check Console**: Open browser developer tools (F12) and check for JavaScript errors
4. **Verify Build**: Make sure you uploaded the latest build files

### If You See a Blank Page:
1. Check that all files were uploaded correctly
2. Verify that `index.html` is in the root directory
3. Check that the `static` folder and its contents are uploaded

### If Images Don't Load:
1. Ensure the `images`, `partners`, `payments`, and `videos` folders were uploaded
2. Check file permissions (should be 644 for files, 755 for directories)

## Important Notes

### Regarding GitHub Deployment
- Uploading files to CPANEL manually will NOT affect your GitHub repository
- GitHub Actions will continue to work for GitHub Pages deployments
- You can continue to deploy to both platforms independently

### Existing LMS Content
- The manual upload will only update the frontend files
- All existing backend functionality (database, authentication, etc.) will remain intact
- Your Supabase database is separate and will not be affected by this upload

## Post-Deployment Verification

After deployment, verify that:
1. ✅ Homepage loads correctly
2. ✅ "Vibe Coding" course appears in the featured courses section
3. ✅ Courses page displays the "Vibe Coding" course
4. ✅ Course detail page loads correctly
5. ✅ All navigation works properly
6. ✅ No console errors in browser developer tools

## Support

If you encounter any issues after following these steps, please contact support with:
1. Screenshots of the issue
2. Browser console errors (if any)
3. Steps you took during deployment
=======
# cPanel Deployment Instructions

This project includes automated deployment scripts to deploy your React application to cPanel via FTP.

## Prerequisites

1. Node.js installed on your system
2. cPanel/FTP access credentials:
   - FTP Hostname
   - FTP Username
   - FTP Password
   - FTP Path (usually `/public_html` or `/www`)

## Setup

1. Install dependencies:
   ```bash
   cd lms-frontend
   npm install
   ```

2. Update the deployment configuration in `deploy-to-cpanel.js`:
   ```javascript
   const config = {
       host: 'your-domain.com',           // Your FTP host
       user: 'your_ftp_username',        // Your FTP username
       password: 'your_ftp_password',    // Your FTP password
       port: 21,                        // FTP port (usually 21)
       remotePath: '/public_html'       // Web root directory
   };
   ```

## Deployment Methods

### Method 1: Using Batch Script (Windows)
1. Run the batch script:
   ```bash
   deploy-to-cpanel.bat
   ```

### Method 2: Using PowerShell Script (Windows)
1. Run the PowerShell script:
   ```powershell
   .\deploy-to-cpanel.ps1
   ```

### Method 3: Manual Deployment
1. Build the React app:
   ```bash
   cd lms-frontend
   npm run build
   ```

2. Run the deployment script:
   ```bash
   node ../deploy-to-cpanel.js
   ```

## Environment Variables (Optional)

Instead of hardcoding credentials in the script, you can set environment variables:

```bash
FTP_HOST=your-domain.com
FTP_USER=your_ftp_username
FTP_PASS=your_ftp_password
FTP_PATH=/public_html
```

The script will use these environment variables if available.

## Notes

- The build process will create optimized static files in the `lms-frontend/build` directory
- The deployment script will upload all files from the build directory to your cPanel
- Make sure your cPanel account has sufficient space and permissions
- The deployment will overwrite existing files in the target directory
>>>>>>> 73219f9bdc90257c2cd625b139c3939bc21645a3
