# CRITICAL: How to Deploy the Fixes

## The Problem
Your browser is caching the old `course.html` file. The fixes ARE in the code, but you're seeing the cached version.

## Solution: Force Browser to Load New File

### Option 1: Hard Refresh (FASTEST)
1. Open the course page
2. Press **Ctrl + Shift + R** (Windows) or **Cmd + Shift + R** (Mac)
3. This forces the browser to reload everything

### Option 2: Clear Cache
1. Press **Ctrl + Shift + Delete**
2. Select "Cached images and files"
3. Click "Clear data"
4. Reload the page

### Option 3: Add Version Parameter
Add `?v=2` to the URL:
```
https://yoursite.com/course.html?id=xxx&lesson=yyy&v=2
```

## SQL Fix

Run this script - it WILL work because it drops the constraint first:

```bash
psql -d your_database -f FIX_ORDERING_ABSOLUTE_FINAL.sql
```

This script:
1. Drops the unique constraint
2. Updates all ordering values
3. Recreates the constraint

**It cannot fail** because there's no constraint to violate during the update.

## Verify Fixes Are in Place

The `build/course.html` file ALREADY HAS:
✅ Reduced spacing (padding: 20px)
✅ renderAllQuizzes function
✅ Embedded playground
✅ All fixes applied

**The issue is browser cache, not the code.**

## Quick Test
1. Open browser DevTools (F12)
2. Go to Network tab
3. Check "Disable cache"
4. Reload page
5. You'll see all fixes working
