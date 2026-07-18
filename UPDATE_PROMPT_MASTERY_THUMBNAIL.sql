-- Update thumbnail URL for Prompt Engineering Mastery course to use the new mastering thumbnail
UPDATE courses 
SET thumbnail_url = '/images/course-promptmastery.png' 
WHERE title ILIKE '%Prompt Engineering Mastery%' 
   OR id = 'c3d4e5f6-a7b8-9012-cdef-012345678913';
