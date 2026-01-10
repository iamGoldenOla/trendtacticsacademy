# SOURCE OF TRUTH - File Locations

**Created:** January 10, 2026  
**Purpose:** Document the canonical location of all production files  
**Status:** Phase 1 - Initial Documentation

---

## 📄 HTML PAGES (Production Files in Root)

### Public Pages
- **Homepage:** `./index.html`
- **About:** `./about.html`
- **Services:** `./services.html`
- **Courses:** `./courses.html`
- **Contact:** `./contact.html`
- **Blog:** `./blog.html`

### Authentication Pages
- **Signup:** `./signup.html`
- **Login:** `./login.html`
- **Forgot Password:** `./forgot-password.html`

### Student Pages
- **Dashboard:** `./new-dashboard.html` ⚠️ (should be `dashboard.html`)
- **Lesson Viewer:** `./learn.html` ⚠️ (should be `lesson-viewer.html`)
- **Playground:** `./playground.html`
- **Whiteboard:** `./whiteboard.html`

### Other Pages
- **Course Detail:** `./course-details.html`
- **Checkout:** `./checkout.html`
- **Payment Success:** `./payment-success.html`
- **404:** `./404.html`

---

## 🎨 CSS FILES

### Main Stylesheet
- **Primary CSS:** `./css/main.css`

---

## 📜 JAVASCRIPT FILES

### Core Scripts (in ./js/)
- **Authentication:** `./js/auth.js`
- **Supabase Client:** `./js/supabase-client.js`
- **Trendy AI System:** `./js/trendy-ai-system.js`
- **Course Loader:** `./js/course-loader.js`
- **Lesson Viewer:** `./js/lesson-viewer.js`
- **Dashboard Redirect:** `./js/dashboard-redirect.js`
- **Config:** `./js/config.js`
- **Environment:** `./js/env.js`

### Lesson Fallback Content
- `./js/lesson-fallback-content.js` (active)
- `./js/lesson-fallback-content-complete.js` (backup)
- `./js/lesson-fallback-content-backup.js` (backup)

---

## 🗄️ DATABASE

### Current State
- **Schema Files:** 68 files moved to `./archive/old-sql/`
- **Master Schema:** ⚠️ TO BE CREATED in `./database/schema/master-schema.sql`

### Database Connection
- **Platform:** Supabase
- **Connection:** Configured in `./js/supabase-client.js`

---

## 📊 COURSE DATA (JSON Files)

### Vibe Coding Course
- `./vibe-coding-course.json`
- Individual lessons: `./vibe-lesson-1.json` through `./vibe-lesson-15.json`
- Additional: `./vibe_coding_lesson_1.json`

### Facebook Ads Course
- `./facebook-ads-course.json`
- Backup: `./facebook-ads-course.json.bak`
- Full version: `./facebook-ads-course-full.json.bak`

### Prompt Engineering Course
- Individual lessons: `./prompt-eng-lesson-1.json` through `./prompt-eng-lesson-16.json`
- Enhanced versions: `./enhanced-prompt-eng-lesson-1.json` through `./enhanced-prompt-eng-lesson-6.json`

---

## 🖼️ ASSETS

### Images
- **Location:** `./images/` and `./public/images/`
- **Optimized:** `./optimized_images/`

### Videos
- **Location:** `./videos/` and `./public/videos/`

---

## 📦 ARCHIVED FILES

### Deployment Documentation (42 files)
- **Location:** `./archive/deployment-history/`
- All files containing: DEPLOY, CPANEL, FTP, GITHUB, TROUBLESHOOT

### Test Scripts (11+ files)
- **Location:** `./archive/legacy-tests/`
- All files: test-*.js, check-*.js, debug-*.js, verify-*.js, diagnose-*.js

### SQL Files (68 files)
- **Location:** `./archive/old-sql/`
- All .sql files from root

---

## 🚧 DUPLICATE/BACKUP LOCATIONS (To Be Cleaned)

### Duplicate HTML Locations
- `./docs/` - Contains copies of many HTML files
- `./complete-html-package/` - Package of HTML files
- `./complete-dashboard-package/` - Dashboard files
- `./deployment-package/` - Deployment package
- `./temp_extract/` - Temporary extraction
- `./html-lms/` - LMS package
- `./FINAL-COMPLETE-DEPLOY/` - Final deployment package

### React/Build Directories
- `./lms-frontend/` - React frontend (separate project?)
- `./build/` - Build output
- `./static/` - Static files

---

## ⚠️ ISSUES TO RESOLVE

1. **Dashboard File:** `new-dashboard.html` should be renamed to `dashboard.html`
2. **Lesson Viewer:** `learn.html` should be renamed to `lesson-viewer.html`
3. **Multiple Copies:** Many HTML files exist in multiple locations
4. **No Master Schema:** Need to create single source of truth for database
5. **Course Data:** JSON files scattered in root, need organization

---

## 📋 NEXT STEPS (Phase 1 Continuation)

1. ✅ Archive deployment docs (DONE)
2. ✅ Archive test scripts (DONE)
3. ✅ Archive SQL files (DONE)
4. ⏳ Create master database schema
5. ⏳ Consolidate course data files
6. ⏳ Move HTML files to `./src/pages/`
7. ⏳ Move CSS files to `./src/styles/`
8. ⏳ Move JS files to `./src/scripts/`
9. ⏳ Clean up duplicate directories

---

## 🔍 HOW TO USE THIS DOCUMENT

- **Finding a file?** Check the appropriate section above
- **File missing?** Check `./archive/` folders
- **Multiple versions?** This document lists the canonical version
- **Making changes?** Update this document when moving files

---

**Last Updated:** January 10, 2026  
**Next Update:** After Phase 1 Day 3-4 (Database consolidation)

