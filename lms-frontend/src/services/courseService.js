// Course Service - Real Supabase Integration
// This service handles actual course creation in your Supabase database

import { createClient } from '@supabase/supabase-js';

// Initialize Supabase client (using anon key for now - in production, use backend API)
const supabaseUrl = process.env.REACT_APP_SUPABASE_URL || 'https://your-project.supabase.co';
const supabaseAnonKey = process.env.REACT_APP_SUPABASE_ANON_KEY || 'your-anon-key';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

class CourseService {
  // Get current user ID (simplified - in production, get from auth service)
  getCurrentUserId() {
    // This is a placeholder - in real implementation, get from your auth system
    return localStorage.getItem('user_id') || 'demo_instructor_id';
  }

  // Get all courses (for student browsing)
  async getAllCourses() {
    try {
      console.log('Fetching courses from Supabase...');
      
      const { data, error } = await supabase
        .from('courses')
        .select(`
          *,
          modules!fk_modules_course_id (
            id,
            title,
            description,
            ordering,
            duration,
            lessons!fk_lessons_module_id (
              id,
              title,
              ordering,
              duration
            )
          )
        `)
        .eq('is_published', true)
        .order('created_at', { ascending: false });

      if (error) {
        console.error('Supabase query error:', error);
        throw error;
      }
      
      // Process the data to ensure proper structure
      if (data && Array.isArray(data)) {
        const processedData = data.map(course => {
          // Ensure modules exist and are sorted
          if (course.modules && Array.isArray(course.modules)) {
            course.modules.sort((a, b) => (a.ordering || 0) - (b.ordering || 0));
            
            // Ensure lessons within each module are sorted
            course.modules.forEach(module => {
              if (module.lessons && Array.isArray(module.lessons)) {
                module.lessons.sort((a, b) => (a.ordering || 0) - (b.ordering || 0));
              }
            });
          }
          return course;
        });
        
        console.log('Successfully fetched courses:', processedData.length);
        return processedData;
      }
      
      console.log('No courses found');
      return [];
    } catch (error) {
      console.error('Error fetching courses:', error);
      throw error;
    }
  }

  // Get course by ID (for course detail page)
  async getCourseById(courseId) {
    try {
      console.log('Fetching course by ID:', courseId);
      
      // Validate input
      if (!courseId) {
        throw new Error('Course ID is required');
      }
      
      // First, get the course data
      const { data: courseData, error: courseError } = await supabase
        .from('courses')
        .select(`
          *,
          modules!fk_modules_course_id (
            id,
            title,
            description,
            ordering,
            duration,
            lessons!fk_lessons_module_id (
              id,
              title,
              ordering,
              duration
            )
          )
        `)
        .eq('id', courseId)
        .eq('is_published', true)
        .single();

      console.log('Supabase response:', { courseData, courseError });

      if (courseError) {
        console.error('Course fetch error for ID', courseId, ':', courseError);
        throw new Error(`Failed to fetch course: ${courseError.message || courseError}`);
      }
      
      if (!courseData) {
        console.warn('Course not found for ID:', courseId);
        throw new Error('Course not found');
      }

      // Ensure modules are sorted by ordering
      if (courseData.modules && Array.isArray(courseData.modules)) {
        courseData.modules.sort((a, b) => (a.ordering || 0) - (b.ordering || 0));
        
        // Ensure lessons within each module are sorted by ordering
        courseData.modules.forEach(module => {
          if (module.lessons && Array.isArray(module.lessons)) {
            module.lessons.sort((a, b) => (a.ordering || 0) - (b.ordering || 0));
          }
        });
      }

      console.log('Successfully fetched course:', courseData.title);
      return courseData;
    } catch (error) {
      console.error('Error fetching course by ID', courseId, ':', error);
      throw new Error(`Failed to load course: ${error.message || 'Unknown error'}. Please try again later.`);
    }
  }

  // Enroll user in course
  async enrollInCourse(courseId, userId) {
    try {
      const enrollment = {
        user_id: userId,
        course_id: courseId,
        enrolled_at: new Date().toISOString(),
        progress: 0
      };

      const { data, error } = await supabase
        .from('enrollments')
        .insert([enrollment])
        .select()
        .single();

      if (error) throw error;
      return data;
    } catch (error) {
      console.error('Error enrolling in course:', error);
      throw error;
    }
  }

  // Create a new course in Supabase
  async createCourse(courseData) {
    try {
      const userId = this.getCurrentUserId();
      
      const course = {
        title: courseData.title,
        description: courseData.description,
        instructor_id: userId,
        category: courseData.category || 'General',
        level: courseData.level || 'Beginner',
        duration: courseData.duration || '4 weeks',
        objectives: courseData.objectives || [],
        prerequisites: courseData.prerequisites || [],
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
        is_published: false, // Start as draft for review
        thumbnail_url: courseData.thumbnail_url || null,
        price: courseData.price || 0
      };

      // Insert course into Supabase
      const { data, error } = await supabase
        .from('courses')
        .insert([course])
        .select()
        .single();

      if (error) throw error;
      return data;
    } catch (error) {
      console.error('Error creating course in Supabase:', error);
      throw error;
    }
  }

