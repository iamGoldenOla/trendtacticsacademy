-- ==========================================
-- READY TO RUN: Enroll Test User
-- ==========================================

-- First, let's see which courses are available
SELECT id, title, price FROM courses ORDER BY title;

-- ==========================================
-- After you see the course IDs above,
-- uncomment ONE of the enrollment blocks below
-- and run it to enroll the user
-- ==========================================

-- OPTION 1: Enroll goldenola75@gmail.com in Facebook Ads Foundation
-- (Replace COURSE_ID_HERE with the actual course ID from the query above)
/*
INSERT INTO enrollments (user_id, course_id, status, enrolled_at)
VALUES (
  '2e34c399-2154-4114-9396-f683608f57df',  -- goldenola75@gmail.com
  'PASTE_COURSE_ID_HERE',  -- Replace with Facebook Ads Foundation ID
  'active',
  NOW()
);
*/

-- OPTION 2: Enroll akinolaolujobi@gmail.com in Facebook Ads Foundation
-- (Replace COURSE_ID_HERE with the actual course ID from the query above)
/*
INSERT INTO enrollments (user_id, course_id, status, enrolled_at)
VALUES (
  'e4571afa-c540-46c0-a397-a4f4fbf8e87f',  -- akinolaolujobi@gmail.com
  'PASTE_COURSE_ID_HERE',  -- Replace with Facebook Ads Foundation ID
  'active',
  NOW()
);
*/

-- OPTION 3: Enroll blissfulseun@gmail.com
/*
INSERT INTO enrollments (user_id, course_id, status, enrolled_at)
VALUES (
  '31990524-35c8-4b33-a06b-395494f0700f',  -- blissfulseun@gmail.com
  'PASTE_COURSE_ID_HERE',  -- Replace with course ID
  'active',
  NOW()
);
*/

-- ==========================================
-- VERIFY ENROLLMENT
-- ==========================================
-- Run this after enrollment to confirm it worked
SELECT 
  u.email,
  c.title,
  e.status,
  e.enrolled_at
FROM enrollments e
JOIN auth.users u ON e.user_id = u.id
JOIN courses c ON e.course_id = c.id
ORDER BY e.enrolled_at DESC
LIMIT 10;
