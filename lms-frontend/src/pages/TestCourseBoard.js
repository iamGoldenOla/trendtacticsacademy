import React from 'react';
import CourseLearningBoard from '../components/CourseLearningBoard';
import { digitalMarketingCourses } from '../data/digitalMarketingCourses';

const TestCourseBoard = () => {
  // Use the first course as a test
  const testCourse = digitalMarketingCourses[0];
  
  const handleLessonComplete = (lessonId, completionData) => {
    console.log(`Lesson ${lessonId} completed`, completionData);
    alert(`Lesson completed! Time spent: ${Math.floor(completionData.timeSpent / 60)} minutes`);
  };

  return (
    <div className="h-screen flex flex-col">
      <div className="bg-brand-navy text-white p-4">
        <h1 className="text-xl font-bold">Test: Interactive Learning Workspace</h1>
        <p className="text-blue-200">Testing the new three-panel course board layout</p>
      </div>
      
      <CourseLearningBoard 
        course={testCourse} 
        onLessonComplete={handleLessonComplete}
      />
      
      <div className="bg-gray-100 p-2 text-center text-sm text-gray-600 border-t">
        Test Page: This is a direct test of the CourseLearningBoard component
      </div>
    </div>
  );
};

export default TestCourseBoard;