  // Save course outline to Supabase
  async saveCourseOutline(courseId, outlineData) {
    try {
      const outline = {
        course_id: courseId,
        content: outlineData.content,
        version: outlineData.version || 1,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      };

      const { data, error } = await supabase
        .from('course_outlines')
        .insert([outline])
        .select()
        .single();

      if (error) throw error;
      return data;
    } catch (error) {
      console.error('Error saving course outline:', error);
      throw error;
    }
  }

  // Create modules for a course
  async createModules(courseId, modulesData) {
    try {
      const modules = modulesData.map((module, index) => ({
        course_id: courseId,
        title: module.title,
        description: module.description,
        ordering: index + 1,
        duration: module.duration || '1 week',
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      }));

      const { data, error } = await supabase
        .from('modules')
        .insert(modules)
        .select();

      if (error) throw error;
      return data;
    } catch (error) {
      console.error('Error creating modules:', error);
      throw error;
    }
  }

  // Create lessons for a module
  async createLessons(moduleId, lessonsData) {
    try {
      const lessons = lessonsData.map((lesson, index) => ({
        module_id: moduleId,
        title: lesson.title,
        content: lesson.content,
        ordering: index + 1,
        duration: lesson.duration || '1 hour',
        video_url: lesson.video_url || null,
        resources: lesson.resources || [],
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      }));

      const { data, error } = await supabase
        .from('lessons')
        .insert(lessons)
        .select();

      if (error) throw error;
      return data;
    } catch (error) {
      console.error('Error creating lessons:', error);
      throw error;
    }
  }

  // Create assessments for a module
  async createAssessments(moduleId, assessmentsData) {
    try {
      const assessments = assessmentsData.map((assessment, index) => ({
        module_id: moduleId,
        title: assessment.title,
        type: assessment.type, // 'quiz', 'assignment', 'exam'
        questions: assessment.questions || [],
        passing_score: assessment.passing_score || 70,
        attempts_allowed: assessment.attempts_allowed || 3,
        time_limit: assessment.time_limit || null,
        ordering: index + 1,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      }));

      const { data, error } = await supabase
        .from('assessments')
        .insert(assessments)
        .select();

      if (error) throw error;
      return data;
    } catch (error) {
      console.error('Error creating assessments:', error);
      throw error;
    }
  }

  // Publish a course (change status from draft to published)
  async publishCourse(courseId) {
    try {
      const { data, error } = await supabase
        .from('courses')
        .update({ 
          is_published: true,
          published_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        })
        .eq('id', courseId)
        .select()
        .single();

      if (error) throw error;
      return data;
    } catch (error) {
      console.error('Error publishing course:', error);
      throw error;
    }
  }

  // Get course creation templates
  async getCourseTemplates() {
    try {
      // In a real implementation, this would fetch from Supabase
      const templates = [
        {
          id: 'web-dev',
          name: 'Web Development Course Template',
          description: 'Complete template for full-stack web development courses',
          modules: 6,
          duration: '8 weeks'
        },
        {
          id: 'app-dev',
          name: 'App Development Course Template',
          description: 'Template for mobile app development with React Native',
          modules: 5,
          duration: '6 weeks'
        },
        {
          id: 'digital-marketing',
          name: 'Digital Marketing Course Template',
          description: 'Comprehensive digital marketing course template',
          modules: 4,
          duration: '5 weeks'
        }
      ];
      
      return templates;
    } catch (error) {
      console.error('Error getting templates:', error);
      throw error;
    }
  }

  // Get existing courses for the instructor
  async getInstructorCourses() {
    try {
      const userId = this.getCurrentUserId();
      
      const { data, error } = await supabase
        .from('courses')
        .select('*')
        .eq('instructor_id', userId)
        .order('created_at', { ascending: false });

      if (error) throw error;
      return data;
    } catch (error) {
      console.error('Error fetching instructor courses:', error);
      throw error;
    }
  }
}

// Export singleton instance
const courseService = new CourseService();

// Export individual methods for named imports
export const getAllCourses = courseService.getAllCourses.bind(courseService);
export const getCourseById = courseService.getCourseById.bind(courseService);
export const enrollInCourse = courseService.enrollInCourse.bind(courseService);
export const createCourse = courseService.createCourse.bind(courseService);
export const saveCourseOutline = courseService.saveCourseOutline.bind(courseService);
export const createModules = courseService.createModules.bind(courseService);
export const createLessons = courseService.createLessons.bind(courseService);
export const createAssessments = courseService.createAssessments.bind(courseService);
export const publishCourse = courseService.publishCourse.bind(courseService);
export const getCourseTemplates = courseService.getCourseTemplates.bind(courseService);
export const getInstructorCourses = courseService.getInstructorCourses.bind(courseService);

export default courseService;