// Authentication utilities for all pages
const Auth = {
    // Check if user is logged in
    async isLoggedIn() {
        const { data: { session } } = await window.sbClient.auth.getSession();
        return !!session;
    },

    // Get current user
    async getCurrentUser() {
        const { data: { session } } = await window.sbClient.auth.getSession();
        if (!session) return null;

        const { data: { user } } = await window.sbClient.auth.getUser();
        if (!user) return null;

        // Get profile from users table
        const { data: profile } = await window.sbClient
            .from('users')
            .select('*')
            .eq('id', user.id)
            .single();

        return {
            ...user,
            ...profile
        };
    },

    // Logout
    async logout() {
        await window.sbClient.auth.signOut();
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
