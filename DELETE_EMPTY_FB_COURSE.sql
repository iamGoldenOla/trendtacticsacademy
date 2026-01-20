
-- Deleting the empty "Facebook Ads" course
-- ID: 123e4567-e89b-12d3-a456-426614174002
-- Verified to have 0 modules.

DELETE FROM courses 
WHERE id = '123e4567-e89b-12d3-a456-426614174002';

-- Just to be safe, delete from enrollments if any (though usually handled by cascade, but good to be explicit if not)
DELETE FROM enrollments
WHERE course_id = '123e4567-e89b-12d3-a456-426614174002';
