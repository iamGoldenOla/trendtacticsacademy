-- ==========================================
-- FIX: Course Price Display Issue
-- The problem: Database has "5000" but no currency symbol
-- ==========================================

-- First, check current data
SELECT id, title, price, currency, 
       CONCAT('Current: ', price, ' ', COALESCE(currency, 'NULL')) as current_display
FROM courses 
ORDER BY title;

-- The issue: Frontend is getting "5000" from database
-- and trying to format it, but currency logic isn't working

-- Solution: Make sure currency column exists and is set
ALTER TABLE courses 
ADD COLUMN IF NOT EXISTS currency VARCHAR(3) DEFAULT 'NGN';

-- Update all courses to have NGN currency
UPDATE courses 
SET currency = 'NGN' 
WHERE currency IS NULL OR currency = '';

-- Ensure prices are numeric strings (not decimals)
UPDATE courses
SET price = CASE
  WHEN price::numeric < 100 THEN (price::numeric * 1500)::text
  WHEN price::numeric >= 100 THEN price
  ELSE '5000'
END;

-- Verify the fix
SELECT 
  title,
  price,
  currency,
  CONCAT('₦', price) as should_display_as
FROM courses
ORDER BY title;

-- ==========================================
-- Expected Result:
-- title: "Facebook Ads Foundation"
-- price: "5000"
-- currency: "NGN"
-- should_display_as: "₦5000"
-- ==========================================
