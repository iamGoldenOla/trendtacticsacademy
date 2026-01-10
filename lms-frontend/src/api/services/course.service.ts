/**
 * Course Service - Backend Agnostic
 *
 * This service handles all course-related API calls.
 * It's completely decoupled from the backend implementation.
 * You can switch from Supabase to any backend without changing this file.
 *
 * TEMPORARY: Currently uses Supabase adapter.
 * When backend API is ready, set USE_API_BACKEND=true in .env
 */

import api from '../client';
import { ENDPOINTS } from '../endpoints';
import { Course, Module, Lesson, CourseFilters, PaginatedResponse } from '../../types/api.types';
import { supabaseCourseAdapter } from '../adapters/supabase.adapter';

// Feature flag: Switch between Supabase and API backend
const USE_API_BACKEND = process.env.REACT_APP_USE_API_BACKEND === 'true';

export class CourseService {
  /**
   * Get all courses with optional filters
   */
  async getAllCourses(filters?: CourseFilters): Promise<Course[]> {
    try {
      // Use Supabase adapter temporarily, switch to API when ready
      if (!USE_API_BACKEND) {
        return await supabaseCourseAdapter.getAllCourses();
      }

      // API Backend implementation
      const params = new URLSearchParams();

      if (filters?.level) params.append('level', filters.level);
      if (filters?.category) params.append('category', filters.category);
      if (filters?.search) params.append('search', filters.search);
      if (filters?.page) params.append('page', filters.page.toString());
      if (filters?.limit) params.append('limit', filters.limit.toString());

      const response = await api.get<Course[]>(
        `${ENDPOINTS.COURSES.BASE}?${params.toString()}`
      );

      return response.data;
    } catch (error) {
      console.error('Error fetching courses:', error);
      throw error;
    }
  }
  
  /**
   * Get course by ID
   */
  async getCourseById(id: string): Promise<Course | null> {
    try {
      // Use Supabase adapter temporarily
      if (!USE_API_BACKEND) {
        return await supabaseCourseAdapter.getCourseById(id);
      }

      // API Backend implementation
      const response = await api.get<Course>(ENDPOINTS.COURSES.BY_ID(id));
      return response.data;
    } catch (error) {
      console.error(`Error fetching course ${id}:`, error);
      throw error;
    }
  }
  
  /**
   * Get featured courses
   */
  async getFeaturedCourses(): Promise<Course[]> {
    try {
      const response = await api.get<Course[]>(ENDPOINTS.COURSES.FEATURED);
      return response.data;
    } catch (error) {
      console.error('Error fetching featured courses:', error);
      throw error;
    }
  }
  
  /**
   * Search courses
   */
  async searchCourses(query: string): Promise<Course[]> {
    try {
      const response = await api.get<Course[]>(
        `${ENDPOINTS.COURSES.SEARCH}?q=${encodeURIComponent(query)}`
      );
      return response.data;
    } catch (error) {
      console.error('Error searching courses:', error);
      throw error;
    }
  }
  
  /**
   * Get courses by category
   */
  async getCoursesByCategory(category: string): Promise<Course[]> {
    try {
      const response = await api.get<Course[]>(ENDPOINTS.COURSES.BY_CATEGORY(category));
      return response.data;
    } catch (error) {
      console.error(`Error fetching courses for category ${category}:`, error);
      throw error;
    }
  }
  
  /**
   * Get courses by level
   */
  async getCoursesByLevel(level: string): Promise<Course[]> {
    try {
      const response = await api.get<Course[]>(ENDPOINTS.COURSES.BY_LEVEL(level));
      return response.data;
    } catch (error) {
      console.error(`Error fetching courses for level ${level}:`, error);
      throw error;
    }
  }
  
  /**
   * Get course modules
   */
  async getCourseModules(courseId: string): Promise<Module[]> {
    try {
      // Use Supabase adapter temporarily
      if (!USE_API_BACKEND) {
        return await supabaseCourseAdapter.getCourseModules(courseId);
      }

      // API Backend implementation
      const response = await api.get<Module[]>(ENDPOINTS.MODULES.BY_COURSE(courseId));
      return response.data;
    } catch (error) {
      console.error(`Error fetching modules for course ${courseId}:`, error);
      throw error;
    }
  }

  /**
   * Get module lessons
   */
  async getModuleLessons(moduleId: string): Promise<Lesson[]> {
    try {
      // Use Supabase adapter temporarily
      if (!USE_API_BACKEND) {
        return await supabaseCourseAdapter.getModuleLessons(moduleId);
      }

      // API Backend implementation
      const response = await api.get<Lesson[]>(ENDPOINTS.LESSONS.BY_MODULE(moduleId));
      return response.data;
    } catch (error) {
      console.error(`Error fetching lessons for module ${moduleId}:`, error);
      throw error;
    }
  }

  /**
   * Get lesson by ID
   */
  async getLessonById(id: string): Promise<Lesson | null> {
    try {
      // Use Supabase adapter temporarily
      if (!USE_API_BACKEND) {
        return await supabaseCourseAdapter.getLessonById(id);
      }

      // API Backend implementation
      const response = await api.get<Lesson>(ENDPOINTS.LESSONS.BY_ID(id));
      return response.data;
    } catch (error) {
      console.error(`Error fetching lesson ${id}:`, error);
      throw error;
    }
  }
  
  /**
   * Enroll in course
   */
  async enrollInCourse(courseId: string): Promise<void> {
    try {
      await api.post(ENDPOINTS.COURSES.ENROLL(courseId));
    } catch (error) {
      console.error(`Error enrolling in course ${courseId}:`, error);
      throw error;
    }
  }
  
  /**
   * Unenroll from course
   */
  async unenrollFromCourse(courseId: string): Promise<void> {
    try {
      await api.post(ENDPOINTS.COURSES.UNENROLL(courseId));
    } catch (error) {
      console.error(`Error unenrolling from course ${courseId}:`, error);
      throw error;
    }
  }
}

// Export singleton instance
export const courseService = new CourseService();
export default courseService;

