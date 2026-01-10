# 🚀 DATABASE DEPLOYMENT GUIDE

**Last Updated:** January 10, 2026  
**Status:** Ready for deployment to existing database

---

## ⚠️ IMPORTANT: FOR EXISTING DATABASES

This guide is specifically designed for deploying to your **existing Supabase database** that already has courses, modules, and lessons tables. The migration scripts will:

- ✅ Preserve all existing data
- ✅ Add missing columns safely
- ✅ Create indexes conditionally
- ✅ Add constraints without conflicts
- ✅ Create functions and triggers

---

## 📋 PRE-DEPLOYMENT CHECKLIST

Before running any scripts, ensure:

- [ ] You have access to your Supabase dashboard
- [ ] You have backed up your database (Supabase does this automatically)
- [ ] You are in the correct project
- [ ] You have reviewed the diagnostic script output

---

## 🔍 STEP 1: DIAGNOSE CURRENT SCHEMA

**Purpose:** See what currently exists in your database

1. Go to your Supabase project: https://supabase.com/dashboard
2. Navigate to **SQL Editor**
3. Click **New Query**
4. Copy the contents of `database/migrations/000_diagnose_current_schema.sql`
5. Paste and click **Run**
6. Review the output to see:
   - Which tables exist
   - What columns each table has
   - Which functions are already created
   - RLS status

**Expected Output:**
- List of existing tables
- List of columns in each table
- List of existing functions
- Summary counts

---

## 🛠️ STEP 2: RUN THE MIGRATION

**Purpose:** Add missing columns, indexes, and functions

### Option A: Full Migration (Recommended)

1. In Supabase SQL Editor, click **New Query**
2. Copy the contents of `database/migrations/001_deploy_master_schema.sql`
3. Paste and click **Run**
4. Watch for NOTICE messages showing what's being added
5. Check for any errors (there shouldn't be any)

**What This Does:**
- Creates tables if they don't exist (won't affect existing tables)
- Adds missing columns to existing tables
- Creates unique constraints
- Creates indexes for performance
- Creates 4 utility functions
- Updates total_lessons count
- Verifies everything worked

**Expected Output:**
```
NOTICE: Added column: courses.featured
NOTICE: Added column: courses.total_lessons
NOTICE: Added column: courses.published_at
NOTICE: Added column: lessons.ai_generated
NOTICE: Added column: lessons.ai_prompt_used
NOTICE: Added column: lessons.ai_model
NOTICE: Added column: lessons.ai_generation_date
NOTICE: Added column: lessons.content_hash
NOTICE: Added column: lessons.has_whiteboard
NOTICE: Added column: lessons.has_code_playground
NOTICE: Added column: lessons.has_quiz
NOTICE: ✅ Migration complete!
NOTICE: Tables created/updated: 7
NOTICE: Functions created: 4
```

### Option B: Master Schema (For New Databases Only)

⚠️ **Only use this if you're starting fresh!**

1. In Supabase SQL Editor, click **New Query**
2. Copy the contents of `database/schema/master-schema.sql`
3. Paste and click **Run**

---

## ✅ STEP 3: VERIFY DEPLOYMENT

Run this verification query:

```sql
-- Check tables
SELECT 
  'Tables' as type,
  COUNT(*) as count
FROM information_schema.tables
WHERE table_schema = 'public'
AND table_name IN ('courses', 'modules', 'lessons', 'assessments', 
                   'student_course_access', 'user_progress', 'ai_content_generations');

-- Check functions
SELECT 
  'Functions' as type,
  COUNT(*) as count
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public'
AND p.proname IN ('get_student_courses', 'get_course_structure', 
                  'generate_content_hash', 'check_content_uniqueness');

-- Check new columns in lessons table
SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'public' 
AND table_name = 'lessons'
AND column_name IN ('ai_generated', 'ai_prompt_used', 'ai_model', 
                    'ai_generation_date', 'content_hash', 'has_whiteboard', 
                    'has_code_playground', 'has_quiz')
ORDER BY column_name;
```

**Expected Results:**
- Tables: 7
- Functions: 4
- New columns: 8 (all listed above)

---

## 🧪 STEP 4: TEST THE FUNCTIONS

Test that the new functions work:

