-- ============================================================================
-- RESCUE VIBE CODING V6 (JSONB Fix)
-- ============================================================================
-- 1. Uses JSONB to store the update list (Fixes syntax error).
-- 2. Iterates through each concept.
-- 3. Finds ALL fuzzy matches.
-- 4. KEEPS ONLY THE NEWEST (Single Survivor).
-- 5. DELETES the rest (Deduplication).
-- 6. UPDATES the survivor with correct Module & Video.
-- ============================================================================

DO $$
DECLARE
    cid UUID;
    m1_id UUID; m2_id UUID; m3_id UUID; m4_id UUID;
    m5_id UUID; m6_id UUID; m7_id UUID; m8_id UUID;
    
    -- JSONB Array of instructions (Safe, standard SQL)
    updates_json jsonb := '[
        {"s": "%Intent Is the New Programming%", "m": 1, "o": 1, "v": "https://www.youtube.com/watch?v=_xc7ikBW3Yo"},
        {"s": "%What Is Vibe Coding%", "m": 1, "o": 2, "v": "https://www.youtube.com/watch?v=lpQugp7AXEU"},
        {"s": "%From Writing Code%", "m": 1, "o": 3, "v": "https://www.youtube.com/watch?v=qaZC3XSAeR8"},

        {"s": "%How AI Thinks%", "m": 2, "o": 1, "v": "https://www.youtube.com/watch?v=006V3t__xkc"},
        {"s": "%Context, Memory%", "m": 2, "o": 2, "v": "https://www.youtube.com/watch?v=-uW5-TaVXu4"},
        {"s": "%Preventing Repetition%", "m": 2, "o": 3, "v": "https://www.youtube.com/watch?v=VQ0CW1fS2Og"},

        {"s": "%System Prompts vs User Prompts%", "m": 3, "o": 1, "v": "https://www.youtube.com/watch?v=rYdIojvUj-Q"},
        {"s": "%The Vibe Coding Loop%", "m": 3, "o": 2, "v": "https://www.youtube.com/watch?v=QfGZkQ4X4mU"},
        {"s": "%Modular Thinking%", "m": 3, "o": 3, "v": "https://www.youtube.com/watch?v=Q4_YjmzzD3U"},

        {"s": "%UI / Frontend AI%", "m": 4, "o": 1, "v": "https://www.youtube.com/watch?v=X406gPfof1E"},
        {"s": "%Full-Stack & Auto Builders%", "m": 4, "o": 2, "v": "https://www.youtube.com/watch?v=PWDDHgW3vog"},
        {"s": "%Backend, Logic & Data%", "m": 4, "o": 3, "v": "https://www.youtube.com/watch?v=1oTuMPIwHmk"},
        {"s": "%Agentic IDEs%", "m": 4, "o": 4, "v": "https://www.youtube.com/watch?v=OxG7df254cw"},
        {"s": "%AI Agents & Orchestration%", "m": 4, "o": 5, "v": "https://www.youtube.com/watch?v=X3XJeTApVMM"},

        {"s": "%Debugging AI Systems%", "m": 5, "o": 1, "v": "https://www.youtube.com/watch?v=IS5dAkFSo_Y"},
        {"s": "%Building a SaaS%", "m": 5, "o": 2, "v": "https://www.youtube.com/watch?v=SmQ9UyyQ2lo"},
        {"s": "%Building an LMS%", "m": 5, "o": 3, "v": "https://www.youtube.com/watch?v=Oo8xo7991nA"},

        {"s": "%Databases Without Fear%", "m": 6, "o": 1, "v": "https://www.youtube.com/watch?v=cBs_6DyovXc"},
        {"s": "%Authentication & Roles%", "m": 6, "o": 2, "v": "https://www.youtube.com/watch?v=-IqMxPU3vbU"},
        {"s": "%State, Caching%", "m": 6, "o": 3, "v": "https://www.youtube.com/watch?v=I2jV0HPUyHM"},

        {"s": "%Verification Prompts%", "m": 7, "o": 1, "v": "https://www.youtube.com/watch?v=QfGZkQ4X4mU"},
        {"s": "%Cost%Performance%", "m": 7, "o": 2, "v": "https://www.youtube.com/watch?v=PWDDHgW3vog"},
        {"s": "%When NOT to Use AI%", "m": 7, "o": 3, "v": "https://www.youtube.com/watch?v=UcYl9HKT1Mg"},

        {"s": "%Internal Tools%", "m": 8, "o": 1, "v": "https://www.youtube.com/watch?v=9UhexJn7ZRA"},
        {"s": "%Client Work%", "m": 8, "o": 2, "v": "https://www.youtube.com/watch?v=X4SU_f8Z2P0"},
        {"s": "%Future of Software%", "m": 8, "o": 3, "v": "https://www.youtube.com/watch?v=KATAoOtxSqQ"},
        {"s": "%Recommended Resources%", "m": 8, "o": 4, "v": "https://www.youtube.com/watch?v=lpQugp7AXEU"}
    ]';
    
    item jsonb;
    search_term TEXT;
    target_mod_idx INT;
    target_order INT;
    vid_url TEXT;

    target_mod_id UUID;
    survivor_id UUID;
