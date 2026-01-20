-- ==========================================
-- QUICK FIX: Set All Courses to ₦5,000
-- Simple and works immediately!
-- ==========================================

-- Update all courses to ₦5,000
UPDATE courses SET price = '5000';

-- Verify
SELECT 
  title,
  price,
  currency,
  CONCAT('₦', price) as display_price
FROM courses
ORDER BY title;

-- ==========================================
-- Result: All courses now ₦5,000
-- Payments will work in Naira!
-- ==========================================

-- Optional: Customize individual prices after
-- UPDATE courses SET price = '7500' WHERE title LIKE '%Mastery%';
-- UPDATE courses SET price = '10000' WHERE title LIKE '%Advanced%';
