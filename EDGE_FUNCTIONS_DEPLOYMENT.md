# Supabase Edge Functions Deployment Guide

This guide explains how to deploy the Edge Functions and configure your Trendtactics Academy installation to use them.

## 1. Deploy the Edge Functions to Supabase

### Prerequisites
- Install Supabase CLI: `npm install -g supabase`
- Log in to your Supabase account: `supabase login`

### Deploy Functions
1. Navigate to your project directory:
   ```bash
   cd c:\Users\Akinola Olujobi\Documents\Trendtactics Academy
   ```

2. Deploy the functions:
   ```bash
   supabase functions deploy add-course-access --project-ref uimdbodamoeyukrghchb
   supabase functions deploy get-student-courses --project-ref uimdbodamoeyukrghchb
   ```

### Set Environment Variables in Supabase
1. Go to your Supabase Dashboard
2. Navigate to Settings → Environment Variables
3. Add these variables:
   - `SUPABASE_URL`: `https://uimdbodamoeyukrghchb.supabase.co`
   - `SUPABASE_SERVICE_ROLE_KEY`: Your actual service role key

## 2. Configure Edge Function Secrets

Since you mentioned the service key is in Edge Functions under secrets, you'll need to:

1. In your Supabase Dashboard, go to Settings → Secrets
2. Add your service role key as a secret with the key name `SUPABASE_SERVICE_ROLE_KEY`
3. Update the Edge Functions to use the secret instead of environment variables

### Update the Edge Functions to use secrets:

**supabase/functions/add-course-access/index.ts**:
```typescript
import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.0.0";

const supabaseUrl = "https://uimdbodamoeyukrghchb.supabase.co";
const supabaseServiceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const supabase = createClient(supabaseUrl, supabaseServiceRoleKey);

// ... rest of the function code
```

**supabase/functions/get-student-courses/index.ts**:
```typescript
import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.0.0";

const supabaseUrl = "https://uimdbodamoeyukrghchb.supabase.co";
const supabaseServiceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const supabase = createClient(supabaseUrl, supabaseServiceRoleKey);

// ... rest of the function code
```

## 3. Update Your Supabase Database RLS Policies

Make sure your RLS policies allow the service role key to perform the necessary operations:

1. Go to your Supabase Dashboard
2. Navigate to Database → Policies
3. Ensure the service role has permissions for:
   - `student_course_access` table: ALL operations
   - `courses` table: SELECT operations

## 4. Test the Functions

You can test the functions directly from the Supabase Dashboard:
1. Go to Database → Functions
2. Find your deployed functions
3. Use the "Test" button to verify they work correctly

## 5. Update CORS Settings

In your Supabase Dashboard:
1. Go to Settings → API
2. Add your domain to the CORS allowed origins:
   - `https://academy.trendtacticsdigital.com`
   - `http://localhost:3000` (for local development)

## 6. Verify the Frontend Integration

The frontend files have been updated to use the Edge Functions instead of the PHP API:
- `course-detail.html` - Uses Edge Functions for course enrollment
- `courses.html` - Uses Edge Functions to get student courses
- `prompt-engineering.html` - Uses Edge Functions for course enrollment
- Other course files - Updated similarly

## 7. Remove PHP API Files (Optional)

Once Edge Functions are working properly, you can remove the PHP API files:
- `api/add-course-access.php`
- `api/get-student-courses.php`
- Any other PHP API files that are replaced by Edge Functions

## 8. Troubleshooting

### Function Deployment Issues
- Ensure you have the Supabase CLI installed and logged in
- Check that your project reference ID is correct
- Verify your service role key has the necessary permissions

### CORS Errors
- Make sure CORS settings allow your domain
- Check browser console for specific CORS error messages

### Authentication Issues
- Verify the authorization header is being sent correctly
- Ensure the Supabase client is properly initialized

## 9. Security Best Practices

- Never expose your service role key in client-side code
- Use environment variables or secrets for sensitive data
- Regularly rotate your service role key
- Monitor your Edge Function logs for suspicious activity