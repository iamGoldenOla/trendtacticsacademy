# 🤖 Automatic Image Fetcher

## ✅ **What This Does:**

Automatically finds and adds professional stock photos to ALL your lessons in 3 steps!

---

## 🚀 **Quick Setup (5 minutes)**

### **Step 1: Get Free Unsplash API Key**

1. Go to https://unsplash.com/developers
2. Click "Register as a Developer" (free!)
3. Create a new application
4. Copy your **Access Key**

**Free Tier:** 50 requests/hour (perfect for your ~30 lessons!)

### **Step 2: Configure the Script**

Open `auto-fetch-images.js` and paste your API key on line 10:

```javascript
const UNSPLASH_ACCESS_KEY = 'paste_your_key_here';
```

### **Step 3: Run the Script**

```bash
node auto-fetch-images.js
```

**That's it!** The script will:
- ✅ Search Unsplash for each lesson
- ✅ Find the best matching image
- ✅ Generate SQL file with all images
- ✅ Create `AUTO_ADD_IMAGES.sql`

---

## 📋 **Then Just Run the SQL**

1. Open `AUTO_ADD_IMAGES.sql` (auto-generated)
2. Copy all content
3. Paste into Supabase SQL Editor
4. Click "Run"
5. Done! All lessons now have images! 🎉

---

## 🎯 **What You Get:**

- ✅ **Professional images** for every lesson
- ✅ **Automatically matched** to lesson content
- ✅ **High resolution** (800px wide)
- ✅ **Free for commercial use**
- ✅ **Photographer credit** included
- ✅ **Brand-matched colors** (cyan/dark theme)

---

## 💡 **How It Works:**

1. **Reads** `LESSON_IMAGE_GUIDE.json`
2. **Searches** Unsplash for each lesson's suggested keywords
3. **Picks** the top result (landscape orientation)
4. **Generates** SQL UPDATE statements
5. **Saves** to `AUTO_ADD_IMAGES.sql`

---

## 📊 **Example Output:**

```sql
-- Intent Is the New Programming Language
UPDATE lessons 
SET content = '<img src="https://images.unsplash.com/photo-xxxxx" 
               alt="Developer planning with AI assistance" 
               style="width:100%; max-width:800px; border-radius:12px; margin:20px 0;"
               title="Photo by John Doe on Unsplash">' 
              || content
WHERE title = 'Intent Is the New Programming Language';
```

---

## ⚙️ **Customization:**

### **Change Image Quality:**
Edit line 22 in `auto-fetch-images.js`:
```javascript
url: image.urls.regular,  // Options: thumb, small, regular, full, raw
```

### **Change Image Count:**
Edit line 18:
```javascript
per_page=1  // Change to 3 to get 3 options per lesson
```

### **Filter by Color:**
Add to line 18:
```javascript
&color=blue  // Options: blue, cyan, black, white, etc.
```

---

## 🔧 **Troubleshooting:**

### **"API key not set" error:**
- Make sure you pasted your key in line 10
- Remove the quotes around YOUR_UNSPLASH_ACCESS_KEY_HERE

### **"Rate limit exceeded":**
- Free tier: 50 requests/hour
- Wait an hour or upgrade (demo tier is free)
- Script has 1-second delay between requests

### **"No images found":**
- Some search terms might not return results
- Edit `LESSON_IMAGE_GUIDE.json` to change search terms
- Run script again

---

## ✅ **Benefits:**

| Manual Method | Automatic Method |
|--------------|------------------|
| 2-3 hours | 5 minutes |
| Pick each image | Auto-selected |
| Copy/paste URLs | One SQL file |
| Inconsistent style | Matched theme |

---

## 🎉 **Result:**

After running the script and SQL:
- ✅ All lessons have professional images
- ✅ Images match lesson content
- ✅ Consistent visual style
- ✅ Free and legal to use
- ✅ High quality and resolution

**Your LMS will look 10x more professional!** 🚀
