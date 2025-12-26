
const { createClient } = require('@supabase/supabase-js');

// Hardcoded from supabaseClient.js for debugging purposes
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

console.log('Testing Supabase Connection...');
console.log('URL:', supabaseUrl);

const supabase = createClient(supabaseUrl, supabaseKey);

async function testSignup() {
    const uniqueId = Date.now();
    const testEmail = `test_debug_${uniqueId}@example.com`;
    // Password must meet complexity requirements: 8+ chars, upper, lower, digit
    const testPassword = 'TestPassword123!';

    console.log(`\nAttempting signup for: ${testEmail}`);

    // Step 1: Auth Signup
    const { data, error } = await supabase.auth.signUp({
        email: testEmail,
        password: testPassword,
        options: {
            data: {
                name: 'Test Debug User',
                role: 'student'
            }
        }
    });

    if (error) {
        console.error('❌ SIGNUP AUTH FAILED');
        console.error('Error Message:', error.message);
        console.error('Error Code:', error.status || 'N/A');

        // Specific checks
        if (error.message.includes('rate limit')) console.log('-> Reason: Rate limit exceeded.');
        if (error.message.includes('confirm')) console.log('-> Reason: Email confirmation required?');
        return;
    }

    if (!data || !data.user) {
        console.error('❌ SIGNUP SUCCEEDED BUT NO USER RETURNED (Likely email confirmation enabled)');
        console.log('Session is:', data.session);
        return;
    }

    console.log('✅ Auth Signup Successful. User ID:', data.user.id);

    // Step 2: Profile Insert
    console.log('Attempting profile insert into public.users...');
    const { error: profileError } = await supabase
        .from('users')
        .insert({
            id: data.user.id,
            email: testEmail,
            name: 'Test Debug User',
            role: 'student',
            created_at: new Date().toISOString(),
            updated_at: new Date().toISOString(),
        });

    if (profileError) {
        console.error('❌ PROFILE INSERT FAILED');
        console.error('Error Message:', profileError.message);
        console.error('Error Details:', profileError.details);
        console.error('Error Code:', profileError.code);

        if (profileError.code === '42P01') console.log('-> Reason: Table "users" does not exist.');
        if (profileError.code === '42501') console.log('-> Reason: RLS Policy violation (Permission denied).');
        if (profileError.code === '23505') console.log('-> Reason: Duplicate key/Primary key violation.');
    } else {
        console.log('✅ Profile Insert Successful');
    }
}

testSignup();
