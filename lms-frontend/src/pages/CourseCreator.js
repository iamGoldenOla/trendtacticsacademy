import React, { useState } from 'react';
import puterService from '../services/puterService';
import courseService from '../services/courseService';
import RichTextEditor from '../components/RichTextEditor';

const CourseCreator = () => {
  const [courseTopic, setCourseTopic] = useState('');
  const [generatedContent, setGeneratedContent] = useState('');
  const [manualContent, setManualContent] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [conversation, setConversation] = useState([]);
  const [userDetails, setUserDetails] = useState({
    name: '',
    expertise: 'Beginner',
    experience: '0-1 years'
  });
  const [feedback, setFeedback] = useState('');
  const [courseId, setCourseId] = useState(null);
  const [creationStep, setCreationStep] = useState('topic'); // topic, outline, modules, publish
  const [createdCourse, setCreatedCourse] = useState(null);
  const [modules, setModules] = useState([
    { id: 1, title: '', description: '', lessons: [{ id: 1, title: '', content: '' }] }
  ]);

  const handleGenerateContent = async () => {
    if (!courseTopic.trim()) return;

    setIsLoading(true);
    try {
      const content = await puterService.generateCourseContent(courseTopic, userDetails);
      setGeneratedContent(content);
      setCreationStep('outline');
    } catch (error) {
      console.error('Failed to generate content:', error);
      setGeneratedContent('Sorry, I encountered an error generating the course content. Please try again.');
    } finally {
      setIsLoading(false);
    }
  };

  const handleCreateDetailedOutline = async () => {
    if (!courseTopic.trim()) return;

    setIsLoading(true);
    try {
      const outline = await puterService.createDetailedCourseOutline(courseTopic, userDetails);
      setGeneratedContent(outline);
      setCreationStep('outline');
    } catch (error) {
      console.error('Failed to create detailed outline:', error);
      setGeneratedContent('Sorry, I encountered an error creating the course outline. Please try again.');
    } finally {
      setIsLoading(false);
    }
  };

  const handleSaveToSupabase = async () => {
    if (!generatedContent.trim()) return;

    setIsLoading(true);
    try {
      // Extract course title from content (simplified)
      const titleMatch = generatedContent.match(/Course Title:?\s*([^\n]+)/i);
      const title = titleMatch ? titleMatch[1].trim() : courseTopic || 'Untitled Course';
      
      // Extract description
      const descMatch = generatedContent.match(/Brief Description:?\s*([^\n]+)/i);
      const description = descMatch ? descMatch[1].trim() : `Comprehensive course on ${courseTopic}`;
      
      // Create course in Supabase
      const courseData = {
        title: title,
        description: description,
        category: getCourseCategory(courseTopic),
        level: userDetails.expertise,
        duration: '4 weeks', // This would be extracted from content in a real implementation
        objectives: [], // This would be extracted from content
        prerequisites: []
      };

      const createdCourse = await courseService.createCourse(courseData);
      setCreatedCourse(createdCourse);
      setCourseId(createdCourse.id);
      
      // Add to conversation
      const saveMessage = {
        id: Date.now(),
        text: `✅ Course "${title}" has been saved to Supabase!
Course ID: ${createdCourse.id}
Status: ${createdCourse.status}

Students will be able to access this course when they enroll.`,
        sender: 'system',
        timestamp: new Date()
      };
      
      setConversation(prev => [...prev, saveMessage]);
      setCreationStep('modules');
      
    } catch (error) {
      console.error('Failed to save to Supabase:', error);
      const errorMessage = {
        id: Date.now(),
        text: `❌ Failed to save course to Supabase: ${error.message}\n\nPlease check your Supabase configuration and try again.`,
        sender: 'system',
        timestamp: new Date()
      };
      setConversation(prev => [...prev, errorMessage]);
    } finally {
      setIsLoading(false);
    }
  };

  const handleCreateModules = async () => {
    if (!courseId) return;

    setIsLoading(true);
    try {
      // Extract modules from generated content (simplified)
      const modules = [
        { title: "Introduction", description: "Getting started with the course", duration: "1 week" },
        { title: "Fundamentals", description: "Core concepts and principles", duration: "1 week" },
        { title: "Intermediate Topics", description: "Building on the basics", duration: "1 week" },
        { title: "Advanced Concepts", description: "Expert-level material", duration: "1 week" },
        { title: "Practical Application", description: "Real-world projects", duration: "1 week" }
      ];

      const createdModules = await courseService.createModules(courseId, modules);
      
      // Add to conversation
      const modulesMessage = {
        id: Date.now(),
        text: `✅ ${createdModules.length} modules have been created for your course in Supabase!\n\nStudents will progress through these modules sequentially when taking the course.`,
        sender: 'system',
        timestamp: new Date()
      };
      
      setConversation(prev => [...prev, modulesMessage]);
      setCreationStep('publish');
      
    } catch (error) {
      console.error('Failed to create modules:', error);
      const errorMessage = {
        id: Date.now(),
        text: `❌ Failed to create modules in Supabase: ${error.message}\n\nPlease try again.`,
        sender: 'system',
        timestamp: new Date()
      };
      setConversation(prev => [...prev, errorMessage]);
    } finally {
      setIsLoading(false);
    }
  };

  const handlePublishCourse = async () => {
    if (!courseId) return;

    setIsLoading(true);
    try {
      const publishedCourse = await courseService.publishCourse(courseId);
      
      // Add to conversation
      const publishMessage = {
        id: Date.now(),
        text: `🎉 Your course "${publishedCourse.title}" has been successfully published!\n\nStudents can now enroll and start learning. The course is live and accessible through the course catalog.`,
        sender: 'system',
        timestamp: new Date()
      };
      
      setConversation(prev => [...prev, publishMessage]);
      setCreationStep('complete');
      setCreatedCourse(publishedCourse);
      
    } catch (error) {
      console.error('Failed to publish course:', error);
      const errorMessage = {
        id: Date.now(),
        text: `❌ Failed to publish course: ${error.message}\n\nPlease try again.`,
        sender: 'system',
        timestamp: new Date()
      };
      setConversation(prev => [...prev, errorMessage]);
    } finally {
      setIsLoading(false);
    }
  };

  const handleProvideFeedback = async () => {
    if (!generatedContent.trim() || !courseTopic.trim()) return;

    setIsLoading(true);
    try {
      // Process feedback with AI
      const updatedContent = await puterService.processFeedback(generatedContent, feedback);
      setGeneratedContent(updatedContent);
      setFeedback(''); // Clear feedback input
      
      const feedbackMessage = {
        id: Date.now(),
        text: '✅ Your feedback has been incorporated into the course content!',
        sender: 'system',
        timestamp: new Date()
      };
      
      setConversation(prev => [...prev, feedbackMessage]);
    } catch (error) {
      console.error('Failed to process feedback:', error);
      setGeneratedContent(generatedContent + '\n\n[Sorry, I had trouble processing your feedback. Please try rephrasing.]');
    } finally {
      setIsLoading(false);
    }
  };

  // Helper function to categorize courses
  const getCourseCategory = (topic) => {
    const lowerTopic = topic.toLowerCase();
    if (lowerTopic.includes('web') || lowerTopic.includes('html') || lowerTopic.includes('css') || lowerTopic.includes('javascript') || lowerTopic.includes('react')) {
      return 'Web Development';
    } else if (lowerTopic.includes('app') || lowerTopic.includes('mobile') || lowerTopic.includes('android') || lowerTopic.includes('ios')) {
      return 'App Development';
    } else if (lowerTopic.includes('market') || lowerTopic.includes('social') || lowerTopic.includes('seo') || lowerTopic.includes('ads')) {
      return 'Digital Marketing';
    } else {
      return 'General';
    }
  };

  // Clear all content
  const handleClearAll = () => {
    setCourseTopic('');
    setGeneratedContent('');
    setManualContent('');
    setConversation([]);
    setFeedback('');
    setCourseId(null);
    setCreationStep('topic');
    setCreatedCourse(null);
    setModules([
      { id: 1, title: '', description: '', lessons: [{ id: 1, title: '', content: '' }] }
    ]);
    setUserDetails({
      name: '',
      expertise: 'Beginner',
      experience: '0-1 years'
    });
  };

  // Add a new module
  const addModule = () => {
    const newModule = {
      id: modules.length + 1,
      title: '',
      description: '',
      lessons: [{ id: 1, title: '', content: '' }]
    };
    setModules([...modules, newModule]);
  };

  // Add a new lesson to a module
  const addLesson = (moduleId) => {
    setModules(modules.map(module => {
      if (module.id === moduleId) {
        const newLesson = {
          id: module.lessons.length + 1,
          title: '',
          content: ''
        };
        return {
          ...module,
          lessons: [...module.lessons, newLesson]
        };
      }
      return module;
    }));
  };

  // Update module data
  const updateModule = (moduleId, field, value) => {
    setModules(modules.map(module => 
      module.id === moduleId ? { ...module, [field]: value } : module
    ));
  };

  // Update lesson data
  const updateLesson = (moduleId, lessonId, field, value) => {
    setModules(modules.map(module => {
      if (module.id === moduleId) {
        return {
          ...module,
          lessons: module.lessons.map(lesson =>
            lesson.id === lessonId ? { ...lesson, [field]: value } : lesson
          )
        };
      }
      return module;
    }));
  };

  // Handle manual content creation
  const handleCreateManualCourse = async () => {
    if (!courseTopic.trim()) return;

    setIsLoading(true);
    try {
      // Create course in Supabase
      const courseData = {
        title: courseTopic,
        description: manualContent.substring(0, 200) + '...',
        category: getCourseCategory(courseTopic),
        level: userDetails.expertise,
        duration: '4 weeks',
        objectives: [],
        prerequisites: []
      };

      const createdCourse = await courseService.createCourse(courseData);
      setCreatedCourse(createdCourse);
      setCourseId(createdCourse.id);
      
      // Add to conversation
      const saveMessage = {
        id: Date.now(),
        text: `✅ Course "${courseTopic}" has been saved to Supabase!
Course ID: ${createdCourse.id}
Status: ${createdCourse.status}

Students will be able to access this course when they enroll.`,
        sender: 'system',
        timestamp: new Date()
      };
      
      setConversation(prev => [...prev, saveMessage]);
      setCreationStep('modules');
      
    } catch (error) {
      console.error('Failed to save to Supabase:', error);
      const errorMessage = {
        id: Date.now(),
        text: `❌ Failed to save course to Supabase: ${error.message}\n\nPlease check your Supabase configuration and try again.`,
        sender: 'system',
        timestamp: new Date()
      };
      setConversation(prev => [...prev, errorMessage]);
    } finally {
      setIsLoading(false);
    }
  };

  // Save modules and lessons to Supabase
  const handleSaveModules = async () => {
    if (!courseId || modules.length === 0) return;

    setIsLoading(true);
    try {
      // Create modules in Supabase
      for (const module of modules) {
        const moduleData = {
          title: module.title,
          description: module.description,
          duration: '1 week'
        };
        
        const createdModule = await courseService.createModules(courseId, [moduleData]);
        
        // Create lessons for this module
        if (module.lessons && module.lessons.length > 0) {
          const lessonsData = module.lessons.map(lesson => ({
            title: lesson.title,
            content: lesson.content,
            duration: '1 hour'
          }));
          
          await courseService.createLessons(createdModule[0].id, lessonsData);
        }
      }
      
      // Add to conversation
      const modulesMessage = {
        id: Date.now(),
        text: `✅ ${modules.length} modules with their lessons have been created for your course in Supabase!\n\nStudents will progress through these modules sequentially when taking the course.`,
        sender: 'system',
        timestamp: new Date()
      };
      
      setConversation(prev => [...prev, modulesMessage]);
      setCreationStep('publish');
      
    } catch (error) {
      console.error('Failed to create modules:', error);
      const errorMessage = {
        id: Date.now(),
        text: `❌ Failed to create modules in Supabase: ${error.message}\n\nPlease try again.`,
        sender: 'system',
        timestamp: new Date()
      };
      setConversation(prev => [...prev, errorMessage]);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-4xl mx-auto">
        <div className="text-center mb-12">
          <h1 className="text-3xl font-bold text-gray-900 mb-4">Create REAL Courses with Trendy</h1>
          <p className="text-lg text-gray-600">
            Design professional courses that students will ACTUALLY TAKE - integrated directly with Supabase
          </p>
        </div>

        <div className="bg-white rounded-xl shadow-lg p-6 mb-8">
          <div className="flex justify-between items-center mb-4">
            <h2 className="text-xl font-semibold text-gray-900">Course Creator for Instructors</h2>
            <button 
              onClick={handleClearAll}
              className="px-3 py-1 text-sm bg-red-100 text-red-700 rounded hover:bg-red-200 transition-colors"
            >
              Clear All
            </button>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Your Name</label>
              <input
                type="text"
                value={userDetails.name}
                onChange={(e) => setUserDetails({...userDetails, name: e.target.value})}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-cyan"
                placeholder="Enter your name"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Expertise Level</label>
              <select
                value={userDetails.expertise}
                onChange={(e) => setUserDetails({...userDetails, expertise: e.target.value})}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-cyan"
              >
                <option value="Beginner">Beginner</option>
                <option value="Intermediate">Intermediate</option>
                <option value="Advanced">Advanced</option>
                <option value="Expert">Expert</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Teaching Experience</label>
              <select
                value={userDetails.experience}
                onChange={(e) => setUserDetails({...userDetails, experience: e.target.value})}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-cyan"
              >
                <option value="0-1 years">0-1 years</option>
                <option value="1-3 years">1-3 years</option>
                <option value="3-5 years">3-5 years</option>
                <option value="5+ years">5+ years</option>
              </select>
            </div>
          </div>

          <h2 className="text-xl font-semibold text-gray-900 mb-4">Create a Course for Students to TAKE</h2>
          <div className="mb-6">
            <label className="block text-sm font-medium text-gray-700 mb-1">Course Topic</label>
            <input
              type="text"
              value={courseTopic}
              onChange={(e) => setCourseTopic(e.target.value)}
              className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-cyan"
              placeholder="What topic would you like to create a course about?"
            />
          </div>
          
          <div className="flex flex-wrap gap-3 mb-6">
            <button
              onClick={handleGenerateContent}
              disabled={isLoading || !courseTopic.trim()}
              className="px-6 py-3 bg-brand-cyan text-white font-medium rounded-lg hover:bg-brand-navy transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {isLoading ? 'Generating...' : 'Generate with AI'}
            </button>
            
            <button
              onClick={handleCreateDetailedOutline}
              disabled={isLoading || !courseTopic.trim()}
              className="px-6 py-3 bg-purple-600 text-white font-medium rounded-lg hover:bg-purple-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Detailed Outline
            </button>
            
            <button
              onClick={handleCreateManualCourse}
              disabled={isLoading || !courseTopic.trim()}
              className="px-6 py-3 bg-green-600 text-white font-medium rounded-lg hover:bg-green-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Create Manual Course
            </button>
          </div>

          <div className="flex flex-wrap gap-3">
            <button
              onClick={handleCreateDetailedOutline}
              disabled={isLoading || !courseTopic.trim()}
              className="px-4 py-2 bg-purple-600 text-white font-medium rounded-lg hover:bg-purple-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Detailed Outline
            </button>
            
            {generatedContent && creationStep === 'outline' && (
              <button
                onClick={handleSaveToSupabase}
                disabled={isLoading}
                className="px-4 py-2 bg-green-600 text-white font-medium rounded-lg hover:bg-green-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
              >
                Save AI Content to Supabase
              </button>
            )}
            
            {courseId && creationStep === 'publish' && (
              <button
                onClick={handlePublishCourse}
                disabled={isLoading}
                className="px-4 py-2 bg-indigo-600 text-white font-medium rounded-lg hover:bg-indigo-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
              >
                Publish Course
              </button>
            )}
          </div>
        </div>

        {conversation.length > 0 && (
          <div className="bg-white rounded-xl shadow-lg p-6 mb-8">
            <h2 className="text-xl font-semibold text-gray-900 mb-4">System Updates</h2>
            <div className="space-y-4">
              {conversation.map((message) => (
                <div
                  key={message.id}
                  className={`p-4 rounded-lg ${
                    message.sender === 'system'
                      ? 'bg-green-50 border border-green-200'
                      : 'bg-gray-50 border border-gray-200'
                  }`}
                >
                  <div className="flex justify-between items-start">
                    <div>
                      <span className={`font-medium ${
                        message.sender === 'system' ? 'text-green-700' : 'text-gray-700'
                      }`}>
                        {message.sender === 'system' ? '✅ System' : 'Trendy'}
                      </span>
                      <p className="mt-2 text-gray-800 whitespace-pre-wrap">{message.text}</p>
                    </div>
                    <span className="text-xs text-gray-500">
                      {message.timestamp.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                    </span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {createdCourse && (
          <div className="bg-white rounded-xl shadow-lg p-6 mb-8">
            <h2 className="text-xl font-semibold text-gray-900 mb-4">Course Status</h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div className="p-4 bg-blue-50 rounded-lg">
                <div className="text-sm text-blue-800">Course Title</div>
                <div className="font-medium">{createdCourse.title}</div>
              </div>
              <div className="p-4 bg-green-50 rounded-lg">
                <div className="text-sm text-green-800">Status</div>
                <div className="font-medium capitalize">{createdCourse.status}</div>
              </div>
              <div className="p-4 bg-purple-50 rounded-lg">
                <div className="text-sm text-purple-800">Course ID</div>
                <div className="font-mono text-sm">{createdCourse.id.substring(0, 8)}...</div>
              </div>
            </div>
          </div>
        )}

        {(generatedContent || creationStep === 'topic') && (
          <div className="bg-white rounded-xl shadow-lg p-6">
            <div className="flex justify-between items-center mb-4">
              <h2 className="text-xl font-semibold text-gray-900">Course Content</h2>
              <div className="flex gap-2">
                {generatedContent && (
                  <>
                    <button
                      onClick={() => navigator.clipboard.writeText(generatedContent)}
                      className="px-3 py-1 text-sm bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition-colors"
                    >
                      Copy
                    </button>
                    <button
                      onClick={() => setGeneratedContent('')}
                      className="px-3 py-1 text-sm bg-red-100 text-red-700 rounded hover:bg-red-200 transition-colors"
                    >
                      Clear
                    </button>
                  </>
                )}
              </div>
            </div>
            
            {generatedContent ? (
              <div className="bg-gray-50 p-4 rounded-lg whitespace-pre-wrap text-gray-800 border border-gray-200 mb-4">
                {generatedContent}
              </div>
            ) : (
              <div className="mb-4">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Course Description
                </label>
                <RichTextEditor
                  value={manualContent}
                  onChange={setManualContent}
                  placeholder="Enter a brief description of your course..."
                />
              </div>
            )}
            
            {/* Feedback section */}
            <div className="mt-4">
              <label className="block text-sm font-medium text-gray-700 mb-2">
                How can we improve this content?
              </label>
              <textarea
                value={feedback}
                onChange={(e) => setFeedback(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-cyan"
                rows="3"
                placeholder="e.g., Add more examples, Focus on beginner level, Include hands-on projects..."
              />
              {generatedContent && (
                <button
                  onClick={handleProvideFeedback}
                  disabled={isLoading || !feedback.trim()}
                  className="mt-2 px-4 py-2 bg-yellow-600 text-white font-medium rounded-lg hover:bg-yellow-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  Improve Content
                </button>
              )}
            </div>
          </div>
        )}

        {/* Manual Course Builder */}
        {creationStep === 'modules' && (
          <div className="bg-white rounded-xl shadow-lg p-6">
            <h2 className="text-xl font-semibold text-gray-900 mb-4">Course Structure</h2>
            <p className="text-gray-600 mb-6">Define the modules and lessons for your course.</p>
            
            <div className="space-y-6">
              {modules.map((module, index) => (
                <div key={module.id} className="border border-gray-200 rounded-lg p-4">
                  <h3 className="font-medium text-gray-900 mb-3">Module {index + 1}</h3>
                  
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">Module Title</label>
                      <input
                        type="text"
                        value={module.title}
                        onChange={(e) => updateModule(module.id, 'title', e.target.value)}
                        className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-cyan"
                        placeholder="e.g., Introduction to the Topic"
                      />
                    </div>
                    
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">Description</label>
                      <input
                        type="text"
                        value={module.description}
                        onChange={(e) => updateModule(module.id, 'description', e.target.value)}
                        className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-cyan"
                        placeholder="Brief description of this module"
                      />
                    </div>
                  </div>
                  
                  <h4 className="font-medium text-gray-900 mb-3">Lessons</h4>
                  <div className="space-y-4">
                    {module.lessons.map((lesson, lessonIndex) => (
                      <div key={lesson.id} className="border border-gray-100 rounded-lg p-3 bg-gray-50">
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-3 mb-3">
                          <div>
                            <label className="block text-sm font-medium text-gray-700 mb-1">Lesson Title</label>
                            <input
                              type="text"
                              value={lesson.title}
                              onChange={(e) => updateLesson(module.id, lesson.id, 'title', e.target.value)}
                              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-cyan"
                              placeholder="e.g., Getting Started"
                            />
                          </div>
                        </div>
                        
                        <div>
                          <label className="block text-sm font-medium text-gray-700 mb-1">Lesson Content</label>
                          <RichTextEditor
                            value={lesson.content}
                            onChange={(value) => updateLesson(module.id, lesson.id, 'content', value)}
                            placeholder="Enter lesson content with rich formatting..."
                          />
                        </div>
                      </div>
                    ))}
                    
                    <button
                      onClick={() => addLesson(module.id)}
                      className="px-3 py-2 text-sm bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition-colors"
                    >
                      + Add Another Lesson
                    </button>
                  </div>
                </div>
              ))}
              
              <button
                onClick={addModule}
                className="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition-colors"
              >
                + Add Another Module
              </button>
              
              <div className="pt-4">
                <button
                  onClick={handleSaveModules}
                  disabled={isLoading}
                  className="px-6 py-3 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  {isLoading ? 'Saving...' : 'Save Modules to Supabase'}
                </button>
              </div>
            </div>
          </div>
        )}

        <div className="mt-8 bg-blue-50 border border-blue-200 rounded-xl p-6">
          <h3 className="text-lg font-semibold text-blue-900 mb-2">How This Creates REAL Courses</h3>
          <ul className="list-disc pl-5 space-y-2 text-blue-800">
            <li>Generate professional course content with AI assistance</li>
            <li>Save courses directly to your Supabase database</li>
            <li>Create structured modules and lessons for students</li>
            <li>Publish courses for students to enroll and take</li>
            <li>All content becomes REAL courses students can access</li>
          </ul>
          <div className="mt-4 p-4 bg-green-50 rounded-lg border border-green-200">
            <p className="text-green-800 text-sm">
              <strong>✅ Real Integration:</strong> This tool connects to your Supabase backend to create actual courses that students can take, not just demos!
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CourseCreator;