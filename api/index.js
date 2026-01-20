// API Index - Entry point for Vibe Coding API endpoints

// Import the lesson retrieval functions
const getLesson = require('./get-lesson');
const resolveCourse = require('./resolve-course');

/**
 * Main API handler
 * Routes requests to appropriate functions based on the path
 */
module.exports = async function handler(req, res) {
  // Set CORS headers
  res.setHeader('Access-Control-Allow-Credentials', true);
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT');
  res.setHeader(
    'Access-Control-Allow-Headers',
    'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version'
  );

  // Handle preflight requests
  if (req.method === 'OPTIONS') {
    res.status(200).end();
    return;
  }

  // Parse the URL to determine the endpoint
  const url = new URL(req.url, `http://${req.headers.host}`);
  const path = url.pathname;
  const params = url.searchParams;

  try {
    // Route based on the path
    if (path === '/api/lesson' || path === '/api/get-lesson') {
      // Get a specific lesson
      req.query = {
        id: params.get('id'),
        moduleTitle: params.get('moduleTitle'),
        lessonNumber: params.get('lessonNumber'),
        courseTitle: params.get('courseTitle')
      };

      await getLesson(req, res);
    }
    else if (path === '/api/module-lessons' || path === '/api/get-module-lessons') {
      // Get all lessons for a specific module
      req.query = {
        moduleTitle: params.get('moduleTitle')
      };

      await getLesson.getAllModuleLessons(req, res);
    }
    else if (path === '/api/course-modules' || path === '/api/get-course-modules') {
      // Get all modules for a specific course
      req.query = {
        courseTitle: params.get('courseTitle')
      };

      await getLesson.getAllCourseModules(req, res);
    }
    else if (path === '/api/courses/resolve' || path === '/api/resolve-course') {
      // Resolve a course (fetch or generate)
      req.query = {
        id: params.get('id')
      };

      await resolveCourse(req, res);
    }
    else {
      // Unknown endpoint
      res.status(404).json({ error: 'Endpoint not found' });
    }
  } catch (error) {
    console.error('API handler error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};