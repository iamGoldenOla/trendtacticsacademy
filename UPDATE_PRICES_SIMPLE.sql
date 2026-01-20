-- ==========================================
-- SIMPLE FIX: Update Course Prices to NGN
-- (No currency column needed)
-- ==========================================

-- First, let's see current prices
SELECT id, title, price 
FROM courses 
ORDER BY title;

-- Update all course prices to Naira
-- Assuming current prices are in USD, multiply by 1500
UPDATE courses
SET price = CASE 
  -- If price is very low (like 3, 5, 10), it's likely in USD
  WHEN price <= 100 THEN price * 1500
  -- If price is already high (like 4500), keep it
  WHEN price > 100 THEN price
  ELSE 5000 -- Default to ₦5,000
END;

-- Verify the update
SELECT 
  title,
  price,
  CONCAT('₦', price::text) as display_price
FROM courses
ORDER BY title;

-- ==========================================
-- OPTIONAL: Set specific prices manually
-- ==========================================

-- Uncomment and run these to set specific prices:

-- UPDATE courses SET price = 5000 WHERE title LIKE '%Facebook Ads Foundation%';
-- UPDATE courses SET price = 10000 WHERE title LIKE '%Facebook Ads Mastery%';
-- UPDATE courses SET price = 7500 WHERE title LIKE '%Vibe Coding%';
-- UPDATE courses SET price = 7500 WHERE title LIKE '%Prompt Engineering%';

-- ==========================================
-- RECOMMENDED PRICES (in Naira):
-- ==========================================
-- Beginner courses: ₦3,000 - ₦5,000
-- Intermediate: ₦7,500 - ₦15,000
-- Advanced: ₦20,000 - ₦50,000
-- Masterclass: ₦75,000 - ₦150,000
-- ==========================================
