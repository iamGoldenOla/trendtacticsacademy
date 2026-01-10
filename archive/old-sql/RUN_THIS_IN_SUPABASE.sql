-- ==========================================
-- FIX FOR SIGNUP ISSUES & PREPARATION FOR VIBE CODING
-- Run this entire script in the Supabase SQL Editor
-- ==========================================

-- 1. Ensure 'users' table exists with correct columns
CREATE TABLE IF NOT EXISTS public.users (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  email TEXT,
  name TEXT,
  role TEXT DEFAULT 'student',
  avatar TEXT,
  bio TEXT,
  location TEXT,
  website TEXT,
  enrolled_courses JSONB DEFAULT '[]'::jsonb,
  badges JSONB DEFAULT '[]'::jsonb,
  dashboard_preferences JSONB DEFAULT '{}'::jsonb,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Enable Row Level Security (RLS)
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

-- 3. Fix RLS Policies for 'users'
-- First, drop existing policies to avoid conflicts
DROP POLICY IF EXISTS "Enable insert for users based on user_id" ON public.users;
DROP POLICY IF EXISTS "Enable read access for all users" ON public.users;
DROP POLICY IF EXISTS "Enable update for users based on user_id" ON public.users;
DROP POLICY IF EXISTS "Users can insert their own profile" ON public.users;
DROP POLICY IF EXISTS "Users can view their own profile" ON public.users;
DROP POLICY IF EXISTS "Users can update their own profile" ON public.users;

-- Policy: Allow users to insert their own profile
CREATE POLICY "Users can insert their own profile" ON public.users
FOR INSERT WITH CHECK (auth.uid() = id);

-- Policy: Allow users to view their own profile (and potentially others if public profiles are needed)
-- For now, let's allow users to see any profile (useful for 'Collaborators' feature in whiteboard)
CREATE POLICY "Users can view all profiles" ON public.users
FOR SELECT USING (true); 

-- Policy: Allow users to update ONLY their own profile
CREATE POLICY "Users can update their own profile" ON public.users
FOR UPDATE USING (auth.uid() = id);

-- 4. Prepare 'lessons' table for Vibe Coding (JSON content)
ALTER TABLE public.lessons ADD COLUMN IF NOT EXISTS lesson_json JSONB;

-- 5. Prepare 'courses' table if not already correct
ALTER TABLE public.courses ADD COLUMN IF NOT EXISTS featured BOOLEAN DEFAULT false;

-- 6. Grant permissions (just in case)
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL ROUTINES IN SCHEMA public TO anon, authenticated;

