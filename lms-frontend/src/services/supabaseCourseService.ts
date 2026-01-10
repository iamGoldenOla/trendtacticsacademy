/**
 * Supabase Course Service
 * Connects directly to Supabase database to fetch courses, modules, and lessons
 */

import { supabase } from './supabaseClient';

export interface Course {
  id: string;
  title: string;
  description: string;
  instructor_id?: string;
  category: string;
  level: string;
  duration?: string;
  objectives?: any;
  prerequisites?: any;
  thumbnail_url?: string;
  status: string;
  price?: number;
  created_at?: string;
  updated_at?: string;
}

export interface Module {
  id: string;
  course_id: string;
  title: string;
  description?: string;
  ordering: number;
  created_at?: string;
  updated_at?: string;
}

export interface Lesson {
  id: string;
  module_id: string;
  title: string;
  description?: string;
  content?: string;
  ordering: number;
  duration?: string;
  video_url?: string;
  resources?: any;
  created_at?: string;
  updated_at?: string;
}

/**
 * Get all courses from Supabase
 */
export const getAllCourses = async (): Promise<Course[]> => {
  try {
    const { data, error } = await supabase
      .from('courses')
      .select('*')
      .eq('status', 'published')
      .order('created_at', { ascending: false });

    if (error) {
      console.error('Error fetching courses:', error);
      return [];
    }

    return data || [];
  } catch (error) {
    console.error('Error fetching courses:', error);
    return [];
  }
};

/**
 * Get course by ID with modules and lessons
 */
export const getCourseById = async (id: string): Promise<Course | null> => {
  try {
    const { data, error } = await supabase
      .from('courses')
      .select('*')
      .eq('id', id)
      .single();

    if (error) {
      console.error(`Error fetching course ${id}:`, error);
      return null;
    }

    return data;
  } catch (error) {
    console.error(`Error fetching course ${id}:`, error);
    return null;
  }
};

/**
 * Get modules for a course
 */
export const getCourseModules = async (courseId: string): Promise<Module[]> => {
  try {
    const { data, error } = await supabase
      .from('modules')
      .select('*')
      .eq('course_id', courseId)
      .order('ordering', { ascending: true });

    if (error) {
      console.error(`Error fetching modules for course ${courseId}:`, error);
      return [];
    }

    return data || [];
  } catch (error) {
    console.error(`Error fetching modules for course ${courseId}:`, error);
    return [];
  }
};

/**
 * Get lessons for a module
 */
export const getModuleLessons = async (moduleId: string): Promise<Lesson[]> => {
  try {
    const { data, error } = await supabase
      .from('lessons')
      .select('*')
      .eq('module_id', moduleId)
      .order('ordering', { ascending: true });

    if (error) {
      console.error(`Error fetching lessons for module ${moduleId}:`, error);
      return [];
    }

    return data || [];
  } catch (error) {
    console.error(`Error fetching lessons for module ${moduleId}:`, error);
    return [];
  }
};

/**
 * Get lesson by ID
 */
export const getLessonById = async (lessonId: string): Promise<Lesson | null> => {
  try {
    const { data, error } = await supabase
      .from('lessons')
      .select('*')
      .eq('id', lessonId)
      .single();

    if (error) {
      console.error(`Error fetching lesson ${lessonId}:`, error);
      return null;
    }

    return data;
  } catch (error) {
    console.error(`Error fetching lesson ${lessonId}:`, error);
    return null;
  }
};

