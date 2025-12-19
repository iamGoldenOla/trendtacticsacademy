import React, { useState, useEffect } from 'react';
import CourseNavigationPanel from './CourseNavigationPanel';
import LessonReadingBoard from './LessonReadingBoard';
import InteractivePlayground from './InteractivePlayground';

const CourseLearningBoard = ({ course, onComplete }) => {
  const [activeModule, setActiveModule] = useState(null);
  const [activeLesson, setActiveLesson] = useState(null);
  const [activeTab, setActiveTab] = useState('code');
  const [lessonData, setLessonData] = useState(null);
  const [completedLessons, setCompletedLessons] = useState(new Set());

  // Set first lesson as active when course loads
  useEffect(() => {
    if (course && course.modules && course.modules.length > 0) {
      const firstModule = course.modules[0];
      setActiveModule(firstModule.id);
      
      if (firstModule.lessons && firstModule.lessons.length > 0) {
        const firstLesson = firstModule.lessons[0];
        setActiveLesson(firstLesson.id);
        setLessonData(firstLesson);
      }
    }
  }, [course]);

  const handleModuleToggle = (moduleId) => {
    setActiveModule(moduleId);
  };

  const handleLessonSelect = async (lessonId) => {
    setActiveLesson(lessonId);
    
    // Find the lesson data
    let selectedLesson = null;
    for (const module of course.modules) {
      const lesson = module.lessons.find(l => l.id === lessonId);
      if (lesson) {
        selectedLesson = lesson;
        break;
      }
    }
    
    setLessonData(selectedLesson);
  };

  const handleLessonComplete = (lessonId) => {
    setCompletedLessons(prev => new Set([...prev, lessonId]));
    
    // Check if all lessons are completed
    const allLessons = course.modules.flatMap(module => module.lessons.map(lesson => lesson.id));
    const allCompleted = allLessons.every(lessonId => completedLessons.has(lessonId) || lessonId === activeLesson);
    
    if (allCompleted && onComplete) {
      onComplete();
    }
  };

  if (!course) {
    return (
      <div className="flex items-center justify-center h-screen">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand-cyan mx-auto"></div>
          <p className="mt-4 text-gray-600">Loading course content...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="flex flex-col h-screen">
      {/* Header */}
      <header className="bg-white border-b border-gray-200 px-6 py-4">
        <div className="flex items-center justify-between">
          <h1 className="text-xl font-semibold text-gray-900">{course.title}</h1>
          <div className="flex items-center space-x-4">
            <div className="text-sm text-gray-500">
              {completedLessons.size} of {course.modules.reduce((total, module) => total + (module.lessons?.length || 0), 0)} lessons completed
            </div>
            <button 
              onClick={() => onComplete && onComplete()}
              className="btn-secondary"
            >
              Exit Course
            </button>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <div className="flex flex-1 overflow-hidden">
        {/* Navigation Panel */}
        <CourseNavigationPanel 
          course={course}
          activeModule={activeModule}
          activeLesson={activeLesson}
          onModuleToggle={handleModuleToggle}
          onLessonSelect={handleLessonSelect}
        />

        {/* Main Content Area */}
        <div className="flex-1 flex flex-col">
          {/* Lesson Reading Board */}
          <LessonReadingBoard 
            lesson={lessonData}
            onLessonComplete={handleLessonComplete}
          />

          {/* Interactive Playground */}
          <InteractivePlayground 
            activeTab={activeTab}
            onTabChange={setActiveTab}
            lesson={lessonData}
          />
        </div>
      </div>
    </div>
  );
};

export default CourseLearningBoard;