-- ==========================================
-- ADD CURRENCY COLUMN (Optional)
-- Run this ONLY if you want to track currency
-- ==========================================

-- Add currency column to courses table
ALTER TABLE courses 
ADD COLUMN IF NOT EXISTS currency VARCHAR(3) DEFAULT 'NGN';

-- Set all existing courses to NGN
UPDATE courses 
SET currency = 'NGN' 
WHERE currency IS NULL;

-- Verify
SELECT title, price, currency 
FROM courses 
ORDER BY title;

-- ==========================================
-- NOTE: This is OPTIONAL
-- The payment system will work without this column
-- It defaults to NGN if currency is not specified
-- ==========================================
