# 🔧 DATABASE DEPLOYMENT TROUBLESHOOTING

**Last Updated:** January 10, 2026  
**Status:** Common issues and solutions

---

## ❌ ERROR: column "lesson_id" does not exist

### What Happened:
The migration script tried to use a column that doesn't exist yet in your database.

### ✅ SOLUTION:
This has been **FIXED** in the latest version! The migration now:
- Checks if columns exist before using them
- Creates columns conditionally
- Handles both new and existing databases

### What to Do:
1. **Pull the latest code** from GitHub (already done if you see this file)
2. **Re-run the migration** - It will now work correctly
3. The script will add missing columns automatically

---

## ❌ ERROR: column "total_lessons" does not exist

### What Happened:
The `get_student_courses` function tried to use the `total_lessons` column before it was created.

### ✅ SOLUTION:
This has been **FIXED**! The function now:
- Checks if `total_lessons` column exists
- Uses it if available
- Calculates it on-the-fly if not available

### What to Do:
1. **Re-run the migration** - The function will now work correctly
2. The column will be added automatically
3. The function will adapt to your database state

---

## ❌ ERROR: column "content_hash" does not exist

### What Happened:
The migration tried to create an index on a column that doesn't exist yet.

### ✅ SOLUTION:
This has been **FIXED**! The migration now:
- Adds the column first
- Then creates the index
- Checks if column exists before creating index

### What to Do:
1. **Re-run the migration** - It will work correctly now

---

## ❌ ERROR: column "ai_generated" does not exist

### What Happened:
The migration tried to create an index on a column that doesn't exist yet.

### ✅ SOLUTION:
This has been **FIXED**! The migration now:
- Adds the column first
- Then creates the index conditionally
- Checks if column exists before creating index

### What to Do:
1. **Re-run the migration** - It will work correctly now

---

## ❌ ERROR: relation "table_name" already exists

### What Happened:
You're running the migration on a database that already has some tables.

### ✅ SOLUTION:
This is **NORMAL** and **SAFE**! The migration uses `CREATE TABLE IF NOT EXISTS`.

### What to Do:
1. **Continue** - This is not an error
2. The migration will skip creating existing tables
3. It will only add missing columns and indexes

---

## ❌ ERROR: column "column_name" already exists

### What Happened:
You're running the migration on a database that already has some columns.

### ✅ SOLUTION:
This is **NORMAL** and **SAFE**! The migration checks for existing columns.

### What to Do:
1. **Continue** - This is not an error
2. The migration will skip adding existing columns
3. It will only add what's missing

---

## ❌ ERROR: function "function_name" already exists

### What Happened:
You're running the migration on a database that already has some functions.

### ✅ SOLUTION:
This is **NORMAL** and **SAFE**! The migration uses `CREATE OR REPLACE FUNCTION`.

### What to Do:
1. **Continue** - This is not an error
2. The function will be updated to the latest version
3. No data will be lost

---

## ❌ ERROR: constraint "constraint_name" already exists

### What Happened:
You're running the migration on a database that already has some constraints.

### ✅ SOLUTION:
This is **NORMAL** and **SAFE**! The migration checks for existing constraints.

### What to Do:
1. **Continue** - This is not an error
2. The migration will skip adding existing constraints
3. It will only add what's missing

---

## ❌ No NOTICE messages appear

### What Happened:
Your Supabase SQL Editor might not show NOTICE messages.

### ✅ SOLUTION:
This is **NORMAL**! Not all SQL clients show NOTICE messages.

### What to Do:
1. **Run the verification queries** from the deployment guide
2. Check that tables exist
3. Check that functions exist
4. Check that columns exist

---

## ❌ Migration runs but nothing seems to happen

### What Happened:
Your database might already have everything the migration adds.

### ✅ SOLUTION:
This is **GOOD**! Your database is already up to date.

### What to Do:
1. **Run the diagnostic script** (`000_diagnose_current_schema.sql`)
2. Check what exists in your database
3. Compare with the expected schema
4. If everything matches, you're done!

---

## ❌ ERROR: permission denied

### What Happened:
Your database user doesn't have permission to create tables/functions.

### ✅ SOLUTION:
You need admin/owner permissions on the database.

### What to Do:
1. **Check your Supabase role** - You should be the project owner
2. **Use the SQL Editor** in Supabase dashboard (has full permissions)
3. **Don't use the API** - Use the dashboard SQL Editor

---

## ❌ ERROR: syntax error near "IF NOT EXISTS"

### What Happened:
Your PostgreSQL version might be too old.

### ✅ SOLUTION:
Supabase uses PostgreSQL 15+, which supports all syntax in the migration.

### What to Do:
1. **Check your PostgreSQL version**: `SELECT version();`
2. **Upgrade if needed** (Supabase handles this automatically)
3. **Contact Supabase support** if version is old

---

## 🔍 HOW TO DIAGNOSE ISSUES

### Step 1: Run Diagnostic Script
```sql
-- Copy and run: database/migrations/000_diagnose_current_schema.sql
```

This will show you:
- What tables exist
- What columns each table has
- What functions exist
- What's missing

### Step 2: Check PostgreSQL Version
```sql
SELECT version();
```

Should be PostgreSQL 15 or higher.

### Step 3: Check Your Permissions
```sql
SELECT current_user, current_database();
```

You should be the database owner.

### Step 4: Check Existing Schema
```sql
-- Check tables
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public'
ORDER BY table_name;

-- Check columns in courses table
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_schema = 'public' 
AND table_name = 'courses'
ORDER BY column_name;
```

---

## 🆘 STILL HAVING ISSUES?

### Before Asking for Help:

1. ✅ Run the diagnostic script
2. ✅ Check the error message carefully
3. ✅ Try re-running the migration
4. ✅ Check if the issue is in this troubleshooting guide

### Information to Provide:

- **Error message** (full text)
- **PostgreSQL version** (`SELECT version();`)
- **Diagnostic script output**
- **What step you're on** in the deployment guide

---

## ✅ VERIFICATION AFTER FIXING

After resolving any issues, verify everything works:

```sql
-- 1. Check tables (should be 7)
SELECT COUNT(*) 
FROM information_schema.tables 
WHERE table_schema = 'public'
AND table_name IN ('courses', 'modules', 'lessons', 'assessments', 
                   'student_course_access', 'user_progress', 'ai_content_generations');

-- 2. Check functions (should be 4)
SELECT COUNT(*) 
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public'
AND p.proname IN ('get_student_courses', 'update_updated_at_column',
                  'generate_content_hash', 'check_content_uniqueness');

-- 3. Check new columns in lessons (should be 8)
SELECT COUNT(*) 
FROM information_schema.columns
WHERE table_schema = 'public' 
AND table_name = 'lessons'
AND column_name IN ('ai_generated', 'ai_prompt_used', 'ai_model', 
                    'ai_generation_date', 'content_hash', 'has_whiteboard', 
                    'has_code_playground', 'has_quiz');
```

**Expected Results:**
- Tables: 7
- Functions: 4
- New columns: 8

---

## 📞 SUCCESS!

If all verification queries return the expected results, you're done! 🎉

**Next Steps:**
1. ✅ Mark deployment as complete
2. ✅ Test the new functions
3. ✅ Continue with Phase 1 Day 5-6

---

**Questions?** Review the `database/DEPLOYMENT_GUIDE.md` for detailed instructions.

