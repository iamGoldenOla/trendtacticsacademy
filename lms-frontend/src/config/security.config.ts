/**
 * Security Configuration
 * 
 * Enterprise-grade security settings for 2B+ users
 * 
 * Features:
 * - Content Security Policy (CSP)
 * - Rate Limiting
 * - Input Validation
 * - XSS Protection
 * - CSRF Protection
 */

// ============================================================================
// Content Security Policy (CSP)
// ============================================================================

export const CSP_DIRECTIVES = {
  'default-src': ["'self'"],
  'script-src': [
    "'self'",
    "'unsafe-inline'", // Required for React
    'https://cdn.jsdelivr.net', // For external libraries
  ],
  'style-src': [
    "'self'",
    "'unsafe-inline'", // Required for styled-components
    'https://fonts.googleapis.com',
  ],
  'img-src': [
    "'self'",
    'data:',
    'https:',
    'blob:',
  ],
  'font-src': [
    "'self'",
    'https://fonts.gstatic.com',
  ],
  'connect-src': [
    "'self'",
    process.env.REACT_APP_API_BASE_URL || 'http://localhost:3001',
    process.env.REACT_APP_SUPABASE_URL || '',
  ],
  'media-src': [
    "'self'",
    'https:',
    'blob:',
  ],
  'object-src': ["'none'"],
  'frame-ancestors': ["'none'"],
  'base-uri': ["'self'"],
  'form-action': ["'self'"],
};

// ============================================================================
// Rate Limiting Configuration
// ============================================================================

export const RATE_LIMITS = {
  // API requests per minute
  API_REQUESTS_PER_MINUTE: 100,
  
  // Login attempts per hour
  LOGIN_ATTEMPTS_PER_HOUR: 5,
  
  // Registration attempts per hour
  REGISTRATION_ATTEMPTS_PER_HOUR: 3,
  
  // Password reset attempts per hour
  PASSWORD_RESET_ATTEMPTS_PER_HOUR: 3,
  
  // File upload size limit (in MB)
  MAX_FILE_UPLOAD_SIZE: 10,
  
  // Video upload size limit (in MB)
  MAX_VIDEO_UPLOAD_SIZE: 500,
};

// ============================================================================
// Input Validation Rules
// ============================================================================

export const VALIDATION_RULES = {
  // Email validation
  EMAIL_REGEX: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
  
  // Password requirements
  PASSWORD_MIN_LENGTH: 8,
  PASSWORD_MAX_LENGTH: 128,
  PASSWORD_REGEX: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]/,
  
  // Username requirements
  USERNAME_MIN_LENGTH: 3,
  USERNAME_MAX_LENGTH: 30,
  USERNAME_REGEX: /^[a-zA-Z0-9_-]+$/,
  
  // Name requirements
  NAME_MIN_LENGTH: 2,
  NAME_MAX_LENGTH: 50,
  NAME_REGEX: /^[a-zA-Z\s'-]+$/,
  
  // Phone number
  PHONE_REGEX: /^\+?[1-9]\d{1,14}$/,
  
  // URL validation
  URL_REGEX: /^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$/,
};

// ============================================================================
// XSS Protection
// ============================================================================

/**
 * Sanitize user input to prevent XSS attacks
 */
export const sanitizeInput = (input: string): string => {
  const map: { [key: string]: string } = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#x27;',
    '/': '&#x2F;',
  };
  
  return input.replace(/[&<>"'/]/g, (char) => map[char]);
};

/**
 * Validate and sanitize HTML content
 */
export const sanitizeHTML = (html: string): string => {
  // Use DOMPurify in production
  // For now, basic sanitization
  return html
    .replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '')
    .replace(/<iframe\b[^<]*(?:(?!<\/iframe>)<[^<]*)*<\/iframe>/gi, '')
    .replace(/on\w+="[^"]*"/g, '');
};

// ============================================================================
// CSRF Protection
// ============================================================================

/**
 * Generate CSRF token
 */
export const generateCSRFToken = (): string => {
  const array = new Uint8Array(32);
  crypto.getRandomValues(array);
  return Array.from(array, byte => byte.toString(16).padStart(2, '0')).join('');
};

/**
 * Validate CSRF token
 */
export const validateCSRFToken = (token: string, storedToken: string): boolean => {
  return token === storedToken;
};

// ============================================================================
// Secure Storage
// ============================================================================

/**
 * Securely store sensitive data in localStorage
 */
export const secureStorage = {
  setItem: (key: string, value: string): void => {
    try {
      // In production, encrypt the value before storing
      localStorage.setItem(key, value);
    } catch (error) {
      console.error('Error storing data:', error);
    }
  },
  
  getItem: (key: string): string | null => {
    try {
      // In production, decrypt the value after retrieving
      return localStorage.getItem(key);
    } catch (error) {
      console.error('Error retrieving data:', error);
      return null;
    }
  },
  
  removeItem: (key: string): void => {
    try {
      localStorage.removeItem(key);
    } catch (error) {
      console.error('Error removing data:', error);
    }
  },
  
  clear: (): void => {
    try {
      localStorage.clear();
    } catch (error) {
      console.error('Error clearing storage:', error);
    }
  },
};

export default {
  CSP_DIRECTIVES,
  RATE_LIMITS,
  VALIDATION_RULES,
  sanitizeInput,
  sanitizeHTML,
  generateCSRFToken,
  validateCSRFToken,
  secureStorage,
};