BEGIN
    -- 1. Find the Vibe Coding Course
    SELECT id INTO cid FROM courses WHERE title ILIKE '%Vibe Coding%' LIMIT 1;
    IF cid IS NULL THEN RAISE EXCEPTION 'CRITICAL: Vibe Coding Course NOT found.'; END IF;

    -- 2. Get Module IDs
    SELECT id INTO m1_id FROM modules WHERE course_id = cid AND (title ILIKE '%Foundations%' OR ordering = 1) LIMIT 1;
    SELECT id INTO m2_id FROM modules WHERE course_id = cid AND (title ILIKE '%AI%Builds%' OR ordering = 2) LIMIT 1;
    SELECT id INTO m3_id FROM modules WHERE course_id = cid AND (title ILIKE '%Core Workflow%' OR ordering = 3) LIMIT 1;
    SELECT id INTO m4_id FROM modules WHERE course_id = cid AND (title ILIKE '%Toolkit%' OR ordering = 4) LIMIT 1;
    SELECT id INTO m5_id FROM modules WHERE course_id = cid AND (title ILIKE '%Real Software%' OR ordering = 5) LIMIT 1;
    SELECT id INTO m6_id FROM modules WHERE course_id = cid AND (title ILIKE '%Data%' OR ordering = 6) LIMIT 1;
    SELECT id INTO m7_id FROM modules WHERE course_id = cid AND (title ILIKE '%Advanced%' OR ordering = 7) LIMIT 1;
    SELECT id INTO m8_id FROM modules WHERE course_id = cid AND (title ILIKE '%Career%' OR ordering = 8) LIMIT 1;

    -- 3. Pre-Clear ALL Slots in these modules
    UPDATE lessons 
    SET ordering = ordering + 10000
    WHERE module_id IN (m1_id, m2_id, m3_id, m4_id, m5_id, m6_id, m7_id, m8_id);


    -- 4. PROCESS EACH LESSON LOOP
    FOR item IN SELECT * FROM jsonb_array_elements(updates_json)
    LOOP
        search_term := item->>'s';
        target_mod_idx := (item->>'m')::INT;
        target_order := (item->>'o')::INT;
        vid_url := item->>'v';

        -- Determine target module ID
        IF target_mod_idx = 1 THEN target_mod_id := m1_id;
        ELSIF target_mod_idx = 2 THEN target_mod_id := m2_id;
        ELSIF target_mod_idx = 3 THEN target_mod_id := m3_id;
        ELSIF target_mod_idx = 4 THEN target_mod_id := m4_id;
        ELSIF target_mod_idx = 5 THEN target_mod_id := m5_id;
        ELSIF target_mod_idx = 6 THEN target_mod_id := m6_id;
        ELSIF target_mod_idx = 7 THEN target_mod_id := m7_id;
        ELSIF target_mod_idx = 8 THEN target_mod_id := m8_id;
        END IF;

        -- A. Find survivor (Newest)
        survivor_id := NULL; -- Reset
        SELECT id INTO survivor_id
        FROM lessons 
        WHERE title ILIKE search_term
        ORDER BY created_at DESC 
        LIMIT 1;
        
        IF survivor_id IS NOT NULL THEN
            -- B. DELETE all matches except survivor
            DELETE FROM lessons 
            WHERE title ILIKE search_term
            AND id != survivor_id;

            -- C. UPDATE survivor
            UPDATE lessons 
            SET course_id = cid,
                module_id = target_mod_id,
                ordering = target_order,
                video_url = vid_url
            WHERE id = survivor_id;
            
            RAISE NOTICE 'Updated: %', search_term;
        else
             RAISE NOTICE 'Skipping (Not Found): %', search_term;
        END IF;
    END LOOP;

END $$;

-- VERIFICATION
SELECT 
    l.title, 
    l.module_id, 
    l.ordering,     
    CASE WHEN l.video_url IS NOT NULL THEN '✅ VIDEO' ELSE '❌ NO VIDEO' END as vid_status,
    l.video_url
FROM lessons l
JOIN courses c ON l.course_id = c.id
WHERE c.title ILIKE '%Vibe Coding%'
ORDER BY l.module_id, l.ordering ASC;
