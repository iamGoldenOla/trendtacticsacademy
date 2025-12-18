import React from 'react';

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

  return (
    <div className="h-full flex flex-col">
      <div className="p-4 border-b border-gray-200">
        <h2 className="text-lg font-semibold text-gray-900 truncate">{course.title}</h2>
        <p className="text-sm text-gray-500 mt-1">Interactive Learning Board</p>
      </div>

      <div className="flex-1 overflow-y-auto">
        {modules.map((module) => (
          <div key={module.id} className="border-b border-gray-200">
            <div className="p-4 bg-gray-50">
              <h3 className="font-medium text-gray-900">{module.title}</h3>
              {module.description && (
                <p className="text-xs text-gray-500 mt-1">{module.description}</p>
              )}
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
                        ? 'bg-brand-cyan text-white' 
                        : isCompleted
                          ? 'bg-green-50 text-green-700 hover:bg-green-100'
                          : 'hover:bg-gray-50'
                    }`}
                  >
                    <div className="flex-shrink-0 w-6 h-6 rounded-full flex items-center justify-center mr-3">
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
                  </button>
                );
              })}
            </div>
          </div>
        ))}
      </div>

      <div className="p-4 border-t border-gray-200 bg-white">
        <div className="flex justify-between text-sm mb-1">
          <span className="text-gray-600">Progress</span>
          <span className="font-medium">
            {completedLessons.length} of {course.lessons ? course.lessons.length : 0} lessons
          </span>
        </div>
        <div className="w-full bg-gray-200 rounded-full h-2">
          <div
            className="bg-brand-cyan h-2 rounded-full transition-all duration-300"
            style={{
              width: `${course.lessons && course.lessons.length > 0 
                ? (completedLessons.length / course.lessons.length) * 100 
                : 0}%`
            }}
          ></div>
        </div>
      </div>
    </div>
  );
};

export default CourseNavigationPanel;