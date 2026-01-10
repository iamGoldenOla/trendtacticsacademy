# CSP Headers Fix for cPanel Hosting

## Issue
YouTube iframe and Supabase API calls are being blocked by restrictive CSP headers, even though `.htaccess` has proper configuration.

## Root Cause
The `.htaccess` file has correct CSP headers, but cPanel may not be applying them if:
1. `mod_headers` Apache module is not enabled
2. `.htaccess` changes haven't been reloaded
3. Different CSP is being set at cPanel level or domain level

## Solution Steps

### Step 1: Verify .htaccess is Deployed
Push the latest changes to GitHub master branch:
```bash
git push origin master
```

Then in your cPanel File Manager:
1. Go to the `public_html` or `public_html/academy` directory
2. Verify `.htaccess` file exists
3. Check its contents - should contain the CSP headers with:
   - ✅ `frame-src` includes YouTube domains
   - ✅ `connect-src` includes Supabase domains

### Step 2: Restart Apache (cPanel)
Log into your cPanel → **EasyApache** or **Apache Modules**:
1. Enable `mod_headers` if not already enabled
2. Restart Apache services
3. Or contact QServers support to enable `mod_headers`

### Step 3: Clear Browser Cache & Test
1. **Hard refresh** browser: `Ctrl + Shift + Delete`
2. Clear all cache for your domain
3. Go to `https://academy.trendtacticsdigital.com/course-detail`
4. Open Developer Console (F12)
5. Check if CSP errors are gone

### Step 4: Test Specific Headers
In browser console, run this to check if headers are being applied:
```javascript
// Check if headers are set correctly
fetch('/', {method: 'HEAD'})
  .then(r => {
    console.log('Content-Security-Policy:', r.headers.get('Content-Security-Policy'));
    console.log('Access-Control-Allow-Origin:', r.headers.get('Access-Control-Allow-Origin'));
  });
```

## Manual .htaccess Fix (if module issues persist)

If `mod_headers` is not available, use `.htaccess` rewrite rules instead:

```apache
# Alternative: If mod_headers doesn't work, remove the Header directives above
# and use this PHP-based approach instead:

# Force PHP to set headers
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteRule ^(.*)$ - [L]
</IfModule>
```

Then create `header-setter.php`:
```php
<?php
header("Content-Security-Policy: default-src 'self' https:; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://unpkg.com https://cdnjs.cloudflare.com https://fonts.googleapis.com https://www.googletagmanager.com https://www.google-analytics.com https://cdn.jsdelivr.net https://www.youtube.com https://s.ytimg.com https://*.youtube.com https://youtube-nocookie.com https://*.youtube-nocookie.com https://*.googleapis.com https://*.google-analytics.com https://*.googletagmanager.com https://uimdbodamoeyukrghchb.supabase.co https://*.supabase.co https://supabase.co; connect-src 'self' https://uimdbodamoeyukrghchb.supabase.co https://*.supabase.co https://supabase.co wss://*.supabase.co https://www.youtube.com https://*.youtube.com https://youtube-nocookie.com https://*.youtube-nocookie.com https://app.supabase.com https://supabase.com; img-src 'self' data: https: http:; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com https://cdnjs.cloudflare.com https://*.googleapis.com; font-src 'self' https://fonts.gstatic.com https://cdnjs.cloudflare.com; frame-src 'self' https://www.youtube.com https://*.youtube.com https://youtube-nocookie.com https://*.youtube-nocookie.com; child-src 'self' https://www.youtube.com https://*.youtube.com https://youtube-nocookie.com https://*.youtube-nocookie.com;");
// Include your HTML here or redirect
?>
```

## Key CSP Directives Needed

| Directive | Required Domains | Purpose |
|-----------|------------------|---------|
| `frame-src` | `youtube.com`, `youtube-nocookie.com` | Allow YouTube iframes |
| `connect-src` | `uimdbodamoeyukrghchb.supabase.co`, `*.supabase.co`, `wss://*.supabase.co` | Allow Supabase API calls and WebSockets |
| `script-src` | All npm/CDN domains | Allow JavaScript resources |

## Current .htaccess Configuration
✅ Already configured with correct headers in `/root` directory
- File: `.htaccess`
- Applied to: `course-detail.html`, `lesson-viewer.html`, `dashboard.html`, and all other pages
- Includes proper `frame-src` for YouTube
- Includes proper `connect-src` for Supabase

## Next Steps
1. Verify `.htaccess` is deployed to cPanel (push to GitHub first)
2. Check `mod_headers` is enabled via cPanel
3. Clear browser cache and reload
4. If issues persist, contact QServers support and ask them to:
   - Enable `mod_headers` Apache module
   - Verify no CSP is being set at domain level that overrides `.htaccess`
   - Check error logs for header-related issues

## Quick Test
After deploying, check the Network tab in DevTools (F12):
- Right-click any request → Response Headers
- Should show: `Content-Security-Policy` header with correct directives
- If not showing, then server isn't sending the headers correctly
