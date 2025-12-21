# One-Click Deployment Instructions

## 🎯 Goal
Deploy your Vibe Coding course to GitHub Pages with minimal effort.

## 📋 What You Need to Do (3 Simple Steps)

### Step 1: Create a New Repository
1. Go to https://github.com/new
2. Name it: `trendtactics-academy` (or any name you prefer)
3. Make it **Public**
4. **Do NOT initialize with README**
5. Click **"Create repository"**

### Step 2: Get Your Repository URL
After creating the repository, you'll see a page with options. 
Find the **"Quick setup"** section and copy the HTTPS URL that looks like:
```
https://github.com/YOUR_USERNAME/trendtactics-academy.git
```

### Step 3: Run the Automated Deployment Script
Open a terminal/command prompt and run this command (replace YOUR_REPO_URL with the URL from step 2):

```bash
git clone https://github.com/AI-Coder-Kit/trendtactics-academy-deployment.git && cd trendtactics-academy-deployment && git init && git remote add origin YOUR_REPO_URL && git checkout -b main && git add . && git commit -m "Initial commit: Vibe Coding course" && git push -u origin main
```

## 🔄 What Happens Automatically

1. **Repository Initialization**: The script creates a local git repository
2. **Content Addition**: All course content is added to the repository
3. **Remote Connection**: Connects to your GitHub repository
4. **Automatic Push**: Uploads all content to GitHub
5. **GitHub Actions Trigger**: Automatic deployment to GitHub Pages begins

## 🎉 Result

Within 2-3 minutes after running the script:
- Your site will be live at: `https://YOUR_USERNAME.github.io/trendtactics-academy/`
- Any future updates pushed to the `main` branch will automatically deploy
- No further action required for ongoing deployments

## 🔧 Troubleshooting

If you encounter any issues:

### Authentication Required
If prompted for username/password:
1. Use your GitHub username
2. Use a Personal Access Token instead of password:
   - Go to GitHub Settings → Developer Settings → Personal Access Tokens
   - Generate new token with "repo" permissions
   - Use this token as your password

### Repository Already Exists
If you get an error about the repository already existing:
1. Delete the repository on GitHub
2. Recreate it following Step 1 above

## 📞 Support

If you have any issues with this one-click deployment, please reach out with:
1. The exact error message you received
2. Which step you were on when the error occurred
3. Your operating system (Windows/Mac/Linux)

This one-click solution minimizes your involvement while maximizing automation.