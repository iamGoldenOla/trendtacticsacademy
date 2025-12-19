# Database Fix Instructions for Vibe Coding Course

## 🎯 Objective
Fix the Vibe Coding course data issues by running the correct sequence of SQL scripts in Supabase.

## 📋 Prerequisites
1. Access to Supabase dashboard
2. SQL Editor access
3. Course ID: `a1b2c3d4-e5f6-7890-abcd-ef1234567890`

## 🔧 Fix Sequence

### Step 1: Clean Database
**File**: `keep-only-vibe-coding.sql`
- Removes all courses except Vibe Coding
- Deletes orphaned modules and lessons
- Ensures clean slate for proper setup

### Step 2: Add Lessons Structure
**File**: `diagnose-and-fix-lessons.sql`
- Inserts all 15 lessons for Vibe Coding course
- Organizes lessons into 5 modules (3 lessons each)
- Verifies lesson count after insertion

### Step 3: Populate Lesson Content
**File**: `update-lesson-content.sql`
- Updates all 15 lessons with detailed content
- Adds rich educational material including:
  - Introductions and big ideas
  - Visual descriptions
  - Step-by-step instructions
  - Examples and activities
  - Reflection questions
  - Quizzes with answers
  - Resource recommendations
  - Summaries

### Step 4: Verify Setup
**File**: `verify-full-setup.sql`
- Confirms course, modules, and lessons exist
- Validates lesson content is populated
- Checks total counts (should be 1 course, 5 modules, 15 lessons)

## ▶️ Execution Instructions

1. Open Supabase dashboard
2. Navigate to SQL Editor
3. Copy and run each script in order:
   - First: `keep-only-vibe-coding.sql`
   - Second: `diagnose-and-fix-lessons.sql`
   - Third: `update-lesson-content.sql`
   - Fourth: `verify-full-setup.sql`

4. After each script, check the results to ensure no errors

## ✅ Expected Results

After running all scripts successfully, you should see:

- **Course Count**: 1
- **Module Count**: 5
- **Lesson Count**: 15
- **Content Length**: > 1000 characters per lesson (indicating detailed content)

## 🆘 Troubleshooting

### If you see duplicate key errors:
1. Run `keep-only-vibe-coding.sql` again to clean database
2. Retry the sequence

### If content doesn't appear:
1. Verify you ran `update-lesson-content.sql`
2. Check that all UPDATE statements executed without errors

### If counts are wrong:
1. Run `verify-full-setup.sql` to see current state
2. Identify which step failed and rerun from that point

## 🧪 Quick Verification Query

Run this query to quickly check your setup:

```sql
SELECT 
    (SELECT COUNT(*) FROM courses WHERE id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890') as course_count,
    (SELECT COUNT(*) FROM modules WHERE course_id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890') as module_count,
    (SELECT COUNT(*) FROM lessons WHERE module_id IN (
        SELECT id FROM modules WHERE course_id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
    )) as lesson_count;
```

Expected output:
```
course_count: 1
module_count: 5
lesson_count: 15
```

## 🎉 Success Confirmation

Once all scripts run successfully and verification shows correct counts, your Vibe Coding course will be properly set up with:
- Interactive three-panel workspace (navigation, reading, playground)
- All 15 lessons with rich educational content
- Working AI playground and code editor
- Progress tracking functionality