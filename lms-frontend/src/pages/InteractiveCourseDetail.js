import React, { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router-dom";
import CourseLearningBoard from "../components/CourseLearningBoard";
import { courseService } from "../services";

const InteractiveCourseDetail = ({ user, onLogin, onSignup }) => {
    const { id } = useParams();
    const navigate = useNavigate();
    const [course, setCourse] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [isEnrolled, setIsEnrolled] = useState(false);

    useEffect(() => {
        const fetchCourseData = async () => {
            try {
                setLoading(true);
                setError(null);
                
                if (!id) {
                    setError('Course ID is missing');
                    setLoading(false);
                    return;
                }
                
                // Fetch course details
                const courseData = await courseService.getCourseById(id);
                setCourse(courseData);
                
                // Check if user is enrolled (simplified check)
                if (user && user.enrolledCourses && user.enrolledCourses.includes(id)) {
                    setIsEnrolled(true);
                } else if (courseData.price === 0) {
                    // Auto-enroll in free courses
                    setIsEnrolled(true);
                }
            } catch (err) {
                console.error('Error fetching course:', err);
                setError('Failed to load course details. Please check your internet connection or try again later.');
            } finally {
                setLoading(false);
            }
        };
        
        fetchCourseData();
    }, [id, user]);

    const handleEnroll = async () => {
        if (!user) {
            if (onLogin) onLogin();
            return;
        }
        
        // If the course is free, enroll directly
        if (course.price === 0) {
            try {
                await courseService.enrollInCourse(course.id);
                setIsEnrolled(true);
            } catch (err) {
                console.error('Enrollment error:', err);
                setError('Failed to enroll in course. Please try again.');
            }
        }
    };

    const handleCourseComplete = () => {
        // Navigate back to dashboard or show completion message
        navigate('/dashboard');
    };

    if (loading) {
        return (
            <div className="flex items-center justify-center h-screen">
                <div className="text-center">
                    <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand-cyan mx-auto"></div>
                    <p className="mt-4 text-gray-600">Loading course content...</p>
                </div>
            </div>
        );
    }

    if (error) {
        return (
            <div className="flex items-center justify-center h-screen">
                <div className="text-center max-w-md">
                    <div className="bg-red-100 rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4">
                        <svg className="w-8 h-8 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                    <h3 className="text-lg font-medium text-gray-900 mb-2">Error Loading Course</h3>
                    <p className="text-gray-600 mb-4">{error}</p>
                    <button 
                        onClick={() => window.location.reload()}
                        className="btn-primary"
                    >
                        Try Again
                    </button>
                </div>
            </div>
        );
    }

    // If not enrolled and course is not free, show enrollment page
    if (!isEnrolled && course.price > 0) {
        return (
            <div className="min-h-screen bg-gray-50 py-12">
                <div className="max-w-4xl mx-auto px-4">
                    <div className="bg-white rounded-lg shadow-lg overflow-hidden">
                        <div className="p-8">
                            <h1 className="text-3xl font-bold text-gray-900 mb-4">{course.title}</h1>
                            <p className="text-gray-600 mb-6">{course.description}</p>
                            
                            <div className="flex items-center justify-between mb-8">
                                <div className="text-3xl font-bold text-gray-900">${course.price}</div>
                                <button 
                                    onClick={handleEnroll}
                                    className="btn-primary"
                                >
                                    Enroll Now
                                </button>
                            </div>
                            
                            <div className="border-t border-gray-200 pt-6">
                                <h2 className="text-xl font-semibold text-gray-900 mb-4">What you'll learn</h2>
                                <ul className="grid grid-cols-1 md:grid-cols-2 gap-3">
                                    {course.modules && course.modules.slice(0, 6).map((module, index) => (
                                        <li key={index} className="flex items-start">
                                            <svg className="w-5 h-5 text-green-500 mr-2 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                                                <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd"/>
                                            </svg>
                                            <span className="text-gray-700">{module.title}</span>
                                        </li>
                                    ))}
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        );
    }

    // If enrolled or course is free, show the interactive learning board
    return (
        <CourseLearningBoard 
            course={course}
            onComplete={handleCourseComplete}
        />
    );
};

export default InteractiveCourseDetail;