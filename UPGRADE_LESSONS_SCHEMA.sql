-- UPGRADE LESSONS TABLE FOR ACADEMY LEARNING ENGINE
-- This adds columns for case studies, key takeaways, playground, and videos

-- Check if columns exist before adding (safe migration)
DO $$
BEGIN
    -- Add case_studies column
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'lessons' AND column_name = 'case_studies') THEN
        ALTER TABLE lessons ADD COLUMN case_studies JSONB DEFAULT '[]';
    END IF;

    -- Add key_takeaways column
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'lessons' AND column_name = 'key_takeaways') THEN
        ALTER TABLE lessons ADD COLUMN key_takeaways JSONB DEFAULT '[]';
    END IF;

    -- Add summary column (executive summary)
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'lessons' AND column_name = 'summary') THEN
        ALTER TABLE lessons ADD COLUMN summary TEXT;
    END IF;

    -- Add playground column
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'lessons' AND column_name = 'playground') THEN
        ALTER TABLE lessons ADD COLUMN playground JSONB;
    END IF;

    -- Add videos column (multiple video resources)
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'lessons' AND column_name = 'videos') THEN
        ALTER TABLE lessons ADD COLUMN videos JSONB DEFAULT '[]';
    END IF;

    -- Rename quiz_questions to quizzes if needed (or add quizzes if missing)
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'lessons' AND column_name = 'quizzes') THEN
        IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'lessons' AND column_name = 'quiz_questions') THEN
            -- Rename existing column
            ALTER TABLE lessons RENAME COLUMN quiz_questions TO quizzes;
        ELSE
            -- Add new column
            ALTER TABLE lessons ADD COLUMN quizzes JSONB DEFAULT '[]';
        END IF;
    END IF;
END $$;

-- Verify the changes
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'lessons'
ORDER BY ordinal_position;
