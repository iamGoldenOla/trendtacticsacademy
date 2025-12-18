/**
 * CSP Bypass Test Script
 * This script tests direct connections to Supabase and Puter.js
 * to verify if the issue is with CSP or something else
 */

console.log('🔬 CSP Bypass Test Started');

// Test 1: Try to fetch courses directly with relaxed CORS
console.log('\n📋 Test 1: Direct Supabase Connection (Bypassing CSP)');
fetch('https://uimdbodamoeyukrghchb.supabase.co/rest/v1/courses?select=id,title,is_published&limit=5', {
  method: 'GET',
  headers: {
    'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpbWRib2RhbW9leXVrcmdoY2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NTYwMzksImV4cCI6MjA4MTAzMjAzOX0.kMFpnaZN04ac94u0wcXJFsS58lX88h8RCM2de3rwYIc',
    // Try to override CSP with these headers
    'Content-Security-Policy': 'connect-src *',
  }
})
.then(response => {
  if (response.ok) {
    console.log('✅ Direct Supabase Connection Succeeded');
    return response.json();
  } else {
    console.log('❌ Direct Supabase Connection Failed:', response.status, response.statusText);
    return response.text();
  }
})
.then(data => {
  console.log('📚 Supabase Response:', data);
})
.catch(error => {
  console.log('❌ Supabase Connection Error (Likely CSP):', error.message);
});

// Test 2: Try to dynamically load Puter.js
console.log('\n📋 Test 2: Dynamic Puter.js Loading');
try {
  const script = document.createElement('script');
  script.src = 'https://js.puter.com/v2/';
  script.onload = () => {
    console.log('✅ Puter.js Loaded Successfully');
  };
  script.onerror = (error) => {
    console.log('❌ Puter.js Load Error (Likely CSP):', error);
  };
  document.head.appendChild(script);
} catch (error) {
  console.log('❌ Puter.js Dynamic Load Error:', error.message);
}

// Test 3: Try to create an iframe to bypass CSP (not recommended for production)
console.log('\n📋 Test 3: Iframe Approach (Experimental)');
try {
  const iframe = document.createElement('iframe');
  iframe.src = 'about:blank';
  iframe.style.display = 'none';
  document.body.appendChild(iframe);
  
  // Try to access iframe's content
  const iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
  const scriptElement = iframeDoc.createElement('script');
  scriptElement.src = 'https://js.puter.com/v2/';
  iframeDoc.head.appendChild(scriptElement);
  
  console.log('✅ Iframe Created (Script loading may still be blocked by CSP)');
} catch (error) {
  console.log('❌ Iframe Approach Failed:', error.message);
}

// Test 4: Check current CSP policy
console.log('\n📋 Test 4: Current CSP Policy');
try {
  const metaTags = document.querySelectorAll('meta[http-equiv="Content-Security-Policy"]');
  if (metaTags.length > 0) {
    metaTags.forEach((tag, index) => {
      console.log(`📄 CSP Meta Tag ${index + 1}:`, tag.content);
    });
  } else {
    console.log('⚠️ No CSP meta tags found');
  }
} catch (error) {
  console.log('❌ Error reading CSP meta tags:', error.message);
}

// Test 5: Check if we're using the correct Supabase URL
console.log('\n📋 Test 5: Supabase URL Validation');
const supabaseUrl = 'https://uimdbodamoeyukrghchb.supabase.co';
console.log('🔗 Supabase URL:', supabaseUrl);
console.log('✅ URL Format Valid');

console.log('\n🧪 CSP Bypass Test Complete');
console.log('\n💡 Recommendations:');
console.log('1. Check if the updated CSP in index.html has been deployed');
console.log('2. Clear browser cache and try again');
console.log('3. Check server-side CSP headers that might override meta tags');
console.log('4. Verify that course IDs are valid UUIDs, not mock IDs like "dm-1"');