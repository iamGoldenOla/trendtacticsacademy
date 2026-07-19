-- ==========================================
-- QUICK ENROLLMENT - Copy & Paste Ready
-- ==========================================

-- 1. Find user email (replace with actual email)
SELECT id, email FROM auth.users WHERE email = 'REPLACE_WITH_USER_EMAIL';

-- 2. Find course (copy the course ID you want)
SELECT id, title FROM courses;

-- 3. Enroll user (replace USER_ID and COURSE_ID)
INSERT INTO enrollments (user_id, course_id, status, enrolled_at)
VALUES (
  'PASTE_USER_ID_HERE',
  'PASTE_COURSE_ID_HERE',
  'active',
  NOW()
);

-- 4. Verify enrollment
SELECT 
  u.email,
  c.title,
  e.status,
  e.enrolled_at
FROM enrollments e
JOIN auth.users u ON e.user_id = u.id
JOIN courses c ON e.course_id = c.id
WHERE u.email = 'REPLACE_WITH_USER_EMAIL';

-- ==========================================
-- User should now see course in dashboard!
-- ==========================================
