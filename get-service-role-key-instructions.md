# How to Get Your Supabase Service Role Key

To populate the lessons for your Vibe Coding course, we need your Supabase Service Role Key. This key has elevated privileges that can bypass row-level security policies.

## Steps to Get Your Service Role Key:

1. **Log into your Supabase Dashboard**
   - Go to https://app.supabase.com/
   - Sign in with your credentials

2. **Select Your Project**
   - Click on your project "trendtactics-academy" or whatever you named it

3. **Navigate to Project Settings**
   - In the left sidebar, scroll down to the bottom
   - Click on "Project Settings" (gear icon)

4. **Find API Settings**
   - In the Project Settings menu, click on "API"

5. **Locate Service Role Key**
   - Scroll down to the "Keys" section
   - You'll see two keys:
     - "anon" key (public, limited access)
     - "service_role" key (private, full access)
   - Copy the "service_role" key

6. **Update Your Environment Variables**
   - Create or update your `.env` file with:
     ```
     SUPABASE_SERVICE_ROLE_KEY=your_actual_service_role_key_here
     ```

## Alternative Method Using This Script:

Once you have the service role key, you can run this command in your terminal:

```bash
SUPABASE_SERVICE_ROLE_KEY=your_actual_service_role_key_here node populate-lessons-admin.js
```

## Windows PowerShell Command:

If you're using Windows PowerShell, use this command:

```powershell
$env:SUPABASE_SERVICE_ROLE_KEY="your_actual_service_role_key_here"; node populate-lessons-admin.js
```

Replace "your_actual_service_role_key_here" with your actual service role key.

After running this script with the correct service role key, your Vibe Coding course should appear on your website.