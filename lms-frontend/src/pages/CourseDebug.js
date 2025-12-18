import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { getCourseById } from '../services/courseService';

const CourseDebug = () => {
  const { courseId } = useParams();
  const navigate = useNavigate();
  const [debugInfo, setDebugInfo] = useState({
    courseId: courseId,
    courseData: null,
    loading: true,
    error: null,
    routeInfo: window.location.pathname
  });

  useEffect(() => {
    const fetchCourseData = async () => {
      try {
        setDebugInfo(prev => ({ ...prev, loading: true }));
        
        // Log what we're trying to fetch
        console.log('Attempting to fetch course with ID:', courseId);
        
        // Try to fetch the course
        const courseData = await getCourseById(courseId);
        
        console.log('Course data received:', courseData);
        
        setDebugInfo(prev => ({
          ...prev,
          courseData: courseData,
          loading: false,
          error: null
        }));
      } catch (err) {
        console.error('Error fetching course:', err);
        setDebugInfo(prev => ({
          ...prev,
          loading: false,
          error: err.message,
          courseData: null
        }));
      }
    };

    if (courseId) {
      fetchCourseData();
    }
  }, [courseId]);

  const handleGoToNewWorkspace = () => {
    navigate(`/course/${courseId}`);
  };

  const handleGoToOldDashboard = () => {
    navigate(`/my-courses/${courseId}`);
  };

  return (
    <div className="min-h-screen bg-gray-50 py-12 px-4">
      <div className="max-w-4xl mx-auto">
        <div className="bg-white rounded-xl shadow-lg p-8">
          <h1 className="text-3xl font-bold text-gray-900 mb-6">Course Debug Information</h1>
          
          <div className="mb-8 p-4 bg-blue-50 rounded-lg">
            <h2 className="text-xl font-semibold text-blue-900 mb-2">Route Information</h2>
            <p className="text-gray-700"><strong>Current Path:</strong> {window.location.pathname}</p>
            <p className="text-gray-700"><strong>Course ID:</strong> {courseId}</p>
          </div>
          
          {debugInfo.loading ? (
            <div className="flex flex-col items-center justify-center py-12">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand-cyan mb-4"></div>
              <p className="text-gray-600">Loading course data...</p>
            </div>
          ) : debugInfo.error ? (
            <div className="mb-8 p-4 bg-red-50 rounded-lg border border-red-200">
              <h2 className="text-xl font-semibold text-red-900 mb-2">Error</h2>
              <p className="text-gray-700 mb-4"><strong>Error Message:</strong> {debugInfo.error}</p>
              <div className="mt-4">
                <h3 className="font-medium text-gray-900 mb-2">Troubleshooting Steps:</h3>
                <ul className="list-disc pl-5 space-y-1 text-gray-700">
                  <li>Check if the course ID is correct</li>
                  <li>Verify that the course exists in the database</li>
                  <li>Ensure Supabase connection is working</li>
                  <li>Check browser console for more detailed error information</li>
                </ul>
              </div>
            </div>
          ) : (
            <div className="mb-8">
              <h2 className="text-xl font-semibold text-gray-900 mb-4">Course Data</h2>
              <div className="bg-gray-50 p-4 rounded-lg">
                <pre className="text-sm text-gray-700 overflow-x-auto">
                  {JSON.stringify(debugInfo.courseData, null, 2)}
                </pre>
              </div>
            </div>
          )}
          
          <div className="mt-8 p-4 bg-yellow-50 rounded-lg">
            <h2 className="text-xl font-semibold text-yellow-900 mb-4">Navigation Options</h2>
            <div className="flex flex-wrap gap-4">
              <button 
                onClick={handleGoToNewWorkspace}
                className="px-6 py-3 bg-green-600 text-white rounded-lg font-medium hover:bg-green-700 transition-colors"
              >
                Go to New Interactive Workspace
              </button>
              <button 
                onClick={handleGoToOldDashboard}
                className="px-6 py-3 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700 transition-colors"
              >
                Go to Old Course Dashboard
              </button>
              <button 
                onClick={() => window.location.reload()}
                className="px-6 py-3 bg-gray-600 text-white rounded-lg font-medium hover:bg-gray-700 transition-colors"
              >
                Reload Page
              </button>
            </div>
          </div>
          
          <div className="mt-8 p-4 bg-purple-50 rounded-lg">
            <h2 className="text-xl font-semibold text-purple-900 mb-4">Expected Behavior</h2>
            <ul className="list-disc pl-5 space-y-2 text-gray-700">
              <li>Clicking "View Details" on a course should take you to the <strong>New Interactive Workspace</strong></li>
              <li>The new workspace has a three-panel layout (navigation, content, playground)</li>
              <li>If you're seeing the old dashboard, you might be accessing the wrong route</li>
              <li>The new workspace route is: <code className="bg-gray-100 px-1 rounded">/course/:courseId</code></li>
              <li>The old dashboard route is: <code className="bg-gray-100 px-1 rounded">/my-courses/:courseId</code></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CourseDebug;