# FINAL DEPLOYMENT INSTRUCTIONS

## 📦 File: `Trendtactics_Academy_FINAL_DEPLOY.zip`
**Location:** `C:\Users\Akinola Olujobi\Documents\Trendtactics Academy\`

## 🛑 STOP AND READ

This zip file is different. It is **CLEAN**.
- It does **NOT** contain other zip files.
- It does **NOT** contain nested folders like "html-lms".
- It contains **ONLY** the files you need to upload.

## 🛠️ HOW TO UPLOAD (Step-by-Step)

1.  **Go to cPanel File Manager**.
2.  Navigate to `/public_html/academy.trendtacticsdigital.com/`.
3.  **VERY IMPORTANT:** Select **ALL** files and folders currently there and **DELETE** them. 
    *   *Why? To ensure no old files (like wrong CSS or nested zips) conflict.*
    *   *Note: If you have a specific database config file you made yourself, keep it, but otherwise, a clean slate is best.*
4.  **Upload** `Trendtactics_Academy_FINAL_DEPLOY.zip`.
5.  **Right-click** the zip and choose **Extract**.
6.  Extract it **directly** to `/public_html/academy.trendtacticsdigital.com/`.

## ✅ WHAT SHOULD BE THERE

After extracting, your folder should look exactly like this:

```
/public_html/academy.trendtacticsdigital.com/
├── css/                  <-- Folder
├── js/                   <-- Folder
├── index.html            <-- File
├── about.html            <-- File
├── services.html         <-- File
├── contact.html          <-- File
├── signup.html           <-- File (I included a working copy just in case)
├── dashboard.html        <-- File
├── course-detail.html    <-- File
├── lesson-viewer.html    <-- File
├── whiteboard.html       <-- File
├── playground.html       <-- File
└── .htaccess             <-- File
```

## 🧪 TEST IT

1.  Open `https://academy.trendtacticsdigital.com/`
2.  Hold **Shift** and reload the page (Force Refresh) to clear old cache.
3.  You should see the **Navy Blue** and **Cyan** theme.
