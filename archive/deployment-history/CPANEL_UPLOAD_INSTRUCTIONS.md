# Manual cPanel Deployment Instructions

## Files to Upload

Upload the entire `html-lms` folder to your cPanel at:
`/public_html/academy.trendtacticsdigital.com/`

## Folder Structure

```
academy.trendtacticsdigital.com/
├── html-lms/
│   ├── css/
│   │   └── main.css
│   ├── js/
│   │   ├── auth.js
│   │   └── supabase-client.js
│   ├── course-detail.html
│   ├── dashboard.html
│   └── lesson-viewer.html
├── signup.html (already uploaded)
├── whiteboard.html (existing)
└── playground.html (existing)
```

## Step-by-Step Upload

1. **Log into cPanel File Manager**
2. **Navigate to:** `/public_html/academy.trendtacticsdigital.com/`
3. **Upload the `html-lms` folder** (you can zip it first, then extract on server)
4. **Set permissions:** Make sure all files are readable (644 for files, 755 for folders)

## Testing URLs

After upload, test these URLs:

- **Course Detail:** `https://academy.trendtacticsdigital.com/html-lms/course-detail.html`
- **Dashboard:** `https://academy.trendtacticsdigital.com/html-lms/dashboard.html`
- **Lesson Viewer:** `https://academy.trendtacticsdigital.com/html-lms/lesson-viewer.html`

## Quick Test

1. Go to course-detail.html
2. Click "Enroll Now"
3. It should redirect to your working signup.html
4. After signup, you'll be redirected to dashboard
5. Dashboard will show your enrolled course

## Files Location on Your Computer

All files are in:
`C:\Users\Akinola Olujobi\Documents\Trendtactics Academy\html-lms\`

You can:
- **Option A:** Zip the `html-lms` folder and upload the zip
- **Option B:** Upload files one by one via cPanel File Manager
- **Option C:** Use FileZilla FTP client to upload the folder

## Important Notes

- The HTML files reference `../whiteboard.html` and `../playground.html` (one level up)
- Make sure `signup.html`, `whiteboard.html`, and `playground.html` are in the parent directory
- All pages use the same Supabase credentials (already configured)
