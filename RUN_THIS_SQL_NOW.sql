-- ==========================================
-- CRITICAL FIX: Update Database Currency
-- RUN THIS NOW to fix payment modal!
-- ==========================================

-- Step 1: Add currency column if it doesn't exist
ALTER TABLE courses 
ADD COLUMN IF NOT EXISTS currency VARCHAR(3) DEFAULT 'NGN';

-- Step 2: Update ALL courses to NGN
UPDATE courses 
SET currency = 'NGN';

-- Step 3: Ensure prices are correct (5000 for all)
UPDATE courses 
SET price = '5000'
WHERE price::numeric < 100 OR price IS NULL;

-- Step 4: Verify the changes
SELECT 
  id,
  title,
  price,
  currency,
  CONCAT('₦', price) as display_price
FROM courses
ORDER BY title;

-- ==========================================
-- Expected Result:
-- ==========================================
-- title                    | price | currency | display_price
-- -------------------------|-------|----------|---------------
-- Facebook Ads Foundation  | 5000  | NGN      | ₦5000
-- Facebook Ads Mastery     | 5000  | NGN      | ₦5000
-- Vibe Coding             | 5000  | NGN      | ₦5000
-- ==========================================

-- ⚠️ IMPORTANT: After running this SQL, the payment modal will show:
-- "₦5,000" instead of "$5000.00"
-- "Nigerian Naira" instead of "US Dollar"
