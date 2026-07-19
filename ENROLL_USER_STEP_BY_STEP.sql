-- ==========================================
-- STEP-BY-STEP USER ENROLLMENT
-- Follow these steps IN ORDER
-- ==========================================

-- ==========================================
-- STEP 1: Find the user's ID
-- ==========================================
-- Replace 'user@example.com' with the actual email of the person who paid
SELECT id, email, created_at 
FROM auth.users 
WHERE email = 'user@example.com';

-- RESULT EXAMPLE:
-- id: 550e8400-e29b-41d4-a716-446655440000
-- email: user@example.com
-- 
-- COPY THE 'id' VALUE (the long UUID string)


-- ==========================================
-- STEP 2: Find the course ID
-- ==========================================
SELECT id, title, price 
FROM courses 
ORDER BY title;

-- RESULT EXAMPLE:
-- id: 123e4567-e89b-12d3-a456-426614174000
-- title: Facebook Ads Foundation
-- price: 5000
--
-- COPY THE 'id' VALUE for the course they paid for


-- ==========================================
-- STEP 3: Create the enrollment
-- ==========================================
-- PASTE the actual UUIDs from Steps 1 and 2 below
-- Remove the quotes around USER_ID and COURSE_ID
-- Replace with your actual values

INSERT INTO enrollments (user_id, course_id, status, enrolled_at)
VALUES (
  '550e8400-e29b-41d4-a716-446655440000',  -- REPLACE with user ID from Step 1
  '123e4567-e89b-12d3-a456-426614174000',  -- REPLACE with course ID from Step 2
  'active',
  NOW()
);

-- ==========================================
-- STEP 4: Verify it worked
-- ==========================================
SELECT 
  u.email as student_email,
  c.title as course_name,
  e.status,
  e.enrolled_at
FROM enrollments e
JOIN auth.users u ON e.user_id = u.id
JOIN courses c ON e.course_id = c.id
ORDER BY e.enrolled_at DESC
LIMIT 5;

-- ==========================================
-- SUCCESS!
-- The user should now see the course in their dashboard
-- They can access all course content
-- ==========================================


-- ==========================================
-- EXAMPLE WITH REAL DATA:
-- ==========================================
-- If user email is: john@example.com
-- And they paid for: Facebook Ads Foundation
--
-- Step 1 returns: id = 550e8400-e29b-41d4-a716-446655440000
-- Step 2 returns: id = 123e4567-e89b-12d3-a456-426614174000
--
-- Then Step 3 becomes:
-- INSERT INTO enrollments (user_id, course_id, status, enrolled_at)
-- VALUES (
--   '550e8400-e29b-41d4-a716-446655440000',
--   '123e4567-e89b-12d3-a456-426614174000',
--   'active',
--   NOW()
-- );
-- ==========================================
