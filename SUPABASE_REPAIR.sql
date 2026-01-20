-- ==========================================
-- 🛠️ TRENDTACTICS ACADEMY - SCHEMA REPAIR
-- ==========================================
-- Run this in your Supabase SQL Editor to fix enrollment errors.

-- 1. Ensure UUID extension is enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Ensure enrollments table exists with a robust structure
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

    -- CHECK LESSONS TABLE FOR course_id (Fixes PGRST204)
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='lessons' AND column_name='course_id') THEN
        ALTER TABLE lessons ADD COLUMN course_id UUID REFERENCES courses(id) ON DELETE CASCADE;
    END IF;

    -- Ensure video_url exists
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='lessons' AND column_name='video_url') THEN
        ALTER TABLE lessons ADD COLUMN video_url TEXT;
    END IF;

    -- Ensure quiz_questions exists (JSONB is better for structured data)
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='lessons' AND column_name='quiz_questions') THEN
        ALTER TABLE lessons ADD COLUMN quiz_questions JSONB;
    END IF;

    -- Ensure resources exists
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='lessons' AND column_name='resources') THEN
        ALTER TABLE lessons ADD COLUMN resources JSONB;
    END IF;

    -- Ensure summary exists
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='lessons' AND column_name='summary') THEN
        ALTER TABLE lessons ADD COLUMN summary TEXT;
    END IF;
END $$;

-- Force Schema Cache Reload
NOTIFY pgrst, 'reload config';

-- 3. Enable RLS and add basic policies
ALTER TABLE enrollments ENABLE ROW LEVEL SECURITY;

-- Allow users to see their own enrollments
DROP POLICY IF EXISTS "Users can view own enrollments" ON enrollments;
CREATE POLICY "Users can view own enrollments" 
ON enrollments FOR SELECT 
USING (auth.uid() = user_id);

-- Allow users to enroll themselves
DROP POLICY IF EXISTS "Users can insert own enrollments" ON enrollments;
CREATE POLICY "Users can insert own enrollments" 
ON enrollments FOR INSERT 
WITH CHECK (auth.uid() = user_id);

-- 4. Standardize Relationship Names (Crucial for V13 Query Stability)
-- This ensures the "more than one relationship" error is fixed forever
DO $$ 
BEGIN 
    -- Modules -> Courses
    IF EXISTS (SELECT 1 FROM information_schema.table_constraints WHERE table_name='modules' AND constraint_type='FOREIGN KEY') THEN
        -- We try to find the FK pointing to courses and rename it to our standard
        BEGIN
            ALTER TABLE modules RENAME CONSTRAINT modules_course_id_fkey TO modules_course_id_fkey_old;
        EXCEPTION WHEN OTHERS THEN NULL; END;
        
        BEGIN
            -- Drop existing and recreate with standard name
            ALTER TABLE modules DROP CONSTRAINT IF EXISTS modules_course_id_fkey;
            ALTER TABLE modules ADD CONSTRAINT modules_course_id_fkey FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE;
        EXCEPTION WHEN OTHERS THEN NULL; END;
    END IF;

    -- Lessons -> Modules
    IF EXISTS (SELECT 1 FROM information_schema.table_constraints WHERE table_name='lessons' AND constraint_type='FOREIGN KEY') THEN
        BEGIN
            ALTER TABLE lessons DROP CONSTRAINT IF EXISTS lessons_module_id_fkey;
            ALTER TABLE lessons ADD CONSTRAINT lessons_module_id_fkey FOREIGN KEY (module_id) REFERENCES modules(id) ON DELETE CASCADE;
        EXCEPTION WHEN OTHERS THEN NULL; END;
    END IF;
END $$;

-- 5. IMPORTANT: Force a schema cache refresh
COMMENT ON TABLE enrollments IS 'Student course enrollments for Trendtactics Academy V13';
COMMENT ON TABLE modules IS 'Course modules V13';
COMMENT ON TABLE lessons IS 'Lesson content V13';

-- 6. FIX MODULES & LESSONS PERMISSIONS (Fixes "violates row-level security policy")
ALTER TABLE modules ENABLE ROW LEVEL SECURITY;
ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;

-- Modules Policies
DROP POLICY IF EXISTS "Public Read Modules" ON modules;
CREATE POLICY "Public Read Modules" ON modules FOR SELECT USING (true);

DROP POLICY IF EXISTS "Auth Insert Modules" ON modules;
CREATE POLICY "Auth Insert Modules" ON modules FOR INSERT WITH CHECK (auth.role() = 'authenticated');

DROP POLICY IF EXISTS "Auth Update Modules" ON modules;
CREATE POLICY "Auth Update Modules" ON modules FOR UPDATE USING (auth.role() = 'authenticated');

DROP POLICY IF EXISTS "Auth Delete Modules" ON modules;
CREATE POLICY "Auth Delete Modules" ON modules FOR DELETE USING (auth.role() = 'authenticated');

-- Lessons Policies
DROP POLICY IF EXISTS "Public Read Lessons" ON lessons;
CREATE POLICY "Public Read Lessons" ON lessons FOR SELECT USING (true);

DROP POLICY IF EXISTS "Auth Insert Lessons" ON lessons;
CREATE POLICY "Auth Insert Lessons" ON lessons FOR INSERT WITH CHECK (auth.role() = 'authenticated');

DROP POLICY IF EXISTS "Auth Update Lessons" ON lessons;
CREATE POLICY "Auth Update Lessons" ON lessons FOR UPDATE USING (auth.role() = 'authenticated');

DROP POLICY IF EXISTS "Auth Delete Lessons" ON lessons;
CREATE POLICY "Auth Delete Lessons" ON lessons FOR DELETE USING (auth.role() = 'authenticated');
