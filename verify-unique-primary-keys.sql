-- Verification script to check for duplicate primary keys in the Vibe Coding course data
-- This checks only the primary keys (the IDs being defined, not referenced)

-- Check for duplicate course IDs (should be only one)
WITH course_ids AS (
  SELECT 'a1b2c3d4-e5f6-7890-abcd-ef1234567890' as id
)
SELECT id, COUNT(*) as count
FROM course_ids
GROUP BY id
HAVING COUNT(*) > 1;

-- Check for duplicate module IDs (should be 5 unique)
WITH module_ids AS (
  SELECT unnest(ARRAY[
    'b2c3d4e5-f6a7-8901-bcde-f01234567891',
    'c3d4e5f6-a7b8-9012-cdef-012345678912',
    'd4e5f6a7-b8c9-0123-def0-123456789123',
    'e5f6a7b8-c9d0-1234-ef01-234567891234',
    'f6a7b8c9-d0e1-2345-f012-345678912345'
  ]) as id
)
SELECT id, COUNT(*) as count
FROM module_ids
GROUP BY id
HAVING COUNT(*) > 1;

-- Check for duplicate lesson IDs (should be 15 unique)
WITH lesson_ids AS (
  SELECT unnest(ARRAY[
    '1a2b3c4d-5e6f-7890-abcd-ef1234567890',
    '2b3c4d5e-6f78-9012-bcde-f01234567891',
    '3c4d5e6f-7890-1234-cdef-012345678912',
    '4d5e6f78-9012-3456-def0-123456789123',
    '5e6f7890-1234-5678-ef01-234567891234',
    '6f789012-3456-7890-f012-345678912345',
    '78901234-5678-9012-0123-456789123456',
    '89012345-6789-0123-1234-567891234567',
    '90123456-7890-1234-2345-678912345678',
    '01234567-8901-2345-3456-789123456789',
    '12345678-9012-3456-4567-891234567890',
    '23456789-0123-4567-5678-912345678901',
    '34567890-1234-5678-6789-123456789012',
    '45678901-2345-6789-7890-234567890123',
    '56789012-3456-7890-8901-345678901234'
  ]) as id
)
SELECT id, COUNT(*) as count
FROM lesson_ids
GROUP BY id
HAVING COUNT(*) > 1;

-- Summary counts
SELECT 'Courses' as entity_type, 1 as expected_count
UNION ALL
SELECT 'Modules' as entity_type, 5 as expected_count
UNION ALL
SELECT 'Lessons' as entity_type, 15 as expected_count;