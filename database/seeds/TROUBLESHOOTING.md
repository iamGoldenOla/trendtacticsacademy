# 🔧 TROUBLESHOOTING GUIDE: Database Seeding

## 🚨 Common Errors and Solutions

---

### **Error 1: Level Check Constraint Violation**

**Error Message:**
```
ERROR: 23514: new row for relation "courses" violates check constraint "courses_level_check"
```

**Cause:** The `level` column has a CHECK constraint that only allows specific values.

**Solution:**
The constraint expects lowercase values: `'beginner'`, `'intermediate'`, `'advanced'`

Use the simplified seed script:
- **File:** `database/seeds/001_seed_courses_simple.sql`
- This uses lowercase level values

---

### **Error 2: Duplicate Key Violation (Modules)**

**Error Message:**
```
ERROR: 23505: duplicate key value violates unique constraint "modules_course_id_ordering_key"
```

**Cause:** Modules already exist in the database with the same course_id and ordering.

**Solution:**
1. **Option A:** Delete existing data first (recommended)
   - The `001_seed_courses_simple.sql` script includes DELETE statements
   - It will clear courses, modules, and lessons before inserting

2. **Option B:** Manually delete existing data
   ```sql
   DELETE FROM lessons;
   DELETE FROM modules;
   DELETE FROM courses;
   ```

---

### **Error 3: Column Does Not Exist (video_transcript)**

**Error Message:**
```
ERROR: 42703: column "video_transcript" of relation "lessons" does not exist
```

**Cause:** Your deployed schema doesn't have the `video_transcript` column.

**Solution:**
1. **Check your schema first:**
   - Run `database/seeds/000_check_schema.sql`
   - This will show you what columns actually exist

2. **Use the updated seed script:**
   - The latest `003_seed_lessons.sql` (regenerated) doesn't include `video_transcript`
   - Regenerate if needed: `node database/seeds/generate-lessons-seed.js`

---

### **Error 4: Column Does Not Exist (Other Columns)**

**Error Message:**
```
ERROR: 42703: column "instructor_name" of relation "courses" does not exist
```

**Cause:** Your deployed schema is different from what the seed script expects.

**Solution:**
1. **Check your actual schema:**
   ```sql
   -- Run this in Supabase SQL Editor
   SELECT column_name, data_type 
   FROM information_schema.columns 
   WHERE table_name = 'courses' 
     AND table_schema = 'public'
   ORDER BY ordinal_position;
   ```

2. **Redeploy the master schema:**
   - File: `database/migrations/001_deploy_master_schema.sql`
   - This ensures your database has the correct structure

3. **Use the simplified seed:**
   - File: `database/seeds/001_seed_courses_simple.sql`
   - Only uses essential columns that should exist in all schemas

---

## 🔍 Diagnostic Steps

### **Step 1: Check What's in Your Database**

Run this query:
```sql
SELECT 
  'courses' as table_name,
  COUNT(*) as row_count
FROM courses
UNION ALL
SELECT 
  'modules' as table_name,
  COUNT(*) as row_count
FROM modules
UNION ALL
SELECT 
  'lessons' as table_name,
  COUNT(*) as row_count
FROM lessons;
```

### **Step 2: Check Your Schema**

Run: `database/seeds/000_check_schema.sql`

This will show you:
- All columns in courses, modules, and lessons tables
- All check constraints
- Current row counts

### **Step 3: Verify Schema Version**

Check if your deployed schema matches the master schema:
- **Master Schema:** `database/migrations/001_deploy_master_schema.sql`
- Compare column names and types

---

## ✅ Recommended Seeding Process

### **Fresh Start (Recommended)**

1. **Run schema checker:**
   ```
   database/seeds/000_check_schema.sql
   ```

2. **Clear existing data and seed courses:**
   ```
   database/seeds/001_seed_courses_simple.sql
   ```
   (This includes DELETE statements)

3. **Seed modules:**
   ```
   database/seeds/002_seed_modules.sql
   ```

4. **Seed lessons:**
   ```
   database/seeds/003_seed_lessons.sql
   ```

### **Update Existing Data**

If you want to keep existing data and just update:

1. **Remove DELETE statements** from `001_seed_courses_simple.sql`
2. Run all three seed scripts
3. The `ON CONFLICT DO UPDATE` clauses will update existing records

---

## 🆘 Still Having Issues?

### **Nuclear Option: Complete Reset**

If nothing works, do a complete reset:

```sql
-- WARNING: This deletes ALL data
DROP TABLE IF EXISTS user_progress CASCADE;
DROP TABLE IF EXISTS assessments CASCADE;
DROP TABLE IF EXISTS lessons CASCADE;
DROP TABLE IF EXISTS modules CASCADE;
DROP TABLE IF EXISTS courses CASCADE;

-- Then redeploy the schema
-- Run: database/migrations/001_deploy_master_schema.sql

-- Then seed the data
-- Run: 001_seed_courses_simple.sql
-- Run: 002_seed_modules.sql
-- Run: 003_seed_lessons.sql
```

---

## 📞 Need Help?

If you're still stuck:
1. Run `000_check_schema.sql` and save the output
2. Note the exact error message
3. Check which seed script is failing
4. Compare your schema with the master schema

---

**Last Updated:** January 10, 2026

