import React, { useState, useEffect } from 'react';
import CourseNavigationPanel from './CourseNavigationPanel';
import LessonReadingBoard from './LessonReadingBoard';
import InteractivePlayground from './InteractivePlayground';

const CourseLearningBoard = ({ course }) => {
  const [currentLesson, setCurrentLesson] = useState(null);
  const [showPlayground, setShowPlayground] = useState(false);

  useEffect(() => {
    // Set the first lesson as default when course loads
    if (course && course.modules && course.modules.length > 0) {
      const firstModule = course.modules[0];
      if (firstModule.lessons && firstModule.lessons.length > 0) {
        setCurrentLesson(firstModule.lessons[0]);
      }
    }
  }, [course]);

  const handleLessonSelect = (lesson) => {
    setCurrentLesson(lesson);
  };

  if (!course) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="text-gray-500">Loading course...</div>
      </div>
    );
  }

  return (
    <div className="flex flex-col h-full">
      <div className="flex flex-1 overflow-hidden">
        {/* Course Navigation Panel */}
        <CourseNavigationPanel
          modules={course.modules}
          currentLessonId={currentLesson?.id}
          onLessonSelect={handleLessonSelect}
          courseId={course.id}
        />

        {/* Main Content Area */}
        <div className="flex-1 flex flex-col">
          <LessonReadingBoard lesson={currentLesson} />
        </div>
      </div>

      {/* Interactive Playground */}
      <InteractivePlayground lesson={currentLesson} />
    </div>
  );
};

export default CourseLearningBoard;