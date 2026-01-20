-- Check which column name is used for lesson ordering
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'lessons' 
AND column_name IN ('ordering', 'order_index')
ORDER BY column_name;

-- Also check a sample lesson to see which column has values
SELECT id, title, ordering, order_index, module_id
FROM lessons
WHERE course_id = 'c3d4e5f6-a7b8-9012-cdef-012345678912'
LIMIT 5;
