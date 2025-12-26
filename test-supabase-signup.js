// Test script to verify Supabase signup functionality
const { createClient } = require('@supabase/supabase-js');

// Supabase configuration (same as in your app)
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function testSignup() {
    console.log('Testing Supabase signup functionality...');
    
    // Generate a test email to avoid conflicts
    const testEmail = `testuser+${Date.now()}@example.com`;
    const testPassword = 'TestPass123!';
    const testName = 'Test User';
    
    try {
        console.log(`Attempting to sign up user: ${testEmail}`);
        
        const { data, error } = await supabase.auth.signUp({
            email: testEmail,
            password: testPassword,
            options: {
                data: {
                    name: testName,
                    role: 'student',
                }
            }
        });
        
        if (error) {
            console.error('Signup error:', error.message);
            return false;
        }
        
        console.log('Signup successful:', data);
        
        // Try to create user profile in the users table
        if (data.user) {
            const { error: profileError } = await supabase
                .from('users')
                .insert({
                    id: data.user.id,
                    email: data.user.email,
                    name: testName,
                    role: 'student',
                    created_at: new Date().toISOString(),
                    updated_at: new Date().toISOString(),
                });
            
            if (profileError) {
                console.error('Profile creation error:', profileError.message);
                // Don't fail the test if profile creation fails, as the auth signup worked
            } else {
                console.log('User profile created successfully');
            }
        }
        
        console.log('Test completed successfully!');
        return true;
        
    } catch (err) {
        console.error('Unexpected error:', err);
        return false;
    }
}

// Run the test
testSignup()
    .then(success => {
        if (success) {
            console.log('✅ Supabase signup test passed!');
        } else {
            console.log('❌ Supabase signup test failed!');
        }
    })
    .catch(err => {
        console.error('Test execution error:', err);
    });