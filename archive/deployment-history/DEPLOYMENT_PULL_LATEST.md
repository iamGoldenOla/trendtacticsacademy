# Quick Deployment Guide - Pull Latest Changes to cPanel

## Issue
The latest course-detail.html with instructor profile and Paystack checkout has been committed to GitHub, but the live server hasn't pulled it yet.

## Solution - Pull Latest Code to cPanel

### Option 1: Via SSH/Terminal (Recommended - Fast)
If you have SSH access to your cPanel server:

```bash
cd /path/to/academy  # Usually /home/username/public_html/academy.trendtacticsdigital.com or similar

# Pull latest changes
git pull origin master

# Verify changes
git log --oneline -5
```

Should show:
```
07179011 Complete checkout flow: Add instructor profile, Paystack integration, and payment verification
c451637d Add PHP enrollment endpoint to bypass CSP restrictions
d25402bd Add CSP cPanel hosting troubleshooting guide
```

### Option 2: Via cPanel File Manager (Manual)
1. Log into cPanel
2. Go to File Manager
3. Navigate to your public_html/academy folder
4. Delete the old `course-detail.html`
5. Upload the new `course-detail.html` from your local machine
6. Upload `checkout.html`
7. Upload `payment-success.html`
8. Upload `api/verify-payment.php`
9. Upload `api/enroll.php` (if not already there)

### Option 3: Via cPanel Terminal
In cPanel → Terminal:
```bash
cd ~/public_html/academy.trendtacticsdigital.com
git pull origin master
```

### Option 4: Via Git Webhook (Automatic)
Set up automatic deployments:
1. Go to your GitHub repo settings
2. Add Webhook: `https://your-domain.com/deploy.php` (if you create a webhook handler)
3. On push to master → automatically pulls to server

---

## Files Changed in Latest Commit (07179011)

✅ `course-detail.html` - Revamped with:
   - Instructor profile section (Akinola Olujobi)
   - Changed "Buy Now" → "Enroll & Pay"
   - Instructor bio with credentials
   - Professional layout

✅ `checkout.html` - New professional checkout with:
   - Two-column responsive layout
   - Paystack payment integration
   - Form validation
   - Security badge

✅ `payment-success.html` - Success page with:
   - Confirmation message
   - Payment details
   - Next steps guidance
   - Links to dashboard

✅ `api/verify-payment.php` - Payment verification:
   - Verifies with Paystack API
   - Auto-enrolls users
   - Records payment reference

---

## Verify Deployment

After pulling, check:
1. Go to `https://academy.trendtacticsdigital.com/course-detail`
2. Should see:
   ✅ Instructor profile with photo
   ✅ "Enroll & Pay" button (not "Buy Now")
   ✅ Professional course overview

If still seeing old version:
- Hard refresh browser: `Ctrl + Shift + Delete`
- Clear browser cache completely
- Try in incognito/private mode

---

## Troubleshooting

**If you get "permission denied":**
```bash
# Set proper permissions
chmod -R 755 /path/to/academy
chmod -R 644 /path/to/academy/*.html
chmod -R 755 /path/to/academy/api
```

**If git pull fails:**
```bash
# Check git status
git status

# Force update (careful - overwrites local changes)
git fetch origin
git reset --hard origin/master
```

**If files not updating:**
- Check cPanel's "public_html" path matches where site is deployed
- Verify you're not in a subdirectory with its own git repo

---

## Next: Setup Paystack Keys

Once deployed, add your Paystack keys:

1. In `checkout.html` (line ~239):
```javascript
const PAYSTACK_PUBLIC_KEY = 'pk_live_YOUR_PAYSTACK_PUBLIC_KEY';
```

2. In cPanel environment variables or directly in `api/verify-payment.php`:
```php
$paystack_secret = getenv('PAYSTACK_SECRET_KEY') ?: 'sk_live_YOUR_SECRET';
```

Get keys from: https://dashboard.paystack.com/settings/api-keys

---

## Test the Flow After Deployment

1. ✅ Go to `/course-detail` → See instructor profile
2. ✅ Click "Enroll & Pay" → Go to `/checkout.html`
3. ✅ Fill form → Click "Pay ₦5,000 Now"
4. ✅ Complete Paystack test payment
5. ✅ Redirect to `/payment-success.html`
6. ✅ Check Paystack dashboard for transaction

---

## Support
If deployment fails, let me know and I can create the files directly via FTP or provide more specific cPanel instructions.
