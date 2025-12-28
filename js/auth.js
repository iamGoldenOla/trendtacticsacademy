// Authentication utilities for all pages
const Auth = {
    // Check if user is logged in
    async isLoggedIn() {
        // Check for session in localStorage
        const session = localStorage.getItem('supabase_session');
        return !!session;
    },

    // Get current user
    async getCurrentUser() {
        // Check for session in localStorage
        const session = localStorage.getItem('supabase_session');
        if (!session) return null;
        
        try {
            // Get user info from localStorage or a server endpoint
            const userData = localStorage.getItem('supabase_user');
            if (userData) {
                return JSON.parse(userData);
            }
            return null;
        } catch (error) {
            console.error('Error getting current user:', error);
            return null;
        }
    },

    // Logout
    async logout() {
        // Clear stored session and user data
        localStorage.removeItem('supabase_session');
        localStorage.removeItem('supabase_user');
        window.location.href = './index.html';
    },

    // Redirect to signup if not logged in
    async requireAuth() {
        const loggedIn = await this.isLoggedIn();
        if (!loggedIn) {
            window.location.href = './signup.html?redirect=' + encodeURIComponent(window.location.pathname);
            return false;
        }
        return true;
    }
};

// Scroll to top when page loads
window.addEventListener('load', function() {
    window.scrollTo(0, 0);
});

// Scroll to top when navigation occurs
window.addEventListener('beforeunload', function() {
    window.scrollTo(0, 0);
});

// Export
window.Auth = Auth;
