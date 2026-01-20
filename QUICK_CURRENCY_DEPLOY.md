# 🚀 Quick Currency Deployment (No React Rebuild Needed!)

## ✅ **Simple Solution - Just Upload One File**

Instead of rebuilding the entire React app, use this standalone script!

### **Step 1: Upload `currency-standalone.js`**

Upload this file to your server:
- **File:** `currency-standalone.js`
- **Location:** `/js/currency-standalone.js`

### **Step 2: Add Script to `index.html`**

Add this line to your `index.html` (in the `<head>` section):

```html
<script src="/js/currency-standalone.js"></script>
```

**Where to add it:**
```html
<head>
    ...
    <script defer="defer" src="/static/js/main.d3663c93.js"></script>
    <link href="/static/css/main.87756b56.css" rel="stylesheet">
    <script src="/js/currency-standalone.js"></script>  <!-- ADD THIS LINE -->
</head>
```

### **Step 3: Update Course Cards**

In your course cards HTML, add `data-price` attribute:

**Before:**
```html
<span>Price: $3</span>
```

**After:**
```html
<span data-price="3">$3.00</span>
```

The script will automatically update these prices based on selected currency!

---

## 🎯 **What This Does:**

✅ Adds currency selector to your page
✅ Converts prices automatically
✅ Saves user preference
✅ Works with existing site (no React rebuild!)
✅ Shows notifications when currency changes

---

## 📦 **Files to Upload:**

1. **`currency-standalone.js`** → Upload to `/js/` folder
2. **`index.html`** → Update with script tag (see Step 2)

---

## 🎨 **Where Currency Selector Appears:**

The script will automatically add a currency selector to:
- Header (if found)
- Filters section (if found)

You can customize the location by editing line 128 in `currency-standalone.js`.

---

## ✅ **Advantages:**

- ✅ No React rebuild needed
- ✅ Just upload 1 file
- ✅ Update 1 line in index.html
- ✅ Works immediately
- ✅ No npm, no build process

---

## 🔄 **For Full React Integration (Later):**

When you're ready to properly integrate into React:
1. Wait for the build to finish
2. Upload the `build` folder
3. The React components will have native currency support

But for now, this standalone script gets you up and running in **2 minutes**! 🚀
