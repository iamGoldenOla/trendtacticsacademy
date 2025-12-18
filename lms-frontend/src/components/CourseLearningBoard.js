import React, { useState, useEffect } from 'react';
import CourseNavigationPanel from './CourseNavigationPanel';
import LessonReadingBoard from './LessonReadingBoard';
import InteractivePlayground from './InteractivePlayground';

const CourseLearningBoard = ({ course, user, onLessonComplete }) => {
  const [currentLesson, setCurrentLesson] = useState(null);
  const [activeTab, setActiveTab] = useState('lesson'); // 'lesson' or 'playground'
  const [completedLessons, setCompletedLessons] = useState([]);

  // Initialize with first lesson
  useEffect(() => {
    if (course && course.lessons && course.lessons.length > 0) {
      setCurrentLesson(course.lessons[0]);
    }
  }, [course]);

  const handleSelectLesson = (lesson) => {
    setCurrentLesson(lesson);
    setActiveTab('lesson');
  };

  const handleLessonComplete = (lessonId) => {
    if (!completedLessons.includes(lessonId)) {
      setCompletedLessons([...completedLessons, lessonId]);
      if (onLessonComplete) {
        onLessonComplete(lessonId);
      }
    }
  };

  if (!course || !currentLesson) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="text-center">
          <div className="text-2xl mb-2">📚</div>
          <p>Loading course content...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="flex h-screen bg-gray-50">
      {/* Course Navigation Panel (Left Sidebar) */}
      <div className="w-80 bg-white border-r border-gray-200 overflow-y-auto">
        <CourseNavigationPanel
          course={course}
          currentLesson={currentLesson}
          completedLessons={completedLessons}
          onSelectLesson={handleSelectLesson}
        />
      </div>

      {/* Main Content Area */}
      <div className="flex-1 flex flex-col overflow-hidden">
        <div className="flex border-b border-gray-200 bg-white">
          <button
            className={`px-6 py-4 font-medium text-sm ${
              activeTab === 'lesson'
                ? 'text-brand-cyan border-b-2 border-brand-cyan'
                : 'text-gray-500 hover:text-gray-700'
            }`}
            onClick={() => setActiveTab('lesson')}
          >
            Lesson Content
          </button>
          <button
            className={`px-6 py-4 font-medium text-sm ${
              activeTab === 'playground'
                ? 'text-brand-cyan border-b-2 border-brand-cyan'
                : 'text-gray-500 hover:text-gray-700'
            }`}
            onClick={() => setActiveTab('playground')}
          >
            Playground
          </button>
        </div>

        <div className="flex-1 overflow-y-auto">
          {activeTab === 'lesson' ? (
            <LessonReadingBoard
              lesson={currentLesson}
              course={course}
              user={user}
              onComplete={handleLessonComplete}
            />
          ) : (
            <InteractivePlayground
              lesson={currentLesson}
              course={course}
              user={user}
            />
          )}
        </div>
      </div>
    </div>
  );
};

export default CourseLearningBoard;