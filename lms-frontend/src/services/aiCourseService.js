// AI Course Generator Service
// This service connects to backend API for AI-powered course generation

import { post } from './api';

const AI_COURSE_ENDPOINT = '/ai/courses/generate';

class AICourseService {
  // Generate a course based on a topic
  async generateCourse(topic) {
    try {
      console.log('Generating AI course for topic:', topic);
      
      // Call backend API to generate course
      const response = await post(AI_COURSE_ENDPOINT, { topic });
      
      if (response.success && response.data) {
        console.log('AI course generated:', response.data);
        return response.data;
      } else {
        throw new Error(response.message || 'Failed to generate AI course');
      }
    } catch (error) {
      console.error('Error generating AI course:', error);
      throw error;
    }
  }
  

}

// Export singleton instance
const aiCourseService = new AICourseService();

export default aiCourseService;