-- Database Updates for Trendtactics Academy
-- Run these commands in your Supabase SQL Editor

-- Option 1: If your price column is numeric, update with just the numeric value
-- First, update the schema to allow text values if needed:
ALTER TABLE courses ALTER COLUMN price TYPE TEXT;

-- Then update the course prices
UPDATE courses 
SET price = '$3 / ₦5,000' 
WHERE title ILIKE '%Vibe Coding%' 
   OR title ILIKE '%Prompt Engineering%' 
   OR title ILIKE '%Facebook Ads%'
   OR price IN ('499', '600', '$499', '$600', '499.00', '600.00');

-- Verify the updates worked
SELECT id, title, price FROM courses 
WHERE title ILIKE '%Vibe Coding%' 
   OR title ILIKE '%Prompt Engineering%' 
   OR title ILIKE '%Facebook Ads%';