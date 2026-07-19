# 🎯 How to Get UUIDs for Test Enrollment

## **Where to Run These Queries:**

1. Go to **Supabase Dashboard**: https://supabase.com/dashboard
2. Select your project
3. Click **SQL Editor** (left sidebar)
4. Paste queries one at a time

---

## **Step 1: Get Your Test User's UUID**

**In Supabase SQL Editor, run:**

```sql
SELECT id, email, created_at 
FROM auth.users 
ORDER BY created_at DESC
LIMIT 10;
```

**This shows all users.** Find the test user you used for payment.

**Example Result:**
```
id                                    | email              | created_at
--------------------------------------|--------------------|-----------
550e8400-e29b-41d4-a716-446655440000 | test@example.com   | 2026-01-20
abc12345-e89b-12d3-a456-426614174000 | admin@test.com     | 2026-01-19
```

**Copy the `id` for your test user** (the long UUID string)

---

## **Step 2: Get Course UUID**

**In Supabase SQL Editor, run:**

```sql
SELECT id, title, price 
FROM courses 
ORDER BY title;
```

**Example Result:**
```
id                                    | title                    | price
--------------------------------------|--------------------------|-------
123e4567-e89b-12d3-a456-426614174000 | Facebook Ads Foundation  | 5000
789abcde-f012-3456-7890-abcdef123456 | Vibe Coding             | 5000
```

**Copy the `id` for the course** they paid for

---

## **Step 3: Create Enrollment**

**Now paste BOTH UUIDs into this query:**

```sql
INSERT INTO enrollments (user_id, course_id, status, enrolled_at)
VALUES (
  '550e8400-e29b-41d4-a716-446655440000',  -- REPLACE with user UUID from Step 1
  '123e4567-e89b-12d3-a456-426614174000',  -- REPLACE with course UUID from Step 2
  'active',
  NOW()
);
```

**Run this in Supabase SQL Editor**

---

## **Step 4: Verify**

```sql
SELECT 
  u.email,
  c.title,
  e.status,
  e.enrolled_at
FROM enrollments e
JOIN auth.users u ON e.user_id = u.id
JOIN courses c ON e.course_id = c.id
ORDER BY e.enrolled_at DESC
LIMIT 5;
```

**You should see the enrollment!**

---

## **Quick Summary:**

1. **Supabase Dashboard** → **SQL Editor**
2. Run query to **find user UUID**
3. Run query to **find course UUID**
4. **Copy both UUIDs**
5. **Paste into INSERT query**
6. **Run INSERT query**
7. **Verify enrollment created**

---

## **If You Don't Know Which User:**

If you're not sure which test user made the payment:

```sql
-- Show recent users
SELECT id, email, created_at 
FROM auth.users 
WHERE created_at > NOW() - INTERVAL '1 day'
ORDER BY created_at DESC;
```

This shows users created in the last 24 hours.

---

**All queries run in Supabase SQL Editor!**
