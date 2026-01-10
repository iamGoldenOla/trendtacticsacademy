/**
 * Supabase Adapter
 * 
 * This adapter allows the frontend to work with Supabase temporarily.
 * When you build your backend API, you can remove this adapter and
 * the frontend will work seamlessly with the new backend.
 * 
 * This is the ONLY file that knows about Supabase.
 * All other files use the generic API service.
 */

import { createClient } from '@supabase/supabase-js';
import { Course, Module, Lesson } from '../../types/api.types';

// Initialize Supabase client
const supabaseUrl = process.env.REACT_APP_SUPABASE_URL || '';
const supabaseKey = process.env.REACT_APP_SUPABASE_ANON_KEY || '';

export const supabase = createClient(supabaseUrl, supabaseKey);

/**
 * Supabase Course Adapter
 * Adapts Supabase responses to match our API types
 */
export class SupabaseCourseAdapter {
  /**
   * Get all courses
   */
  async getAllCourses(): Promise<Course[]> {
    const { data, error } = await supabase
      .from('courses')
      .select('*')
      .order('created_at', { ascending: false });
    
    if (error) throw error;
    
    return this.mapCoursesFromSupabase(data || []);
  }
  
  /**
   * Get course by ID
   */
  async getCourseById(id: string): Promise<Course | null> {
    const { data, error } = await supabase
      .from('courses')
      .select('*')
      .eq('id', id)
      .single();
    
    if (error) throw error;
    
    return data ? this.mapCourseFromSupabase(data) : null;
  }
  
  /**
   * Get course modules
   */
  async getCourseModules(courseId: string): Promise<Module[]> {
    const { data, error } = await supabase
      .from('modules')
      .select('*')
      .eq('course_id', courseId)
      .order('order_index', { ascending: true });
    
    if (error) throw error;
    
    return this.mapModulesFromSupabase(data || []);
  }
  
  /**
   * Get module lessons
   */
  async getModuleLessons(moduleId: string): Promise<Lesson[]> {
    const { data, error } = await supabase
      .from('lessons')
      .select('*')
      .eq('module_id', moduleId)
      .order('order_index', { ascending: true });
    
    if (error) throw error;
    
    return this.mapLessonsFromSupabase(data || []);
  }
  
  /**
   * Get lesson by ID
   */
  async getLessonById(id: string): Promise<Lesson | null> {
    const { data, error } = await supabase
      .from('lessons')
      .select('*')
      .eq('id', id)
      .single();
    
    if (error) throw error;
    
    return data ? this.mapLessonFromSupabase(data) : null;
  }
  
  // ============================================================================
  // Mapping Functions - Convert Supabase format to API format
  // ============================================================================
  
  private mapCourseFromSupabase(data: any): Course {
    return {
      id: data.id,
      title: data.title,
      description: data.description,
      thumbnail_url: data.thumbnail_url,
      level: data.level,
      category: data.category,
      price: data.price,
      duration: data.duration,
      instructor_id: data.instructor_id,
      objectives: data.objectives,
      requirements: data.requirements,
      tags: data.tags,
      isPublished: data.is_published ?? true,
      createdAt: data.created_at,
      updatedAt: data.updated_at,
    };
  }
  
  private mapCoursesFromSupabase(data: any[]): Course[] {
    return data.map(item => this.mapCourseFromSupabase(item));
  }
  
  private mapModuleFromSupabase(data: any): Module {
    return {
      id: data.id,
      course_id: data.course_id,
      title: data.title,
      description: data.description,
      order_index: data.order_index,
      duration: data.duration,
      createdAt: data.created_at,
      updatedAt: data.updated_at,
    };
  }
  
  private mapModulesFromSupabase(data: any[]): Module[] {
    return data.map(item => this.mapModuleFromSupabase(item));
  }
  
  private mapLessonFromSupabase(data: any): Lesson {
    return {
      id: data.id,
      module_id: data.module_id,
      title: data.title,
      description: data.description,
      content: data.content,
      content_type: data.content_type,
      video_url: data.video_url,
      duration: data.duration,
      order_index: data.order_index,
      isPreview: data.is_preview ?? false,
      resources: data.resources,
      createdAt: data.created_at,
      updatedAt: data.updated_at,
    };
  }
  
  private mapLessonsFromSupabase(data: any[]): Lesson[] {
    return data.map(item => this.mapLessonFromSupabase(item));
  }
}

// Export singleton instance
export const supabaseCourseAdapter = new SupabaseCourseAdapter();
export default supabaseCourseAdapter;

