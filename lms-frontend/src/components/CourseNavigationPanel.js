import React, { useMemo } from 'react';

const CourseNavigationPanel = ({ course, currentLesson, completedLessons, onSelectLesson }) => {
  // Group lessons by modules if they exist, otherwise treat as single module
  const getModuleStructure = () => {
    if (course.modules && course.modules.length > 0) {
      return course.modules.map(module => ({
        ...module,
        lessons: module.lessons || []
      }));
    }
    
    // If no modules, create a default module with all lessons
    return [{
      id: 'default-module',
      title: 'Course Content',
      description: 'All lessons in this course',
      lessons: course.lessons || []
    }];
  };

  const modules = getModuleStructure();
  
  // Calculate overall progress
  const overallProgress = useMemo(() => {
    // Count total lessons across all modules
    const totalLessons = modules.reduce((total, module) => total + (module.lessons ? module.lessons.length : 0), 0);
    
    // Calculate percentage
    if (totalLessons === 0) return 0;
    return Math.round((completedLessons.length / totalLessons) * 100);
  }, [modules, completedLessons]);

  return (
    <div className="h-full flex flex-col bg-white">
      <div className="p-4 border-b border-gray-200 bg-gradient-to-r from-brand-cyan to-brand-navy">
        <h2 className="text-lg font-semibold text-white truncate">{course.title}</h2>
        <p className="text-sm text-blue-100 mt-1">Interactive Learning Board</p>
      </div>

      <div className="flex-1 overflow-y-auto">
        {modules.map((module) => (
          <div key={module.id} className="border-b border-gray-200 last:border-b-0">
            <div className="p-4 bg-gray-50 border-l-4 border-brand-cyan">
              <div className="flex justify-between items-start">
                <div>
                  <h3 className="font-medium text-gray-900">{module.title}</h3>
                  {module.description && (
                    <p className="text-xs text-gray-500 mt-1">{module.description}</p>
                  )}
                </div>
              </div>
            </div>
            
            <div className="py-2">
              {module.lessons.map((lesson) => {
                const isCurrent = currentLesson && currentLesson.id === lesson.id;
                const isCompleted = completedLessons.includes(lesson.id);
                
                return (
                  <button
                    key={lesson.id}
                    onClick={() => onSelectLesson(lesson)}
                    className={`w-full text-left px-4 py-3 flex items-center transition-colors ${
                      isCurrent 
                        ? 'bg-brand-cyan text-white shadow-sm' 
                        : isCompleted
                          ? 'bg-green-50 text-green-700 hover:bg-green-100'
                          : 'hover:bg-gray-50'
                    }`}
                  >
                    <div className="flex-shrink-0 w-6 h-6 rounded-full flex items-center justify-center mr-3 border ${
                      isCompleted 
                        ? 'bg-green-500 border-green-500 text-white' 
                        : isCurrent 
                          ? 'border-white text-white' 
                          : 'border-gray-300 text-gray-500'
                    }`}>
                      {isCompleted ? (
                        <span className="text-xs">✓</span>
                      ) : (
                        <span className="text-xs font-medium">
                          {module.lessons.indexOf(lesson) + 1}
                        </span>
                      )}
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-sm font-medium truncate">{lesson.title}</p>
                      {lesson.duration && (
                        <p className="text-xs opacity-75">{lesson.duration} min</p>
                      )}
                    </div>
                    {isCurrent && (
                      <div className="ml-2 text-xs bg-white bg-opacity-20 px-2 py-1 rounded">
                        Current
                      </div>
                    )}
                  </button>
                );
              })}
            </div>
          </div>
        ))}
      </div>

      <div className="p-4 border-t border-gray-200 bg-white sticky bottom-0">
        <div className="flex justify-between text-sm mb-1">
          <span className="text-gray-600 font-medium">Course Progress</span>
          <span className="font-medium text-brand-cyan">
            {overallProgress}%
          </span>
        </div>
        <div className="w-full bg-gray-200 rounded-full h-3 mb-2">
          <div
            className="bg-gradient-to-r from-brand-cyan to-brand-navy h-3 rounded-full transition-all duration-500 ease-out"
            style={{
              width: `${overallProgress}%`
            }}
          ></div>
        </div>
        <div className="text-xs text-gray-500 flex justify-between">
          <span>{completedLessons.length} completed</span>
          <span>{modules.reduce((total, module) => total + (module.lessons ? module.lessons.length : 0), 0)} total lessons</span>
        </div>
      </div>
    </div>
  );
};

export default CourseNavigationPanel;