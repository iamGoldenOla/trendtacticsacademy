# 🛠️ Deployment Troubleshooting Guide

This guide helps you resolve common issues with GitHub Actions deployment failures.

## 🚨 Common Error: "The process '/usr/bin/git' failed with exit code 128"

This error typically indicates authentication or permission issues with Git.

### 🔧 Solutions:

1. **Check Repository Permissions**
   - Ensure your GitHub account has write access to the repository
   - Verify you're using the correct repository URL

2. **Verify SSH Keys (if using SSH)**
   - Check that your SSH key is properly added to your GitHub account
   - Test your SSH connection: `ssh -T git@github.com`

3. **Check Branch Protection Rules**
   - Verify that branch protection rules aren't preventing pushes
   - Ensure required status checks are passing

## 📋 Checklist for Successful Deployment

### 1. GitHub Secrets Configuration
Run `node verify-secrets.js` to see what secrets you need to configure.

### 2. Workflow File Validation
Your workflow file should look like this:

```yaml
name: Deploy Frontend to Academy Subdomain

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    env:
      REACT_APP_SUPABASE_URL: ${{ secrets.SUPABASE_URL }}
      REACT_APP_SUPABASE_ANON_KEY: ${{ secrets.SUPABASE_ANON_KEY }}
    
    steps:
    - name: Checkout repository
      uses: actions/checkout@v4

    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        cache: 'npm'
        cache-dependency-path: 'lms-frontend/package-lock.json'

    - name: Install frontend dependencies
      working-directory: lms-frontend
      run: npm ci

    - name: Build frontend
      working-directory: lms-frontend
      run: npm run build
      env:
        CI: false

    - name: Deploy via FTP
      uses: SamKirkland/FTP-Deploy-Action@v4.3.5
      with:
        server: ${{ secrets.FTP_HOST }}
        username: ${{ secrets.FTP_USERNAME }}
        password: ${{ secrets.FTP_PASSWORD }}
        server-dir: /public_html/academy/
        local-dir: lms-frontend/build/
```

### 3. Local Build Testing
Before deploying, test your build locally:
```bash
cd lms-frontend
npm ci
npm run build
```

### 4. FTP Directory Permissions
Ensure your FTP user has write permissions to:
```
/public_html/academy/
```

## 🔄 How to Fix Deployment Issues

### Step 1: Verify Secrets
1. Go to your GitHub repository
2. Settings → Secrets and variables → Actions
3. Ensure all required secrets are set:
   - `FTP_HOST`
   - `FTP_USERNAME`
   - `FTP_PASSWORD`
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`

### Step 2: Check Workflow Syntax
Run `node troubleshoot-deployment.js` to verify your workflow file.

### Step 3: Test Locally
Run `node test-frontend-build.js` to ensure your frontend builds correctly.

### Step 4: Re-run Failed Workflow
1. Go to your GitHub repository
2. Click "Actions" tab
3. Select the failed workflow
4. Click "Re-run jobs"

## 🆘 Still Having Issues?

1. **Check Detailed Logs**
   - Go to GitHub → Actions → Select failed workflow
   - Expand each step to see detailed error messages

2. **Common Fixes**
   - Update workflow action versions
   - Verify branch names match your repository
   - Check FTP credentials and directory permissions
   - Ensure package-lock.json is committed to the repository

3. **Contact Support**
   - If issues persist, check GitHub Status (www.githubstatus.com)
   - Review GitHub Actions documentation

## 🎯 Pro Tips

1. **Keep Dependencies Updated**
   - Regularly update your package-lock.json
   - Keep workflow actions up to date

2. **Test Changes Locally**
   - Always test builds locally before pushing
   - Use the same Node.js version locally and in CI

3. **Monitor Deployments**
   - Watch the Actions tab during deployments
   - Set up notifications for failed deployments

By following this guide, you should be able to resolve most deployment issues and get your Trendtactics Academy frontend deployed successfully!