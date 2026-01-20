import { supabase } from './supabaseClient';


// Use Supabase auth directly instead of backend API

/**
 * Login a user with email and password
 */
export const login = async (credentials) => {
    try {
        if (!credentials.email || !credentials.password) {
            throw new Error('Email and password are required');
        }

        const { data, error } = await supabase.auth.signInWithPassword({
            email: credentials.email,
            password: credentials.password,
        });

        if (error) {
            throw new Error(error.message || 'Login failed. Please try again.');
        }

        if (!data || !data.user) {
            throw new Error('Invalid response from server: Missing user data');
        }

        // Get user profile from the users table
        let { data: profileData, error: profileError } = await supabase
            .from('users')
            .select('*')
            .eq('id', data.user.id)
            .single();

        // If no profile exists, create one
        if (profileError) {
            const { error: insertError } = await supabase
                .from('users')
                .insert({
                    id: data.user.id,
                    email: data.user.email,
                    name: data.user.user_metadata?.name || data.user.email.split('@')[0],
                    role: 'student',
                    created_at: new Date().toISOString(),
                    updated_at: new Date().toISOString(),
                });

            if (insertError) {
                console.error('Error creating user profile:', insertError);
            }

            // Fetch the created profile
            const { data: newProfile, error: newProfileError } = await supabase
                .from('users')
                .select('*')
                .eq('id', data.user.id)
                .single();

            if (!newProfileError) {
                profileData = newProfile;
            }
        }

        // Create complete user object with guaranteed name field
        const userName = profileData?.name || data.user.user_metadata?.name || (data.user.email ? data.user.email.split('@')[0] : 'User');

        const completeUser = {
            _id: data.user.id,
            name: userName, // Guaranteed to have a value
            email: data.user.email || '',
            role: profileData?.role || 'student',
            avatar: profileData?.avatar || data.user.user_metadata?.avatar || '',
            bio: profileData?.bio || '',
            location: profileData?.location || '',
            website: profileData?.website || '',
            enrolledCourses: profileData?.enrolled_courses || [],
            createdAt: profileData?.created_at || data.user.created_at || new Date().toISOString(),
            updatedAt: profileData?.updated_at || new Date().toISOString(),
            badges: profileData?.badges || [],
            dashboardPreferences: profileData?.dashboard_preferences || {},
        };

        // Store session in localStorage for consistency
        if (data.session) {
            localStorage.setItem('token', data.session.access_token);
        }
        localStorage.setItem('user', JSON.stringify(completeUser));

        return { token: data.session?.access_token, user: completeUser };
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

        const { data, error } = await supabase.auth.signUp({
            email: userData.email,
            password: userData.password,
            options: {
                data: {
                    name: userData.name,
                    role: 'student',
                }
            }
        });

        if (error) {
            throw new Error(error.message || 'Signup failed. Please try again.');
        }

        if (!data || !data.user) {
            throw new Error('Invalid response from server: Missing user data');
        }

        // Create user profile in the users table
        const { error: profileError } = await supabase
            .from('users')
            .insert({
                id: data.user.id,
                email: data.user.email,
                name: userData.name,
                role: 'student',
                created_at: new Date().toISOString(),
                updated_at: new Date().toISOString(),
            });

        if (profileError) {
            console.error('Error creating user profile:', profileError);
            // Don't throw error here as the user is already created in auth
        }

        // Create complete user object
        const completeUser = {
            _id: data.user.id,
            name: userData.name,
            email: data.user.email,
            role: 'student',
            avatar: '',
            bio: '',
            location: '',
            website: '',
            enrolledCourses: [],
            createdAt: new Date().toISOString(),
            updatedAt: new Date().toISOString(),
            badges: [],
            dashboardPreferences: {},
        };

        // Store session in localStorage for consistency
        if (data.session) {
            localStorage.setItem('token', data.session.access_token);
        }
        localStorage.setItem('user', JSON.stringify(completeUser));

        // Send welcome email after successful registration
        try {
            const emailResponse = await fetch('/api/emails/welcome', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    email: completeUser.email,
                    name: completeUser.name
                }),
            });

            const emailResult = await emailResponse.json();
            if (!emailResult.success) {
                console.error('Error sending welcome email:', emailResult.error);
            }
        } catch (emailError) {
            console.error('Error sending welcome email:', emailError);
        }

        return { token: data.session?.access_token, user: completeUser };
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
        // Sign out from Supabase
        const { error } = await supabase.auth.signOut();

        if (error) {
            console.error('Supabase logout error:', error);
        }

        // Clear token and user from localStorage
        localStorage.removeItem('token');
        localStorage.removeItem('user');
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
        // Get session from Supabase
        const { data: { session } } = await supabase.auth.getSession();

        if (!session) {
            // No active session, clear local storage
            localStorage.removeItem('token');
            localStorage.removeItem('user');
            return null;
        }

        // Get current user from Supabase auth
        const { data: { user }, error: userError } = await supabase.auth.getUser();

        if (userError || !user) {
            throw new Error('Unable to get user data');
        }

        // Get user profile from the users table
        const { data: profileData, error: profileError } = await supabase
            .from('users')
            .select('*')
            .eq('id', user.id)
            .single();

        // Create complete user object with guaranteed name field
        const userName = profileData?.name || user.user_metadata?.name || (user.email ? user.email.split('@')[0] : 'User');

        const completeUser = {
            _id: user.id,
            name: userName, // Guaranteed to have a value
            email: user.email || '',
            role: profileData?.role || user.user_metadata?.role || 'student',
            avatar: profileData?.avatar || user.user_metadata?.avatar || '',
            bio: profileData?.bio || user.user_metadata?.bio || '',
            location: profileData?.location || user.user_metadata?.location || '',
            website: profileData?.website || user.user_metadata?.website || '',
            enrolledCourses: profileData?.enrolled_courses || user.user_metadata?.enrolledCourses || [],
            createdAt: profileData?.created_at || user.created_at || new Date().toISOString(),
            updatedAt: profileData?.updated_at || new Date().toISOString(),
            badges: profileData?.badges || user.user_metadata?.badges || [],
            dashboardPreferences: profileData?.dashboard_preferences || user.user_metadata?.dashboardPreferences || {},
        };

        // Update localStorage with the latest user data
        localStorage.setItem('user', JSON.stringify(completeUser));

        return completeUser;
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
        // Get current user
        const currentUser = await getCurrentUser();
        if (!currentUser) {
            throw new Error('User not authenticated');
        }

        // Update user profile in the database
        const { error: updateError } = await supabase
            .from('users')
            .update({
                name: profileData.name,
                avatar: profileData.avatar,
                bio: profileData.bio,
                location: profileData.location,
                website: profileData.website,
                updated_at: new Date().toISOString(),
            })
            .eq('id', currentUser._id);

        if (updateError) {
            throw new Error(updateError.message || 'Profile update failed');
        }

        // Update user metadata in Supabase auth if needed
        if (profileData.name) {
            const { error: metadataError } = await supabase.auth.updateUser({
                data: { name: profileData.name }
            });

            if (metadataError) {
                console.error('Error updating user metadata:', metadataError);
                // Don't throw error here as profile was updated in DB
            }
        }

        // Fetch updated user data
        const updatedUser = await getCurrentUser();

        if (!updatedUser) {
            throw new Error('Unable to fetch updated user data');
        }

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