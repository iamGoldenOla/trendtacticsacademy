-- ============================================================================
-- RESCUE VIBE CODING V5 (The "Highlander" Fix)
-- ============================================================================
-- "There can be only one."
-- The previous errors happened because 'UPDATE ... ILIKE' matched multiple 
-- slightly different titles (e.g. with trailing spaces) that evaded strict deduplication.
-- This script Iterates through each concept, finds ALL fuzzy matches, 
-- deletes the extras, and updates the survivor.
-- ============================================================================

DO $$
DECLARE
    cid UUID;
    m1_id UUID; m2_id UUID; m3_id UUID; m4_id UUID;
    m5_id UUID; m6_id UUID; m7_id UUID; m8_id UUID;
    
    -- We define a type to hold our update instruction
    TYPE lesson_update IS RECORD (
        search_term TEXT,
        target_mod_idx INT, -- 1 to 8
        target_order INT,
        vid_url TEXT
    );
    
    -- Array of instructions
    updates lesson_update[] := ARRAY[
        -- Module 1
        ('%Intent Is the New Programming%', 1, 1, 'https://www.youtube.com/watch?v=_xc7ikBW3Yo'),
        ('%What Is Vibe Coding%', 1, 2, 'https://www.youtube.com/watch?v=lpQugp7AXEU'),
        ('%From Writing Code%', 1, 3, 'https://www.youtube.com/watch?v=qaZC3XSAeR8'),

        -- Module 2
        ('%How AI Thinks%', 2, 1, 'https://www.youtube.com/watch?v=006V3t__xkc'),
        ('%Context, Memory%', 2, 2, 'https://www.youtube.com/watch?v=-uW5-TaVXu4'),
        ('%Preventing Repetition%', 2, 3, 'https://www.youtube.com/watch?v=VQ0CW1fS2Og'),

        -- Module 3
        ('%System Prompts vs User Prompts%', 3, 1, 'https://www.youtube.com/watch?v=rYdIojvUj-Q'),
        ('%The Vibe Coding Loop%', 3, 2, 'https://www.youtube.com/watch?v=QfGZkQ4X4mU'),
        ('%Modular Thinking%', 3, 3, 'https://www.youtube.com/watch?v=Q4_YjmzzD3U'),

        -- Module 4
        ('%UI / Frontend AI%', 4, 1, 'https://www.youtube.com/watch?v=X406gPfof1E'),
        ('%Full-Stack & Auto Builders%', 4, 2, 'https://www.youtube.com/watch?v=PWDDHgW3vog'),
        ('%Backend, Logic & Data%', 4, 3, 'https://www.youtube.com/watch?v=1oTuMPIwHmk'),
        ('%Agentic IDEs%', 4, 4, 'https://www.youtube.com/watch?v=OxG7df254cw'),
        ('%AI Agents & Orchestration%', 4, 5, 'https://www.youtube.com/watch?v=X3XJeTApVMM'),

        -- Module 5
        ('%Debugging AI Systems%', 5, 1, 'https://www.youtube.com/watch?v=IS5dAkFSo_Y'),
        ('%Building a SaaS%', 5, 2, 'https://www.youtube.com/watch?v=SmQ9UyyQ2lo'),
        ('%Building an LMS%', 5, 3, 'https://www.youtube.com/watch?v=Oo8xo7991nA'),

        -- Module 6
        ('%Databases Without Fear%', 6, 1, 'https://www.youtube.com/watch?v=cBs_6DyovXc'),
        ('%Authentication & Roles%', 6, 2, 'https://www.youtube.com/watch?v=-IqMxPU3vbU'),
        ('%State, Caching%', 6, 3, 'https://www.youtube.com/watch?v=I2jV0HPUyHM'),

        -- Module 7
        ('%Verification Prompts%', 7, 1, 'https://www.youtube.com/watch?v=QfGZkQ4X4mU'),
        ('%Cost%Performance%', 7, 2, 'https://www.youtube.com/watch?v=PWDDHgW3vog'),
        ('%When NOT to Use AI%', 7, 3, 'https://www.youtube.com/watch?v=UcYl9HKT1Mg'),

        -- Module 8
        ('%Internal Tools%', 8, 1, 'https://www.youtube.com/watch?v=9UhexJn7ZRA'),
        ('%Client Work%', 8, 2, 'https://www.youtube.com/watch?v=X4SU_f8Z2P0'),
        ('%Future of Software%', 8, 3, 'https://www.youtube.com/watch?v=KATAoOtxSqQ'),
        ('%Recommended Resources%', 8, 4, 'https://www.youtube.com/watch?v=lpQugp7AXEU') -- Using placeholder, resource link is internal
    ];
    
    rec lesson_update;
    target_mod_id UUID;
    survivor_id UUID;
    duplicate_count INT;