```sql
-- Test generate_content_hash
SELECT generate_content_hash('Test content');

-- Test check_content_uniqueness
SELECT check_content_uniqueness('test_hash_123');

-- Test get_student_courses (replace with your user ID)
SELECT * FROM get_student_courses('YOUR_USER_ID_HERE');
```

---

## 📊 STEP 5: CHECK YOUR DATA

Verify your existing data is intact:

```sql
-- Count existing records
SELECT 
  'courses' as table_name, COUNT(*) as count FROM courses
UNION ALL
SELECT 'modules', COUNT(*) FROM modules
UNION ALL
SELECT 'lessons', COUNT(*) FROM lessons;

-- Check a sample lesson
SELECT 
  id, 
  title, 
  ai_generated, 
  content_hash, 
  has_whiteboard,
  has_code_playground,
  has_quiz
FROM lessons 
LIMIT 5;
```

---

## 🎯 WHAT WAS ADDED

### New Columns in `courses`:
- `featured` (BOOLEAN) - Mark courses as featured
- `total_lessons` (INTEGER) - Cached lesson count
- `published_at` (TIMESTAMPTZ) - Publication date

### New Columns in `lessons`:
- `ai_generated` (BOOLEAN) - AI-generated flag
- `ai_prompt_used` (TEXT) - Prompt used for generation
- `ai_model` (TEXT) - AI model used
- `ai_generation_date` (TIMESTAMPTZ) - When generated
- `content_hash` (TEXT) - SHA-256 hash for uniqueness
- `has_whiteboard` (BOOLEAN) - Whiteboard feature
- `has_code_playground` (BOOLEAN) - Code playground feature
- `has_quiz` (BOOLEAN) - Quiz feature

### New Functions:
1. `update_updated_at_column()` - Auto-update timestamps
2. `generate_content_hash(content)` - Generate SHA-256 hash
3. `check_content_uniqueness(hash)` - Check for duplicates
4. `get_student_courses(user_id)` - Get enrolled courses with progress

---

## ❌ TROUBLESHOOTING

### Error: "column already exists"
**Solution:** This is fine! The migration checks for existing columns. The column won't be added twice.

### Error: "relation already exists"
**Solution:** This is fine! The migration uses `IF NOT EXISTS` clauses.

### Error: "function already exists"
**Solution:** The migration uses `CREATE OR REPLACE` so it will update the function.

### No NOTICE messages appear
**Solution:** Your database might not show NOTICE messages. Check the verification queries instead.

---

## 🔄 ROLLBACK (If Needed)

If something goes wrong, you can remove the new columns:

```sql
-- Remove new columns from courses (if needed)
ALTER TABLE courses DROP COLUMN IF EXISTS featured;
ALTER TABLE courses DROP COLUMN IF EXISTS total_lessons;
ALTER TABLE courses DROP COLUMN IF EXISTS published_at;

-- Remove new columns from lessons (if needed)
ALTER TABLE lessons DROP COLUMN IF EXISTS ai_generated;
ALTER TABLE lessons DROP COLUMN IF EXISTS ai_prompt_used;
ALTER TABLE lessons DROP COLUMN IF EXISTS ai_model;
ALTER TABLE lessons DROP COLUMN IF EXISTS ai_generation_date;
ALTER TABLE lessons DROP COLUMN IF EXISTS content_hash;
ALTER TABLE lessons DROP COLUMN IF EXISTS has_whiteboard;
ALTER TABLE lessons DROP COLUMN IF EXISTS has_code_playground;
ALTER TABLE lessons DROP COLUMN IF EXISTS has_quiz;
```

---

## ✅ SUCCESS CRITERIA

After deployment, you should have:

- [x] All 7 tables exist
- [x] All new columns added
- [x] All 4 functions created
- [x] All indexes created
- [x] All constraints added
- [x] Existing data preserved
- [x] No errors in verification

---

## 📞 NEXT STEPS

After successful deployment:

1. ✅ Mark deployment task as complete
2. ✅ Test the new functions
3. ✅ Update your application code to use new columns
4. ✅ Begin using AI content generation features
5. ✅ Continue with Phase 1 Day 5-6 (Lock Course Structures)

---

**Questions?** Review the DATABASE_DOCUMENTATION.md for detailed schema information.

