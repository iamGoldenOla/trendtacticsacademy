// Course Service - Supabase Integration
// This service handles course operations through Supabase directly

import { supabase } from './supabaseClient';


// Use Supabase tables directly instead of backend API

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
      
      const { data: courses, error } = await supabase
        .from('courses')
        .select('*')
        .eq('is_published', true)
        .order('created_at', { ascending: false });
      
      if (error) {
        console.error('Error fetching courses from Supabase:', error.message);
        // Even if there's an error, we should not break the app - return empty array
        return [];
      }
      
      console.log('Successfully fetched courses:', courses?.length || 0);
      return courses || [];
    } catch (error) {
      console.error('Error fetching courses:', error);
      // Even if there's an error, we should not break the app - return empty array
      return [];
    }
  }

  // Get course by ID (for course detail page)
  async getCourseById(courseId) {
    try {
      console.log('Fetching course by ID from Supabase:', courseId);
      
      // Validate input
      if (!courseId) {
        throw new Error('Course ID is required');
      }
      
      // Check if courseId looks like a UUID
      const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
      if (!uuidRegex.test(courseId)) {
        console.error('Invalid UUID format:', courseId);
        throw new Error('Invalid course ID format. Expected a UUID.');
      }
      
      const { data: courseData, error } = await supabase
        .from('courses')
        .select('*')
        .eq('id', courseId)
        .single();
      
      if (error) {
        console.error('Error fetching course from Supabase:', error.message);
        throw new Error('Course not found');
      }
      
      console.log('Successfully fetched course:', courseData.title);
      return courseData;
    } catch (error) {
      console.error('Error fetching course by ID', courseId, ':', error);
      throw error;
    }
  }

  // Enroll user in course
  async enrollInCourse(courseId) {
    try {
      // Get current user
      const { data: { user }, error: authError } = await supabase.auth.getUser();
      
      if (authError || !user) {
        throw new Error('User not authenticated');
      }
      
      // Check if user is already enrolled
      const { data: existingEnrollment, error: checkError } = await supabase
        .from('enrollments')
        .select('*')
        .eq('user_id', user.id)
        .eq('course_id', courseId)
        .single();
      
      if (!checkError && existingEnrollment) {
        // Already enrolled
        return { success: true, message: 'Already enrolled in this course' };
      }
      
      // Create enrollment record
      const { data: enrollment, error: enrollError } = await supabase
        .from('enrollments')
        .insert([{ 
          user_id: user.id, 
          course_id: courseId, 
          enrolled_at: new Date().toISOString(),
          status: 'active'
        }]);
      
      if (enrollError) {
        console.error('Error enrolling in course:', enrollError.message);
        throw new Error(enrollError.message);
      }
      
      // Update user's enrolled courses in the users table
      const { data: userData, error: userError } = await supabase
        .from('users')
        .select('enrolled_courses')
        .eq('id', user.id)
        .single();
      
      if (!userError && userData) {
        const enrolledCourses = userData.enrolled_courses || [];
        if (!enrolledCourses.includes(courseId)) {
          enrolledCourses.push(courseId);
          
          await supabase
            .from('users')
            .update({ enrolled_courses: enrolledCourses, updated_at: new Date().toISOString() })
            .eq('id', user.id);
        }
      }
      
      // Get course details for the email
      const { data: courseData, error: courseError } = await supabase
        .from('courses')
        .select('title')
        .eq('id', courseId)
        .single();
      
      // Send enrollment confirmation email
      if (courseData && courseData.title) {
        try {
          const emailResponse = await fetch('/api/emails/enrollment', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({
              email: user.email,
              studentName: userData?.name || user.user_metadata?.name || 'Student',
              courseTitle: courseData.title
            }),
          });
          
          const emailResult = await emailResponse.json();
          if (!emailResult.success) {
            console.error('Error sending enrollment confirmation email:', emailResult.error);
          }
        } catch (emailError) {
          console.error('Error sending enrollment confirmation email:', emailError);
        }
      }
      
      return { success: true, message: 'Successfully enrolled in course' };
    } catch (error) {
      console.error('Error enrolling in course:', error);
      throw error;
    }
  }

  // Create a new course
  async createCourse(courseData) {
    try {
      // Get current user
      const { data: { user }, error: authError } = await supabase.auth.getUser();
      
      if (authError || !user) {
        throw new Error('User not authenticated');
      }
      
      // Prepare course data with user ID and defaults
      const newCourse = {
        ...courseData,
        instructor_id: user.id,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
        is_published: courseData.is_published ?? false,
        is_featured: courseData.is_featured ?? false,
      };
      
      const { data: course, error: courseError } = await supabase
        .from('courses')
        .insert([newCourse])
        .select()
        .single();
      
      if (courseError) {
        console.error('Error creating course:', courseError.message);
        throw new Error(courseError.message);
      }
      
      return course;
    } catch (error) {
      console.error('Error creating course:', error);
      throw error;
    }
  }

  // Update a course
  async updateCourse(courseId, courseData) {
    try {
      // Get current user
      const { data: { user }, error: authError } = await supabase.auth.getUser();
      
      if (authError || !user) {
        throw new Error('User not authenticated');
      }
      
      // Update the course
      const { data: updatedCourse, error: courseError } = await supabase
        .from('courses')
        .update({
          ...courseData,
          updated_at: new Date().toISOString(),
        })
        .eq('id', courseId)
        .eq('instructor_id', user.id) // Ensure user owns the course
        .select()
        .single();
      
      if (courseError) {
        console.error('Error updating course:', courseError.message);
        throw new Error(courseError.message);
      }
      
      return updatedCourse;
    } catch (error) {
      console.error('Error updating course:', error);
      throw error;
    }
  }

  // Delete a course
  async deleteCourse(courseId) {
    try {
      // Get current user
      const { data: { user }, error: authError } = await supabase.auth.getUser();
      
      if (authError || !user) {
        throw new Error('User not authenticated');
      }
      
      // Delete the course
      const { error: courseError } = await supabase
        .from('courses')
        .delete()
        .eq('id', courseId)
        .eq('instructor_id', user.id); // Ensure user owns the course
      
      if (courseError) {
        console.error('Error deleting course:', courseError.message);
        throw new Error(courseError.message);
      }
      
      return { success: true, message: 'Course deleted successfully' };
    } catch (error) {
      console.error('Error deleting course:', error);
      throw error;
    }
  }

  // Get course creation templates
  async getCourseTemplates() {
    try {
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
      // Get current user
      const { data: { user }, error: authError } = await supabase.auth.getUser();
      
      if (authError || !user) {
        throw new Error('User not authenticated');
      }
      
      const { data: courses, error: courseError } = await supabase
        .from('courses')
        .select('*')
        .eq('instructor_id', user.id)
        .order('created_at', { ascending: false });
      
      if (courseError) {
        console.error('Error fetching instructor courses:', courseError.message);
        throw new Error(courseError.message);
      }
      
      return courses || [];
    } catch (error) {
      console.error('Error fetching instructor courses:', error);
      throw error;
    }
  }

  // Get enrolled courses for the current user
  async getEnrolledCourses() {
    try {
      // Get current user
      const { data: { user }, error: authError } = await supabase.auth.getUser();
      
      if (authError || !user) {
        throw new Error('User not authenticated');
      }
      
      // Get enrolled courses by joining enrollments and courses tables
      const { data: enrolledCourses, error: courseError } = await supabase
        .from('enrollments')
        .select(`
          courses!inner(
            id,
            title,
            description,
            thumbnail_url,
            duration,
            level,
            price,
            is_featured,
            is_published,
            created_at,
            updated_at
          ),
          enrolled_at,
          status
        `)
        .eq('user_id', user.id)
        .eq('courses.is_published', true);
      
      if (courseError) {
        console.error('Error fetching enrolled courses:', courseError.message);
        throw new Error(courseError.message);
      }
      
      // Return the course data from the joined result
      return enrolledCourses.map(item => ({
        ...item.courses,
        enrolled_at: item.enrolled_at,
        enrollment_status: item.status
      })) || [];
    } catch (error) {
      console.error('Error fetching enrolled courses:', error);
      throw error;
    }
  }

  // Add lesson to a course/module
  async addLesson(courseId, lessonData) {
    try {
      // Get current user
      const { data: { user }, error: authError } = await supabase.auth.getUser();
      
      if (authError || !user) {
        throw new Error('User not authenticated');
      }
      
      // Verify user owns the course
      const { data: course, error: courseCheckError } = await supabase
        .from('courses')
        .select('*')
        .eq('id', courseId)
        .eq('instructor_id', user.id)
        .single();
      
      if (courseCheckError || !course) {
        throw new Error('Course not found or you do not have permission to add lessons');
      }
      
      // Prepare lesson data
      const newLesson = {
        ...lessonData,
        course_id: courseId,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
      };
      
      const { data: lesson, error: lessonError } = await supabase
        .from('lessons')
        .insert([newLesson])
        .select()
        .single();
      
      if (lessonError) {
        console.error('Error adding lesson:', lessonError.message);
        throw new Error(lessonError.message);
      }
      
      return lesson;
    } catch (error) {
      console.error('Error adding lesson:', error);
      throw error;
    }
  }

  // Update a lesson
  async updateLesson(courseId, lessonId, lessonData) {
    try {
      // Get current user
      const { data: { user }, error: authError } = await supabase.auth.getUser();
      
      if (authError || !user) {
        throw new Error('User not authenticated');
      }
      
      // Verify user owns the course
      const { data: course, error: courseCheckError } = await supabase
        .from('courses')
        .select('*')
        .eq('id', courseId)
        .eq('instructor_id', user.id)
        .single();
      
      if (courseCheckError || !course) {
        throw new Error('Course not found or you do not have permission to update lessons');
      }
      
      // Update the lesson
      const { data: updatedLesson, error: lessonError } = await supabase
        .from('lessons')
        .update({
          ...lessonData,
          updated_at: new Date().toISOString(),
        })
        .eq('id', lessonId)
        .eq('course_id', courseId)
        .select()
        .single();
      
      if (lessonError) {
        console.error('Error updating lesson:', lessonError.message);
        throw new Error(lessonError.message);
      }
      
      return updatedLesson;
    } catch (error) {
      console.error('Error updating lesson:', error);
      throw error;
    }
  }

  // Mark lesson as complete
  async markLessonComplete(courseId, lessonId) {
    try {
      // Get current user
      const { data: { user }, error: authError } = await supabase.auth.getUser();
      
      if (authError || !user) {
        throw new Error('User not authenticated');
      }
      
      // Check if user is enrolled in the course
      const { data: enrollment, error: enrollmentError } = await supabase
        .from('enrollments')
        .select('*')
        .eq('user_id', user.id)
        .eq('course_id', courseId)
        .single();
      
      if (enrollmentError || !enrollment) {
        throw new Error('User is not enrolled in this course');
      }
      
      // Create or update lesson completion record
      const { data: completion, error: completionError } = await supabase
        .from('lesson_progress')
        .upsert([
          { 
            user_id: user.id, 
            course_id: courseId, 
            lesson_id: lessonId, 
            completed: true, 
            completed_at: new Date().toISOString()
          }
        ])
        .select()
        .single();
      
      if (completionError) {
        console.error('Error marking lesson complete:', completionError.message);
        throw new Error(completionError.message);
      }
      
      return completion;
    } catch (error) {
      console.error('Error marking lesson complete:', error);
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
export const updateCourse = courseService.updateCourse.bind(courseService);
export const deleteCourse = courseService.deleteCourse.bind(courseService);
export const getCourseTemplates = courseService.getCourseTemplates.bind(courseService);
export const getInstructorCourses = courseService.getInstructorCourses.bind(courseService);
export const getEnrolledCourses = courseService.getEnrolledCourses.bind(courseService);
export const addLesson = courseService.addLesson.bind(courseService);
export const updateLesson = courseService.updateLesson.bind(courseService);
export const markLessonComplete = courseService.markLessonComplete.bind(courseService);

export default courseService;