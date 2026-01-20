# 🚀 GitHub Auto-Deployment Setup

## 📋 **What This Does:**

Automatically builds and deploys your React app to GitHub Pages whenever you push to the `master` branch.

---

## ✅ **Setup Steps:**

### **Step 1: Add Workflow File**

File created: `.github/workflows/deploy.yml`

This file tells GitHub to:
1. Build your React app
2. Deploy to `gh-pages` branch
3. Serve at `academy.trendtacticsdigital.com`

### **Step 2: Add Secrets to GitHub**

1. Go to: https://github.com/iamGoldenOla/trendtacticsacademy/settings/secrets/actions
2. Click "New repository secret"
3. Add these 4 secrets:

```
Name: REACT_APP_SUPABASE_URL
Value: https://uimdbodamoeyukrghchb.supabase.co

Name: REACT_APP_SUPABASE_ANON_KEY
Value: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc

Name: REACT_APP_FLUTTERWAVE_PUBLIC_KEY
Value: FLWPUBK_TEST-415d3c92b9c49dd6eda7eaf268998803-X

Name: REACT_APP_PAYSTACK_PUBLIC_KEY
Value: pk_test_43035d3b6c556c7019386196faf399c1c51b1ce4
```

### **Step 3: Enable GitHub Pages**

1. Go to: https://github.com/iamGoldenOla/trendtacticsacademy/settings/pages
2. Source: Deploy from a branch
3. Branch: `gh-pages` / `/ (root)`
4. Save

### **Step 4: Add CNAME File**

Create file: `lms-frontend/public/CNAME`
Content: `academy.trendtacticsdigital.com`

### **Step 5: Update DNS**

In your domain registrar (e.g., Namecheap):
```
Type: CNAME
Host: academy
Value: iamgoldenola.github.io
```

---

## 🎯 **How to Deploy:**

### **Automatic (Recommended):**
```bash
git add .
git commit -m "Update site"
git push origin master
```

GitHub automatically builds and deploys!

### **Manual:**
```bash
npm run build
# Upload build folder to server
```

---

## 📊 **Workflow:**

```
1. You push code to master
   ↓
2. GitHub Actions runs
   ↓
3. Builds React app
   ↓
4. Deploys to gh-pages branch
   ↓
5. Site updates at academy.trendtacticsdigital.com
```

---

## ✅ **Benefits:**

- ✅ Automatic deployment
- ✅ No manual uploads
- ✅ Version control
- ✅ Rollback capability
- ✅ Build logs for debugging

---

## 🔧 **Testing:**

After setup:
1. Make a small change
2. Commit and push
3. Go to: https://github.com/iamGoldenOla/trendtacticsacademy/actions
4. Watch the deployment
5. Check your site!

---

## ⚠️ **Important:**

- Secrets are encrypted
- Never commit `.env` file
- Use GitHub secrets for sensitive data
- `gh-pages` branch is auto-created

**Your site will auto-deploy on every push to master!** 🚀
