// API endpoint to get a specific lesson by ID or by module and lesson number
const { createClient } = require('@supabase/supabase-js');

// Initialize Supabase client
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

/**
 * API endpoint to retrieve a lesson by its ID or by module and lesson number
 * @param {Object} req - The request object
 * @param {Object} res - The response object
 */
module.exports = async function getLesson(req, res) {
  try {
    let lesson;
    
    // Check if the request is looking for a specific lesson by ID
    if (req.query.id) {
      const { data, error } = await supabase
        .from('lessons')
        .select('*, modules(title), courses(title)')
        .eq('id', req.query.id)
        .single();
      
      if (error) {
        console.error('Error fetching lesson by ID:', error);
        return res.status(500).json({ error: 'Failed to fetch lesson' });
      }
      
      lesson = data;
    } 
    // Check if the request is looking for a lesson by module and lesson number
    else if (req.query.moduleTitle && req.query.lessonNumber) {
      // First get the module ID
      const { data: moduleData, error: moduleError } = await supabase
        .from('modules')
        .select('id')
        .eq('title', req.query.moduleTitle)
        .single();
      
      if (moduleError || !moduleData) {
        console.error('Error fetching module:', moduleError);
        return res.status(500).json({ error: 'Failed to find module' });
      }
      
      // Then get the lesson using module ID and lesson number
      const { data, error } = await supabase
        .from('lessons')
        .select('*, modules(title), courses(title)')
        .eq('module_id', moduleData.id)
        .eq('lesson_number', req.query.lessonNumber)
        .single();
      
      if (error) {
        console.error('Error fetching lesson by module and number:', error);
        return res.status(500).json({ error: 'Failed to fetch lesson' });
      }
      
      lesson = data;
    } 
    // Check if the request is looking for a lesson by course, module and lesson number
    else if (req.query.courseTitle && req.query.moduleTitle && req.query.lessonNumber) {
      // Get the module ID based on course and module titles
      const { data: moduleData, error: moduleError } = await supabase
        .from('modules')
        .select('id')
        .eq('title', req.query.moduleTitle)
        .eq('course_id', req.query.courseTitle)
        .single();
      
      if (moduleError || !moduleData) {
        console.error('Error fetching module:', moduleError);
        return res.status(500).json({ error: 'Failed to find module' });
      }
      
      // Then get the lesson using module ID and lesson number
      const { data, error } = await supabase
        .from('lessons')
        .select('*, modules(title), courses(title)')
        .eq('module_id', moduleData.id)
        .eq('lesson_number', req.query.lessonNumber)
        .single();
      
      if (error) {
        console.error('Error fetching lesson by course, module and number:', error);
        return res.status(500).json({ error: 'Failed to fetch lesson' });
      }
      
      lesson = data;
    } 
    else {
      return res.status(400).json({ error: 'Missing required parameters' });
    }
    
    // Return the lesson data
    if (lesson) {
      // Format the response to match the expected lesson structure
      const formattedLesson = {
        id: lesson.id,
        course_title: lesson.courses.title,
        module_title: lesson.modules.title,
        lesson_number: lesson.lesson_number,
        lesson_title: lesson.title,
        lesson_content: lesson.lesson_json
      };
      
      res.status(200).json(formattedLesson);
    } else {
      res.status(404).json({ error: 'Lesson not found' });
    }
  } catch (error) {
    console.error('Unexpected error in getLesson:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

/**
 * API endpoint to get all lessons for a specific module
 * @param {Object} req - The request object
 * @param {Object} res - The response object
 */
module.exports.getAllModuleLessons = async function getAllModuleLessons(req, res) {
  try {
    if (!req.query.moduleTitle) {
      return res.status(400).json({ error: 'Missing module title parameter' });
    }
    
    // Get the module ID first
    const { data: moduleData, error: moduleError } = await supabase
      .from('modules')
      .select('id')
      .eq('title', req.query.moduleTitle)
      .single();
    
    if (moduleError || !moduleData) {
      console.error('Error fetching module:', moduleError);
      return res.status(500).json({ error: 'Failed to find module' });
    }
    
    // Get all lessons for this module
    const { data, error } = await supabase
      .from('lessons')
      .select('id, lesson_number, title')
      .eq('module_id', moduleData.id)
      .order('lesson_number', { ascending: true });
    
    if (error) {
      console.error('Error fetching module lessons:', error);
      return res.status(500).json({ error: 'Failed to fetch lessons' });
    }
    
    res.status(200).json({
      module: req.query.moduleTitle,
      lessons: data
    });
  } catch (error) {
    console.error('Unexpected error in getAllModuleLessons:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

/**
 * API endpoint to get all modules for a specific course
 * @param {Object} req - The request object
 * @param {Object} res - The response object
 */
module.exports.getAllCourseModules = async function getAllCourseModules(req, res) {
  try {
    if (!req.query.courseTitle) {
      return res.status(400).json({ error: 'Missing course title parameter' });
    }
    
    // Get the course ID first
    const { data: courseData, error: courseError } = await supabase
      .from('courses')
      .select('id')
      .eq('title', req.query.courseTitle)
      .single();
    
    if (courseError || !courseData) {
      console.error('Error fetching course:', courseError);
      return res.status(500).json({ error: 'Failed to find course' });
    }
    
    // Get all modules for this course
    const { data, error } = await supabase
      .from('modules')
      .select('id, title, order_index')
      .eq('course_id', courseData.id)
      .order('order_index', { ascending: true });
    
    if (error) {
      console.error('Error fetching course modules:', error);
      return res.status(500).json({ error: 'Failed to fetch modules' });
    }
    
    // For each module, get the lesson count
    const modulesWithLessonCount = [];
    for (const module of data) {
      const { count, error: countError } = await supabase
        .from('lessons')
        .select('*', { count: 'exact', head: true })
        .eq('module_id', module.id);
      
      if (!countError) {
        modulesWithLessonCount.push({
          ...module,
          lesson_count: count
        });
      } else {
        modulesWithLessonCount.push({
          ...module,
          lesson_count: 0
        });
      }
    }
    
    res.status(200).json({
      course: req.query.courseTitle,
      modules: modulesWithLessonCount
    });
  } catch (error) {
    console.error('Unexpected error in getAllCourseModules:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};