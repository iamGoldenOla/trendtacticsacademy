# 🛠️ Manual RLS Policy Fix for Lessons Table

## 🔍 Problem Summary

Your database has 70 lessons that are properly published, but the frontend cannot access them due to Row Level Security (RLS) policies on the `lessons` table. The admin client (service role key) can see the lessons, but the anon client (what the frontend uses) cannot.

## 🎯 Solution

You need to manually update the RLS policies in your Supabase SQL editor. Here are the exact steps:

## 🔧 Steps to Fix RLS Policies

### 1. Access Supabase SQL Editor

1. Go to your Supabase project dashboard
2. Click on **SQL Editor** in the left sidebar
3. Click **"+"** to create a new query

### 2. Run These SQL Commands

Copy and paste each of these commands into the SQL editor and run them one by one:

```sql
-- Enable RLS on lessons table
ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;

-- Drop existing policy if it exists
DROP POLICY IF EXISTS "Allow public read access to published lessons" ON lessons;

-- Create new policy allowing read access to published lessons
CREATE POLICY "Allow public read access to published lessons"
ON lessons
FOR SELECT
USING (is_published = true);

-- Grant SELECT permission to anon role
GRANT SELECT ON lessons TO anon;
```

### 3. Verify the Fix

After running the commands, test if the fix worked:

```sql
-- Test query to verify anonymous access
SELECT COUNT(*) FROM lessons WHERE is_published = true;
```

This should return a count greater than 0.

## 🔄 After Applying the Fix

1. Refresh your course page
2. The "Error Loading Course" message should be gone
3. You should see actual lesson content

## 🔐 Security Note

These policies ensure that:
- Only published lessons are accessible to anonymous users
- Admin users can still perform all operations
- The database remains secure

## 🆘 If You Encounter Issues

If you get permission errors when running these commands:

1. Make sure you're running them as a user with sufficient privileges
2. You may need to contact Supabase support for assistance with RLS policies
3. As a temporary workaround, you could disable RLS entirely (not recommended for production):

```sql
-- ONLY as a last resort and NOT recommended for production
ALTER TABLE lessons DISABLE ROW LEVEL SECURITY;
```

## 💡 Need Help?

If you need assistance with these steps:
1. Take screenshots of any error messages
2. Share them with your development team
3. Or contact Supabase support directly

---
*This manual fix addresses the RLS policy issue preventing anonymous users from accessing published lessons.*