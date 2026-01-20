-- Add extra_resources column (if not exists)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'lessons' AND column_name = 'extra_resources') THEN
        ALTER TABLE lessons ADD COLUMN extra_resources JSONB DEFAULT '[]';
    END IF;
END $$;

-- Lesson 1: "What Is Vibe Coding (Deep)"
UPDATE lessons 
SET extra_resources = '[
    {"title": "Andrej Karpathy Blog", "url": "https://karpathy.ai", "type": "blog"},
    {"title": "The Systems Thinker", "url": "https://thesystemsthinker.com/", "type": "article"}
]'::jsonb
WHERE title ILIKE '%What Is Vibe Coding%';

-- Lesson 2: "From Writing Code to Directing Systems"
UPDATE lessons 
SET extra_resources = '[
    {"title": "Cursor AI", "url": "https://cursor.sh", "type": "tool"},
    {"title": "System Thinking Guide", "url": "https://nesslabs.com/systems-thinking", "type": "article"}
]'::jsonb
WHERE title ILIKE '%Writing Code to Directing Systems%';

-- Lesson 3: "Prompt Engineering for Architects"
UPDATE lessons 
SET extra_resources = '[
    {"title": "OpenAI Prompt Engineering Guide", "url": "https://platform.openai.com/docs/guides/prompt-engineering", "type": "docs"},
    {"title": "Anthropic Prompt Library", "url": "https://docs.anthropic.com/claude/prompt-library", "type": "docs"}
]'::jsonb
WHERE title ILIKE '%Prompt Engineering for Architects%';

-- Lesson 4: "Building the \"Brain\" (Backend Logic)"
UPDATE lessons 
SET extra_resources = '[
    {"title": "Supabase Docs", "url": "https://supabase.com/docs", "type": "docs"},
    {"title": "PostgreSQL Tutorial", "url": "https://www.postgresqltutorial.com/", "type": "article"}
]'::jsonb
WHERE title ILIKE '%Building the "Brain"%';

-- Init empty resources for others
UPDATE lessons SET extra_resources = '[]'::jsonb WHERE extra_resources IS NULL;
