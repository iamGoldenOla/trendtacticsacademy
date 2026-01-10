-- Diagnose and fix lessons for Vibe Coding course

-- First, let's check what we have
SELECT 
    c.title as course_title,
    m.title as module_title,
    COUNT(l.id) as lesson_count
FROM courses c
JOIN modules m ON c.id = m.course_id
LEFT JOIN lessons l ON m.id = l.module_id
WHERE c.id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
GROUP BY c.title, m.title, m.ordering
ORDER BY m.ordering;

-- Delete any existing lessons for Vibe Coding modules (to avoid conflicts)
DELETE FROM lessons WHERE module_id IN (
    SELECT id FROM modules WHERE course_id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
);

-- Now insert all 15 lessons for Vibe Coding course

-- Module 1: Understanding Vibe Coding (3 lessons)
INSERT INTO lessons (id, module_id, title, content, ordering, duration, created_at, updated_at) VALUES
('1a2b3c4d-5e6f-7890-abcd-ef1234567890', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'What Is Vibe Coding?', '{}', 1, '30 minutes', NOW(), NOW()),
('2b3c4d5e-6f78-9012-bcde-f01234567891', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'Why Vibe Coding Exists', '{}', 2, '30 minutes', NOW(), NOW()),
('3c4d5e6f-7890-1234-cdef-012345678912', 'b2c3d4e5-f6a7-8901-bcde-f01234567891', 'How Vibe Coding Is Different from Traditional Coding', '{}', 3, '30 minutes', NOW(), NOW());

-- Module 2: Thinking Before Coding (3 lessons)
INSERT INTO lessons (id, module_id, title, content, ordering, duration, created_at, updated_at) VALUES
('4d5e6f78-9012-3456-def0-123456789123', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Learning to Think in Ideas, Not Code', '{}', 1, '30 minutes', NOW(), NOW()),
('5e6f7890-1234-5678-ef01-234567891234', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Turning Simple Ideas into Digital Instructions', '{}', 2, '30 minutes', NOW(), NOW()),
('6f789012-3456-7890-f012-345678912345', 'c3d4e5f6-a7b8-9012-cdef-012345678912', 'Understanding ''Intent'' in Vibe Coding', '{}', 3, '30 minutes', NOW(), NOW());

-- Module 3: Working with AI as a Creative Partner (3 lessons)
INSERT INTO lessons (id, module_id, title, content, ordering, duration, created_at, updated_at) VALUES
('78901234-5678-9012-0123-456789123456', 'd4e5f6a7-b8c9-0123-def0-123456789123', 'What AI Really Is (In Simple Terms)', '{}', 1, '30 minutes', NOW(), NOW()),
('89012345-6789-0123-1234-567891234567', 'd4e5f6a7-b8c9-0123-def0-123456789123', 'How AI Helps in Vibe Coding', '{}', 2, '30 minutes', NOW(), NOW()),
('90123456-7890-1234-2345-678912345678', 'd4e5f6a7-b8c9-0123-def0-123456789123', 'Talking to AI Clearly and Effectively', '{}', 3, '30 minutes', NOW(), NOW());

-- Module 4: Vibe Coding in Real Life (3 lessons)
INSERT INTO lessons (id, module_id, title, content, ordering, duration, created_at, updated_at) VALUES
('01234567-8901-2345-3456-789123456789', 'e5f6a7b8-c9d0-1234-ef01-234567891234', 'Real Examples of Vibe Coding', '{}', 1, '30 minutes', NOW(), NOW()),
('12345678-9012-3456-4567-891234567890', 'e5f6a7b8-c9d0-1234-ef01-234567891234', 'Building Simple Things Without Fear', '{}', 2, '30 minutes', NOW(), NOW()),
('23456789-0123-4567-5678-912345678901', 'e5f6a7b8-c9d0-1234-ef01-234567891234', 'Common Beginner Mistakes and How to Avoid Them', '{}', 3, '30 minutes', NOW(), NOW());

-- Module 5: Exploring and Building with Confidence (3 lessons)
INSERT INTO lessons (id, module_id, title, content, ordering, duration, created_at, updated_at) VALUES
('34567890-1234-5678-6789-123456789012', 'f6a7b8c9-d0e1-2345-f012-345678912345', 'Using a Playground to Experiment Safely', '{}', 1, '30 minutes', NOW(), NOW()),
('45678901-2345-6789-7890-234567890123', 'f6a7b8c9-d0e1-2345-f012-345678912345', 'Improving Your Ideas Step by Step', '{}', 2, '30 minutes', NOW(), NOW()),
('56789012-3456-7890-8901-345678901234', 'f6a7b8c9-d0e1-2345-f012-345678912345', 'Your First Complete Vibe-Coded Project', '{}', 3, '45 minutes', NOW(), NOW());

-- Verify the fix
SELECT 
    c.title as course_title,
    m.title as module_title,
    COUNT(l.id) as lesson_count
FROM courses c
JOIN modules m ON c.id = m.course_id
LEFT JOIN lessons l ON m.id = l.module_id
WHERE c.id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
GROUP BY c.title, m.title, m.ordering
ORDER BY m.ordering;