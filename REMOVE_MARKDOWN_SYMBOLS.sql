-- ============================================================================
-- REMOVE MARKDOWN SYMBOLS (Clean Text Fix)
-- ============================================================================
-- Removes specific markdown syntax ('## ', '# ', '**') from the content
-- of the Prompt Engineering course, leaving clean text structure.
-- ============================================================================

DO $$
DECLARE
    cid UUID := '123e4567-e89b-12d3-a456-426614174001';
BEGIN
    -- 1. Remove Bold Markers (**) globally
    UPDATE lessons 
    SET content = REPLACE(content, '**', '')
    WHERE course_id = cid;

    -- 2. Remove Heading 1 Markers (# )
    UPDATE lessons 
    SET content = REPLACE(content, '# ', '')
    WHERE course_id = cid;

    -- 3. Remove Heading 2 Markers (## )
    UPDATE lessons 
    SET content = REPLACE(content, '## ', '')
    WHERE course_id = cid;

    -- 4. Remove Heading 3 Markers (### )
    UPDATE lessons 
    SET content = REPLACE(content, '### ', '')
    WHERE course_id = cid;
    
    -- 5. Clean up any 'Review **Module' artifacts if any exist
    UPDATE lessons 
    SET content = REPLACE(content, 'Review Module', 'Review Module') -- Just a safety no-op or specific fix if needed
    WHERE course_id = cid;

END $$;

-- VERIFICATION
SELECT title, substring(content from 1 for 100) as preview 
FROM lessons 
WHERE course_id = '123e4567-e89b-12d3-a456-426614174001'
LIMIT 5;
