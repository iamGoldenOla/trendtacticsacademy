/**
 * API Endpoints Configuration
 * 
 * Centralized API endpoint definitions.
 * Makes it easy to update endpoints without touching service files.
 */

const API_VERSION = '/v1';

export const ENDPOINTS = {
  // Authentication
  AUTH: {
    LOGIN: `${API_VERSION}/auth/login`,
    REGISTER: `${API_VERSION}/auth/register`,
    LOGOUT: `${API_VERSION}/auth/logout`,
    REFRESH: `${API_VERSION}/auth/refresh`,
    VERIFY_EMAIL: `${API_VERSION}/auth/verify-email`,
    FORGOT_PASSWORD: `${API_VERSION}/auth/forgot-password`,
    RESET_PASSWORD: `${API_VERSION}/auth/reset-password`,
    ME: `${API_VERSION}/auth/me`,
  },
  
  // Users
  USERS: {
    BASE: `${API_VERSION}/users`,
    BY_ID: (id: string) => `${API_VERSION}/users/${id}`,
    PROFILE: `${API_VERSION}/users/profile`,
    UPDATE_PROFILE: `${API_VERSION}/users/profile`,
    CHANGE_PASSWORD: `${API_VERSION}/users/change-password`,
    UPLOAD_AVATAR: `${API_VERSION}/users/avatar`,
  },
  
  // Courses
  COURSES: {
    BASE: `${API_VERSION}/courses`,
    BY_ID: (id: string) => `${API_VERSION}/courses/${id}`,
    SEARCH: `${API_VERSION}/courses/search`,
    FEATURED: `${API_VERSION}/courses/featured`,
    BY_CATEGORY: (category: string) => `${API_VERSION}/courses/category/${category}`,
    BY_LEVEL: (level: string) => `${API_VERSION}/courses/level/${level}`,
    ENROLL: (id: string) => `${API_VERSION}/courses/${id}/enroll`,
    UNENROLL: (id: string) => `${API_VERSION}/courses/${id}/unenroll`,
  },
  
  // Modules
  MODULES: {
    BASE: `${API_VERSION}/modules`,
    BY_ID: (id: string) => `${API_VERSION}/modules/${id}`,
    BY_COURSE: (courseId: string) => `${API_VERSION}/courses/${courseId}/modules`,
  },
  
  // Lessons
  LESSONS: {
    BASE: `${API_VERSION}/lessons`,
    BY_ID: (id: string) => `${API_VERSION}/lessons/${id}`,
    BY_MODULE: (moduleId: string) => `${API_VERSION}/modules/${moduleId}/lessons`,
    COMPLETE: (id: string) => `${API_VERSION}/lessons/${id}/complete`,
    UNCOMPLETE: (id: string) => `${API_VERSION}/lessons/${id}/uncomplete`,
  },
  
  // Progress
  PROGRESS: {
    BASE: `${API_VERSION}/progress`,
    BY_COURSE: (courseId: string) => `${API_VERSION}/progress/course/${courseId}`,
    BY_USER: (userId: string) => `${API_VERSION}/progress/user/${userId}`,
    UPDATE: `${API_VERSION}/progress/update`,
    STATS: `${API_VERSION}/progress/stats`,
  },
  
  // Enrollments
  ENROLLMENTS: {
    BASE: `${API_VERSION}/enrollments`,
    MY_COURSES: `${API_VERSION}/enrollments/my-courses`,
    BY_COURSE: (courseId: string) => `${API_VERSION}/enrollments/course/${courseId}`,
    CHECK: (courseId: string) => `${API_VERSION}/enrollments/check/${courseId}`,
  },
  
  // Payments
  PAYMENTS: {
    BASE: `${API_VERSION}/payments`,
    CREATE_INTENT: `${API_VERSION}/payments/create-intent`,
    CONFIRM: `${API_VERSION}/payments/confirm`,
    HISTORY: `${API_VERSION}/payments/history`,
    REFUND: (id: string) => `${API_VERSION}/payments/${id}/refund`,
  },
  
  // Certificates
  CERTIFICATES: {
    BASE: `${API_VERSION}/certificates`,
    BY_ID: (id: string) => `${API_VERSION}/certificates/${id}`,
    BY_COURSE: (courseId: string) => `${API_VERSION}/certificates/course/${courseId}`,
    GENERATE: (courseId: string) => `${API_VERSION}/certificates/generate/${courseId}`,
    VERIFY: (code: string) => `${API_VERSION}/certificates/verify/${code}`,
  },
  
  // Quizzes
  QUIZZES: {
    BASE: `${API_VERSION}/quizzes`,
    BY_ID: (id: string) => `${API_VERSION}/quizzes/${id}`,
    BY_LESSON: (lessonId: string) => `${API_VERSION}/lessons/${lessonId}/quizzes`,
    SUBMIT: (id: string) => `${API_VERSION}/quizzes/${id}/submit`,
    RESULTS: (id: string) => `${API_VERSION}/quizzes/${id}/results`,
  },
  
  // Discussions
  DISCUSSIONS: {
    BASE: `${API_VERSION}/discussions`,
    BY_ID: (id: string) => `${API_VERSION}/discussions/${id}`,
    BY_COURSE: (courseId: string) => `${API_VERSION}/discussions/course/${courseId}`,
    BY_LESSON: (lessonId: string) => `${API_VERSION}/discussions/lesson/${lessonId}`,
    COMMENTS: (id: string) => `${API_VERSION}/discussions/${id}/comments`,
    LIKE: (id: string) => `${API_VERSION}/discussions/${id}/like`,
  },
  
  // Notifications
  NOTIFICATIONS: {
    BASE: `${API_VERSION}/notifications`,
    UNREAD: `${API_VERSION}/notifications/unread`,
    MARK_READ: (id: string) => `${API_VERSION}/notifications/${id}/read`,
    MARK_ALL_READ: `${API_VERSION}/notifications/read-all`,
    PREFERENCES: `${API_VERSION}/notifications/preferences`,
  },
  
  // Analytics
  ANALYTICS: {
    DASHBOARD: `${API_VERSION}/analytics/dashboard`,
    COURSE_STATS: (courseId: string) => `${API_VERSION}/analytics/course/${courseId}`,
    USER_STATS: `${API_VERSION}/analytics/user`,
    LEARNING_TIME: `${API_VERSION}/analytics/learning-time`,
  },
  
  // Admin
  ADMIN: {
    USERS: `${API_VERSION}/admin/users`,
    COURSES: `${API_VERSION}/admin/courses`,
    ANALYTICS: `${API_VERSION}/admin/analytics`,
    REPORTS: `${API_VERSION}/admin/reports`,
  },
};

export default ENDPOINTS;

