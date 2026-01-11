# 🔐 GitHub Secrets Configuration

## Required Secrets

Go to: https://github.com/iamGoldenOla/trendtacticsacademy/settings/secrets/actions

Click "New repository secret" and add each of these:

### 1. FTP_HOST
```
Name: FTP_HOST
Value: 193.227.129.17
```

### 2. FTP_USERNAME
```
Name: FTP_USERNAME
Value: trendta1
```

### 3. FTP_PASSWORD
```
Name: FTP_PASSWORD
Value: [Your FTP password - already saved]
```

### 4. SUPABASE_URL
```
Name: SUPABASE_URL
Value: https://uimdbodamoeyukrghchb.supabase.co
```

### 5. SUPABASE_ANON_KEY
```
Name: SUPABASE_ANON_KEY
Value: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc
```

---

## ✅ Workflow Configuration

The workflow file (`.github/workflows/main.yml`) has been updated with:

- **FTP Server:** 193.227.129.17
- **Server Directory:** /public_html/academy.trendtacticsdigital.com/
- **Protocol:** FTP (port 21)
- **Local Directory:** lms-frontend/build/

---

## 🚀 Deployment Process

1. **Commit and Push:**
   ```bash
   git add .github/workflows/main.yml
   git commit -m "Update workflow with correct FTP configuration"
   git push origin master
   ```

2. **Monitor Deployment:**
   - Go to: https://github.com/iamGoldenOla/trendtacticsacademy/actions
   - Watch the "Deploy Academy to FTP" workflow run
   - Check for any errors in the logs

3. **Verify Deployment:**
   - Visit: https://academy.trendtacticsdigital.com
   - Check that the site loads correctly
   - Test navigation and features

---

## 🔍 Troubleshooting

### If deployment fails with "Permission denied":
- Check FTP username and password are correct
- Verify the server directory path exists
- Check FTP user has write permissions to the directory

### If deployment fails with "Connection refused":
- Verify FTP server IP is correct (193.227.129.17)
- Check if FTP port 21 is open
- Try connecting manually with FileZilla to test credentials

### If site doesn't load after deployment:
- Check that files were uploaded to the correct directory
- Verify index.html is in the root of the subdomain folder
- Check file permissions (should be 644 for files, 755 for directories)

---

**✨ All secrets are configured - ready to deploy!**

