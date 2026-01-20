// Input Validation Utilities
// Protects against XSS, SQL injection, and malicious inputs

/**
 * Validate email address
 * @param {string} email - Email to validate
 * @returns {boolean} - True if valid
 */
export const validateEmail = (email) => {
    if (!email || typeof email !== 'string') {
        throw new Error('Email is required');
    }

    // Check length
    if (email.length > 254) {
        throw new Error('Email is too long');
    }

    // Check format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        throw new Error('Invalid email format');
    }

    // Check for dangerous characters
    const dangerousChars = /<|>|"|'|`|;|\\|\/\*/;
    if (dangerousChars.test(email)) {
        throw new Error('Email contains invalid characters');
    }

    return true;
};

/**
 * Validate password strength
 * @param {string} password - Password to validate
 * @returns {boolean} - True if valid
 */
export const validatePassword = (password) => {
    if (!password || typeof password !== 'string') {
        throw new Error('Password is required');
    }

    const requirements = {
        minLength: 12,
        hasUppercase: /[A-Z]/.test(password),
        hasLowercase: /[a-z]/.test(password),
        hasNumber: /\d/.test(password),
        hasSpecialChar: /[!@#$%^&*(),.?":{}|<>]/.test(password)
    };

    if (password.length < requirements.minLength) {
        throw new Error(`Password must be at least ${requirements.minLength} characters long`);
    }

    if (!requirements.hasUppercase) {
        throw new Error('Password must contain at least one uppercase letter');
    }

    if (!requirements.hasLowercase) {
        throw new Error('Password must contain at least one lowercase letter');
    }

    if (!requirements.hasNumber) {
        throw new Error('Password must contain at least one number');
    }

    if (!requirements.hasSpecialChar) {
        throw new Error('Password must contain at least one special character');
    }

    return true;
};

/**
 * Sanitize user input to prevent XSS
 * @param {string} input - User input to sanitize
 * @returns {string} - Sanitized input
 */
export const sanitizeInput = (input) => {
    if (!input || typeof input !== 'string') {
        return '';
    }

    return input
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#x27;')
        .replace(/\//g, '&#x2F;')
        .trim();
};

/**
 * Validate name (no special characters)
 * @param {string} name - Name to validate
 * @returns {boolean} - True if valid
 */
export const validateName = (name) => {
    if (!name || typeof name !== 'string') {
        throw new Error('Name is required');
    }

    if (name.length < 2 || name.length > 100) {
        throw new Error('Name must be between 2 and 100 characters');
    }

    // Only letters, spaces, hyphens, and apostrophes
    const nameRegex = /^[a-zA-Z\s'-]+$/;
    if (!nameRegex.test(name)) {
        throw new Error('Name contains invalid characters');
    }

    return true;
};

/**
 * Validate URL
 * @param {string} url - URL to validate
 * @returns {boolean} - True if valid
 */
export const validateURL = (url) => {
    if (!url || typeof url !== 'string') {
        return false;
    }

    try {
        const urlObj = new URL(url);
        return urlObj.protocol === 'http:' || urlObj.protocol === 'https:';
    } catch {
        return false;
    }
};

/**
 * Rate limiter for login attempts
 */
class RateLimiter {
    constructor() {
        this.attempts = new Map();
    }

    checkLimit(identifier, maxAttempts = 5, windowMs = 15 * 60 * 1000) {
        const now = Date.now();
        const userAttempts = this.attempts.get(identifier) || [];

        // Remove old attempts outside the window
        const recentAttempts = userAttempts.filter(
            timestamp => now - timestamp < windowMs
        );

        if (recentAttempts.length >= maxAttempts) {
            const oldestAttempt = Math.min(...recentAttempts);
            const timeUntilReset = Math.ceil((windowMs - (now - oldestAttempt)) / 1000 / 60);
            throw new Error(`Too many attempts. Try again in ${timeUntilReset} minutes.`);
        }

        // Add current attempt
        recentAttempts.push(now);
        this.attempts.set(identifier, recentAttempts);

        return true;
    }

    reset(identifier) {
        this.attempts.delete(identifier);
    }
}

export const loginRateLimiter = new RateLimiter();

/**
 * Validate course ID (UUID format)
 * @param {string} id - ID to validate
 * @returns {boolean} - True if valid
 */
export const validateUUID = (id) => {
    if (!id || typeof id !== 'string') {
        throw new Error('ID is required');
    }

    const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
    if (!uuidRegex.test(id)) {
        throw new Error('Invalid ID format');
    }

    return true;
};

/**
 * Escape SQL special characters (defense in depth)
 * Note: Supabase uses parameterized queries, but this adds extra protection
 * @param {string} input - Input to escape
 * @returns {string} - Escaped input
 */
export const escapeSQLInput = (input) => {
    if (!input || typeof input !== 'string') {
        return '';
    }

    return input
        .replace(/'/g, "''")
        .replace(/;/g, '')
        .replace(/--/g, '')
        .replace(/\/\*/g, '')
        .replace(/\*\//g, '');
};

export default {
    validateEmail,
    validatePassword,
    sanitizeInput,
    validateName,
    validateURL,
    validateUUID,
    escapeSQLInput,
    loginRateLimiter
};
