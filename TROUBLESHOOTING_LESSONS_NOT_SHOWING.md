# 🔍 TROUBLESHOOTING: Lessons Not Showing on Dashboard

## ❓ **The Problem**

You ran the SQL files to update Prompt Engineering lessons, but they're not showing on the dashboard.

---

## 🎯 **Root Cause**

The course player (`course-player.php`) has **auto-generation code** that creates placeholder lessons if none exist. Your SQL files updated the database, but there might be a mismatch between:

1. **Module names** in your SQL vs. what exists in the database
2. **Lesson matching** - SQL uses `WHERE c.title ILIKE '%Prompt Engineering%'` which might not find the right course

---

## ✅ **SOLUTION: 3-Step Fix**

### **Step 1: Run Diagnostic Query**

Run `DIAGNOSTIC_CHECK_PROMPT_ENG.sql` in Supabase SQL Editor.

**Expected Results:**
- Query 1: Shows 1 Prompt Engineering course
- Query 2: Shows 4 modules (Foundations, Core Techniques, Advanced Workflows, Professional Mastery)
- Query 3: Shows lessons with "FULL CONTENT" (1000+ characters)
- Query 4: Most lessons show "FULL CONTENT" status

**If you see "PLACEHOLDER" or "NO CONTENT":**
→ The SQL didn't update the lessons (module/course mismatch)

---

### **Step 2: Fix Module Structure**

**Option A: Update Modules Manually (Recommended)**

1. Go to Supabase → Table Editor → `modules`
2. Find your Prompt Engineering course modules
3. Update module titles to match SQL expectations:
   - Module 1: "Foundations"
   - Module 2: "Core Techniques"  
   - Module 3: "Advanced Workflows"
   - Module 4: "Professional Mastery"

**Option B: Delete Auto-Generated Content**

If the diagnostic shows placeholder lessons:

```sql
-- Delete auto-generated lessons (CAREFUL!)
DELETE FROM lessons 
WHERE course_id IN (SELECT id FROM courses WHERE title ILIKE '%Prompt Engineering%')
AND LENGTH(description) < 100;

-- Delete auto-generated modules
DELETE FROM modules
WHERE course_id IN (SELECT id FROM courses WHERE title ILIKE '%Prompt Engineering%')
AND title IN ('Prompt Engineering Basics', 'Advanced Techniques', 'Specialized Applications', 'Best Practices');
```

Then create the correct modules:

```sql
-- Create correct modules
INSERT INTO modules (course_id, title, ordering)
SELECT id, 'Foundations', 1 FROM courses WHERE title ILIKE '%Prompt Engineering%'
UNION ALL
SELECT id, 'Core Techniques', 2 FROM courses WHERE title ILIKE '%Prompt Engineering%'
UNION ALL
SELECT id, 'Advanced Workflows', 3 FROM courses WHERE title ILIKE '%Prompt Engineering%'
UNION ALL
SELECT id, 'Professional Mastery', 4 FROM courses WHERE title ILIKE '%Prompt Engineering%';
```

---

### **Step 3: Re-run SQL Files**

After fixing modules, re-run the SQL files in order:

1. `PROMPT_ENG_COMPLETE_MODULE1.sql`
2. `PROMPT_ENG_MODULE1_LESSONS_2_3_4.sql`
3. `PROMPT_ENG_REMAINING_LESSONS_COMPLETE.sql`
4. `PROMPT_ENG_LESSONS_6_7_8_12_13_16_17.sql`
5. `PROMPT_ENG_GOLD_STANDARD.sql`
6. `PROMPT_ENG_GOLD_STANDARD_PART2.sql`
7. `PROMPT_ENG_GOLD_STANDARD_PART3.sql`
8. `PROMPT_ENG_GOLD_STANDARD_PART4_5.sql`

---

## 🔄 **Alternative: Quick Fix (If Modules Exist)**

If you already have the correct modules but lessons aren't updating, the issue might be the `order_index` column. Try this:

```sql
-- Check if lessons exist but with wrong order_index
SELECT id, title, order_index, module_id
FROM lessons
WHERE course_id IN (SELECT id FROM courses WHERE title ILIKE '%Prompt Engineering%')
ORDER BY order_index;
```

If `order_index` is NULL or wrong, the SQL `INSERT` statements might be creating **new** lessons instead of updating existing ones.

**Fix:** Use `UPSERT` instead:

```sql
-- Example: Update Lesson 1 (modify for each lesson)
INSERT INTO lessons (course_id, module_id, title, description, summary, key_takeaways, case_studies, playground, extra_resources, quizzes, order_index)
SELECT c.id, m.id, 'What is Prompt Engineering?', '[full content]', '[summary]', '[takeaways]', '[case_studies]', '[playground]', '[resources]', '[quizzes]', 1
FROM courses c CROSS JOIN modules m 
WHERE c.title ILIKE '%Prompt Engineering%' AND m.title ILIKE '%Foundations%'
ON CONFLICT (course_id, order_index) 
DO UPDATE SET 
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    summary = EXCLUDED.summary,
    key_takeaways = EXCLUDED.key_takeaways,
    case_studies = EXCLUDED.case_studies,
    playground = EXCLUDED.playground,
    extra_resources = EXCLUDED.extra_resources,
    quizzes = EXCLUDED.quizzes;
```

---

## 📊 **Verify Success**

After fixing, refresh the dashboard and check:

1. ✅ All 17 lessons appear
2. ✅ Lessons have full content (not placeholders)
3. ✅ Quizzes, case studies, and playgrounds load
4. ✅ Modules are organized correctly

---

## 🆘 **Still Not Working?**

Share the results of the diagnostic query, and I'll provide a custom fix!
