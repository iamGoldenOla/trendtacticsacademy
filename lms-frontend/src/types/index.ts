// User types
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
  badges?: Badge[];
  dateOfBirth?: string;
  phone?: string;
  gender?: string;
  socialLinks?: {
    linkedin?: string;
    github?: string;
    facebook?: string;
    instagram?: string;
    website?: string;
  };
}

// Course types
export interface Course {
  id: string;
  title: string;
  description: string;
  instructor: User;
  thumbnail: string;
  price: number;
  duration: string;
  level: 'beginner' | 'intermediate' | 'advanced';
  category: string;
  lessons: Lesson[];
  enrolledStudents: number;
  rating: number;
  createdAt: Date;
  topics: string[];
  moduleQuiz?: QuizQuestion[];
}

// Quiz question type for lessons and modules
export interface QuizQuestion {
  question: string;
  options: string[];
  correctAnswer: number;
  explanation?: string;
}

// Lesson types
export interface Lesson {
  id: string;
  title: string;
  description: string;
  videoUrl?: string;
  content: string;
  duration: number; // in minutes
  order: number;
  isCompleted?: boolean;
  quiz?: QuizQuestion[];
}

// Progress types
export interface Progress {
  userId: string;
  courseId: string;
  completedLessons: string[];
  progressPercentage: number;
  lastAccessed: Date;
}

// Navigation types
export interface NavItem {
  label: string;
  href: string;
  icon?: string;
  children?: NavItem[];
}

// Badge type for user achievements
export interface Badge {
  id: string;
  name: string;
  description: string;
  icon?: string;
  awardedAt: Date;
}

// Task and Calendar types
export interface Task {
  id: string;
  title: string;
  description?: string;
  type: 'assignment' | 'quiz' | 'project' | 'reading' | 'personal';
  priority: 'low' | 'medium' | 'high';
  status: 'pending' | 'in-progress' | 'completed';
  dueDate?: Date;
  courseId?: string;
  courseName?: string;
  createdAt: Date;
  completedAt?: Date;
  attachments?: Attachment[];
  notes?: string[];
  editable?: boolean;
}

export interface Attachment {
  name: string;
  url: string;
  type?: string;
}

export interface CalendarEvent {
  id: string;
  title: string;
  description?: string;
  date: Date;
  type: 'assignment' | 'quiz' | 'lesson' | 'deadline' | 'event';
  courseId?: string;
  courseName?: string;
  color?: string;
}

export interface TaskFilter {
  status?: 'all' | 'pending' | 'in-progress' | 'completed';
  type?: 'all' | 'assignment' | 'quiz' | 'project' | 'reading' | 'personal';
  priority?: 'all' | 'low' | 'medium' | 'high';
  course?: 'all' | string;
}