# cPanel Cleanup Guide

## ❌ DELETE These Files/Folders (React/Old System)

### Folders to DELETE:
- `static/` - React build files
- `.git/` - Git repository (not needed on server)
- `.github/` - GitHub workflows
- `_backup/` - Old backups

### Files to DELETE:
- `asset-manifest.json` - React build file
- `manifest.json` - React manifest
- `ftp-deploy-sync-state.json` - Old deployment state
- `.htaccess` - May have React routing rules
- `_headers` - React headers
- `robots.txt` - Can recreate if needed
- `serve.php` - Not needed
- `netlify.toml` - Netlify config (not using)
- `test.txt` - Test file
- `test-csp.html` - Test file
- `test-env.html` - Test file

### Keep These Files:
- ✅ `index.html` - Homepage (check if it's React or static)
- ✅ `courses.html` - Course listing
- ✅ `course-detail.html` - Course detail page
- ✅ `signup.html` - Your working signup
- ✅ `favicon.jpg` - Site icon
- ✅ `logo0192.png` - Logo
- ✅ `logo0512.png` - Logo

### Keep These Folders:
- ✅ `courses/` - Course content
- ✅ `partners/` - Partner info
- ✅ `payments/` - Payment integration
- ✅ `videos/` - Video content
- ✅ `html-lms/` - Your new HTML LMS (if uploaded)

## ⚠️ IMPORTANT: Check index.html First

Before deleting, check if `index.html` is:
- **React build** → DELETE it, we'll create a new one
- **Static HTML** → KEEP it

## 🎯 Recommended Action Plan

1. **Backup first** - Download everything to your computer
2. **Delete the React files** listed above
3. **Upload your new `html-lms` folder**
4. **Create a new simple `index.html`** (I'll provide this)
5. **Test the site**

## New index.html (I'll create this for you)

After cleanup, I'll create a simple homepage that links to:
- Course listing
- Signup
- Dashboard (if logged in)

Would you like me to create the cleanup script and new index.html?
