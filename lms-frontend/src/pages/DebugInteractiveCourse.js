import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { courseService } from "../services";
import CourseLearningBoard from "../components/CourseLearningBoard";
import LoadingSpinner from "../components/LoadingSpinner";

const DebugInteractiveCourse = () => {
    const { id } = useParams();
    const [course, setCourse] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [debugInfo, setDebugInfo] = useState({});

    useEffect(() => {
        const fetchCourseData = async () => {
            try {
                setLoading(true);
                setError(null);
                
                console.log("Fetching course with ID:", id);
                
                if (!id) {
                    setError('Course ID is missing');
                    setLoading(false);
                    return;
                }
                
                // Fetch course details
                const courseData = await courseService.getCourseById(id);
                console.log("Course data received:", courseData);
                
                // Set debug info
                setDebugInfo({
                    courseId: id,
                    courseExists: !!courseData,
                    courseType: typeof courseData,
                    courseKeys: courseData ? Object.keys(courseData) : [],
                    hasModules: courseData && Array.isArray(courseData.modules),
                    moduleCount: courseData && Array.isArray(courseData.modules) ? courseData.modules.length : 0,
                    modulesStructure: courseData && Array.isArray(courseData.modules) ? courseData.modules.map(m => ({
                        id: m.id,
                        title: m.title,
                        lessonCount: Array.isArray(m.lessons) ? m.lessons.length : 0
                    })) : []
                });
                
                setCourse(courseData);
            } catch (err) {
                console.error('Error fetching course:', err);
                setError('Failed to load course details: ' + (err.message || 'Unknown error'));
                setDebugInfo({
                    error: err.message,
                    courseId: id
                });
            } finally {
                setLoading(false);
            }
        };
        
        if (id) {
            fetchCourseData();
        }
    }, [id]);

    if (loading) {
        return (
            <div className="container mx-auto px-4 py-16 text-center">
                <LoadingSpinner size="large"/>
                <p className="mt-4 text-gray-600">Loading course details...</p>
            </div>
        );
    }

    if (error) {
        return (
            <div className="container mx-auto px-4 py-16">
                <div className="bg-red-50 border border-red-200 rounded-lg p-6 max-w-4xl mx-auto">
                    <h2 className="text-xl font-semibold text-red-800 mb-2">Error Loading Course</h2>
                    <p className="text-red-600 mb-4">{error}</p>
                    
                    <div className="bg-white p-4 rounded mt-4">
                        <h3 className="font-medium text-gray-900 mb-2">Debug Information:</h3>
                        <pre className="text-sm text-gray-600 bg-gray-50 p-3 rounded overflow-x-auto">
                            {JSON.stringify(debugInfo, null, 2)}
                        </pre>
                    </div>
                    
                    <button 
                        onClick={() => window.location.reload()}
                        className="mt-4 px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700"
                    >
                        Try Again
                    </button>
                </div>
            </div>
        );
    }

    if (!course) {
        return (
            <div className="container mx-auto px-4 py-16 text-center">
                <p className="text-gray-600">Course not found.</p>
                
                <div className="bg-white p-4 rounded mt-4 max-w-2xl mx-auto">
                    <h3 className="font-medium text-gray-900 mb-2">Debug Information:</h3>
                    <pre className="text-sm text-gray-600 bg-gray-50 p-3 rounded overflow-x-auto">
                        {JSON.stringify(debugInfo, null, 2)}
                    </pre>
                </div>
            </div>
        );
    }

    return (
        <div className="min-h-screen bg-gray-50">
            {/* Debug Info Bar */}
            <div className="bg-yellow-50 border-b border-yellow-200 p-2 text-sm">
                <div className="max-w-7xl mx-auto px-4">
                    <strong>DEBUG MODE:</strong> Course loaded successfully. Modules: {debugInfo.moduleCount || 0}
                </div>
            </div>
            
            {/* Header */}
            <div className="bg-white border-b border-gray-200">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="py-4">
                        <h1 className="text-2xl font-bold text-gray-900">{course.title}</h1>
                        <p className="text-gray-600">{course.description}</p>
                    </div>
                </div>
            </div>
            
            {/* Main Content */}
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 h-[calc(100vh-140px)]">
                <CourseLearningBoard course={course} />
            </div>
            
            {/* Detailed Debug Info */}
            <div className="bg-gray-50 border-t border-gray-200 p-4">
                <div className="max-w-7xl mx-auto">
                    <h3 className="font-medium text-gray-900 mb-2">Detailed Course Structure:</h3>
                    <pre className="text-xs text-gray-600 bg-white p-3 rounded overflow-x-auto max-h-40">
                        {JSON.stringify(course, null, 2)}
                    </pre>
                </div>
            </div>
        </div>
    );
};

export default DebugInteractiveCourse;