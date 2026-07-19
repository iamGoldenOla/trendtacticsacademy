-- ==========================================
-- MANUAL FIX: Enroll User After Payment
-- Use this if webhook is not working
-- ==========================================

-- Step 1: Find the user who made payment
-- Replace 'user@example.com' with actual email
SELECT id, email, created_at 
FROM auth.users 
WHERE email = 'user@example.com';
-- Copy the 'id' value

-- Step 2: Find the course they paid for
SELECT id, title, price 
FROM courses 
WHERE title LIKE '%Facebook%' OR title LIKE '%Vibe%';
-- Copy the 'id' value

-- Step 3: Create enrollment manually
-- Replace USER_ID and COURSE_ID with values from above
INSERT INTO enrollments (user_id, course_id, status, enrolled_at)
VALUES (
  'USER_ID_HERE',  -- From Step 1
  'COURSE_ID_HERE', -- From Step 2
  'active',
  NOW()
);

-- Step 4: Verify enrollment was created
SELECT 
  e.id,
  u.email,
  c.title,
  e.status,
  e.enrolled_at
FROM enrollments e
JOIN auth.users u ON e.user_id = u.id
JOIN courses c ON e.course_id = c.id
ORDER BY e.enrolled_at DESC
LIMIT 10;

-- ==========================================
-- Expected Result:
-- User should now see course in "My Courses"
-- User can access course content
-- ==========================================
