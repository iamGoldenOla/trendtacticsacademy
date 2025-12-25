import { supabase } from './supabaseClient';

/**
 * Get the current user's profile
 */
export const getUserProfile = async () => {
    try {
        // Get current user from auth
        const { data: { user }, error: authError } = await supabase.auth.getUser();
        
        if (authError || !user) {
            throw new Error('User not authenticated');
        }
        
        // Get user profile from the users table
        const { data: profile, error: profileError } = await supabase
            .from('users')
            .select('*')
            .eq('id', user.id)
            .single();
        
        if (profileError) {
            // If no profile exists, return basic user info
            return {
                id: user.id,
                email: user.email,
                name: user.user_metadata?.name || user.email.split('@')[0],
                role: 'student',
                created_at: user.created_at,
                enrolled_courses: [],
            };
        }
        
        return profile;
    }
    catch (error) {
        console.error('Error fetching user profile:', error);
        return null;
    }
};

/**
 * Update the current user's profile
 */
export const updateUserProfile = async (userData) => {
    try {
        // Get current user from auth
        const { data: { user }, error: authError } = await supabase.auth.getUser();
        
        if (authError || !user) {
            throw new Error('User not authenticated');
        }
        
        // Update user profile in the database
        const { data: profile, error: profileError } = await supabase
            .from('users')
            .update({
                ...userData,
                updated_at: new Date().toISOString(),
            })
            .eq('id', user.id)
            .select()
            .single();
        
        if (profileError) {
            console.error('Error updating user profile:', profileError.message);
            throw new Error(profileError.message || 'Failed to update profile');
        }
        
        // Update user metadata in auth if needed
        if (userData.name) {
            const { error: metadataError } = await supabase.auth.updateUser({
                data: { name: userData.name }
            });
            
            if (metadataError) {
                console.error('Error updating user metadata:', metadataError);
                // Don't throw error here as profile was updated in DB
            }
        }
        
        // Update the user in localStorage
        const userJson = localStorage.getItem('user');
        if (userJson) {
            const currentUser = JSON.parse(userJson);
            const updatedUser = { ...currentUser, ...profile };
            localStorage.setItem('user', JSON.stringify(updatedUser));
        }
        
        return profile;
    }
    catch (error) {
        console.error('Error updating user profile:', error);
        throw new Error(error.message || 'Failed to update profile');
    }
};

/**
 * Update the current user's password
 */
export const updatePassword = async (currentPassword, newPassword) => {
    try {
        // Use Supabase's change password function
        const { error } = await supabase.auth.updateUser({
            password: newPassword,
        });
        
        if (error) {
            console.error('Error updating password:', error.message);
            throw new Error(error.message || 'Failed to update password');
        }
        
        return { success: true };
    }
    catch (error) {
        console.error('Error updating password:', error);
        throw new Error(error.message || 'Failed to update password');
    }
};

export default {
    getUserProfile,
    updateUserProfile,
    updatePassword,
};