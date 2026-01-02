# Deployment Configuration Guide

This guide explains how to properly configure your Trendtactics Academy installation after deployment.

## 1. Configure Supabase Service Role Key for Edge Functions

The service role key is required for course enrollment functionality but is not included in the repository for security reasons. The course enrollment functionality now uses Supabase Edge Functions instead of PHP API.

### Option A: Using Supabase Edge Function Secrets (Recommended)
1. **In your Supabase Dashboard:**
   - Go to Settings → Secrets
   - Add a new secret:
     - Key: `SUPABASE_SERVICE_ROLE_KEY`
     - Value: Your actual Supabase Service Role Key

### Option B: Direct Configuration (Less Secure)
1. Download the code to your server
2. Edit `api/config.php` on your server (NOT in the repository)
3. Find the line with `define('SUPABASE_SERVICE_ROLE_KEY', '');`
4. Replace the empty string with your actual service role key
5. **Important:** Do not upload this change back to the repository

## 2. Supabase Service Role Key Location

To get your Service Role Key:
1. Go to your Supabase project dashboard
2. Navigate to Settings → API
3. Copy the "Service Role Key" (not the anon key)
4. Use this key in the configuration above

## 3. Deploy Supabase Edge Functions

To use the new Edge Functions architecture:
1. Install Supabase CLI: `npm install -g supabase`
2. Log in to your Supabase account: `supabase login`
3. Deploy the functions:
   ```bash
   supabase functions deploy add-course-access --project-ref your-project-id
   supabase functions deploy get-student-courses --project-ref your-project-id
   ```

## 4. YouTube Video Playback

The Content Security Policy has been configured to allow YouTube embeds. If videos still don't play:

1. Ensure your server supports the `mod_headers` Apache module
2. Verify the .htaccess file is in your web root directory
3. Check that your hosting provider allows YouTube embedding

## 5. Security Best Practices

- Never commit your actual service role key to any repository
- Use Edge Function secrets when possible
- Regularly rotate your service role key
- Monitor your Supabase project for unauthorized access

## 6. Troubleshooting

### Enrollment Error Persists
- Verify the Edge Functions are properly deployed to Supabase
- Check that your service role key is correctly configured in Edge Function secrets
- Ensure the `student_course_access` table exists in your database
- Confirm CORS settings allow your domain

### YouTube Videos Still Not Working
- Check browser console for CSP errors
- Verify your hosting provider doesn't block YouTube embeds
- Confirm .htaccess file is active (test by temporarily adding an invalid directive)

## 7. Verification Steps

After configuration:
1. Test course enrollment with a new user
2. Verify YouTube videos play in lesson content
3. Check that all interactive features work properly
4. Confirm no security warnings appear in browser console