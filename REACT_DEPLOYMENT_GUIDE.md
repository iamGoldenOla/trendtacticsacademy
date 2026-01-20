# 📦 React Dashboard Deployment Guide

## 🎯 **Quick Deployment (Just Updated Files)**

Since you only changed the Courses page, you have two options:

### **Option 1: Build & Deploy React App** (Recommended)

1. **Build the React app:**
   ```bash
   cd lms-frontend
   npm run build
   ```

2. **Upload only these files from `build` folder:**
   - `build/static/js/main.*.js` (the main JavaScript bundle)
   - `build/static/css/main.*.css` (the main CSS bundle)

3. **Replace on server:**
   - Upload to `/static/js/` and `/static/css/` folders
   - Overwrite existing files

### **Option 2: Quick Fix Without Building** ⭐ FASTEST

Since building might take time, here's a simpler approach:

**Just update the source files and I'll create a deployment package:**

Files that changed:
1. `src/components/CurrencySelector.js` (NEW)
2. `src/pages/Courses.js` (UPDATED)

---

## 🚀 **What I'll Do For You:**

I'll create a ZIP file with:
1. The new `CurrencySelector.js` component
2. The updated `Courses.js` file
3. Instructions on where to upload

**But wait...** React apps need to be **built** before deployment. You can't just upload source `.js` files.

---

## 💡 **Best Solution:**

### **Deploy via GitHub (Automated):**

1. **Commit changes:**
   ```bash
   cd lms-frontend
   git add .
   git commit -m "Add currency selector to courses page"
   git push
   ```

2. **GitHub Actions will auto-build and deploy**

### **Manual Deploy (If no GitHub Actions):**

1. **Build locally:**
   ```bash
   cd lms-frontend
   npm run build
   ```

2. **Upload `build` folder contents to cPanel**
   - Replace existing files in `public_html/academy.trendtacticsdigital.com/`

---

## 📋 **Files You Need:**

If you want to manually upload, you need:

**From `lms-frontend/build/`:**
- `index.html`
- `static/js/main.*.js`
- `static/css/main.*.css`

These are the compiled/bundled files that browsers can run.

---

## ⚠️ **Important:**

- React source files (`.jsx`, `.js` in `src/`) **cannot** be uploaded directly
- They must be **built** first using `npm run build`
- The build process compiles everything into browser-ready files

---

## 🎯 **Recommended Action:**

**Run the build command I started above, then I'll help you create a deployment ZIP!**

Or tell me if you want me to:
1. Create a deployment script
2. Show you how to set up auto-deployment
3. Create a manual deployment guide

What would you prefer?
