# 🚀 Build and Deploy to cPanel

## ⚠️ ISSUE: Website Showing Old Version

**Problem:** cPanel is serving the `public` folder directly, but React apps need to be **built** first.

**Solution:** Build the React app and deploy the `build` folder to cPanel.

---

## 📦 STEP 1: Build the React App Locally

```bash
# Navigate to frontend folder
cd lms-frontend

# Install dependencies (if not already installed)
npm install

# Build for production
npm run build
```

This will create a `build` folder with optimized production files.

---

## 🌐 STEP 2: Deploy to cPanel

### Option A: Manual Upload (Fastest)

1. **Locate the build folder:**
   - Path: `lms-frontend/build/`

2. **Login to cPanel:**
   - Go to: https://your-cpanel-url.com
   - Navigate to **File Manager**

3. **Upload build files:**
   - Go to `public_html` directory
   - **Delete all old files** (backup first if needed)
   - Upload all files from `lms-frontend/build/` folder
   - Extract if uploaded as zip

4. **Set permissions:**
   - Select all files
   - Set permissions to 644 for files
   - Set permissions to 755 for folders

5. **Clear browser cache:**
   - Press `Ctrl + Shift + R` (Windows)
   - Press `Cmd + Shift + R` (Mac)

---

### Option B: Automated Deployment Script

Create a deployment script in cPanel:

1. **SSH into cPanel** (if available)
2. **Create deploy script:**

```bash
#!/bin/bash
cd /home/your-username/trendtacticsacademy/lms-frontend
npm install
npm run build
rm -rf /home/your-username/public_html/*
cp -r build/* /home/your-username/public_html/
echo "Deployment complete!"
```

3. **Make executable:**
```bash
chmod +x deploy.sh
```

4. **Run deployment:**
```bash
./deploy.sh
```

---

### Option C: GitHub Actions Auto-Deploy

Create `.github/workflows/deploy-cpanel.yml`:

```yaml
name: Deploy to cPanel

on:
  push:
    branches: [ master ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v2
      
      - name: Setup Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: |
          cd lms-frontend
          npm ci
      
      - name: Build
        run: |
          cd lms-frontend
          npm run build
      
      - name: Deploy to cPanel via FTP
        uses: SamKirkland/FTP-Deploy-Action@4.3.0
        with:
          server: ${{ secrets.FTP_SERVER }}
          username: ${{ secrets.FTP_USERNAME }}
          password: ${{ secrets.FTP_PASSWORD }}
          local-dir: ./lms-frontend/build/
          server-dir: /public_html/
```

---

## 🔍 STEP 3: Verify Deployment

1. **Visit your website:**
   - URL: https://academy.trendtacticsdigital.com

2. **Check for new features:**
   - Modern Navy Blue + Cyan design
   - Animated hero section
   - Professional course cards
   - Smooth animations

3. **Clear cache if needed:**
   - Hard refresh: `Ctrl + Shift + R`
   - Or clear browser cache completely

4. **Check browser console:**
   - Press `F12`
   - Look for any errors
   - Check Network tab for failed requests

---

## 🐛 TROUBLESHOOTING

### Issue: Blank Page

**Solution:**
```bash
# Check if .env file exists
cd lms-frontend
ls -la | grep .env

# If missing, create it
cp .env.example .env

# Add your Supabase credentials
nano .env
```

### Issue: 404 Errors on Refresh

**Solution:** Add `.htaccess` file to `public_html`:

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
```

### Issue: CSS Not Loading

**Solution:** Check `package.json` homepage setting:

```json
{
  "homepage": "https://academy.trendtacticsdigital.com",
  ...
}
```

Or remove it completely if deploying to root domain.

---

## ⚡ QUICK FIX (Do This Now!)

```bash
# 1. Build the app
cd "C:\Users\Akinola Olujobi\Documents\Trendtactics Academy\lms-frontend"
npm run build

# 2. The build folder will be created at:
# C:\Users\Akinola Olujobi\Documents\Trendtactics Academy\lms-frontend\build

# 3. Upload contents of 'build' folder to cPanel public_html

# 4. Clear browser cache and refresh
```

---

## 📋 CHECKLIST

- [ ] Build completed successfully
- [ ] Build folder created
- [ ] Old files removed from cPanel
- [ ] New files uploaded to cPanel
- [ ] .htaccess file added
- [ ] Browser cache cleared
- [ ] Website loads correctly
- [ ] All pages work
- [ ] No console errors

---

## 🎯 EXPECTED RESULT

After deployment, you should see:
- ✅ Modern Navy Blue + Cyan design
- ✅ Animated hero section with gradient
- ✅ Professional course cards
- ✅ Smooth Framer Motion animations
- ✅ Real course data from Supabase
- ✅ Working navigation
- ✅ Responsive design

---

## 📞 NEED HELP?

If you're still seeing the old website:
1. Make sure you uploaded the **build** folder contents, not the **public** folder
2. Clear browser cache completely
3. Check cPanel error logs
4. Verify all files uploaded correctly
5. Check .htaccess file is present

---

**Let me know once you've built the app and I'll help you deploy it!**

