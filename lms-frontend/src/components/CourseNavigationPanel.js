import React from 'react';
import { Link } from 'react-router-dom';

const CourseNavigationPanel = ({ modules, currentLessonId, onLessonSelect, courseId }) => {
  return (
    <div className="w-64 bg-white border-r border-gray-200 h-full overflow-y-auto">
      <div className="p-4">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Course Content</h2>
        <div className="space-y-2">
          {modules && modules.map((module) => (
            <div key={module.id} className="border border-gray-200 rounded-lg">
              <div className="bg-gray-50 px-3 py-2 border-b border-gray-200">
                <h3 className="font-medium text-gray-800">{module.title}</h3>
              </div>
              <div className="p-2 space-y-1">
                {module.lessons && module.lessons.map((lesson) => {
                  const isActive = lesson.id === currentLessonId;
                  return (
                    <button
                      key={lesson.id}
                      onClick={() => onLessonSelect(lesson)}
                      className={`w-full text-left px-3 py-2 rounded text-sm ${
                        isActive 
                          ? 'bg-brand-cyan text-white' 
                          : 'text-gray-700 hover:bg-gray-100'
                      }`}
                    >
                      <div className="flex items-center">
                        <span className="mr-2">•</span>
                        <span className="truncate">{lesson.title}</span>
                      </div>
                    </button>
                  );
                })}
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default CourseNavigationPanel;