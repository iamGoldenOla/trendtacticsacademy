# Supabase Components Explained

## How Environment Variables, Functions, and Secrets Work Together

### 1. Environment Variables
These are configuration settings that your application needs but aren't sensitive.

**Setting in Supabase Dashboard:**
```
Settings > Configuration > Environment Variables
```

**Examples:**
```env
SITE_NAME=Trendtactics Academy
SUPPORT_EMAIL=support@trendtactics.com
FRONTEND_URL=https://trendtactics.com
```

### 2. Database Functions (SQL Functions)
These are PostgreSQL functions that run directly in the database.

**Creating a Database Function:**
```sql
-- In Supabase SQL Editor
CREATE OR REPLACE FUNCTION get_user_course_count(user_id UUID)
RETURNS INTEGER AS $$
BEGIN
  RETURN (
    SELECT COUNT(*)
    FROM enrollments
    WHERE enrollments.user_id = $1
  );
END;
$$ LANGUAGE plpgsql;
```

**Using in your backend:**
```javascript
const { data, error } = await supabase.rpc('get_user_course_count', { user_id: userId });
```

### 3. Edge Functions
These are serverless JavaScript/TypeScript functions that run globally.

**Creating an Edge Function (supabase/functions/send-welcome-email/index.ts):**
```typescript
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

serve(async (req) => {
  const supabase = createClient(
    Deno.env.get('SUPABASE_URL') ?? '',
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
  );

  const { email, name } = await req.json();

  // Send welcome email using a secret
  const apiKey = Deno.env.get('SENDGRID_API_KEY');
  
  // Implementation here...
  
  return new Response(JSON.stringify({ success: true }), {
    headers: { "Content-Type": "application/json" },
  });
});
```

**Deploying Edge Functions:**
```bash
supabase functions deploy send-welcome-email
```

### 4. Secrets
These are sensitive values that are securely stored and injected into functions.

**Setting Secrets:**
```bash
supabase secrets set SENDGRID_API_KEY=SG.xxxxx
supabase secrets set STRIPE_SECRET_KEY=sk_test_xxxx
```

**Using Secrets in Edge Functions:**
```typescript
// The secret is automatically available as an environment variable
const sendgridKey = Deno.env.get('SENDGRID_API_KEY');
```

## Practical Example for Trendtactics Academy

### 1. Environment Variables Setup
In Supabase Dashboard:
```
Settings > Configuration > Environment Variables

SITE_NAME=Trendtactics Academy
SUPPORT_EMAIL=support@trendtactics.com
FRONTEND_URL=https://trendtactics.com
```

### 2. Secrets Setup
Via Supabase CLI:
```bash
supabase secrets set \
  SENDGRID_API_KEY=SG.your-sendgrid-key \
  STRIPE_SECRET_KEY=sk_test_your-stripe-key \
  ADMIN_EMAIL=admin@trendtactics.com
```

### 3. Database Function for Analytics
```sql
CREATE OR REPLACE FUNCTION get_user_learning_stats(user_id UUID)
RETURNS TABLE(
  total_courses BIGINT,
  completed_courses BIGINT,
  avg_progress NUMERIC
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    COUNT(*) as total_courses,
    COUNT(CASE WHEN progress = 100 THEN 1 END) as completed_courses,
    COALESCE(ROUND(AVG(progress), 2), 0) as avg_progress
  FROM enrollments
  WHERE enrollments.user_id = $1;
END;
$$ LANGUAGE plpgsql;
```

### 4. Edge Function for Payment Processing
```typescript
// supabase/functions/process-payment/index.ts
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import Stripe from "https://esm.sh/stripe?target=deno&no-check";

serve(async (req) => {
  // Access environment variables
  const siteName = Deno.env.get('SITE_NAME'); // From ENV vars
  
  // Access secrets
  const stripeKey = Deno.env.get('STRIPE_SECRET_KEY'); // From Secrets
  const stripe = Stripe(stripeKey);
  
  const { amount, userId } = await req.json();
  
  try {
    const paymentIntent = await stripe.paymentIntents.create({
      amount: amount,
      currency: 'usd',
      metadata: { userId }
    });
    
    return new Response(JSON.stringify({
      success: true,
      clientSecret: paymentIntent.client_secret
    }), {
      headers: { "Content-Type": "application/json" },
    });
  } catch (error) {
    return new Response(JSON.stringify({
      success: false,
      error: error.message
    }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
});
```

## Summary

| Component | Purpose | Sensitivity | Access Method |
|-----------|---------|-------------|---------------|
| Environment Variables | Configuration settings | Low-Medium | `Deno.env.get()` or process.env |
| Database Functions | SQL logic in database | Low | SQL queries or `.rpc()` |
| Edge Functions | Serverless endpoints | Low-Medium | HTTP requests |
| Secrets | Sensitive credentials | High | `Deno.env.get()` in functions |

## Best Practices

1. **Use Environment Variables** for non-sensitive configuration
2. **Use Secrets** for API keys, passwords, and sensitive tokens
3. **Use Database Functions** for complex data operations
4. **Use Edge Functions** for custom APIs and integrations

The key distinction is that **secrets are specifically for sensitive data**, while **environment variables are for general configuration**.