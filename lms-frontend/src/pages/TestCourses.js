import React, { useState, useEffect } from "react";
import { courseService } from "../services";

const TestCourses = () => {
    const [courses, setCourses] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchCourses = async () => {
            try {
                setLoading(true);
                setError(null);
                
                // Fetch all courses to see what's available
                const courseData = await courseService.getAllCourses();
                console.log('All courses:', courseData);
                setCourses(courseData);
            } catch (err) {
                console.error('Error fetching courses:', err);
                setError(err.message || 'Failed to load courses');
            } finally {
                setLoading(false);
            }
        };
        
        fetchCourses();
    }, []);

    if (loading) {
        return (
            <div className="container mx-auto px-4 py-16 text-center">
                <p>Loading courses...</p>
            </div>
        );
    }

    if (error) {
        return (
            <div className="container mx-auto px-4 py-16 text-center">
                <div className="bg-red-50 border border-red-200 rounded-lg p-6 max-w-2xl mx-auto">
                    <h2 className="text-xl font-semibold text-red-800 mb-2">Error Loading Courses</h2>
                    <p className="text-red-600 mb-4">{error}</p>
                    <button 
                        onClick={() => window.location.reload()}
                        className="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700"
                    >
                        Try Again
                    </button>
                </div>
            </div>
        );
    }

    return (
        <div className="container mx-auto px-4 py-8">
            <h1 className="text-2xl font-bold mb-6">Available Courses</h1>
            
            {courses.length === 0 ? (
                <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-6 text-center">
                    <p className="text-yellow-800">No courses found in the database.</p>
                </div>
            ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {courses.map((course) => (
                        <div key={course.id} className="bg-white rounded-lg shadow p-6 border border-gray-200">
                            <h2 className="text-xl font-bold text-gray-900 mb-2">{course.title}</h2>
                            <p className="text-gray-600 mb-4">{course.description}</p>
                            
                            <div className="mb-4">
                                <p className="text-sm text-gray-500">
                                    <strong>ID:</strong> {course.id}
                                </p>
                                <p className="text-sm text-gray-500">
                                    <strong>Status:</strong> {course.is_published ? 'Published' : 'Draft'}
                                </p>
                                <p className="text-sm text-gray-500">
                                    <strong>Modules:</strong> {course.modules?.length || 0}
                                </p>
                                <p className="text-sm text-gray-500">
                                    <strong>Lessons:</strong> {
                                        course.modules?.reduce((total, module) => total + (module.lessons?.length || 0), 0) || 0
                                    }
                                </p>
                            </div>
                            
                            <a 
                                href={`/course/${course.id}`} 
                                className="inline-block px-4 py-2 bg-brand-cyan text-white rounded hover:bg-cyan-700 text-sm font-medium"
                            >
                                View Course
                            </a>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
};

export default TestCourses;