/**
 * Test Supabase connectivity
 */

const SUPABASE_URL = 'https://uimdbodamoeyukrghchb.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc';

async function testConnectivity() {
    console.log('🔍 Testing Supabase Connectivity\n');

    try {
        // Test 1: Basic fetch to Supabase REST API
        console.log('1. Testing basic REST API access...');
        const response = await fetch(`${SUPABASE_URL}/rest/v1/`, {
            method: 'GET',
            headers: {
                'apikey': SUPABASE_KEY,
                'Authorization': `Bearer ${SUPABASE_KEY}`
            }
        });

        if (response.ok) {
            console.log('✅ REST API accessible');
        } else {
            console.log(`❌ REST API returned ${response.status}: ${response.statusText}`);
        }

        // Test 2: Try to access courses table
        console.log('\n2. Testing courses table access...');
        const coursesResponse = await fetch(`${SUPABASE_URL}/rest/v1/courses?select=*&limit=1`, {
            method: 'GET',
            headers: {
                'apikey': SUPABASE_KEY,
                'Authorization': `Bearer ${SUPABASE_KEY}`,
                'Content-Type': 'application/json'
            }
        });

        if (coursesResponse.ok) {
            const data = await coursesResponse.json();
            console.log('✅ Courses table accessible');
            console.log(`   Found ${data.length} courses`);
        } else {
            console.log(`❌ Courses table error: ${coursesResponse.status} ${coursesResponse.statusText}`);
        }

        // Test 3: Test Supabase JS client
        console.log('\n3. Testing Supabase JS client...');
        const { createClient } = await import('https://esm.sh/@supabase/supabase-js@2');
        const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

        const { data, error } = await supabase
            .from('courses')
            .select('*')
            .limit(1);

        if (error) {
            console.log(`❌ Supabase client error: ${error.message}`);
        } else {
            console.log('✅ Supabase client working');
            console.log(`   Retrieved ${data.length} courses`);
        }

    } catch (error) {
        console.log(`❌ Connectivity test failed: ${error.message}`);
        if (error.message.includes('ERR_NAME_NOT_RESOLVED')) {
            console.log('\n🔍 DNS Resolution Issue Detected');
            console.log('This suggests the Supabase project may be:');
            console.log('• Paused due to inactivity');
            console.log('• Suspended due to billing issues');
            console.log('• Deleted');
            console.log('• Regionally restricted');
        }
    }
}

// Run the test
testConnectivity();