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