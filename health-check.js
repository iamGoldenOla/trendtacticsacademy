// Health check script for Trendtactics Academy
async function runHealthCheck() {
    console.log('🔍 Starting Trendtactics Academy Health Check...');
    
    // Check if Supabase client is available
    console.log('📡 Checking Supabase client...');
    if (typeof window.supabaseClient !== 'undefined') {
        console.log('✅ Supabase client is available');
        
        try {
            // Check authentication status
            console.log('🔐 Checking authentication status...');
            const isLoggedIn = await Auth.isLoggedIn();
            if (isLoggedIn) {
                console.log('✅ User is authenticated');
                const user = await Auth.getCurrentUser();
                console.log(`👤 Authenticated user: ${user?.email || 'Unknown'}`);
            } else {
                console.log('🔓 User is not authenticated (this may be normal)');
            }
        } catch (error) {
            console.error('❌ Error checking authentication:', error);
        }
    } else {
        console.log('❌ Supabase client is not available');
    }
    
    // Check if Auth utility is available
    console.log('🔑 Checking Auth utility...');
    if (typeof window.Auth !== 'undefined') {
        console.log('✅ Auth utility is available');
    } else {
        console.error('❌ Auth utility is not available');
    }
    
    console.log('✅ Health check completed!');
}

// Run the health check when the page loads
document.addEventListener('DOMContentLoaded', function() {
    // Small delay to ensure everything is loaded
    setTimeout(runHealthCheck, 1000);
});