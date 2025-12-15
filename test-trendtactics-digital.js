// Test script for Trendtactics Digital Supabase connection
const { createClient } = require('@supabase/supabase-js');

// Trendtactics Digital Supabase credentials
const supabaseUrl = 'https://wtgwxnhnqdnbzpetltrt.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind0Z3d4bmhucWRuYnpwZXRsdHJ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUwNjQ2NjUsImV4cCI6MjA4MDY0MDY2NX0.3eblmq4lsnDQU33M9XqZpBqux9bi9hX2G0yUuPScHJA';

// Create Supabase client
const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function testConnection() {
    try {
        console.log('Testing connection to Trendtactics Digital Supabase...');
        
        // Test database connection by querying a common table
        // This will likely fail due to permissions but will confirm connectivity
        const { data, error } = await supabase
            .from('users')
            .select('count')
            .limit(1);
            
        if (error) {
            // Expected error for anon key access or table not found
            if (error.message.includes('permission denied') || 
                error.message.includes('not found') ||
                error.message.includes('_relation "users" does not exist_')) {
                console.log('✅ Database connection successful (limited access with anon key)');
                console.log('Note: This is expected as anonymous users have limited table access');
            } else {
                console.error('Database Error:', error.message);
                return;
            }
        } else {
            console.log('✅ Database connection successful');
            console.log('Sample data:', data);
        }
        
        console.log('\n📝 Connection Details:');
        console.log('URL:', supabaseUrl);
        console.log('Key Type: Anonymous (Public)');
        
        console.log('\n🎉 Connection test completed! The credentials are valid.');
        
    } catch (err) {
        console.error('❌ Unexpected error:', err.message);
    }
}

// Run the test
testConnection();