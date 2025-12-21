# Deployment Checklist: Trendtactics Academy Vibe Coding Course Fix

## Pre-Deployment ✅

- [ ] **Backup Current Site**: Take a backup of the current `academy.trendtacticsdigital.com` directory
- [ ] **Download Deployment Package**: Ensure you have `trendtactics-academy-deployment.zip` (36.8MB)
- [ ] **Review Instructions**: Read through `CPANEL_DEPLOYMENT_INSTRUCTIONS.md` completely
- [ ] **Prepare CPANEL Access**: Have your CPANEL login credentials ready

## Deployment Process ⏳

### Step 1: Extract Files
- [ ] Extract `trendtactics-academy-deployment.zip` to a local folder
- [ ] Verify the extracted folder contains `index.html` and `static/` directory

### Step 2: Access CPANEL
- [ ] Log in to your CPANEL dashboard
- [ ] Navigate to File Manager
- [ ] Locate the `academy.trendtacticsdigital.com` directory

### Step 3: Prepare Directory
- [ ] Back up the current contents of `academy.trendtacticsdigital.com` (if needed)
- [ ] Delete all contents of `academy.trendtacticsdigital.com` directory
- [ ] **Important**: Do NOT delete the directory itself, only its contents

### Step 4: Upload New Files
- [ ] Upload all files from the extracted build folder to `academy.trendtacticsdigital.com`
- [ ] Ensure all folders are uploaded (`static/`, `images/`, `partners/`, `payments/`, `videos/`)
- [ ] Verify `index.html` is in the root directory

## Post-Deployment Verification ✅

### Basic Functionality
- [ ] Visit https://academy.trendtacticsdigital.com
- [ ] Homepage loads without errors
- [ ] Navigation menu works correctly
- [ ] All images load properly

### Course Display
- [ ] **Homepage**: "Vibe Coding" course appears in featured courses section
- [ ] **Courses Page**: "Vibe Coding" course is listed
- [ ] **Course Detail**: Clicking on "Vibe Coding" loads the course detail page
- [ ] **Course Content**: All 5 modules and 15 lessons are visible

### Browser Testing
- [ ] Test in Chrome (desktop and mobile)
- [ ] Test in Firefox (desktop)
- [ ] Test in Safari (desktop and mobile if available)
- [ ] Clear cache and test again

### Console Check
- [ ] Open browser developer tools (F12)
- [ ] Check Console tab for JavaScript errors
- [ ] Check Network tab for failed resource loads
- [ ] Verify no 404 errors for critical assets

## Troubleshooting ❌

If issues occur:

### Quick Fixes
- [ ] Hard refresh (Ctrl+F5 or Cmd+Shift+R)
- [ ] Clear browser cache completely
- [ ] Try incognito/private browsing mode

### Common Issues
- [ ] **Blank page**: Check that `index.html` is in the root directory
- [ ] **Missing images**: Verify all image folders were uploaded
- [ ] **JavaScript errors**: Check browser console for specific error messages
- [ ] **Course not showing**: Verify database queries are working (see test scripts)

### Advanced Troubleshooting
- [ ] Run `test-frontend-queries.js` to verify database connectivity
- [ ] Check Supabase environment variables in CPANEL
- [ ] Verify file permissions (644 for files, 755 for directories)

## Success Confirmation ✅

When all checks pass:
- [ ] Homepage displays correctly with featured course
- [ ] Courses page lists the Vibe Coding course
- [ ] Course detail page loads with all modules and lessons
- [ ] No console errors in browser developer tools
- [ ] All navigation works properly
- [ ] Site works across different browsers

## Documentation 📋

Files created for this deployment:
- [ ] `trendtactics-academy-deployment.zip` - Deployment package
- [ ] `CPANEL_DEPLOYMENT_INSTRUCTIONS.md` - Deployment guide
- [ ] `FINAL_SOLUTION_SUMMARY.md` - Technical summary of fixes
- [ ] `DEPLOYMENT_CHECKLIST.md` - This checklist

## Support Contact 🆘

If you encounter issues after following this checklist:
1. Take screenshots of the problem
2. Copy any error messages from browser console
3. Note which steps you've completed
4. Contact support with this information

---

**Estimated Deployment Time**: 15-30 minutes  
**Downtime Required**: Minimal (only during file upload)  
**Rollback Plan**: Restore from backup if needed