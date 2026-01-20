# 🎯 Quiz Deployment Instructions

## ⚠️ IMPORTANT: Run Files Individually

Supabase SQL Editor doesn't support running multiple files at once. You need to run each quiz file separately.

## 📋 Step-by-Step Deployment

### **Step 1: Open Supabase SQL Editor**
1. Go to your Supabase project
2. Click on "SQL Editor" in the left sidebar
3. Click "New Query"

### **Step 2: Deploy Quizzes One by One**

Run these files **in order**, one at a time:

#### **File 1: Vibe Coding Quizzes** (if not already done)
```
VIBE_ADD_ALL_QUIZZES.sql
```
- Copy entire file content
- Paste into Supabase SQL Editor
- Click "Run"
- Wait for success message
- Should create ~140 quizzes

#### **File 2: Prompt Engineering Quizzes** ⭐ NEW
```
PROMPT_ADD_ALL_QUIZZES.sql
```
- Copy entire file content
- Paste into Supabase SQL Editor
- Click "Run"
- Wait for success message
- Should create ~135 quizzes

#### **File 3: Facebook Ads Foundation Quizzes** ⭐ NEW
```
FB_FOUNDATION_ADD_QUIZZES.sql
```
- Copy entire file content
- Paste into Supabase SQL Editor
- Click "Run"
- Wait for success message
- Creates 5 quizzes per lesson

#### **File 4: Facebook Ads Mastery Quizzes** ⭐ NEW
```
FB_MASTERY_ADD_QUIZZES.sql
```
- Copy entire file content
- Paste into Supabase SQL Editor
- Click "Run"
- Wait for success message
- Should create ~135 quizzes

### **Step 3: Verify Deployment**

After running all files, verify with this query:

```sql
SELECT 
    c.title as course,
    COUNT(DISTINCT l.id) as total_lessons,
    COUNT(q.id) as total_quizzes,
    ROUND(COUNT(q.id)::numeric / NULLIF(COUNT(DISTINCT l.id), 0), 1) as avg_per_lesson
FROM courses c
LEFT JOIN modules m ON m.course_id = c.id
LEFT JOIN lessons l ON l.module_id = m.id
LEFT JOIN quizzes q ON q.lesson_id = l.id
WHERE c.title IN (
    'Vibe Coding 3.0',
    'Prompt Engineering Mastery',
    'Facebook Ads Foundation',
    'Facebook Ads Mastery'
)
GROUP BY c.title
ORDER BY c.title;
```

**Expected Results:**
- Each course should show `avg_per_lesson = 5.0`
- Total quizzes should be lessons × 5

---

## ✅ Quick Checklist

- [ ] Run `VIBE_ADD_ALL_QUIZZES.sql` (if not done)
- [ ] Run `PROMPT_ADD_ALL_QUIZZES.sql`
- [ ] Run `FB_FOUNDATION_ADD_QUIZZES.sql`
- [ ] Run `FB_MASTERY_ADD_QUIZZES.sql`
- [ ] Verify all quizzes with verification query
- [ ] Test quiz tab appears in course viewer

---

## 🎯 What Happens After Deployment

Once quizzes are in the database:

1. **Quiz Tab Appears Automatically** - The course viewer (`course.html`) will automatically show the Quiz tab for lessons that have quizzes
2. **5 Questions Per Lesson** - Each lesson gets 5 multiple-choice questions
3. **Instant Feedback** - Students get immediate feedback with explanations
4. **No Code Changes Needed** - Everything works automatically!

---

## 🔍 Troubleshooting

### **If quizzes don't appear:**
1. Check the verification query shows quizzes exist
2. Clear browser cache and reload
3. Check browser console for errors
4. Verify lesson IDs match between lessons and quizzes tables

### **If SQL errors occur:**
1. Make sure you're running ONE file at a time
2. Check you have proper permissions in Supabase
3. Verify the quizzes table exists (it's created in each file)
4. Try running the CREATE TABLE part separately first

---

## 📊 Expected Results Summary

| Course | Lessons | Quizzes | Status |
|--------|---------|---------|--------|
| Vibe Coding 3.0 | 28 | 140 | ✅ Should work |
| Prompt Engineering | 27 | 135 | ⭐ Deploy now |
| FB Ads Foundation | ~40+ | ~200+ | ⭐ Deploy now |
| FB Ads Mastery | 27 | 135 | ⭐ Deploy now |

**Total: 600+ quizzes across all courses!** 🎉
