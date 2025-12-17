import React, { useState, useEffect } from 'react';
import { courseService } from '../services';

const DebugCourses = () => {
  const [courses, setCourses] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [courseDetails, setCourseDetails] = useState(null);
  const [detailsLoading, setDetailsLoading] = useState(false);
  const [detailsError, setDetailsError] = useState(null);

  useEffect(() => {
    const fetchCourses = async () => {
      try {
        setLoading(true);
        console.log('Attempting to fetch courses from Supabase...');
        const data = await courseService.getAllCourses();
        console.log('Courses fetched successfully:', data);
        setCourses(data);
        setError(null);
      } catch (err) {
        console.error('Error fetching courses:', err);
        setError(err.message || 'Failed to fetch courses');
        setCourses([]);
      } finally {
        setLoading(false);
      }
    };

    fetchCourses();
  }, []);

  const fetchCourseDetails = async (courseId) => {
    try {
      setDetailsLoading(true);
      setDetailsError(null);
      console.log(`Fetching details for course ID: ${courseId}`);
      const data = await courseService.getCourseById(courseId);
      console.log('Course details fetched successfully:', data);
      setCourseDetails(data);
    } catch (err) {
      console.error('Error fetching course details:', err);
      setDetailsError(err.message || 'Failed to fetch course details');
      setCourseDetails(null);
    } finally {
      setDetailsLoading(false);
    }
  };

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-6">Debug Courses</h1>
      
      {/* Courses List */}
      <div className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">All Courses</h2>
        
        {loading ? (
          <div className="text-center py-4">
            <p>Loading courses...</p>
          </div>
        ) : error ? (
          <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
            <p>Error: {error}</p>
          </div>
        ) : courses.length > 0 ? (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {courses.map(course => (
              <div key={course.id} className="border rounded-lg p-4 shadow-sm">
                <h3 className="font-semibold text-lg mb-2">{course.title}</h3>
                <p className="text-gray-600 text-sm mb-3">{course.description}</p>
                <div className="flex justify-between text-sm text-gray-500 mb-3">
                  <span>Level: {course.level}</span>
                  <span>Duration: {course.duration}</span>
                </div>
                <button 
                  onClick={() => fetchCourseDetails(course.id)}
                  className="btn-primary text-sm w-full"
                  disabled={detailsLoading}
                >
                  {detailsLoading ? 'Loading...' : 'View Details'}
                </button>
              </div>
            ))}
          </div>
        ) : (
          <div className="text-center py-4">
            <p>No courses found</p>
          </div>
        )}
      </div>

      {/* Course Details */}
      <div>
        <h2 className="text-2xl font-semibold mb-4">Course Details</h2>
        
        {detailsLoading ? (
          <div className="text-center py-4">
            <p>Loading course details...</p>
          </div>
        ) : detailsError ? (
          <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
            <p>Error: {detailsError}</p>
          </div>
        ) : courseDetails ? (
          <div className="border rounded-lg p-6 shadow-sm">
            <h3 className="font-bold text-xl mb-2">{courseDetails.title}</h3>
            <p className="text-gray-700 mb-4">{courseDetails.description}</p>
            
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
              <div>
                <h4 className="font-semibold mb-2">Course Info</h4>
                <ul className="text-sm text-gray-600 space-y-1">
                  <li>Level: {courseDetails.level}</li>
                  <li>Duration: {courseDetails.duration}</li>
                  <li>Price: ${courseDetails.price}</li>
                </ul>
              </div>
              
              <div>
                <h4 className="font-semibold mb-2">Structure</h4>
                <ul className="text-sm text-gray-600 space-y-1">
                  <li>Modules: {courseDetails.modules?.length || 0}</li>
                  <li>Total Lessons: {courseDetails.modules?.reduce((total, module) => total + (module.lessons?.length || 0), 0) || 0}</li>
                </ul>
              </div>
            </div>
            
            {courseDetails.modules && courseDetails.modules.length > 0 && (
              <div>
                <h4 className="font-semibold mb-3">Modules</h4>
                <div className="space-y-4">
                  {courseDetails.modules.map((module, index) => (
                    <div key={module.id} className="border-l-4 border-brand-cyan pl-4 py-2">
                      <h5 className="font-medium">{index + 1}. {module.title}</h5>
                      <p className="text-sm text-gray-600 mb-2">{module.description}</p>
                      <p className="text-xs text-gray-500">Duration: {module.duration} | Lessons: {module.lessons?.length || 0}</p>
                      
                      {module.lessons && module.lessons.length > 0 && (
                        <ul className="mt-2 space-y-1">
                          {module.lessons.map((lesson, lessonIndex) => (
                            <li key={lesson.id} className="text-sm text-gray-600 flex items-center">
                              <span className="w-6 h-6 rounded-full bg-gray-100 flex items-center justify-center text-xs mr-2">
                                {lessonIndex + 1}
                              </span>
                              {lesson.title} <span className="ml-2 text-xs text-gray-400">({lesson.duration})</span>
                            </li>
                          ))}
                        </ul>
                      )}
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        ) : (
          <div className="text-center py-4 text-gray-500">
            <p>Select a course to view details</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default DebugCourses;