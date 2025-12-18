import React, { useState, useEffect } from 'react';
import CourseNavigationPanel from './CourseNavigationPanel';
import LessonReadingBoard from './LessonReadingBoard';
import InteractivePlayground from './InteractivePlayground';

const CourseLearningBoard = ({ course, user, onLessonComplete }) => {
  const [currentLesson, setCurrentLesson] = useState(null);
  const [activeTab, setActiveTab] = useState('lesson'); // 'lesson' or 'playground'
  const [completedLessons, setCompletedLessons] = useState([]);
  const [loading, setLoading] = useState(true);

  // Initialize with first lesson
  useEffect(() => {
    if (course) {
      // If course has modules with lessons, use the first lesson from the first module
      if (course.modules && course.modules.length > 0 && course.modules[0].lessons && course.modules[0].lessons.length > 0) {
        setCurrentLesson(course.modules[0].lessons[0]);
      } 
      // Otherwise, use the first lesson from the course
      else if (course.lessons && course.lessons.length > 0) {
        setCurrentLesson(course.lessons[0]);
      }
      // If no lessons found, set a placeholder lesson
      else {
        setCurrentLesson({
          id: 'placeholder',
          title: 'No Lessons Available',
          content: '<h2>No Lessons Available</h2><p>This course does not currently have any lessons. Please check back later as new content is being added regularly.</p>'
        });
      }
      setLoading(false);
    }
  }, [course]);

  const handleSelectLesson = (lesson) => {
    setCurrentLesson(lesson);
    setActiveTab('lesson');
  };

  const handleLessonComplete = (lessonId, completionData) => {
    if (!completedLessons.includes(lessonId)) {
      setCompletedLessons([...completedLessons, lessonId]);
      if (onLessonComplete) {
        onLessonComplete(lessonId, completionData);
      }
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center h-screen bg-gray-50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand-cyan mx-auto mb-4"></div>
          <p className="text-gray-600">Loading course content...</p>
        </div>
      </div>
    );
  }

  if (!course || !currentLesson) {
    return (
      <div className="flex items-center justify-center h-screen bg-gray-50">
        <div className="text-center">
          <div className="text-4xl mb-4">📚</div>
          <h3 className="text-xl font-medium text-gray-900 mb-2">No Content Available</h3>
          <p className="text-gray-600">This course doesn't have any lessons yet.</p>
        </div>
      </div>
    );
  }

  return (
    <div className="flex h-screen bg-gray-50">
      {/* Course Navigation Panel (Left Sidebar) */}
      <div className="w-80 bg-white border-r border-gray-200 overflow-y-auto flex flex-col">
        <CourseNavigationPanel
          course={course}
          currentLesson={currentLesson}
          completedLessons={completedLessons}
          onSelectLesson={handleSelectLesson}
        />
      </div>

      {/* Main Content Area */}
      <div className="flex-1 flex flex-col overflow-hidden">
        {/* Tab Navigation */}
        <div className="flex border-b border-gray-200 bg-white">
          <button
            className={`px-6 py-4 font-medium text-sm flex items-center ${
              activeTab === 'lesson'
                ? 'text-brand-cyan border-b-2 border-brand-cyan'
                : 'text-gray-500 hover:text-gray-700'
            }`}
            onClick={() => setActiveTab('lesson')}
          >
            <span className="mr-2">📖</span>
            Lesson Content
          </button>
          <button
            className={`px-6 py-4 font-medium text-sm flex items-center ${
              activeTab === 'playground'
                ? 'text-brand-cyan border-b-2 border-brand-cyan'
                : 'text-gray-500 hover:text-gray-700'
            }`}
            onClick={() => setActiveTab('playground')}
          >
            <span className="mr-2">💻</span>
            Playground
          </button>
        </div>

        {/* Tab Content */}
        <div className="flex-1 overflow-hidden flex flex-col">
          {activeTab === 'lesson' ? (
            <LessonReadingBoard
              lesson={currentLesson}
              course={course}
              user={user}
              onComplete={handleLessonComplete}
              onTabChange={setActiveTab}
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