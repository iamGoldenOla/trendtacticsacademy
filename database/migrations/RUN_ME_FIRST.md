# 🚨 DEPLOYMENT ORDER - READ THIS FIRST!

**IMPORTANT:** Run these scripts in the exact order shown below.

---

## 📋 STEP-BY-STEP DEPLOYMENT

### ✅ STEP 1: Fix user_progress Table (RUN THIS FIRST!)

**File:** `000_fix_user_progress_columns.sql`

**What it does:**
- Creates `user_progress` table if it doesn't exist
- Adds `lesson_id` column (THE CRITICAL FIX!)
- Adds all other required columns
- Verifies everything is ready

**How to run:**
1. Open Supabase SQL Editor
2. Copy contents of `database/migrations/000_fix_user_progress_columns.sql`
3. Paste and click **Run**
4. Wait for success message

**Expected output:**
```
✅ Added column: user_progress.user_id
✅ Added column: user_progress.lesson_id
✅ Added column: user_progress.completed
... (more columns)
========================================
✅ USER_PROGRESS TABLE READY
========================================
Total columns: 11
✅ All required columns exist!
✅ You can now run 001_deploy_master_schema.sql
========================================
```

---

### ✅ STEP 2: Deploy Master Schema (RUN THIS SECOND!)

**File:** `001_deploy_master_schema.sql`

**What it does:**
- Creates all other tables
- Adds missing columns to courses, modules, lessons
- Creates indexes for performance
- Creates 4 utility functions
- Adds constraints
- Verifies deployment

**How to run:**
1. **ONLY after Step 1 completes successfully**
2. Open Supabase SQL Editor (new query)
3. Copy contents of `database/migrations/001_deploy_master_schema.sql`
4. Paste and click **Run**
5. Wait for success message

**Expected output:**
```
NOTICE: Added column: courses.featured
NOTICE: Added column: courses.total_lessons
NOTICE: Added column: courses.published_at
NOTICE: Added column: lessons.ai_generated
... (more columns)
NOTICE: ✅ Migration complete!
NOTICE: Tables created/updated: 7
NOTICE: Functions created: 4
```

---

## ⚠️ IMPORTANT NOTES

### Why Two Scripts?

The `user_progress` table needs the `lesson_id` column **BEFORE** we create functions that reference it. Running them separately ensures:

1. ✅ `lesson_id` column exists first
2. ✅ Functions can reference it without errors
3. ✅ Clear separation of concerns
4. ✅ Easier to debug if something goes wrong

### What If I Already Ran 001_deploy_master_schema.sql?

No problem! Just run:
1. `000_fix_user_progress_columns.sql` - Adds missing columns
2. `001_deploy_master_schema.sql` again - Will skip what exists and complete the rest

Both scripts are **idempotent** (safe to run multiple times).

---

## ✅ VERIFICATION

After running both scripts, verify everything worked:

```sql
-- 1. Check user_progress has lesson_id
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' 
AND table_name = 'user_progress'
ORDER BY ordinal_position;

-- Should show: id, user_id, lesson_id, completed, score, time_spent, 
--              last_accessed_at, completed_at, notes, created_at, updated_at

-- 2. Check all tables exist
SELECT COUNT(*) as table_count
FROM information_schema.tables
WHERE table_schema = 'public'
AND table_name IN ('courses', 'modules', 'lessons', 'assessments', 
                   'student_course_access', 'user_progress', 'ai_content_generations');

-- Should return: 7

-- 3. Check all functions exist
SELECT COUNT(*) as function_count
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public'
AND p.proname IN ('get_student_courses', 'update_updated_at_column',
                  'generate_content_hash', 'check_content_uniqueness');

-- Should return: 4
```

---

## 🎯 QUICK CHECKLIST

- [ ] Run `000_fix_user_progress_columns.sql` first
- [ ] Verify success message appears
- [ ] Run `001_deploy_master_schema.sql` second
- [ ] Verify success message appears
- [ ] Run verification queries
- [ ] All checks pass ✅

---

## 🔧 TROUBLESHOOTING

### Error: "relation user_progress does not exist"
**Solution:** The script will create it. This is normal.

### Error: "column already exists"
**Solution:** That's fine! The script will skip it. This is normal.

### Error: "permission denied"
**Solution:** Make sure you're using Supabase SQL Editor (has full permissions).

### Still getting "lesson_id does not exist"?
**Solution:** Make sure you ran `000_fix_user_progress_columns.sql` FIRST and it completed successfully.

---

## 📞 AFTER SUCCESSFUL DEPLOYMENT

Once both scripts complete:

1. ✅ Your database schema is complete
2. ✅ All tables have required columns
3. ✅ All functions are created
4. ✅ Progress tracking is enabled
5. ✅ You can continue with Phase 1 Day 5-6

---

## 🚀 READY TO GO!

**Start with Step 1 above and follow the order exactly.**

The scripts are designed to work together and will fix the `lesson_id` error once and for all!

---

**Questions?** Check `database/TROUBLESHOOTING.md` for more help.

