import React, { useState } from 'react';
import { Link } from 'react-router-dom';

const CourseNavigationPanel = ({ course, activeModule, activeLesson, onModuleToggle, onLessonSelect }) => {
  const [openModules, setOpenModules] = useState({});

  const toggleModule = (moduleId) => {
    setOpenModules(prev => ({
      ...prev,
      [moduleId]: !prev[moduleId]
    }));
    if (onModuleToggle) onModuleToggle(moduleId);
  };

  const handleLessonSelect = (lessonId) => {
    if (onLessonSelect) onLessonSelect(lessonId);
  };

  if (!course || !course.modules) {
    return (
      <div className="w-80 bg-white border-r border-gray-200 h-full flex flex-col">
        <div className="p-4 border-b border-gray-200">
          <h2 className="text-lg font-semibold text-gray-900">Course Navigation</h2>
        </div>
        <div className="p-4 text-gray-500">
          No course content available
        </div>
      </div>
    );
  }

  return (
    <div className="w-80 bg-white border-r border-gray-200 h-full flex flex-col">
      <div className="p-4 border-b border-gray-200">
        <h2 className="text-lg font-semibold text-gray-900">{course.title}</h2>
      </div>
      
      <div className="flex-1 overflow-y-auto">
        {course.modules && course.modules.length > 0 ? (
          course.modules.map((module) => (
            <div key={module.id} className="border-b border-gray-100">
              <button
                onClick={() => toggleModule(module.id)}
                className="w-full flex items-center justify-between p-4 text-left hover:bg-gray-50 transition-colors"
              >
                <div>
                  <h3 className="font-medium text-gray-900">{module.title}</h3>
                  <p className="text-sm text-gray-500 mt-1">{module.description}</p>
                </div>
                <svg 
                  className={`w-5 h-5 text-gray-400 transition-transform ${openModules[module.id] ? 'rotate-180' : ''}`}
                  fill="none" 
                  stroke="currentColor" 
                  viewBox="0 0 24 24"
                >
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                </svg>
              </button>
              
              {openModules[module.id] && module.lessons && (
                <div className="pl-4 pr-2 pb-2">
                  {module.lessons.map((lesson) => (
                    <button
                      key={lesson.id}
                      onClick={() => handleLessonSelect(lesson.id)}
                      className={`w-full text-left p-3 rounded-lg mb-1 text-sm transition-colors ${
                        activeLesson === lesson.id 
                          ? 'bg-brand-cyan text-white' 
                          : 'hover:bg-gray-100 text-gray-700'
                      }`}
                    >
                      <div className="flex items-center">
                        <div className={`w-2 h-2 rounded-full mr-3 ${activeLesson === lesson.id ? 'bg-white' : 'bg-gray-300'}`}></div>
                        <span className="truncate">{lesson.title}</span>
                      </div>
                      {lesson.duration && (
                        <div className="text-xs mt-1 ml-5 opacity-75">
                          {lesson.duration}
                        </div>
                      )}
                    </button>
                  ))}
                  
                  {module.lessons.length === 0 && (
                    <div className="p-3 text-gray-500 text-sm italic">
                      No lessons available
                    </div>
                  )}
                </div>
              )}
            </div>
          ))
        ) : (
          <div className="p-4 text-gray-500">
            No modules available for this course
          </div>
        )}
      </div>
    </div>
  );
};

export default CourseNavigationPanel;