-- ==========================================
-- UPDATE COURSE PRICES TO NAIRA (NGN)
-- Run this in Supabase SQL Editor
-- ==========================================

-- Update all courses to use Naira pricing
UPDATE courses
SET 
  price = CASE 
    -- If price is $3 USD, convert to ₦4,500 NGN
    WHEN price = 3 THEN 4500
    -- If price is $5 USD, convert to ₦7,500 NGN
    WHEN price = 5 THEN 7500
    -- If price is $10 USD, convert to ₦15,000 NGN
    WHEN price = 10 THEN 15000
    -- If price is $20 USD, convert to ₦30,000 NGN
    WHEN price = 20 THEN 30000
    -- If price is $50 USD, convert to ₦75,000 NGN
    WHEN price = 50 THEN 75000
    -- If price is $100 USD, convert to ₦150,000 NGN
    WHEN price = 100 THEN 150000
    -- Default: multiply by 1500 (USD to NGN rate)
    ELSE price * 1500
  END,
  currency = 'NGN'
WHERE currency = 'USD' OR currency IS NULL;

-- Verify the update
SELECT 
  title,
  price,
  currency,
  CONCAT('₦', price::text) as display_price
FROM courses
ORDER BY title;

-- ==========================================
-- RECOMMENDED PRICING (in Naira):
-- ==========================================
-- Beginner courses: ₦3,000 - ₦5,000
-- Intermediate courses: ₦7,500 - ₦15,000
-- Advanced courses: ₦20,000 - ₦50,000
-- Premium/Masterclass: ₦75,000 - ₦150,000
-- ==========================================

-- Optional: Set specific prices for your courses
-- UPDATE courses SET price = 5000, currency = 'NGN' WHERE title = 'Facebook Ads Foundation';
-- UPDATE courses SET price = 10000, currency = 'NGN' WHERE title = 'Facebook Ads Mastery';
-- UPDATE courses SET price = 7500, currency = 'NGN' WHERE title = 'Vibe Coding 3.0';
-- UPDATE courses SET price = 7500, currency = 'NGN' WHERE title = 'Prompt Engineering Mastery';
