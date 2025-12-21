# Post-Deployment Troubleshooting Guide

## Current Status ✅

The deployment to CPANEL was successful, and we've confirmed that:
- The database is correctly configured with the Vibe Coding course
- All 5 modules and 15 lessons are properly populated
- Supabase queries are returning the correct data
- Row Level Security policies allow public access

## Next Steps to Display the Course

Since the backend is working correctly, the issue is in the frontend presentation layer. Follow these steps:

## 1. Clear Browser Cache Completely 🔁

This is the most common cause of the issue:

### Chrome:
1. Press `Ctrl+Shift+Delete` (Windows) or `Cmd+Shift+Delete` (Mac)
2. Select "All time" for time range
3. Check all boxes (Cookies, Cached images and files, etc.)
4. Click "Clear data"

### Firefox:
1. Press `Ctrl+Shift+Delete` (Windows) or `Cmd+Shift+Delete` (Mac)
2. Select "Everything" for time range
3. Check all boxes
4. Click "Clear"

### Safari:
1. Safari → Preferences → Privacy
2. Click "Manage Website Data"
3. Click "Remove All"

## 2. Hard Refresh the Website 🔄

After clearing cache:
1. Visit https://academy.trendtacticsdigital.com
2. Press `Ctrl+F5` (Windows) or `Cmd+Shift+R` (Mac) to force refresh

## 3. Check Browser Console for Errors 🐛

Open Developer Tools:
1. Press `F12` or `Ctrl+Shift+I` (Windows) or `Cmd+Option+I` (Mac)
2. Click on the "Console" tab
3. Look for any red error messages
4. Refresh the page and watch for new errors

## 4. Test with Our Diagnostic Files 🧪

I've created several files to help diagnose the issue:

### File 1: `test-frontend-display.html`
Upload this file to your CPANEL server and visit it in your browser to test frontend processing.

### File 2: `frontend-debug.js`
Add this script to your website to check frontend filtering logic.

### File 3: `check-frontend-processing.js`
Run this in your browser console to verify how course data is processed.

## 5. Common Issues and Solutions 💡

### Issue: Course still not showing
**Solution**: 
1. Check browser console for JavaScript errors
2. Verify network requests in the Network tab
3. Look for any 404 errors for critical assets

### Issue: Blank page or layout issues
**Solution**:
1. Check that all files were uploaded correctly
2. Verify file permissions (644 for files, 755 for directories)
3. Ensure `index.html` is in the root directory

### Issue: Images not loading
**Solution**:
1. Verify all image folders were uploaded (`images/`, `partners/`, `payments/`, `videos/`)
2. Check that image paths in the code are correct

## 6. Advanced Troubleshooting 🔧

If basic steps don't work:

### Check Environment Variables:
1. Verify that `REACT_APP_SUPABASE_URL` and `REACT_APP_SUPABASE_ANON_KEY` are correctly set
2. These should be in your build files or CPANEL environment settings

### Test Direct Database Connection:
Run the test scripts we created earlier to verify database connectivity:
```bash
node test-frontend-queries.js
```

### Verify File Integrity:
1. Re-download the `trendtactics-academy-deployment.zip` file
2. Re-extract and re-upload to CPANEL
3. Compare file counts and sizes

## 7. What to Do If Issues Persist 🆘

If you've tried all the above steps and the course still isn't displaying:

1. **Take screenshots** of:
   - The homepage showing the issue
   - Browser console errors
   - Network tab showing failed requests

2. **Provide information** about:
   - Which browsers you tested
   - What steps you've already taken
   - Any error messages you saw

3. **Contact support** with this information

## Expected Outcome ✅

After following these steps, you should see:
- The "Vibe Coding" course displayed in the featured courses section on the homepage
- The course listed on the Courses page
- The course detail page loading correctly with all 5 modules and 15 lessons

## Files Created for Troubleshooting

1. `test-frontend-display.html` - HTML test page for frontend processing
2. `frontend-debug.js` - JavaScript for checking frontend filtering
3. `check-frontend-processing.js` - Detailed course processing verification
4. `POST_DEPLOYMENT_TROUBLESHOOTING.md` - This guide

## Timeline Estimate ⏰

- Cache clearing and hard refresh: 5 minutes
- Console checking: 10 minutes
- Testing with diagnostic files: 15 minutes
- Advanced troubleshooting (if needed): 30-60 minutes

Most issues are resolved with cache clearing and hard refresh, which should take less than 10 minutes.