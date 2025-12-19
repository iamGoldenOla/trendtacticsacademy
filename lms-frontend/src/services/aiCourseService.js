// AI Course Generator Service
// This service simulates AI-generated courses for demonstration purposes
// In a real implementation, this would connect to an AI service or backend API

class AICourseService {
  // Generate a course based on a topic
  async generateCourse(topic) {
    try {
      console.log('Generating AI course for topic:', topic);
      
      // Simulate AI processing delay
      await new Promise(resolve => setTimeout(resolve, 2000));
      
      // Generate a course based on the topic
      const course = this.createCourseFromTopic(topic);
      
      console.log('AI course generated:', course);
      return course;
    } catch (error) {
      console.error('Error generating AI course:', error);
      throw error;
    }
  }
  
  // Create a course structure based on a topic
  createCourseFromTopic(topic) {
    // Normalize the topic for course title
    const normalizedTopic = topic.charAt(0).toUpperCase() + topic.slice(1).toLowerCase();
    
    // Generate course ID (in real implementation, this would come from the database)
    const courseId = this.generateUUID();
    
    // Create course structure
    const course = {
      id: courseId,
      title: `Master ${normalizedTopic}`,
      description: `Learn everything you need to know about ${topic} in this comprehensive course.`,
      category: this.determineCategory(topic),
      level: 'Beginner',
      duration: '4 weeks',
      price: 0, // Free by default
      is_published: true,
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
      thumbnail_url: this.getThumbnailUrl(topic),
      modules: this.generateModules(topic, courseId)
    };
    
    return course;
  }
  
  // Generate modules for a course
  generateModules(topic, courseId) {
    const modules = [];
    
    // Generate 3-5 modules based on the topic
    const moduleCount = Math.floor(Math.random() * 3) + 3; // 3-5 modules
    
    for (let i = 1; i <= moduleCount; i++) {
      const moduleId = this.generateUUID();
      
      modules.push({
        id: moduleId,
        course_id: courseId,
        title: `${topic} Module ${i}`,
        description: `Learn the fundamentals of ${topic} in module ${i}`,
        ordering: i,
        duration: `${Math.floor(Math.random() * 2) + 1} week${Math.floor(Math.random() * 2) + 1 > 1 ? 's' : ''}`,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
        lessons: this.generateLessons(topic, moduleId, i)
      });
    }
    
    return modules;
  }
  
  // Generate lessons for a module
  generateLessons(topic, moduleId, moduleNumber) {
    const lessons = [];
    
    // Generate 2-4 lessons per module
    const lessonCount = Math.floor(Math.random() * 3) + 2; // 2-4 lessons
    
    for (let i = 1; i <= lessonCount; i++) {
      lessons.push({
        id: this.generateUUID(),
        module_id: moduleId,
        title: `${topic} Lesson ${moduleNumber}.${i}`,
        content: `This is the content for lesson ${moduleNumber}.${i} about ${topic}. In a real implementation, this would contain detailed educational content.`,
        ordering: i,
        duration: `${Math.floor(Math.random() * 60) + 30} minutes`,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      });
    }
    
    return lessons;
  }
  
  // Determine category based on topic
  determineCategory(topic) {
    const topicLower = topic.toLowerCase();
    
    if (topicLower.includes('web') || topicLower.includes('html') || topicLower.includes('css') || topicLower.includes('javascript')) {
      return 'Web Development';
    } else if (topicLower.includes('mobile') || topicLower.includes('app') || topicLower.includes('react native')) {
      return 'Mobile Development';
    } else if (topicLower.includes('marketing') || topicLower.includes('seo') || topicLower.includes('social')) {
      return 'Digital Marketing';
    } else if (topicLower.includes('data') || topicLower.includes('analytics')) {
      return 'Data Science';
    } else {
      return 'General';
    }
  }
  
  // Get thumbnail URL based on topic
  getThumbnailUrl(topic) {
    const topicLower = topic.toLowerCase();
    
    if (topicLower.includes('web')) {
      return 'https://placehold.co/400x200/3b82f6/white?text=Web+Development';
    } else if (topicLower.includes('mobile') || topicLower.includes('app')) {
      return 'https://placehold.co/400x200/10b981/white?text=App+Development';
    } else if (topicLower.includes('marketing')) {
      return 'https://placehold.co/400x200/f59e0b/white?text=Digital+Marketing';
    } else if (topicLower.includes('data')) {
      return 'https://placehold.co/400x200/8b5cf6/white?text=Data+Science';
    } else {
      return 'https://placehold.co/400x200/6b7280/white?text=Course+Thumbnail';
    }
  }
  
  // Generate a UUID (simplified version for demonstration)
  generateUUID() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      const r = Math.random() * 16 | 0;
      const v = c == 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16);
    }).replace(/[g-z]/g, function(c) {
      // Ensure only valid hex characters (0-9, a-f)
      const hexChars = '0123456789abcdef';
      return hexChars[Math.floor(Math.random() * 16)];
    });
  }
}

// Export singleton instance
const aiCourseService = new AICourseService();

export default aiCourseService;