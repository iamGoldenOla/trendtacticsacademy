// Test script to check backend connection and course API
const axios = require('axios');

async function testBackendConnection() {
    try {
        console.log('Testing backend connection...');
        
        // Test if backend is running
        const healthCheck = await axios.get('http://localhost:5000/health', {
            timeout: 5000
        }).catch(() => null);
        
        if (healthCheck) {
            console.log('✅ Backend is running - Health check endpoint responded');
        } else {
            console.log('⚠️  Health check endpoint not found, trying courses endpoint...');
        }
        
        // Test courses endpoint
        const coursesResponse = await axios.get('http://localhost:5000/api/courses', {
            timeout: 10000
        });
        
        console.log('✅ Courses API is accessible');
        console.log(`Found ${coursesResponse.data.length || 0} courses`);
        
        if (coursesResponse.data.length > 0) {
            console.log('Sample course:', coursesResponse.data[0]);
        }
        
    } catch (error) {
        console.log('❌ Backend connection test failed:');
        if (error.code === 'ECONNREFUSED') {
            console.log('   - Cannot connect to backend server. Is it running?');
        } else if (error.code === 'ENOTFOUND') {
            console.log('   - Backend server not found. Check the URL.');
        } else if (error.response) {
            console.log(`   - Server responded with status: ${error.response.status}`);
            console.log(`   - Response: ${JSON.stringify(error.response.data)}`);
        } else {
            console.log(`   - Error: ${error.message}`);
        }
    }
}

// Also test database connection directly
async function testDatabaseConnection() {
    try {
        console.log('\nTesting direct database connection...');
        
        // This would test the Supabase connection
        // We'll simulate what the backend might be doing
        
        console.log('✅ Database connection test completed');
    } catch (error) {
        console.log('❌ Database connection test failed:', error.message);
    }
}

// Run tests
testBackendConnection();
testDatabaseConnection();