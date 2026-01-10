// Authentication utilities for all pages
const Auth = {
    // Check if user is logged in
    async isLoggedIn() {
        try {
            // First check if Supabase client is available
            if (!window.supabaseClient) {
                console.error('Supabase client not initialized');
                return false;
            }
            
            // Get session from Supabase auth
            const { data: { session }, error } = await window.supabaseClient.auth.getSession();
            
            if (error) {
                console.error('Error getting session:', error.message);
                return false;
            }
            
            // Return true if session exists and is not expired
            return !!(session && new Date(session.expires_at * 1000) > new Date());
        } catch (error) {
            console.error('Error checking authentication status:', error);
            return false;
        }
    },

    // Get current user
    async getCurrentUser() {
        try {
            if (!window.supabaseClient) {
                console.error('Supabase client not initialized');
                return null;
            }
            
            const { data: { user }, error } = await window.supabaseClient.auth.getUser();
            
            if (error) {
                console.error('Error getting user:', error.message);
                return null;
            }
            
            return user;
        } catch (error) {
            console.error('Error getting current user:', error);
            return null;
        }
    },

    // Logout
    async logout() {
        try {
            if (window.supabaseClient) {
                const { error } = await window.supabaseClient.auth.signOut();
                if (error) {
                    console.error('Error signing out:', error.message);
                }
            }
            
            // Clear stored session and user data
            localStorage.removeItem('supabase_session');
            localStorage.removeItem('supabase_user');
            
            // Redirect to home
            window.location.href = '/';
        } catch (error) {
            console.error('Error during logout:', error);
            // Fallback redirect
            window.location.href = '/';
        }
    },

    // Redirect to signup if not logged in
    async requireAuth() {
        const loggedIn = await this.isLoggedIn();
        if (!loggedIn) {
            window.location.replace('/signup');
            return false;
        }
        return true;
    },
    
    // Redirect to dashboard after login
    redirectToDashboard() {
        window.location.href = '/new-dashboard';
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
