# 🚀 QUICK START: Seed Your Database

## ✅ Prerequisites
- Supabase project created
- Database schema deployed (from `database/migrations/001_deploy_master_schema.sql`)

---

## 📝 Step-by-Step Instructions

### **Step 1: Open Supabase SQL Editor**
1. Go to your Supabase project dashboard
2. Click on **SQL Editor** in the left sidebar
3. Click **New Query**

### **Step 2: Seed Courses**
1. Open `database/seeds/001_seed_courses.sql`
2. Copy the entire contents
3. Paste into Supabase SQL Editor
4. Click **Run** (or press Ctrl+Enter)

**Expected Output:**
```
✅ COURSES SEEDED SUCCESSFULLY
Total courses in database: 3

Courses:
1. Vibe Coding (26 lessons)
2. Facebook Ads (26 lessons)
3. Prompt Engineering (16 lessons)
```

### **Step 3: Seed Modules**
1. Open `database/seeds/002_seed_modules.sql`
2. Copy the entire contents
3. Paste into Supabase SQL Editor
4. Click **Run**

**Expected Output:**
```
✅ MODULES SEEDED SUCCESSFULLY
Total modules in database: 29

Breakdown:
- Vibe Coding: 13 modules (expected: 13)
- Facebook Ads: 10 modules (expected: 10)
- Prompt Engineering: 6 modules (expected: 6)
```

### **Step 4: Seed Lessons**
1. Open `database/seeds/003_seed_lessons.sql`
2. Copy the entire contents
3. Paste into Supabase SQL Editor
4. Click **Run**

**Expected Output:**
```
✅ LESSONS SEEDED SUCCESSFULLY
Total lessons in database: 68

Breakdown:
- Vibe Coding: 26 lessons
- Facebook Ads: 26 lessons
- Prompt Engineering: 16 lessons

🎉 All course data seeded successfully!
```

---

## ✅ Verification

Run this query in Supabase SQL Editor to verify everything:

```sql
-- Check all data
SELECT 
  c.title as course,
  COUNT(DISTINCT m.id) as modules,
  COUNT(DISTINCT l.id) as lessons
FROM courses c
LEFT JOIN modules m ON m.course_id = c.id
LEFT JOIN lessons l ON l.module_id = m.id
GROUP BY c.id, c.title
ORDER BY c.title;
```

**Expected Result:**
| Course | Modules | Lessons |
|--------|---------|---------|
| Facebook Ads: Building Profitable... | 10 | 26 |
| Prompt Engineering: Designing... | 6 | 16 |
| Vibe Coding: Building Real Software... | 13 | 26 |

---

## 🔄 Re-Seeding

If you need to run the seeds again:
- The scripts use `ON CONFLICT DO UPDATE`
- They will update existing records instead of creating duplicates
- Safe to run multiple times

---

## ❌ Troubleshooting

### Error: "relation does not exist"
**Solution:** Run the schema migration first:
```
database/migrations/001_deploy_master_schema.sql
```

### Error: "foreign key violation"
**Solution:** Run the scripts in order:
1. 001_seed_courses.sql
2. 002_seed_modules.sql
3. 003_seed_lessons.sql

### Error: "column does not exist"
**Solution:** The schema might be outdated. Check that you're using the latest schema from:
```
database/migrations/001_deploy_master_schema.sql
```

---

## 📊 What Gets Seeded

### **3 Courses**
- Vibe Coding: Building Real Software with AI
- Facebook Ads: Building Profitable, Predictable Ad Systems in 2025
- Prompt Engineering: Designing Instructions That Control AI Systems

### **29 Modules Total**
- Vibe Coding: 13 modules
- Facebook Ads: 10 modules
- Prompt Engineering: 6 modules

### **68 Lessons Total**
- Vibe Coding: 26 lessons
- Facebook Ads: 26 lessons
- Prompt Engineering: 16 lessons

Each lesson includes:
- Title and description
- Full content (key concepts, examples, applications)
- Resources (images, videos, links)
- Duration estimate
- Proper ordering

---

## 🎉 Success!

Once all three scripts run successfully, your database is fully populated and ready for the frontend to connect!

**Next Steps:**
1. Test the API endpoints
2. Verify data in Supabase Table Editor
3. Connect the frontend to display courses

---

**Status:** ✅ Ready to seed  
**Last Updated:** January 10, 2026  
**Total Time:** ~5 minutes

