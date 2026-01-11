# 🛠️ How to Fix Your Deployment Issues

Based on the errors you're seeing:
1. "Input required and not supplied: server"
2. "The process '/usr/bin/git' failed with exit code 128"

Here's exactly what you need to do to fix these issues.

## 🔧 Issue 1: "Input required and not supplied: server"

This error means the FTP deployment action isn't receiving the required server information.

### ✅ Solution:

1. **Go to your GitHub repository settings**
   - URL: https://github.com/iamGoldenOla/trendtacticsacademy/settings/secrets/actions

2. **Add these EXACT secret names** (case-sensitive):
   ```
   FTP_HOST = ftp.trendtacticsdigital.com
   FTP_USERNAME = your-ftp-username
   FTP_PASSWORD = your-ftp-password
   SUPABASE_URL = your-supabase-project-url
   SUPABASE_ANON_KEY = your-supabase-anon-key
   ```

3. **Double-check the secret names match exactly**:
   - ✅ `FTP_HOST` (not `ftp_host` or `FTPHOST`)
   - ✅ `FTP_USERNAME` (not `ftp_username`)
   - ✅ `FTP_PASSWORD` (not `ftp_password`)

## 🌐 Issue 2: "git failed with exit code 128"

This is usually an authentication issue.

### ✅ Solution:

1. **Verify you're using HTTPS (not SSH)** for your remote:
   ```bash
   git remote -v
   ```
   You should see:
   ```
   origin  https://github.com/iamGoldenOla/trendtacticsacademy.git (fetch)
   origin  https://github.com/iamGoldenOla/trendtacticsacademy.git (push)
   ```

2. **If you see SSH URLs** (git@github.com), change to HTTPS:
   ```bash
   git remote set-url origin https://github.com/iamGoldenOla/trendtacticsacademy.git
   ```

## 📋 Step-by-Step Fix Process

### Step 1: Set Up GitHub Secrets

1. Go to: https://github.com/iamGoldenOla/trendtacticsacademy/settings/secrets/actions
2. Click "New repository secret"
3. Add each secret one by one:
   - Name: `FTP_HOST`, Value: `ftp.trendtacticsdigital.com`
   - Name: `FTP_USERNAME`, Value: `your-actual-ftp-username`
   - Name: `FTP_PASSWORD`, Value: `your-actual-ftp-password`
   - Name: `SUPABASE_URL`, Value: `your-supabase-url`
   - Name: `SUPABASE_ANON_KEY`, Value: `your-supabase-anon-key`

### Step 2: Verify Your Current Branch

Run this command to check your branch:
```bash
git branch --show-current
```

You should see `master` (which is correct based on our verification).

### Step 3: Make a Small Change to Trigger Deployment

Make a small change to trigger the workflow:
```bash
# Add a comment to the workflow file
echo "# Trigger deployment" >> .github/workflows/deploy-frontend.yml

# Commit and push
git add .github/workflows/deploy-frontend.yml
git commit -m "Trigger deployment workflow"
git push origin master
```

### Step 4: Watch the Deployment

1. Go to: https://github.com/iamGoldenOla/trendtacticsacademy/actions
2. Click on the running workflow
3. Watch the logs to see if it passes all steps

## 🧪 Pre-Deployment Testing

Before pushing, test locally:

1. **Test the build**:
   ```bash
   cd lms-frontend
   npm ci
   npm run build
   ```

2. **Verify workflow syntax**:
   ```bash
   node diagnose-secrets.js
   ```

## 🆘 If Issues Continue

1. **Check detailed logs** in GitHub Actions
2. **Verify FTP credentials** work in an FTP client
3. **Confirm Supabase keys** are correct in the Supabase dashboard
4. **Ensure your FTP user** has write access to `/public_html/academy/`

## 🎯 Success Indicators

When fixed, you should see:
1. All workflow steps complete with green checkmarks
2. "Deploy via FTP" step shows files transferred
3. Your site at https://academy.trendtacticsdigital.com updates with new content

## 📞 Emergency Troubleshooting

If nothing works:

1. **Delete and recreate secrets** in GitHub
2. **Check repository permissions** - ensure you're an admin
3. **Verify package-lock.json** is committed to the repository
4. **Contact GitHub Support** if the issue persists

By following these exact steps, your deployment should work correctly. The key is ensuring the secret names match exactly what the workflow expects.