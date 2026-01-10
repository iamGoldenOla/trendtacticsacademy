# 🌱 DATABASE SEEDING GUIDE

This directory contains SQL scripts to populate your Supabase database with course data.

---

## 📋 SEEDING ORDER

**IMPORTANT:** Run these scripts in the exact order shown below.

### **Step 1: Seed Courses**
**File:** `001_seed_courses.sql`

**What it does:**
- Inserts 3 courses into the `courses` table
- Sets up course metadata (title, description, level, etc.)

**How to run:**
1. Open Supabase SQL Editor
2. Copy contents of `001_seed_courses.sql`
3. Paste and click **Run**

**Expected output:**
```
✅ COURSES SEEDED SUCCESSFULLY
Total courses in database: 3
```

---

### **Step 2: Seed Modules**
**File:** `002_seed_modules.sql`

**What it does:**
- Inserts 32 modules across all 3 courses
- Links modules to their parent courses

**How to run:**
1. Open Supabase SQL Editor
2. Copy contents of `002_seed_modules.sql`
3. Paste and click **Run**

**Expected output:**
```
✅ MODULES SEEDED SUCCESSFULLY
Total modules in database: 32
- Vibe Coding: 13 modules
- Facebook Ads: 13 modules
- Prompt Engineering: 6 modules
```

---

### **Step 3: Seed Lessons**
**File:** `003_seed_lessons.sql`

**What it does:**
- Inserts 68 lessons across all modules
- Includes full lesson content (introduction, key concepts, quizzes, etc.)

**How to run:**
1. Open Supabase SQL Editor
2. Copy contents of `003_seed_lessons.sql`
3. Paste and click **Run**

**Expected output:**
```
✅ LESSONS SEEDED SUCCESSFULLY
Total lessons in database: 68
- Vibe Coding: 26 lessons
- Facebook Ads: 26 lessons
- Prompt Engineering: 16 lessons
```

---

## 🔄 RE-SEEDING

If you need to re-seed the database:

1. **Option A: Keep existing data and update**
   - Just run the scripts again
   - They use `ON CONFLICT DO UPDATE` so they'll update existing records

2. **Option B: Start fresh**
   - Uncomment the `DELETE` statements at the top of `001_seed_courses.sql`
   - Run all 3 scripts in order

---

## ✅ VERIFICATION

After seeding, verify everything worked:

```sql
-- Check courses
SELECT id, title, total_lessons FROM courses ORDER BY title;

-- Check modules
SELECT 
  c.title as course,
  COUNT(m.id) as module_count
FROM courses c
LEFT JOIN modules m ON m.course_id = c.id
GROUP BY c.id, c.title
ORDER BY c.title;

-- Check lessons
SELECT 
  c.title as course,
  COUNT(l.id) as lesson_count
FROM courses c
LEFT JOIN modules m ON m.course_id = c.id
LEFT JOIN lessons l ON l.module_id = m.id
GROUP BY c.id, c.title
ORDER BY c.title;

-- Should show:
-- Vibe Coding: 26 lessons
-- Facebook Ads: 26 lessons
-- Prompt Engineering: 16 lessons
```

---

## 📊 WHAT GETS SEEDED

### **Courses (3 total)**
1. Vibe Coding: Building Real Software with AI
2. Facebook Ads: Building Profitable, Predictable Ad Systems in 2025
3. Prompt Engineering: Designing Instructions That Control AI Systems

### **Modules (32 total)**
- Vibe Coding: 13 modules
- Facebook Ads: 13 modules
- Prompt Engineering: 6 modules

### **Lessons (68 total)**
- Vibe Coding: 26 lessons
- Facebook Ads: 26 lessons
- Prompt Engineering: 16 lessons

Each lesson includes:
- ✅ Title and introduction
- ✅ Big idea and why it matters
- ✅ Key concepts (JSON array)
- ✅ Real-world examples
- ✅ Practical applications
- ✅ Reflection questions
- ✅ Quiz questions and answers
- ✅ Resources (images, videos, links)

---

## 🔧 TROUBLESHOOTING

### Error: "relation does not exist"
**Solution:** Make sure you ran the migration scripts first:
- `database/migrations/000_fix_user_progress_columns.sql`
- `database/migrations/001_deploy_master_schema.sql`

### Error: "foreign key violation"
**Solution:** Make sure you run the scripts in order (courses → modules → lessons)

### Error: "duplicate key value"
**Solution:** The scripts use `ON CONFLICT DO UPDATE`, so this shouldn't happen. If it does, check that you're using the correct IDs.

---

## 📁 FILE STRUCTURE

```
database/seeds/
├── README.md                      ← You are here
├── 001_seed_courses.sql          ← Run first
├── 002_seed_modules.sql          ← Run second
├── 003_seed_lessons.sql          ← Run third (generated)
└── generate-lessons-seed.js      ← Script to generate lesson seeds
```

---

## 🚀 QUICK START

```bash
# 1. Run in Supabase SQL Editor
001_seed_courses.sql

# 2. Run in Supabase SQL Editor
002_seed_modules.sql

# 3. Run in Supabase SQL Editor
003_seed_lessons.sql

# 4. Verify
SELECT COUNT(*) FROM courses;   -- Should be 3
SELECT COUNT(*) FROM modules;   -- Should be 32
SELECT COUNT(*) FROM lessons;   -- Should be 68
```

---

**Status:** ✅ Ready to seed  
**Last Updated:** January 10, 2026

