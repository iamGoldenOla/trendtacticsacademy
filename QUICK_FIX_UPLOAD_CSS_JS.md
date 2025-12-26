# QUICK FIX - Upload CSS & JS Folders

## 🔧 Problem
Your site has no styling because the `css` and `js` folders are missing from cPanel.

## ✅ Solution

### Option 1: Upload Missing Folders (FASTEST)

**File:** `css-js-folders.zip`
**Location:** `C:\Users\Akinola Olujobi\Documents\Trendtactics Academy\html-lms\`

1. Extract `css-js-folders.zip`
2. Upload both folders to cPanel root:
   - `css/` folder
   - `js/` folder
3. Refresh browser - colors will appear!

### Option 2: Re-upload Complete Package

If you want to be sure everything is correct:

1. **Delete everything in cPanel** except:
   - `signup.html`
   - `whiteboard.html`
   - `playground.html`
   - `courses/`, `partners/`, `payments/`, `videos/` folders

2. **Extract `COMPLETE-ACADEMY-DEPLOY.zip`**

3. **Upload ALL files and folders:**
   - `index.html`
   - `about.html`
   - `services.html`
   - `contact.html`
   - `course-detail.html`
   - `dashboard.html`
   - `lesson-viewer.html`
   - `.htaccess`
   - **`css/` folder** ← IMPORTANT
   - **`js/` folder** ← IMPORTANT

## 📁 Final Structure Should Be:

```
academy.trendtacticsdigital.com/
├── css/
│   └── main.css          ← Brand colors here!
├── js/
│   ├── auth.js
│   └── supabase-client.js
├── index.html
├── about.html
├── services.html
├── contact.html
├── course-detail.html
├── dashboard.html
├── lesson-viewer.html
├── .htaccess
├── signup.html
├── whiteboard.html
├── playground.html
└── [other folders]
```

## ✅ After Upload

Visit: https://academy.trendtacticsdigital.com/

You should see:
- Dark background
- Cyan and navy blue colors
- Styled buttons and cards
- Proper navigation

## 🗑️ Clean Up Supabase

Since Lesson 1 was inserted 4 times, run this in Supabase:

```sql
DELETE FROM lessons 
WHERE id IN (
  SELECT id FROM lessons 
  WHERE title = 'What Is Vibe Coding?'
  ORDER BY created_at DESC
  OFFSET 1
);
```

This keeps only the newest Lesson 1 and deletes the duplicates.
