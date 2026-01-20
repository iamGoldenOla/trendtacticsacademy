-- ==========================================
-- UPDATE COURSE PRICES TO $3 BASE PRICE
-- Sets all courses to $3 USD
-- Handles TEXT price column
-- ==========================================

-- Update all courses to $3 (handling TEXT column)
UPDATE courses 
SET price = '3.00'
WHERE price IS NULL 
   OR price = '' 
   OR price = '0' 
   OR CAST(price AS DECIMAL) != 3.00;

-- Verify the update
SELECT 
    id,
    title,
    price,
    CASE 
        WHEN price = 3.00 THEN '✅ Correct'
        ELSE '❌ Needs Update'
    END as status
FROM courses
ORDER BY title;

-- Show summary
SELECT 
    COUNT(*) as total_courses,
    COUNT(CASE WHEN price = 3.00 THEN 1 END) as courses_at_3_dollars,
    COUNT(CASE WHEN price != 3.00 THEN 1 END) as courses_wrong_price
FROM courses;
