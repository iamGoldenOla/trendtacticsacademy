// API Response Types
export interface ApiResponse<T> {
  success: boolean;
  message?: string;
  data?: T;
}

// User Types
export interface User {
  _id: string;
  name: string;
  email: string;
  role: 'student' | 'instructor' | 'admin';
  avatar?: string;
  bio?: string;
  location?: string;
  website?: string;
  enrolledCourses?: string[];
  createdAt: string;
  updatedAt: string;
  badges?: {
    id: string;
    name: string;
    description: string;
    icon?: string;
    awardedAt: Date;
  }[];
  dashboardPreferences?: {
    activeTab?: string;
    theme?: string;
    [key: string]: any;
  };
  dateOfBirth?: string;
  phone?: string;
  gender?: string;
}

// Auth Types
export interface AuthResponse {
  token: string;
  user: User;
}

// Login Credentials
export interface LoginCredentials {
  email: string;
  password: string;
}

// Signup Data
export interface SignupData extends LoginCredentials {
  name: string;
  role?: 'student' | 'instructor' | 'admin';
}