import { post, get } from "./api";

const AUTH_ENDPOINTS = {
    LOGIN: '/auth/login',
    SIGNUP: '/auth/register',
    LOGOUT: '/auth/logout',
    CURRENT_USER: '/auth/profile',
};

/**
 * Login a user with email and password
 */
export const login = async (credentials) => {
    try {
        if (!credentials.email || !credentials.password) {
            throw new Error('Email and password are required');
        }
        const response = await post(AUTH_ENDPOINTS.LOGIN, credentials);
        if (!response || !response.token) {
            throw new Error('Invalid response from server: Missing token');
        }
        const { token, ...user } = response;
        if (!user._id || !user.email) {
            throw new Error('Invalid user data received from server');
        }
        // Merge with defaults for missing fields
        const completeUser = {
            _id: user._id,
            name: user.name || '',
            email: user.email,
            role: user.role || 'student',
            avatar: user.avatar || '',
            bio: user.bio || '',
            location: user.location || '',
            website: user.website || '',
            enrolledCourses: user.enrolledCourses || [],
            createdAt: user.createdAt || new Date().toISOString(),
            updatedAt: user.updatedAt || new Date().toISOString(),
            badges: user.badges || [],
            dashboardPreferences: user.dashboardPreferences || {},
        };
        // Store token and user in localStorage
        localStorage.setItem('token', token);
        localStorage.setItem('user', JSON.stringify(completeUser));
        return { token, user: completeUser };
    }
    catch (error) {
        console.error('Login error:', error);
        throw new Error(error.message || 'Login failed. Please try again.');
    }
};

/**
 * Register a new user
 */
export const signup = async (userData) => {
    try {
        // Validate required fields
        if (!userData.name || !userData.email || !userData.password) {
            throw new Error('Name, email, and password are required');
        }
        // Validate email format
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(userData.email)) {
            throw new Error('Invalid email format');
        }
        // Validate password strength
        if (userData.password.length < 8) {
            throw new Error('Password must be at least 8 characters long');
        }
        const response = await post(AUTH_ENDPOINTS.SIGNUP, userData);
        if (!response || !response.token) {
            throw new Error('Invalid response from server: Missing token');
        }
        const { token, ...user } = response;
        if (!user._id || !user.email) {
            throw new Error('Invalid user data received from server');
        }
        // Merge with defaults for missing fields
        const completeUser = {
            _id: user._id,
            name: user.name || userData.name || '',
            email: user.email,
            role: user.role || 'student',
            avatar: user.avatar || '',
            bio: user.bio || '',
            location: user.location || '',
            website: user.website || '',
            enrolledCourses: user.enrolledCourses || [],
            createdAt: user.createdAt || new Date().toISOString(),
            updatedAt: user.updatedAt || new Date().toISOString(),
            badges: user.badges || [],
            dashboardPreferences: user.dashboardPreferences || {},
        };
        // Store token and user in localStorage
        localStorage.setItem('token', token);
        localStorage.setItem('user', JSON.stringify(completeUser));
        return { token, user: completeUser };
    }
    catch (error) {
        console.error('Signup error:', error);
        throw new Error(error.message || 'Signup failed. Please try again.');
    }
};

/**
 * Logout the current user
 */
export const logout = async () => {
    try {
        // Clear token and user from localStorage
        localStorage.removeItem('token');
        localStorage.removeItem('user');
        // Call logout endpoint
        await post(AUTH_ENDPOINTS.LOGOUT);
    }
    catch (error) {
        console.error('Logout error:', error);
        // Still clear local storage even if API call fails
        localStorage.removeItem('token');
        localStorage.removeItem('user');
    }
};

/**
 * Get the current logged in user
 */
export const getCurrentUser = async () => {
    try {
        // First check if we have the token
        const token = localStorage.getItem('token');
        if (!token) {
            return null;
        }
        // Always fetch fresh user data from API when token exists
        const user = await get(AUTH_ENDPOINTS.CURRENT_USER);
        if (!user || !user._id || !user.email) {
            throw new Error('Invalid user data received from server');
        }
        // Update localStorage with the latest user data
        localStorage.setItem('user', JSON.stringify(user));
        return user;
    }
    catch (error) {
        console.error('Get current user error:', error);
        // If there's an error (like an expired token), clear localStorage
        localStorage.removeItem('token');
        localStorage.removeItem('user');
        return null;
    }
};

/**
 * Check if the user is authenticated
 */
export const isAuthenticated = () => {
    return localStorage.getItem('token') !== null;
};

/**
 * Get the current user's role
 */
export const getUserRole = () => {
    const userJson = localStorage.getItem('user');
    if (!userJson) return null;
    const user = JSON.parse(userJson);
    return user.role;
};

/**
 * Update the current user's profile
 */
export const updateProfile = async (profileData) => {
    try {
        const updatedUser = await post(AUTH_ENDPOINTS.CURRENT_USER, profileData);
        if (!updatedUser || !updatedUser._id || !updatedUser.email) {
            throw new Error('Invalid user data received from server');
        }
        localStorage.setItem('user', JSON.stringify(updatedUser));
        return updatedUser;
    }
    catch (error) {
        console.error('Update profile error:', error);
        throw new Error(error.message || 'Profile update failed. Please try again.');
    }
};

export default {
    login,
    signup,
    logout,
    getCurrentUser,
    isAuthenticated,
    getUserRole,
    updateProfile,
};