// Simple redirect script to ensure users are directed to the new dashboard
(function() {
    'use strict';
    
    // Check if we're on the old dashboard page
    if (window.location.pathname === '/dashboard' || window.location.pathname === '/dashboard/') {
        // Redirect to the new dashboard
        window.location.replace('/new-dashboard');
    }
})();