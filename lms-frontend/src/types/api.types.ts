/**
 * API Types - Backend Agnostic
 * 
 * These types define the contract between frontend and backend.
 * They are independent of the backend implementation.
 */

// ============================================================================
// Common Types
// ============================================================================

export interface PaginatedResponse<T> {
  data: T[];
  pagination: {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
  };
}

export interface ApiResponse<T> {
  success: boolean;
  data: T;
  message?: string;
  errors?: ApiError[];
}

export interface ApiError {
  field?: string;
  message: string;
  code?: string;
}

// ============================================================================
// User Types
// ============================================================================

export interface User {
  id: string;
  email: string;
  firstName: string;
  lastName: string;
  avatar?: string;
  role: 'student' | 'instructor' | 'admin';
  enrolledCourses: string[];
  createdAt: string;
  updatedAt: string;
}

export interface UserProfile extends User {
  bio?: string;
  phone?: string;
  country?: string;
  timezone?: string;
  preferences: UserPreferences;
}

export interface UserPreferences {
  emailNotifications: boolean;
  pushNotifications: boolean;
  language: string;
  theme: 'light' | 'dark' | 'auto';
}

// ============================================================================
// Course Types
// ============================================================================

export interface Course {
  id: string;
  title: string;
  description: string;
  thumbnail_url?: string;
  level: 'beginner' | 'intermediate' | 'advanced';
  category: string;
  price?: number;
  duration?: string;
  instructor_id?: string;
  instructor?: Instructor;
  objectives?: string[];
  requirements?: string[];
  tags?: string[];
  rating?: number;
  totalStudents?: number;
  totalLessons?: number;
  totalDuration?: number;
  isPublished: boolean;
  createdAt: string;
  updatedAt: string;
}

export interface Instructor {
  id: string;
  name: string;
  avatar?: string;
  bio?: string;
  expertise?: string[];
  rating?: number;
  totalCourses?: number;
  totalStudents?: number;
}

export interface Module {
  id: string;
  course_id: string;
  title: string;
  description?: string;
  order_index: number;
  duration?: string;
  createdAt: string;
  updatedAt: string;
}

export interface Lesson {
  id: string;
  module_id: string;
  title: string;
  description?: string;
  content?: string;
  content_type: 'video' | 'text' | 'quiz' | 'assignment';
  video_url?: string;
  duration?: string;
  order_index: number;
  isPreview: boolean;
  resources?: LessonResource[];
  createdAt: string;
  updatedAt: string;
}

export interface LessonResource {
  id: string;
  title: string;
  type: 'pdf' | 'video' | 'link' | 'code';
  url: string;
  size?: number;
}

// ============================================================================
// Progress Types
// ============================================================================

export interface CourseProgress {
  id: string;
  user_id: string;
  course_id: string;
  completedLessons: string[];
  currentLesson?: string;
  progressPercentage: number;
  timeSpent: number; // in minutes
  lastAccessedAt: string;
  startedAt: string;
  completedAt?: string;
}

export interface LessonProgress {
  id: string;
  user_id: string;
  lesson_id: string;
  isCompleted: boolean;
  timeSpent: number;
  lastPosition?: number; // for video lessons
  completedAt?: string;
}

// ============================================================================
// Enrollment Types
// ============================================================================

export interface Enrollment {
  id: string;
  user_id: string;
  course_id: string;
  status: 'active' | 'completed' | 'cancelled';
  enrolledAt: string;
  completedAt?: string;
  expiresAt?: string;
}

// ============================================================================
// Payment Types
// ============================================================================

export interface Payment {
  id: string;
  user_id: string;
  course_id: string;
  amount: number;
  currency: string;
  status: 'pending' | 'completed' | 'failed' | 'refunded';
  paymentMethod: string;
  transactionId?: string;
  createdAt: string;
  updatedAt: string;
}

// ============================================================================
// Certificate Types
// ============================================================================

export interface Certificate {
  id: string;
  user_id: string;
  course_id: string;
  certificateCode: string;
  issuedAt: string;
  pdfUrl?: string;
}

// ============================================================================
// Filter Types
// ============================================================================

export interface CourseFilters {
  level?: string;
  category?: string;
  search?: string;
  minPrice?: number;
  maxPrice?: number;
  rating?: number;
  page?: number;
  limit?: number;
  sortBy?: 'popular' | 'newest' | 'price' | 'rating';
}

// ============================================================================
// Authentication Types
// ============================================================================

export interface LoginCredentials {
  email: string;
  password: string;
}

export interface RegisterData {
  email: string;
  password: string;
  firstName: string;
  lastName: string;
}

export interface AuthResponse {
  user: User;
  access_token: string;
  refresh_token: string;
  expiresIn: number;
}

export interface TokenRefreshResponse {
  access_token: string;
  expiresIn: number;
}

