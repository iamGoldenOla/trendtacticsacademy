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
        window.location.href = '/';
    },

    // Redirect to signup if not logged in
    async requireAuth() {
        const loggedIn = await this.isLoggedIn();
        if (!loggedIn) {
            window.location.href = '/signup.html?redirect=' + encodeURIComponent(window.location.pathname);
            return false;
        }
        return true;
    }
};

// Export
window.Auth = Auth;
