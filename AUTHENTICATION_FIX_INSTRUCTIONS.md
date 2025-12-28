# Authentication Fix Instructions

## Issue Description
The authentication system was failing because the Supabase Anon Key was not properly configured on the deployed site. The frontend expected `window.__ENV__?.SUPABASE_ANON_KEY` to be available, but this environment variable was not being injected into the HTML files on the deployed site.

## Solution Implemented
I have updated all HTML files that use authentication to include the Supabase environment variable configuration:

- signup.html
- login.html
- index.html
- course-detail.html
- dashboard.html
- courses.html
- lesson-viewer.html
- forgot-password.html
- about.html
- contact.html
- services.html

Each file now includes the following script in the `<head>` section with your actual Supabase Anon Key:
```html
<script>
    // Supabase configuration - your actual Supabase key
    window.__ENV__ = {
        SUPABASE_ANON_KEY: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc'
    };
</script>
```

## How to Complete the Fix

### 1. Get Your Supabase Anon Key
1. Go to your Supabase dashboard at [supabase.com](https://supabase.com)
2. Select your project
3. Navigate to "Project Settings" → "API"
4. Copy the "anon key" (it starts with `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`)

### 2. Update the HTML Files
All HTML files have been updated with your Supabase Anon Key. The key has been automatically added to all required HTML files.

### 3. Alternative: Server-Side Environment Injection
For better security, consider implementing server-side environment variable injection instead of hardcoding the key in HTML files. This can be done through:

- Server-side rendering that injects the environment variables
- Build-time variable replacement
- A configuration endpoint that securely provides the necessary keys

## Testing the Fix
After updating the Supabase Anon Key:

1. Clear your browser cache (Ctrl+Shift+R or Cmd+Shift+R)
2. Try signing up with a new user account
3. The signup should now work without errors
4. Try logging in with an existing account
5. Verify that you can access protected pages after login

## Security Note
⚠️ **Important**: The Supabase Anon Key is safe to use in client-side applications as it has limited permissions, but it should still be treated carefully. Do not confuse it with the Service Role Key, which should never be exposed in client-side code.

## Additional Troubleshooting
If authentication is still not working after the fix:

1. Check browser console for any error messages
2. Verify that your Supabase project has email authentication enabled
3. Ensure that your Supabase project allows requests from your domain
4. Check that Row Level Security (RLS) policies are properly configured if you're using them

## Files Updated
The following files were modified to include the Supabase environment variable:
- signup.html
- login.html
- index.html
- course-detail.html
- dashboard.html
- courses.html
- lesson-viewer.html
- forgot-password.html
- about.html
- contact.html
- services.html