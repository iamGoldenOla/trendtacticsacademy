-- ==========================================
-- 🛠️ TRENDTACTICS ACADEMY - SCHEMA REPAIR
-- ==========================================
-- Run this in your Supabase SQL Editor to fix enrollment errors.

-- 1. Ensure enrollments table exists with a robust structure
CREATE TABLE IF NOT EXISTS enrollments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
    status TEXT DEFAULT 'active',
    enrolled_at TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    progress INTEGER DEFAULT 0,
    UNIQUE(user_id, course_id)
);

-- 2. Add missing columns to enrollments if they somehow disappeared
DO $$ 
BEGIN 
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='enrollments' AND column_name='status') THEN
        ALTER TABLE enrollments ADD COLUMN status TEXT DEFAULT 'active';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='enrollments' AND column_name='enrolled_at') THEN
        ALTER TABLE enrollments ADD COLUMN enrolled_at TIMESTAMPTZ DEFAULT NOW();
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='enrollments' AND column_name='created_at') THEN
        ALTER TABLE enrollments ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW();
    END IF;
END $$;

-- 3. Enable RLS and add basic policies
ALTER TABLE enrollments ENABLE ROW LEVEL SECURITY;

-- Allow users to see their own enrollments
CREATE POLICY "Users can view own enrollments" 
ON enrollments FOR SELECT 
USING (auth.uid() = user_id);

-- Allow users to enroll themselves
CREATE POLICY "Users can insert own enrollments" 
ON enrollments FOR INSERT 
WITH CHECK (auth.uid() = user_id);

-- 4. IMPORTANT: Force a schema cache refresh by doing a dummy update
COMMENT ON TABLE enrollments IS 'Student course enrollments for Trendtactics Academy';
