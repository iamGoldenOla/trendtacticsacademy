-- ==========================================
-- UPDATE COURSE PRICES TO NAIRA
-- Fixed for TEXT price column
-- ==========================================

-- First, let's see current prices
SELECT id, title, price, price::numeric as numeric_price
FROM courses 
ORDER BY title;

-- Update all course prices to Naira
-- Convert text to numeric, then multiply by 1500
UPDATE courses
SET price = CASE 
  -- If price is 3.00 (USD), convert to ₦4,500
  WHEN price::numeric = 3 THEN '4500'
  -- If price is 5.00 (USD), convert to ₦7,500
  WHEN price::numeric = 5 THEN '7500'
  -- If price is 10.00 (USD), convert to ₦15,000
  WHEN price::numeric = 10 THEN '15000'
  -- If price is very low (under 100), multiply by 1500
  WHEN price::numeric < 100 THEN (price::numeric * 1500)::text
  -- If already high (over 100), keep it
  WHEN price::numeric >= 100 THEN price
  ELSE '5000' -- Default to ₦5,000
END;

-- Verify the update
SELECT 
  title,
  price,
  CONCAT('₦', price) as display_price
FROM courses
ORDER BY title;

-- ==========================================
-- RECOMMENDED: Set specific prices
-- ==========================================

-- Set all courses to ₦5,000 (good starting price)
-- UPDATE courses SET price = '5000';

-- OR set individually:
-- UPDATE courses SET price = '5000' WHERE title LIKE '%Facebook Ads Foundation%';
-- UPDATE courses SET price = '10000' WHERE title LIKE '%Facebook Ads Mastery%';
-- UPDATE courses SET price = '7500' WHERE title LIKE '%Vibe Coding%';
-- UPDATE courses SET price = '7500' WHERE title LIKE '%Prompt Engineering%';

-- ==========================================
