# Advanced Signup Troubleshooting

## Current RLS Policy Status
Based on your query results, all required RLS policies are properly configured:
- ✅ Service Role can insert users - CORRECTLY CONFIGURED
- ✅ Service Role can select users - CORRECTLY CONFIGURED  
- ✅ Service Role can update users - CORRECTLY CONFIGURED
- ✅ Users can update their own data - CORRECTLY CONFIGURED
- ✅ Users can view their own data - CORRECTLY CONFIGURED

## Alternative Issues to Check

Since RLS policies are correctly configured, the signup issue likely stems from other areas:

### 1. Supabase Auth Settings
Check your Supabase Dashboard Authentication Settings:
- Navigate to Authentication > Settings
- Ensure "Enable email sign-ups" is turned ON
- Check that email templates are properly configured
- Verify that "Secure email change" settings are not blocking new signups

### 2. Service Role Key Usage
The issue might be in how the service role key is being used in your application:

```typescript
// In src/utils/supabase.js, verify the service role client is properly configured:
const supabaseUrl = process.env.SUPABASE_URL || '';
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY || '';

// The service role client should use the service role key for authentication
exports.supabaseAdmin = (0, supabase_js_1.createClient)(supabaseUrl, supabaseServiceRoleKey);
```

### 3. Supabase Auth User Creation vs Database User Creation
The error might be occurring during the database user creation step after the auth user is created. Let me check the signup flow:

1. Supabase Auth creates the user (this should work with proper auth settings)
2. Application tries to create a corresponding record in the public.users table (this uses the service role client)

### 4. Debug the Specific Error Location
The error "new row violates row-level security policy for table 'users'" is happening in:
`src/utils/supabaseModels.js:46:19`

This is likely in the User.create method. The issue might be that the service role key is not being properly used or authenticated when making the database call.

### 5. Potential Solutions

#### Solution A: Verify Service Role Key in Environment
Make sure your SUPABASE_SERVICE_ROLE_KEY is correctly set in your environment variables and is the actual service role key (not the anon key).

#### Solution B: Check Supabase Client Authentication
Verify that when the supabaseAdmin client makes the insert call, it's properly authenticated as the service role.

#### Solution C: Test Direct Database Insert
Try running this test directly in your Supabase SQL Editor:
```sql
INSERT INTO public.users (id, name, email, role, dashboard_preferences) 
VALUES ('test-id', 'Test User', 'test@example.com', 'student', '{}');
```

#### Solution D: Check for Other Constraints
The error might be from a different constraint (not RLS). Check if there are:
- Unique constraints on email
- Check constraints on role values
- Foreign key constraints
- Other triggers that might be causing issues

### 6. Enhanced Debugging Steps

1. **Check the actual error in detail** - The error might not be RLS-related but another constraint
2. **Verify the service role key permissions** in Supabase dashboard
3. **Test the Supabase client connection** directly in a test script
4. **Check for any database triggers** that might interfere with inserts

### 7. Test Script for Service Role Access
Create this test to verify service role permissions:

```javascript
// test-service-role.js
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

const supabase = createClient(supabaseUrl, supabaseServiceRoleKey);

async function testServiceRoleInsert() {
  try {
    // Test if service role can insert
    const { data, error } = await supabase
      .from('users')
      .insert([{
        id: 'test-' + Date.now(),
        name: 'Test User',
        email: `test${Date.now()}@example.com`,
        role: 'student',
        dashboard_preferences: {}
      }])
      .select();

    if (error) {
      console.error('Service role insert failed:', error);
      return false;
    }

    console.log('Service role insert successful:', data);
    return true;
  } catch (err) {
    console.error('Service role test error:', err);
    return false;
  }
}

testServiceRoleInsert().then(result => {
  console.log('Service role test result:', result);
});
```

Run this script to verify if the service role key has proper insert permissions.