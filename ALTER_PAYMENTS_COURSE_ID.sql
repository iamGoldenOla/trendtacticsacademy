-- ======================================================================
-- MIGRATION: ALTER PAYMENTS COURSE_ID COLUMN TO TEXT
-- Ensure payments table course_id matches frontend slug course IDs
-- ======================================================================

-- 1. Create payments table if it doesn't exist
CREATE TABLE IF NOT EXISTS payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  transaction_ref TEXT UNIQUE NOT NULL,
  user_id UUID NOT NULL,
  course_id TEXT NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  currency TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('pending', 'completed', 'failed', 'refunded')),
  payment_method TEXT NOT NULL,
  customer_email TEXT,
  customer_name TEXT,
  raw_data JSONB,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- 2. Alter column type to TEXT if it was created as UUID
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'payments' 
          AND column_name = 'course_id' 
          AND data_type = 'uuid'
    ) THEN
        ALTER TABLE payments ALTER COLUMN course_id TYPE TEXT;
        RAISE NOTICE 'Successfully altered payments.course_id type from UUID to TEXT';
    END IF;
END $$;
