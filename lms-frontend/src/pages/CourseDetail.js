import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import CourseLearningBoard from '../components/CourseLearningBoard';
import { getCourseById } from '../services/courseService';
import './CourseDetail.css';

const CourseDetail = () => {
  const { courseId } = useParams();
  const [course, setCourse] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchCourse = async () => {
      try {
        setLoading(true);
        const courseData = await getCourseById(courseId);
        setCourse(courseData);
      } catch (err) {
        console.error('Error fetching course:', err);
        setError('Failed to load course. Please try again later.');
      } finally {
        setLoading(false);
      }
    };

    if (courseId) {
      fetchCourse();
    }
  }, [courseId]);

  const handleLessonComplete = (lessonId, completionData) => {
    // In a real implementation, this would save to the backend
    console.log(`Lesson ${lessonId} completed`, completionData);
  };

  if (loading) {
    return (
      <div className="course-detail-page flex items-center justify-center h-screen bg-gray-50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand-cyan mx-auto mb-4"></div>
          <p className="text-gray-600">Loading course content...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="course-detail-page flex items-center justify-center h-screen bg-gray-50">
        <div className="text-center max-w-md p-6 bg-white rounded-lg shadow-sm border border-gray-200">
          <div className="text-2xl mb-4 text-red-500">⚠️</div>
          <h3 className="text-xl font-medium text-gray-900 mb-2">Error Loading Course</h3>
          <p className="text-gray-600 mb-4">{error}</p>
          <div className="mt-4 text-xs text-gray-500 bg-gray-100 p-2 rounded">
            <p>This usually happens when:</p>
            <ul className="list-disc text-left mt-1 ml-4 space-y-1">
              <li>The course doesn't exist or was removed</li>
              <li>There's a connection issue with our database</li>
              <li>You don't have permission to view this course</li>
            </ul>
          </div>
          <button 
            onClick={() => window.location.reload()}
            className="mt-4 px-4 py-2 bg-brand-cyan text-white rounded-lg font-medium hover:bg-brand-navy"
          >
            Try Again
          </button>
        </div>
      </div>
    );
  }

  if (!course) {
    return (
      <div className="course-detail-page flex items-center justify-center h-screen bg-gray-50">
        <div className="text-center">
          <div className="text-4xl mb-4">📚</div>
          <h3 className="text-xl font-medium text-gray-900 mb-2">Course Not Found</h3>
          <p className="text-gray-600">The course you're looking for doesn't exist or has been removed.</p>
        </div>
      </div>
    );
  }

  return (
    <div className="course-detail-page h-screen flex flex-col">
      <CourseLearningBoard 
        course={course} 
        onLessonComplete={handleLessonComplete}
      />
    </div>
  );
};

export default CourseDetail;