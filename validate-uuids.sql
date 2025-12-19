-- Validate that all UUIDs in the populate-sample-courses.sql file are valid
-- This script checks for common invalid characters in UUIDs

-- Check for invalid characters in the sample course UUIDs
SELECT 
    'Course UUID check' as check_type,
    CASE 
        WHEN 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11' ~ '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' 
        THEN 'VALID' 
        ELSE 'INVALID' 
    END as result,
    'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11' as uuid_value
UNION ALL
SELECT 
    'Module UUID check 1' as check_type,
    CASE 
        WHEN 'd3aadf22-cf3e-7a11-ee9a-9ee2ea613d44' ~ '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' 
        THEN 'VALID' 
        ELSE 'INVALID' 
    END as result,
    'd3aadf22-cf3e-7a11-ee9a-9ee2ea613d44' as uuid_value
UNION ALL
SELECT 
    'Module UUID check 2' as check_type,
    CASE 
        WHEN 'e4bbea33-df4f-8b22-ff0b-0ff3fb724e55' ~ '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' 
        THEN 'VALID' 
        ELSE 'INVALID' 
    END as result,
    'e4bbea33-df4f-8b22-ff0b-0ff3fb724e55' as uuid_value
UNION ALL
SELECT 
    'Module UUID check 3' as check_type,
    CASE 
        WHEN 'f5ccfb44-ef5f-9c33-ff1c-1ff4fc835f66' ~ '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' 
        THEN 'VALID' 
        ELSE 'INVALID' 
    END as result,
    'f5ccfb44-ef5f-9c33-ff1c-1ff4fc835f66' as uuid_value;

-- Check for invalid characters in the sample lesson UUIDs
SELECT 
    'Lesson UUID check 1' as check_type,
    CASE 
        WHEN '06aaf155-f16f-0a14-ff2a-2ff5fa946f77' ~ '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' 
        THEN 'VALID' 
        ELSE 'INVALID' 
    END as result,
    '06aaf155-f16f-0a14-ff2a-2ff5fa946f77' as uuid_value
UNION ALL
SELECT 
    'Lesson UUID check 2' as check_type,
    CASE 
        WHEN '17bbf266-f27f-1b25-ff3b-3ff6fb057f88' ~ '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' 
        THEN 'VALID' 
        ELSE 'INVALID' 
    END as result,
    '17bbf266-f27f-1b25-ff3b-3ff6fb057f88' as uuid_value
UNION ALL
SELECT 
    'Lesson UUID check 3' as check_type,
    CASE 
        WHEN '28ccf377-f38f-2c36-ff4c-4ff7fc168f99' ~ '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' 
        THEN 'VALID' 
        ELSE 'INVALID' 
    END as result,
    '28ccf377-f38f-2c36-ff4c-4ff7fc168f99' as uuid_value
UNION ALL
SELECT 
    'Lesson UUID check 4' as check_type,
    CASE 
        WHEN '39ddf488-f49f-3d47-ff5d-5ff8fd279f00' ~ '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' 
        THEN 'VALID' 
        ELSE 'INVALID' 
    END as result,
    '39ddf488-f49f-3d47-ff5d-5ff8fd279f00' as uuid_value;