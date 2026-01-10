# FTP Deployment Guide - Upload Latest Files to cPanel

## Files to Upload via FTP

You need to upload these files from your local machine to your FTP server:

### Main Files (CRITICAL - These have changes):

1. **course-detail.html** 
   - Location: `/public_html/academy/` or `/public_html/academy.trendtacticsdigital.com/`
   - Replace the OLD file with the NEW one

2. **checkout.html**
   - Location: `/public_html/academy/` or `/public_html/academy.trendtacticsdigital.com/`
   - NEW file

3. **payment-success.html**
   - Location: `/public_html/academy/` or `/public_html/academy.trendtacticsdigital.com/`
   - NEW file

4. **api/verify-payment.php**
   - Location: `/public_html/academy/api/` or `/public_html/academy.trendtacticsdigital.com/api/`
   - NEW file

### Optional (May already be there):

5. **api/enroll.php**
   - Location: `/public_html/academy/api/`
   - Already uploaded (double-check it exists)

---

## Step-by-Step FTP Upload Instructions

### Using FileZilla (Recommended - Free)

1. **Connect to FTP**
   - Open FileZilla
   - Host: `ftp.academy.trendtacticsdigital.com` (or your FTP host)
   - Username: Your FTP username
   - Password: Your FTP password
   - Port: 21 (or 990 for SFTP)
   - Click "Quickconnect"

2. **Navigate to your site folder**
   - Right side (Remote site) browse to:
     - `/public_html/academy/` 
     - OR `/public_html/academy.trendtacticsdigital.com/`

3. **Upload course-detail.html**
   - Left side (Local site): Find `course-detail.html` from your Documents folder
   - Right-click → Upload
   - Or drag & drop to right side
   - **IMPORTANT: Choose "Overwrite" when prompted**

4. **Upload checkout.html**
   - Same process as above
   - This is a NEW file, so it will just create it

5. **Upload payment-success.html**
   - Same process
   - NEW file

6. **Upload api/verify-payment.php**
   - Navigate to `/api/` folder on FTP (create if doesn't exist)
   - Upload `verify-payment.php`
   - NEW file

7. **Done!** All files uploaded

---

## Using cPanel File Manager (Alternative)

1. **Log into cPanel**

2. **Go to File Manager**

3. **Navigate to public_html**
   - Click on `public_html` 
   - Then `academy` or `academy.trendtacticsdigital.com`

4. **Upload files**
   - Click "Upload" button
   - Select files from your computer:
     - `course-detail.html`
     - `checkout.html`
     - `payment-success.html`
   - Click "Upload Files"

5. **For api/verify-payment.php**
   - Go into the `api` folder
   - Click Upload
   - Upload `verify-payment.php`

---

## Where to Get These Files

All files are in: `c:\Users\Akinola Olujobi\Documents\Trendtactics Academy\`

- `course-detail.html` ✅
- `checkout.html` ✅
- `payment-success.html` ✅
- `api\verify-payment.php` ✅

---

## Verify Upload was Successful

1. **Hard refresh browser** (Ctrl + Shift + Delete)
2. Go to: `https://academy.trendtacticsdigital.com/course-detail`
3. You should see:
   - ✅ **Instructor profile** (Akinola Olujobi with photo)
   - ✅ **"Enroll & Pay" button** (NOT "Buy Now")
   - ✅ Professional course overview
   - ✅ 8 modules with curriculum

4. Click **"Enroll & Pay"** button
   - Should go to checkout page
   - ✅ Shows course summary
   - ✅ Shows payment form
   - ✅ Shows "Pay ₦5,000 Now" button

---

## If Still Seeing Old Version

### Clear Cache Completely

**Browser Cache:**
- Chrome: Ctrl + Shift + Delete → Select "All time" → Clear all
- Firefox: Ctrl + Shift + Delete → Clear everything
- Safari: Cmd + Shift + Delete

**FTP Cache (if using FileZilla):**
- File → Clear all private data
- View → Refresh (F5)

**Server Cache (if any):**
- Contact QServers support to clear any server-side caching
- Ask them to clear Cloudflare cache if enabled

**Try Incognito Mode:**
- Ctrl + Shift + N (or Cmd + Shift + N on Mac)
- Go to your site
- This bypasses all local cache

---

## Troubleshooting

**Q: File won't upload - "Permission Denied"**
A: 
- Contact QServers and ask to set file permissions to 644
- Or use cPanel File Manager instead of FTP

**Q: Can't see the `/api/` folder**
A:
- It should already exist (from previous uploads)
- If not, use cPanel File Manager to create it
- Or FTP: Right-click → Create Directory → Name it "api"

**Q: Page still shows old content**
A:
1. Hard refresh: Ctrl + Shift + Delete
2. Try incognito/private window
3. Wait 5 minutes (server cache)
4. Contact QServers to clear caching

**Q: "Upload failed" error**
A:
- Try uploading one file at a time
- Check FTP username/password
- Use cPanel File Manager instead
- Contact QServers FTP support

---

## Quick Checklist

- [ ] Connected to FTP
- [ ] Located correct folder (`/academy/` or `/academy.trendtacticsdigital.com/`)
- [ ] Uploaded `course-detail.html` (replaced old one)
- [ ] Uploaded `checkout.html` (new file)
- [ ] Uploaded `payment-success.html` (new file)
- [ ] Navigated to `/api/` folder
- [ ] Uploaded `verify-payment.php` (new file)
- [ ] Hard refresh browser (Ctrl + Shift + Delete)
- [ ] Visited `https://academy.trendtacticsdigital.com/course-detail`
- [ ] ✅ See instructor profile and "Enroll & Pay" button!

---

## Need Help?

If you get stuck:
1. Let me know which file won't upload
2. Send the error message
3. I can create alternative versions or helper scripts
