# GitHub Auto-Deploy Setup

## ✅ Your cPanel Files Look Perfect!

I can see:
- ✅ `index.html` - New homepage
- ✅ `course-detail.html` - Course page
- ✅ `dashboard.html` - Dashboard
- ✅ `lesson-viewer.html` - Lesson viewer
- ✅ `signup.html` - Working signup
- ✅ `css/` and `js/` folders
- ✅ `.htaccess` - Updated

Everything is in the right place!

## 🚀 GitHub Auto-Deploy Setup

I've created a GitHub Actions workflow that will automatically deploy to your cPanel whenever you push changes.

### Step 1: Add Secrets to GitHub

1. Go to your repository: `https://github.com/iamGoldenOla/trendtacticsacademy`
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret** and add these three secrets:

**Secret 1:**
- Name: `FTP_SERVER`
- Value: `193.227.129.17`

**Secret 2:**
- Name: `FTP_USERNAME`
- Value: `Trendta1`

**Secret 3:**
- Name: `FTP_PASSWORD`
- Value: `2jWO6x][Oa6M4x`

### Step 2: Push the Workflow

The workflow file is at: `.github/workflows/deploy.yml`

It will automatically deploy whenever you push changes to:
- `html-lms/` folder
- `signup.html`
- `whiteboard.html`
- `playground.html`

### Step 3: Test It

1. Make a small change to any file in `html-lms/`
2. Commit and push to GitHub
3. Go to **Actions** tab in your repository
4. Watch the deployment happen automatically!

## 🎯 What Gets Deployed

The workflow will upload:
- All HTML LMS files
- CSS and JavaScript
- Images and assets
- But NOT: node_modules, .git files, or React build files

## 🔒 Security Note

Your FTP credentials are stored as encrypted secrets in GitHub. They're never visible in logs or code.

## ✅ Ready to Test!

Your site should be live at:
- **Homepage:** `https://academy.trendtacticsdigital.com/`
- **Course:** `https://academy.trendtacticsdigital.com/course-detail.html`
- **Signup:** `https://academy.trendtacticsdigital.com/signup.html`

Try visiting the homepage and clicking "View Course" on Vibe Coding!
