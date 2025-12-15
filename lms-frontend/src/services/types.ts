// API Response Types
export interface ApiResponse<T> {
  success: boolean;
  data?: T;
  message?: string;
  error?: string;
}

// User Types
export interface User {
  _id: string;
  name: string;
  email: string;
  avatar?: string;
  role: string;
  createdAt: string;
  badges?: (string | { name: string; icon: string })[];
  dateOfBirth?: string;
  phone?: string;
  gender?: string;
  bio?: string;
  location?: string;
  website?: string;
}

export interface LoginCredentials {
  email: string;
  password: string;
}

export interface SignupData {
  name: string;
  email: string;
  password: string;
}

export interface AuthResponse {
  user: User;
  token: string;
}

// Game Activity Types
export interface GameActivity {
  id: string;
  title: string;
  description: string;
  type: 'quiz' | 'memory' | 'drag-drop' | 'word-match' | 'scenario';
  difficulty: 'easy' | 'medium' | 'hard';
  points: number;
  timeLimit?: number; // in seconds
  questions?: GameQuestion[];
  content?: any; // flexible content for different game types
  unlocked: boolean;
  completed: boolean;
  bestScore?: number;
}

export interface GameQuestion {
  id: string;
  question: string;
  options?: string[];
  correctAnswer: number | string;
  explanation?: string;
  points: number;
}

// Course Types
export interface Course {
  _id: string;
  title: string;
  description: string;
  instructor: string | User;
  price: number;
  imageUrl: string;
  category: string;
  level: 'beginner' | 'intermediate' | 'advanced';
  tags: string[];
  lessons: Lesson[] | string[];
  gameActivities?: GameActivity[];
  createdAt: string;
  updatedAt: string;
}

// Lesson Types
export interface Lesson {
  _id: string;
  title: string;
  description: string;
  content: string;
  videoUrl?: string;
  duration: number;
  order: number;
  course: string | Course;
  createdAt: string;
  updatedAt: string;
}

// Quiz Types
export interface QuizQuestion {
  _id: string;
  question: string;
  options: string[];
  correctOption: number;
  lesson: string | Lesson;
  createdAt: string;
  updatedAt: string;
}

// Progress Types
export interface Progress {
  _id: string;
  user: string | User;
  course: string | Course;
  lesson: string | Lesson;
  completed: boolean;
  completedAt?: string;
  createdAt: string;
  updatedAt: string;
}

// Badge Types
export interface Badge {
  _id: string;
  name: string;
  description: string;
  imageUrl: string;
  criteria: string;
  createdAt: string;
  updatedAt: string;
}