BEGIN
    -- 1. Find the Vibe Coding Course
    SELECT id INTO cid FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1;
    IF cid IS NULL THEN RAISE EXCEPTION 'Vibe Coding Course NOT found.'; END IF;

    -- 2. Get Module IDs
    SELECT id INTO m1_id FROM modules WHERE course_id = cid AND (title ILIKE '%Foundations%' OR ordering = 1) LIMIT 1;
    SELECT id INTO m2_id FROM modules WHERE course_id = cid AND (title ILIKE '%AI%Builds%' OR ordering = 2) LIMIT 1;
    SELECT id INTO m3_id FROM modules WHERE course_id = cid AND (title ILIKE '%Core Workflow%' OR ordering = 3) LIMIT 1;
    SELECT id INTO m4_id FROM modules WHERE course_id = cid AND (title ILIKE '%Toolkit%' OR ordering = 4) LIMIT 1;
    SELECT id INTO m5_id FROM modules WHERE course_id = cid AND (title ILIKE '%Real Software%' OR ordering = 5) LIMIT 1;
    SELECT id INTO m6_id FROM modules WHERE course_id = cid AND (title ILIKE '%Data%' OR ordering = 6) LIMIT 1;
    SELECT id INTO m7_id FROM modules WHERE course_id = cid AND (title ILIKE '%Advanced%' OR ordering = 7) LIMIT 1;
    SELECT id INTO m8_id FROM modules WHERE course_id = cid AND (title ILIKE '%Career%' OR ordering = 8) LIMIT 1;

    -- 3. Pre-Clear ALL Slots in these modules using the NUCLEAR module_id approach
    -- This ensures we don't trip over a lesson we haven't processed yet.
    UPDATE lessons 
    SET ordering = ordering + 10000
    WHERE module_id IN (m1_id, m2_id, m3_id, m4_id, m5_id, m6_id, m7_id, m8_id);


    -- 4. PROCESS EACH LESSON
    FOREACH rec IN ARRAY updates
    LOOP
        -- Determine target module ID based on index
        IF rec.target_mod_idx = 1 THEN target_mod_id := m1_id;
        ELSIF rec.target_mod_idx = 2 THEN target_mod_id := m2_id;
        ELSIF rec.target_mod_idx = 3 THEN target_mod_id := m3_id;
        ELSIF rec.target_mod_idx = 4 THEN target_mod_id := m4_id;
        ELSIF rec.target_mod_idx = 5 THEN target_mod_id := m5_id;
        ELSIF rec.target_mod_idx = 6 THEN target_mod_id := m6_id;
        ELSIF rec.target_mod_idx = 7 THEN target_mod_id := m7_id;
        ELSIF rec.target_mod_idx = 8 THEN target_mod_id := m8_id;
        END IF;

        -- A. Find ALL matching IDs for this fuzzy term
        -- Keep the newest one (created_at DESC)
        SELECT id INTO survivor_id
        FROM lessons 
        WHERE title ILIKE rec.search_term
        ORDER BY created_at DESC 
        LIMIT 1;
        
        IF survivor_id IS NOT NULL THEN
            -- B. DELETE all OTHER matches (The "Highlander" logic)
            -- This explicitly deletes the duplicates that caused the constraint error
            DELETE FROM lessons 
            WHERE title ILIKE rec.search_term 
            AND id != survivor_id;

            -- C. UPDATE the survivor
            UPDATE lessons 
            SET course_id = cid,
                module_id = target_mod_id,
                ordering = rec.target_order,
                video_url = rec.vid_url
            WHERE id = survivor_id;
            
        ELSE
            RAISE NOTICE 'Warning: No lesson found for term: %', rec.search_term;
        END IF;
        
    END LOOP;

END $$;

-- VERIFICATION
SELECT 
    l.title, 
    l.module_id, 
    l.ordering, 
    l.video_url
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%'
ORDER BY l.module_id, l.ordering ASC;
