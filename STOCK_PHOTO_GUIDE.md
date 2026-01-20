# 📸 Stock Photo Implementation Guide

## 🎯 Quick Start

### **Best Free Stock Photo Sites:**
1. **Unsplash** - https://unsplash.com (Best quality)
2. **Pexels** - https://pexels.com (Great variety)
3. **Pixabay** - https://pixabay.com (Large collection)
4. **StockSnap** - https://stocksnap.io (Modern style)

All are **100% free for commercial use** - no attribution required!

---

## 📋 How to Add Images to Lessons

### **Method 1: Quick SQL Update** (Recommended)

```sql
-- Add image to top of lesson
UPDATE lessons 
SET content = '<img src="https://images.unsplash.com/photo-xxxxx" 
               alt="AI coding workspace" 
               style="width:100%; max-width:800px; border-radius:12px; margin:20px 0; box-shadow: 0 4px 6px rgba(0,217,255,0.1);">' 
              || content
WHERE title = 'Your Lesson Title';
```

### **Method 2: Batch Update Script**

See `LESSON_IMAGE_GUIDE.json` for specific recommendations per lesson!

---

## 🎨 Image Search Strategy

### **For Vibe Coding Lessons:**
**Search Terms:**
- "AI coding" + "dark theme"
- "developer workspace" + "modern"
- "programming abstract" + "futuristic"
- "artificial intelligence" + "technology"

**Style:** Dark, tech-focused, modern

### **For Prompt Engineering Lessons:**
**Search Terms:**
- "AI communication" + "digital"
- "writing code" + "screen"
- "chat interface" + "modern"
- "creative writing" + "technology"

**Style:** Clean, professional, communication-focused

### **For Facebook Ads Lessons:**
**Search Terms:**
- "social media marketing" + "professional"
- "digital advertising" + "analytics"
- "mobile phone" + "ads"
- "marketing dashboard" + "data"

**Style:** Business-focused, data visualization, professional

---

## 💡 Pro Tips

### **Image Selection:**
✅ **DO:**
- Choose high-resolution (1920x1080+)
- Pick images with dark/tech themes
- Use images with cyan/blue tones (matches brand)
- Select professional, modern aesthetics
- Ensure images are landscape orientation

❌ **DON'T:**
- Use images with text overlays
- Choose busy/cluttered images
- Pick outdated or cheesy stock photos
- Use portrait orientation (too tall)

### **Color Matching:**
Your brand colors: **Cyan (#00D9FF)** and **Dark Blue (#050B18)**

Look for images with:
- Blue tones
- Dark backgrounds
- Cyan/teal accents
- Tech/neon aesthetics

---

## 🚀 Quick Implementation

### **Option A: Use Unsplash URLs Directly**
1. Find image on Unsplash
2. Right-click → Copy image address
3. Use URL directly in SQL (no download needed!)

```sql
UPDATE lessons 
SET content = '<img src="https://images.unsplash.com/photo-1234567890" 
               alt="Description" 
               style="width:100%; max-width:800px; border-radius:12px; margin:20px 0;">' 
              || content
WHERE title = 'Lesson Title';
```

### **Option B: Upload to Supabase Storage**
1. Download images
2. Upload to Supabase Storage
3. Get public URL
4. Use in SQL

---

## 📊 Recommended Images Per Course

### **Vibe Coding (8 lessons shown as examples):**

1. **Intent Is the New Programming Language**
   - Search: `person thinking laptop technology`
   - Unsplash: https://unsplash.com/s/photos/developer-thinking

2. **What Is Vibe Coding**
   - Search: `AI robot coding futuristic`
   - Unsplash: https://unsplash.com/s/photos/ai-technology

3. **The Vibe Coding Loop**
   - Search: `circular workflow continuous`
   - Unsplash: https://unsplash.com/s/photos/workflow-cycle

4. **Debugging AI Systems**
   - Search: `debugging code magnifying glass`
   - Unsplash: https://unsplash.com/s/photos/code-debugging

### **Prompt Engineering (6 lessons shown):**

1. **Chain-of-Thought Prompting**
   - Search: `chain links connected`
   - Unsplash: https://unsplash.com/s/photos/chain-connection

2. **Prompt Templates**
   - Search: `template framework design`
   - Unsplash: https://unsplash.com/s/photos/blueprint-design

### **Facebook Ads (6 lessons shown):**

1. **Audience Targeting**
   - Search: `diverse people target audience`
   - Unsplash: https://unsplash.com/s/photos/diverse-business-people

2. **Scaling Strategies**
   - Search: `growth chart scaling up`
   - Unsplash: https://unsplash.com/s/photos/business-growth

---

## 🎯 Complete Implementation Script

See `LESSON_IMAGE_GUIDE.json` for:
- ✅ Specific search terms for EVERY lesson
- ✅ Suggested image types
- ✅ Alt text recommendations
- ✅ Ready-to-use SQL templates

---

## ✅ Next Steps

1. **Review** `LESSON_IMAGE_GUIDE.json`
2. **Search** for images on Unsplash/Pexels
3. **Copy** image URLs
4. **Run** SQL updates to add images
5. **Verify** images display correctly

**Time estimate:** 5-10 minutes per course (20-40 minutes total)

**Result:** Professional, visually engaging lessons! 🎨
