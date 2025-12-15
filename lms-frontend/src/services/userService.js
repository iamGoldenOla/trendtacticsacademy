import { get, put } from "./api";

const USER_ENDPOINTS = {
    GET_PROFILE: '/users/profile',
    UPDATE_PROFILE: '/users/profile',
    UPDATE_PASSWORD: '/users/password',
};

/**
 * Get the current user's profile
 */
export const getUserProfile = async () => {
    try {
        const response = await get(USER_ENDPOINTS.GET_PROFILE);
        if (response.success && response.data) {
            return response.data;
        }
        return null;
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
        const response = await put(USER_ENDPOINTS.UPDATE_PROFILE, userData);
        if (response.success && response.data) {
            // Update the user in localStorage
            const userJson = localStorage.getItem('user');
            if (userJson) {
                const currentUser = JSON.parse(userJson);
                const updatedUser = { ...currentUser, ...response.data };
                localStorage.setItem('user', JSON.stringify(updatedUser));
            }
            return response.data;
        }
        return null;
    }
    catch (error) {
        console.error('Error updating user profile:', error);
        throw new Error(error.response?.data?.message || error.message || 'Failed to update profile');
    }
};

/**
 * Update the current user's password
 */
export const updatePassword = async (currentPassword, newPassword) => {
    try {
        const response = await put(USER_ENDPOINTS.UPDATE_PASSWORD, {
            currentPassword,
            newPassword,
        });
        return response.success;
    }
    catch (error) {
        console.error('Error updating password:', error);
        throw new Error(error.response?.data?.message || error.message || 'Failed to update password');
    }
};

export default {
    getUserProfile,
    updateUserProfile,
    updatePassword,
};