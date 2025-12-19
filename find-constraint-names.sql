-- Find the exact foreign key constraint names between courses and modules
SELECT 
    conname AS constraint_name,
    conrelid::regclass AS table_from,
    confrelid::regclass AS table_to,
    a.attname AS column_name
FROM pg_constraint AS c
JOIN pg_attribute AS a 
    ON a.attnum = ANY(c.conkey) AND a.attrelid = c.conrelid
WHERE c.confrelid = 'courses'::regclass 
AND c.conrelid = 'modules'::regclass
AND c.contype = 'f';

-- Also check for any constraints from courses to modules
SELECT 
    conname AS constraint_name,
    conrelid::regclass AS table_from,
    confrelid::regclass AS table_to,
    a.attname AS column_name
FROM pg_constraint AS c
JOIN pg_attribute AS a 
    ON a.attnum = ANY(c.conkey) AND a.attrelid = c.conrelid
WHERE c.confrelid = 'modules'::regclass 
AND c.conrelid = 'courses'::regclass
AND c.contype = 'f';

-- Check all foreign key constraints in the database
SELECT 
    tc.table_name, 
    kcu.column_name, 
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name,
    tc.constraint_name
FROM 
    information_schema.table_constraints AS tc 
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema = kcu.table_schema
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
      AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY' 
AND (
    tc.table_name IN ('courses', 'modules', 'lessons') 
    OR ccu.table_name IN ('courses', 'modules', 'lessons')
)
ORDER BY tc.table_name, ccu.table_name;