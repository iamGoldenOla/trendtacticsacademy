import { get, post, put, del } from './api';
import { ApiResponse, Course } from './types';
import { digitalMarketingCourses } from '../data/digitalMarketingCourses';

const COURSE_ENDPOINTS = {
  GET_ALL: '/courses',
  GET_BY_ID: (id: string) => `/courses/${id}`,
  CREATE: '/courses',
  UPDATE: (id: string) => `/courses/${id}`,
  DELETE: (id: string) => `/courses/${id}`,
  GET_BY_CATEGORY: (category: string) => `/courses/category/${category}`,
  ENROLL: (id: string) => `/courses/${id}/enroll`,
  GET_ENROLLED: '/courses/student/enrolled',
};

/**
 * Get all courses
 */
export const getAllCourses = async (): Promise<Course[]> => {
  try {
    // Use local data for demo purposes to show games functionality
    return digitalMarketingCourses as any[];
  } catch (error) {
    console.error('Error fetching courses:', error);
    return [];
  }
};

/**
 * Get course by ID
 */
export const getCourseById = async (id: string): Promise<Course | null> => {
  try {
    // Use local data for demo purposes to show games functionality
    const course = digitalMarketingCourses.find(c => c.id === id);
    return course as any || null;
  } catch (error) {
    console.error(`Error fetching course with ID ${id}:`, error);
    return null;
  }
};

/**
 * Get courses by category
 */
export const getCoursesByCategory = async (category: string): Promise<Course[]> => {
  try {
    const response = await get<ApiResponse<Course[]>>(COURSE_ENDPOINTS.GET_BY_CATEGORY(category));
    if (response.success && response.data) {
      return response.data;
    }
    return [];
  } catch (error) {
    console.error(`Error fetching courses in category ${category}:`, error);
    return [];
  }
};

/**
 * Create a new course (instructor/admin only)
 */
export const createCourse = async (courseData: Partial<Course>): Promise<Course | null> => {
  try {
    const response = await post<ApiResponse<Course>>(COURSE_ENDPOINTS.CREATE, courseData);
    if (response.success && response.data) {
      return response.data;
    }
    return null;
  } catch (error: any) {
    console.error('Error creating course:', error);
    throw new Error(error.response?.data?.message || error.message || 'Failed to create course');
  }
};

/**
 * Update an existing course (instructor/admin only)
 */
export const updateCourse = async (id: string, courseData: Partial<Course>): Promise<Course | null> => {
  try {
    const response = await put<ApiResponse<Course>>(COURSE_ENDPOINTS.UPDATE(id), courseData);
    if (response.success && response.data) {
      return response.data;
    }
    return null;
  } catch (error: any) {
    console.error(`Error updating course with ID ${id}:`, error);
    throw new Error(error.response?.data?.message || error.message || 'Failed to update course');
  }
};

/**
 * Delete a course (instructor/admin only)
 */
export const deleteCourse = async (id: string): Promise<boolean> => {
  try {
    const response = await del<ApiResponse<any>>(COURSE_ENDPOINTS.DELETE(id));
    return response.success || false;
  } catch (error) {
    console.error(`Error deleting course with ID ${id}:`, error);
    return false;
  }
};

/**
 * Enroll in a course
 */
export const enrollInCourse = async (courseId: string): Promise<boolean> => {
  try {
    const response = await post<ApiResponse<any>>(COURSE_ENDPOINTS.ENROLL(courseId));
    return response.success || false;
  } catch (error) {
    console.error(`Error enrolling in course with ID ${courseId}:`, error);
    return false;
  }
};

/**
 * Get enrolled courses for the current user
 */
export const getEnrolledCourses = async (): Promise<Course[]> => {
  try {
    const response = await get<ApiResponse<Course[]>>(COURSE_ENDPOINTS.GET_ENROLLED);
    if (response.success && response.data) {
      return response.data;
    }
    return [];
  } catch (error) {
    console.error('Error fetching enrolled courses:', error);
    return [];
  }
};

export default {
  getAllCourses,
  getCourseById,
  getCoursesByCategory,
  createCourse,
  updateCourse,
  deleteCourse,
  enrollInCourse,
  getEnrolledCourses,
};