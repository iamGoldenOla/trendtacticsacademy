// Debug script to understand what the frontend is requesting
// This simulates what might be happening in the frontend

const axios = require('axios');

async function debugFrontendRequests() {
    console.log('🔍 Debugging frontend course requests...\n');
    
    // Common API endpoints the frontend might be using
    const endpoints = [
        'http://localhost:5000/api/courses',
        'http://localhost:5000/api/courses/published',
        'http://localhost:5000/api/course-catalog',
        'http://localhost:5000/courses',
        'http://localhost:3000/api/courses' // Sometimes frontend proxies to backend
    ];
    
    for (const endpoint of endpoints) {
        try {
            console.log(`Testing endpoint: ${endpoint}`);
            const response = await axios.get(endpoint, {
                timeout: 5000,
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            });
            
            console.log(`✅ Success! Status: ${response.status}`);
            console.log(`   Found ${Array.isArray(response.data) ? response.data.length : 'unknown'} items`);
            
            if (Array.isArray(response.data) && response.data.length > 0) {
                console.log(`   Sample item keys: ${Object.keys(response.data[0]).join(', ')}`);
            }
            
            console.log('---\n');
        } catch (error) {
            if (error.response) {
                console.log(`⚠️  Status ${error.response.status}: ${error.response.statusText}`);
                if (error.response.data) {
                    console.log(`   Response: ${JSON.stringify(error.response.data).substring(0, 100)}...`);
                }
            } else if (error.code === 'ECONNREFUSED') {
                console.log('❌ Connection refused - server not running');
            } else if (error.code === 'ENOTFOUND') {
                console.log('❌ Endpoint not found');
            } else {
                console.log(`❌ Error: ${error.message}`);
            }
            console.log('---\n');
        }
    }
}

// Test database query directly
async function testDirectDatabaseQuery() {
    console.log('🧪 Testing direct database query simulation...\n');
    
    // This would be similar to what we did with SQL queries
    console.log('From our previous SQL queries, we know:');
    console.log('- There are 10 published courses in the database');
    console.log('- They are properly categorized');
    console.log('- All have is_published = true');
    console.log('- No constraint violations');
    
    console.log('\nIf the frontend still shows 0 courses, the issue might be:');
    console.log('1. Backend API not returning the data in expected format');
    console.log('2. Frontend making requests to wrong endpoint');
    console.log('3. CORS issues between frontend and backend');
    console.log('4. Authentication/authorization issues');
}

debugFrontendRequests();
testDirectDatabaseQuery();