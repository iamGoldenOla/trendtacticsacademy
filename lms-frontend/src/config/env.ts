/**
 * Environment configuration for the frontend application
 */

// Get the API base URL from environment variables or use default
const getApiBaseUrl = (): string => {
  // In development, use the local backend server
  if (process.env.NODE_ENV === 'development') {
    return process.env.REACT_APP_API_URL || 'http://localhost:5000';
  }
  
  // In production, use the production API URL
  return process.env.REACT_APP_API_URL || 'https://your-production-api.com';
};

export const config = {
  // API Configuration
  apiBaseUrl: getApiBaseUrl(),
  apiTimeout: 30000, // 30 seconds
  
  // AI Service Configuration
  ai: {
    maxRetries: 3,
    retryDelay: 1000, // 1 second
    sessionTimeout: 30 * 60 * 1000, // 30 minutes
    maxMessageLength: 1000,
    typingIndicatorDelay: 500, // 0.5 seconds
  },
  
  // Feature Flags
  features: {
    aiTutor: true,
    analytics: true,
    recommendations: true,
    contentGeneration: false, // Disabled for students
  },
  
  // UI Configuration
  ui: {
    itemsPerPage: 10,
    maxFileSize: 10 * 1024 * 1024, // 10MB
    supportedImageTypes: ['image/jpeg', 'image/png', 'image/gif', 'image/webp'],
    supportedVideoTypes: ['video/mp4', 'video/webm', 'video/ogg'],
  },
  
  // Development Configuration
  development: {
    enableMockData: process.env.NODE_ENV === 'development',
    enableDebugLogs: process.env.NODE_ENV === 'development',
    mockApiDelay: 1000, // 1 second delay for mock API calls
  },
};

// Helper functions
export const isProduction = (): boolean => process.env.NODE_ENV === 'production';
export const isDevelopment = (): boolean => process.env.NODE_ENV === 'development';
export const isFeatureEnabled = (feature: keyof typeof config.features): boolean => {
  return config.features[feature];
};

// API endpoints
export const endpoints = {
  // Authentication
  auth: {
    login: '/api/auth/login',
    register: '/api/auth/register',
    logout: '/api/auth/logout',
    profile: '/api/auth/profile',
    refresh: '/api/auth/refresh',
  },
  
  // Courses
  courses: {
    list: '/api/courses',
    detail: (id: string) => `/api/courses/${id}`,
    enroll: (id: string) => `/api/courses/${id}/enroll`,
    lessons: (courseId: string) => `/api/courses/${courseId}/lessons`,
    lesson: (courseId: string, lessonId: string) => `/api/courses/${courseId}/lessons/${lessonId}`,
  },
  
  // AI Services
  ai: {
    startSession: '/api/ai/session/start',
    chat: '/api/ai/chat',
    getSession: (sessionId: string) => `/api/ai/session/${sessionId}`,
    recommendations: '/api/ai/recommendations',
    analytics: '/api/ai/analytics',
    generateContent: '/api/ai/generate',
    analyzeProgress: '/api/ai/analyze-progress',
    personalizePath: '/api/ai/personalize-path',
    health: '/api/ai/health',
  },
  
  // Progress
  progress: {
    update: '/api/progress',
    get: (courseId: string) => `/api/progress/${courseId}`,
  },
  
  // Badges
  badges: {
    list: '/api/badges',
    user: (userId: string) => `/api/badges/user/${userId}`,
  },
  
  // File Upload
  upload: {
    file: '/api/upload',
    avatar: '/api/upload/avatar',
  },
};

export default config;