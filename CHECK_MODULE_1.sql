-- DIAGNOSTIC: Check Module 1 Status
SELECT id, title, ordering, is_published, course_id FROM modules WHERE title ILIKE '%Foundations%' OR ordering = 1;

-- Check Lessons for Module 1
SELECT title, module_id, ordering, course_id FROM lessons WHERE title ILIKE '%Intent Is the New Programming%' OR title ILIKE '%What Is Vibe Coding%';
