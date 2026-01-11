# 🚀 Deploy to cPanel - Step by Step Guide

## ⚠️ CURRENT ISSUE
Your website https://academy.trendtacticsdigital.com is showing the old version because:
- cPanel is serving the `public` folder (development files)
- React apps need to be **built** first to create optimized production files
- The **build** folder needs to be uploaded to cPanel

---

## 📦 STEP 1: Build the React App

### Option A: Using PowerShell Script (Easiest)

```powershell
# Run this command in PowerShell
.\build-for-cpanel.ps1
```

### Option B: Manual Build

```powershell
# Navigate to frontend folder
cd lms-frontend

# Build for production
npm run build

# Wait for build to complete (2-5 minutes)
```

After building, you'll have a `build` folder at:
```
C:\Users\Akinola Olujobi\Documents\Trendtactics Academy\lms-frontend\build
```

---

## 📤 STEP 2: Upload to cPanel

### Method 1: File Manager (Recommended)

1. **Login to cPanel**
   - Go to your cPanel URL
   - Enter username and password

2. **Open File Manager**
   - Find "File Manager" icon
   - Click to open

3. **Navigate to public_html**
   - Click on `public_html` folder
   - This is where your website files go

4. **Backup Old Files (Optional)**
   - Select all files in `public_html`
   - Click "Compress"
   - Name it `backup-old-site.zip`
   - Download it

5. **Delete Old Files**
   - Select all files in `public_html`
   - Click "Delete"
   - Confirm deletion

6. **Upload New Files**
   - Click "Upload" button
   - Navigate to: `C:\Users\Akinola Olujobi\Documents\Trendtactics Academy\lms-frontend\build`
   - Select ALL files and folders inside `build` folder
   - Upload them
   - Wait for upload to complete

7. **Verify Files**
   - You should see these files in `public_html`:
     - `index.html`
     - `asset-manifest.json`
     - `manifest.json`
     - `robots.txt`
     - `static` folder (with css, js, media subfolders)

### Method 2: FTP Upload

1. **Download FileZilla** (if you don't have it)
   - https://filezilla-project.org/

2. **Connect to cPanel**
   - Host: ftp.yourdomain.com
   - Username: your cPanel username
   - Password: your cPanel password
   - Port: 21

3. **Navigate to public_html**
   - On the right side (Remote site)
   - Find and open `public_html` folder

4. **Upload Build Files**
   - On the left side (Local site)
   - Navigate to: `C:\Users\Akinola Olujobi\Documents\Trendtactics Academy\lms-frontend\build`
   - Select all files inside `build` folder
   - Drag and drop to `public_html` on the right

---

## 🔧 STEP 3: Configure .htaccess (Important!)

Create a file named `.htaccess` in `public_html` with this content:

```apache
<IfModule mod_rewrite.c>
  RewriteEngine On
  RewriteBase /
  RewriteRule ^index\.html$ - [L]
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteCond %{REQUEST_FILENAME} !-d
  RewriteCond %{REQUEST_FILENAME} !-l
  RewriteRule . /index.html [L]
</IfModule>

# Enable GZIP compression
<IfModule mod_deflate.c>
  AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript application/json
</IfModule>

# Browser caching
<IfModule mod_expires.c>
  ExpiresActive On
  ExpiresByType image/jpg "access plus 1 year"
  ExpiresByType image/jpeg "access plus 1 year"
  ExpiresByType image/gif "access plus 1 year"
  ExpiresByType image/png "access plus 1 year"
  ExpiresByType text/css "access plus 1 month"
  ExpiresByType application/javascript "access plus 1 month"
  ExpiresByType text/html "access plus 1 hour"
</IfModule>
```

---

## 🌐 STEP 4: Verify Deployment

1. **Clear Browser Cache**
   - Press `Ctrl + Shift + Delete`
   - Select "Cached images and files"
   - Click "Clear data"

2. **Hard Refresh**
   - Go to: https://academy.trendtacticsdigital.com
   - Press `Ctrl + Shift + R` (Windows)
   - Or `Cmd + Shift + R` (Mac)

3. **Check for New Design**
   You should see:
   - ✅ Navy Blue + Cyan color scheme
   - ✅ Animated hero section
   - ✅ Modern course cards
   - ✅ Smooth animations
   - ✅ Professional design

4. **Test Navigation**
   - Click on "Courses" menu
   - Click on a course card
   - Check if pages load correctly

5. **Check Browser Console**
   - Press `F12`
   - Go to "Console" tab
   - Look for any errors (should be none)

---

## 🐛 TROUBLESHOOTING

### Issue: Still Seeing Old Website

**Solutions:**
1. Clear browser cache completely
2. Try incognito/private browsing mode
3. Try a different browser
4. Check if files uploaded correctly in cPanel
5. Verify `.htaccess` file exists

### Issue: Blank White Page

**Solutions:**
1. Check browser console for errors (F12)
2. Verify all files uploaded correctly
3. Check if `index.html` exists in `public_html`
4. Make sure you uploaded files FROM `build` folder, not the `build` folder itself

### Issue: 404 Error on Page Refresh

**Solution:**
- Add the `.htaccess` file (see Step 3)
- This tells the server to route all requests to `index.html`

### Issue: CSS Not Loading

**Solutions:**
1. Check if `static` folder uploaded correctly
2. Verify file permissions (644 for files, 755 for folders)
3. Clear browser cache

### Issue: Images Not Loading

**Solutions:**
1. Check if `static/media` folder exists
2. Verify image paths in code
3. Check file permissions

---

## ✅ CHECKLIST

Before you say "deployment complete":

- [ ] Build completed successfully
- [ ] `build` folder created
- [ ] Old files backed up (optional)
- [ ] Old files deleted from `public_html`
- [ ] New files uploaded to `public_html`
- [ ] `.htaccess` file created
- [ ] Browser cache cleared
- [ ] Website loads with new design
- [ ] All pages work correctly
- [ ] No console errors
- [ ] Navigation works
- [ ] Images load correctly

---

## 🎯 EXPECTED RESULT

After successful deployment, your website should have:

✅ **Modern Design**
- Navy Blue (#0A1F44) + Cyan (#00D9FF) colors
- Professional typography
- Clean, modern layout

✅ **Animations**
- Smooth page transitions
- Animated hero section
- Hover effects on cards
- Framer Motion animations

✅ **Features**
- Real course data from Supabase
- Working navigation
- Responsive design
- Fast loading times

✅ **Pages**
- Home page with hero section
- Courses page with filters
- Course detail pages
- About, Contact pages

---

## 📞 NEED HELP?

If you're stuck:

1. **Check the build folder**
   - Make sure it exists
   - Make sure it has files inside

2. **Check cPanel**
   - Verify files uploaded
   - Check file permissions
   - Look at error logs

3. **Check browser**
   - Clear cache completely
   - Try incognito mode
   - Check console for errors

4. **Contact me**
   - Share screenshots of:
     - cPanel file manager
     - Browser console errors
     - What you see on the website

---

## 🚀 QUICK START (Do This Now!)

```powershell
# 1. Open PowerShell in project root
cd "C:\Users\Akinola Olujobi\Documents\Trendtactics Academy"

# 2. Run build script
.\build-for-cpanel.ps1

# 3. Wait for build to complete

# 4. Upload files from 'lms-frontend\build' to cPanel public_html

# 5. Clear browser cache and visit your website!
```

---

**Let me know once you've uploaded the files and I'll help verify the deployment!** 🎉

