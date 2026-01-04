# URGENT: Upload These 2 Files to Fix "Buy Now" → "Enroll & Pay"

## Files to Upload RIGHT NOW

1. **course-detail.html** - Has the new "Enroll & Pay" button + instructor profile
2. **courses.html** - Fixed so all course cards link to course-detail

---

## FASTEST METHOD - Using cPanel File Manager

### Step 1: Log into cPanel
- Go to: `https://academy.trendtacticsdigital.com:2083` (or your cPanel URL)
- OR ask your host for cPanel login
- Enter username and password

### Step 2: Open File Manager
- Find **File Manager** in cPanel dashboard
- Click it

### Step 3: Navigate to Site Folder
1. Click on `public_html` folder
2. Look for and double-click: `academy` or `academy.trendtacticsdigital.com`
3. You should see: `course-detail.html`, `courses.html`, `index.html`, etc.

### Step 4: Upload course-detail.html
1. Click the **Upload** button
2. Select: `C:\Users\Akinola Olujobi\Documents\Trendtactics Academy\course-detail.html`
3. Click **Upload**
4. When done, it will show "✓ Upload Complete"
5. **IMPORTANT:** Right-click on the uploaded file → **Permissions** → Set to `644`

### Step 5: Upload courses.html  
1. Same as Step 4 - select and upload `courses.html`
2. Set permissions to `644`

### Step 6: Verify Changes
1. **Clear browser cache** - Press: **Ctrl + Shift + Delete**
   - Select "All time"
   - Check: "Cookies" and "Cached images and files"
   - Click "Clear data"

2. **Try Incognito Mode** - Press: **Ctrl + Shift + N**
   - Go to: `https://academy.trendtacticsdigital.com/courses`
   - Click "Start Learning" on any course
   - You should now see:
     - ✅ "Enroll & Pay" button (NOT "Buy Now")
     - ✅ Instructor profile (Akinola Olujobi)
     - ✅ Professional template

---

## ALTERNATIVE - Using FileZilla (If you have it)

### Step 1: Open FileZilla
- File → Site Manager → New site

### Step 2: Connect
- Host: `academy.trendtacticsdigital.com`
- Protocol: FTP
- Port: 21
- Username: Your FTP username
- Password: Your FTP password
- Click Connect

### Step 3: Upload
- Left side (Local): Navigate to your Documents folder
- Right side (Remote): Navigate to `/public_html/academy.trendtacticsdigital.com/`
- Drag these files from left to right:
  - `course-detail.html` (right-click → Overwrite if asked)
  - `courses.html` (right-click → Overwrite if asked)

### Step 4: Verify
- Same as cPanel Step 6 above

---

## What's in These Files?

**course-detail.html:**
- ✅ "Enroll & Pay" button (line 121) - **NEW**
- ✅ Instructor profile section (Akinola Olujobi) - **NEW**
- ✅ Redirect to checkout page
- ✅ Paystack payment integration

**courses.html:**
- ✅ All 3 course cards now link to `/course-detail` - **FIXED**
- Before:
  - Vibe Coding → `/course-detail` ✅
  - Prompt Engineering → `/prompt-engineering` ❌
  - Facebook Ads → `/facebook-ads` ❌
- After:
  - Vibe Coding → `/course-detail` ✅
  - Prompt Engineering → `/course-detail` ✅ **FIXED**
  - Facebook Ads → `/course-detail` ✅ **FIXED**

---

## Troubleshooting

### Still seeing "Buy Now" after upload?

1. **Clear cache more aggressively:**
   - Open DevTools: F12
   - Right-click Refresh button → **Empty cache and hard refresh**
   - OR close browser completely and reopen

2. **Try different browser:**
   - Use Firefox, Chrome, or Edge
   - Try Incognito/Private mode
   - Try another device/phone

3. **Contact QServers:**
   - Ask them to clear CDN cache for `academy.trendtacticsdigital.com`
   - Ask them to clear server-side cache

4. **Check file was actually uploaded:**
   - In cPanel File Manager, right-click `course-detail.html` → Edit
   - Search for "Enroll & Pay" - should find it on line ~121
   - If NOT there, file wasn't uploaded correctly - try again

---

## Quick Checklist

- [ ] Logged into cPanel
- [ ] Opened File Manager
- [ ] Navigated to `/academy/` or `/academy.trendtacticsdigital.com/`
- [ ] Uploaded `course-detail.html`
- [ ] Set permissions to 644 on course-detail.html
- [ ] Uploaded `courses.html`
- [ ] Set permissions to 644 on courses.html
- [ ] Cleared browser cache (Ctrl + Shift + Delete)
- [ ] Tried incognito mode (Ctrl + Shift + N)
- [ ] Visited: https://academy.trendtacticsdigital.com/courses
- [ ] Clicked "Start Learning"
- [ ] ✅ See "Enroll & Pay" button!

---

## GitHub Status

✅ Latest version is on GitHub master branch:
- Commit: `1cf145de` - Fixed course links
- Commit: `bcb76845` - Advanced upload script
- Both `course-detail.html` and `courses.html` have the latest code

You just need to **upload to FTP** now!

Do the cPanel upload now - takes about 2 minutes total. Let me know once done!
