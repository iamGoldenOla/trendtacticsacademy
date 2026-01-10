# Quick FTP Upload Steps

## Option 1: Use FileZilla (Easiest - Recommended)

### Step 1: Download & Install FileZilla
- Go to: https://filezilla-project.org/download.php
- Download FileZilla Client (free)
- Install it

### Step 2: Connect to FTP
1. Open FileZilla
2. Click **File** → **Site Manager**
3. Click **New site**
4. Fill in:
   - **Host:** `academy.trendtacticsdigital.com` (or your FTP server)
   - **Protocol:** FTP
   - **Port:** 21
   - **User:** Your FTP username
   - **Password:** Your FTP password
5. Click **Connect**

### Step 3: Upload Files
1. **Left panel** (Local): Navigate to `C:\Users\Akinola Olujobi\Documents\Trendtactics Academy`
2. **Right panel** (Remote): Navigate to `/public_html/academy.trendtacticsdigital.com/`
3. Upload these files (drag & drop or right-click → Upload):
   - ✅ `course-detail.html` (overwrite existing)
   - ✅ `checkout.html` (new file)
   - ✅ `payment-success.html` (new file)
4. Navigate to `/api/` folder (or create if doesn't exist)
5. Upload `verify-payment.php` (new file)

### Step 4: Verify
1. Hard refresh browser: **Ctrl + Shift + Delete**
2. Go to: `https://academy.trendtacticsdigital.com/course-detail`
3. Look for:
   - ✅ Instructor profile (Akinola Olujobi)
   - ✅ "Enroll & Pay" button (NOT "Buy Now")
   - ✅ Professional course overview

---

## Option 2: Use cPanel File Manager

### Step 1: Log into cPanel
1. Go to your cPanel login (usually: `academy.trendtacticsdigital.com:2083`)
2. Enter your username and password
3. Find **File Manager** and click it

### Step 2: Navigate to Site Folder
1. Click on `public_html`
2. Look for `academy` or `academy.trendtacticsdigital.com` folder
3. Double-click to enter

### Step 3: Upload Files
1. Click the **Upload** button
2. Select these files from your computer:
   - `course-detail.html`
   - `checkout.html`
   - `payment-success.html`
3. Click **Upload**
4. When complete, go back and navigate to the `api/` folder
5. Upload `verify-payment.php`

### Step 4: Verify
Same as Option 1 Step 4

---

## Option 3: Use PowerShell Script (Advanced)

### Step 1: Edit the Script
1. Open `upload-to-ftp.ps1` in any text editor
2. Find these lines:
   ```powershell
   $FtpUser = "your_ftp_username"   # CHANGE THIS
   $FtpPass = "your_ftp_password"   # CHANGE THIS
   ```
3. Replace with your actual FTP credentials:
   ```powershell
   $FtpUser = "your_real_ftp_username"
   $FtpPass = "your_real_ftp_password"
   ```
4. Also check the `$FtpHost` and `$RemotePath` are correct for your setup

### Step 2: Run the Script
1. Open PowerShell
2. Navigate to the folder:
   ```powershell
   cd "c:\Users\Akinola Olujobi\Documents\Trendtactics Academy"
   ```
3. Run the script:
   ```powershell
   .\upload-to-ftp.ps1
   ```
4. Wait for "All files uploaded successfully!" message

### Step 3: Verify
Same as Option 1 Step 4

---

## Troubleshooting

### "File won't upload - Permission Denied"
- Contact QServers support: ask them to set file permissions to 644
- Or use cPanel File Manager instead

### "Can't find /api/ folder"
- Use cPanel File Manager to create it: Right-click → Create Directory → Name: `api`
- Or ask QServers to create it

### "Still seeing old page after upload"
1. **Hard refresh browser:** Ctrl + Shift + Delete
2. **Clear all cache** for your domain
3. **Try incognito/private mode:** Ctrl + Shift + N
4. **Wait 5 minutes** (server cache)
5. **Contact QServers** to clear any CDN/server-side caching

### "Can't connect to FTP"
- Verify FTP username/password
- Check if FTP host is correct
- Contact QServers for FTP connection details

---

## Files to Upload

```
✅ course-detail.html      → Replace existing file
✅ checkout.html            → New file
✅ payment-success.html     → New file
✅ api/verify-payment.php   → New file in api folder
```

---

## Summary

Pick **Option 1 (FileZilla)** if you want the easiest method. It's free, intuitive, and you can see all files as you upload them.

Let me know if you need help with any step!
