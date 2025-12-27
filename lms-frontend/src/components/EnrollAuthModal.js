import React, { useState } from 'react';
import { supabase } from '../services/supabaseClient';

/**
 * A simplified authentication modal that handles signup and login
 * directly with Supabase to avoid legacy abstractions.
 */
const EnrollAuthModal = ({ isOpen, onClose, onAuthSuccess }) => {
    const [isLogin, setIsLogin] = useState(false);
    const [formData, setFormData] = useState({
        name: '',
        email: '',
        password: '',
    });
    const [error, setError] = useState(null);
    const [isLoading, setIsLoading] = useState(false);
    const [successMessage, setSuccessMessage] = useState(null);

    if (!isOpen) return null;

    const handleInputChange = (e) => {
        setFormData({ ...formData, [e.target.name]: e.target.value });
        setError(null); // Clear error on typing
    };

    const toggleMode = () => {
        setIsLogin(!isLogin);
        setError(null);
        setSuccessMessage(null);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError(null);
        setIsLoading(true);
        setSuccessMessage(null);

        try {
            if (isLogin) {
                // LOGIN LOGIC
                const { data, error } = await supabase.auth.signInWithPassword({
                    email: formData.email,
                    password: formData.password,
                });

                if (error) throw error;

                // Get profile
                const { data: profile } = await supabase
                    .from('users')
                    .select('*')
                    .eq('id', data.user.id)
                    .single();

                const user = { ...data.user, ...profile };
                localStorage.setItem('user', JSON.stringify(user));
                localStorage.setItem('token', data.session.access_token);

                onAuthSuccess(user);
                onClose();

            } else {
                // SIGNUP LOGIC
                if (formData.password.length < 8) {
                    throw new Error("Password must be at least 8 characters long.");
                }

                const { data, error } = await supabase.auth.signUp({
                    email: formData.email,
                    password: formData.password,
                    options: {
                        data: {
                            name: formData.name,
                            role: 'student'
                        }
                    }
                });

                if (error) throw error;

                if (data?.user) {
                    // Create Profile
                    const { error: profileError } = await supabase
                        .from('users')
                        .insert({
                            id: data.user.id,
                            email: formData.email,
                            name: formData.name,
                            role: 'student',
                            created_at: new Date().toISOString(),
                            updated_at: new Date().toISOString(),
                        });

                    if (profileError) {
                        // Even if profile fails, auth worked. We can log it.
                        console.error("Profile creation warning:", profileError);
                    }

                    // Auto-login after signup
                    // Note: If email confirmation is enabled, this might need adjustment,
                    // but for now we assume we can proceed or show a "Check email" message.

                    if (!data.session) {
                        setSuccessMessage("Account created! Please check your email to confirm.");
                        setIsLoading(false);
                        return;
                    }

                    const user = { ...data.user, name: formData.name, role: 'student' };
                    localStorage.setItem('user', JSON.stringify(user));
                    localStorage.setItem('token', data.session.access_token);

                    onAuthSuccess(user);
                    onClose();
                }
            }

        } catch (err) {
            console.error("Auth Error:", err);
            setError(err.message || "An unknown error occurred.");
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <div className="fixed inset-0 bg-black bg-opacity-70 flex items-center justify-center z-50 p-4">
            <div className="bg-[#1a1c23] border border-gray-700 rounded-2xl w-full max-w-md overflow-hidden relative shadow-2xl animate-fade-in-up">

                {/* Header */}
                <div className="px-8 pt-8 pb-6 text-center">
                    <h2 className="text-3xl font-bold bg-gradient-to-r from-blue-400 to-purple-500 bg-clip-text text-transparent mb-2">
                        {isLogin ? 'Welcome Back' : 'Join Academy'}
                    </h2>
                    <p className="text-gray-400 text-sm">
                        {isLogin ? 'Continue your learning journey' : 'Start your creative coding journey today'}
                    </p>
                </div>

                {/* Form */}
                <form onSubmit={handleSubmit} className="px-8 pb-8 space-y-4">

                    {/* Error / Success Messages */}
                    {error && (
                        <div className="bg-red-500/10 border border-red-500/50 text-red-200 px-4 py-3 rounded-lg text-sm">
                            ⚠️ {error}
                        </div>
                    )}
                    {successMessage && (
                        <div className="bg-green-500/10 border border-green-500/50 text-green-200 px-4 py-3 rounded-lg text-sm">
                            ✅ {successMessage}
                        </div>
                    )}

                    {!isLogin && (
                        <div>
                            <label className="block text-gray-300 text-xs font-medium mb-1 ml-1">Full Name</label>
                            <input
                                type="text"
                                name="name"
                                value={formData.name}
                                onChange={handleInputChange}
                                className="w-full bg-[#13141a] border border-gray-700 rounded-xl px-4 py-3 text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 transition-colors"
                                placeholder="Viktor James"
                                required
                            />
                        </div>
                    )}

                    <div>
                        <label className="block text-gray-300 text-xs font-medium mb-1 ml-1">Email Address</label>
                        <input
                            type="email"
                            name="email"
                            value={formData.email}
                            onChange={handleInputChange}
                            className="w-full bg-[#13141a] border border-gray-700 rounded-xl px-4 py-3 text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 transition-colors"
                            placeholder="you@example.com"
                            required
                        />
                    </div>

                    <div>
                        <label className="block text-gray-300 text-xs font-medium mb-1 ml-1">Password</label>
                        <input
                            type="password"
                            name="password"
                            value={formData.password}
                            onChange={handleInputChange}
                            className="w-full bg-[#13141a] border border-gray-700 rounded-xl px-4 py-3 text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 transition-colors"
                            placeholder="••••••••"
                            required
                        />
                    </div>

                    <button
                        type="submit"
                        disabled={isLoading}
                        className="w-full bg-gradient-to-r from-blue-600 to-purple-600 hover:from-blue-500 hover:to-purple-500 text-white font-bold py-3.5 rounded-xl transition-all transform hover:scale-[1.02] active:scale-[0.98] shadow-lg disabled:opacity-50 disabled:cursor-not-allowed mt-2"
                    >
                        {isLoading ? (
                            <span className="flex items-center justify-center gap-2">
                                <svg className="animate-spin h-5 w-5 text-white" fill="none" viewBox="0 0 24 24">
                                    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                                    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                                </svg>
                                Processing...
                            </span>
                        ) : (
                            isLogin ? 'Sign In' : 'Create Account'
                        )}
                    </button>

                    <div className="text-center pt-2">
                        <button
                            type="button"
                            onClick={toggleMode}
                            className="text-gray-400 hover:text-white text-sm transition-colors"
                        >
                            {isLogin ? "Don't have an account? Sign up" : "Already have an account? Sign in"}
                        </button>
                    </div>
                </form>

                {/* Close Button */}
                <button
                    onClick={onClose}
                    className="absolute top-4 right-4 text-gray-500 hover:text-white transition-colors"
                >
                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
        </div>
    );
};

export default EnrollAuthModal;
