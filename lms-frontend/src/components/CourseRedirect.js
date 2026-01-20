import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { courseService } from '../services';

const CourseRedirect = () => {
    const { id } = useParams();
    const navigate = useNavigate();
    const [error, setError] = useState(null);

    useEffect(() => {
        const redirect = async () => {
            try {
                // Use direct Supabase queries to avoid relationship errors
                const course = await courseService.getCourseById(id);

                if (!course) {
                    setError('Course not found');
                    setTimeout(() => navigate('/dashboard'), 3000);
                    return;
                }

                let firstLessonId = null;

                if (course.modules && course.modules.length > 0) {
                    // Find first lesson in first module
                    const firstModule = course.modules[0];
                    if (firstModule.lessons && firstModule.lessons.length > 0) {
                        firstLessonId = firstModule.lessons[0].id;
                    }
                } else if (course.lessons && course.lessons.length > 0) {
                    firstLessonId = course.lessons[0].id;
                }

                console.log('Resolved firstLessonId:', firstLessonId, 'for course:', id);

                // Redirect to the stable HTML learner instead of a React route
                window.location.href = `/course.html?id=${id}${firstLessonId ? `&lesson=${firstLessonId}` : ''}`;
            } catch (err) {
                console.error("Course resolution failed:", err);
                setError(err.message || 'Failed to load course');
                // Fallback: Redirect to dashboard after 3 seconds
                setTimeout(() => {
                    navigate('/dashboard');
                }, 3000);
            }
        };
        redirect();
    }, [id, navigate]);

    if (error) {
        return (
            <div className="flex flex-col items-center justify-center h-screen bg-gray-50 p-4">
                <div className="text-center max-w-md">
                    <div className="text-4xl mb-4">⚠️</div>
                    <h2 className="text-2xl font-bold text-gray-900 mb-2">Could Not Resolve Course</h2>
                    <p className="text-gray-600 mb-6">{error}</p>
                    <button
                        onClick={() => navigate('/dashboard')}
                        className="btn-primary"
                    >
                        Back to Dashboard
                    </button>
                </div>
            </div>
        );
    }

    return (
        <div className="flex items-center justify-center h-screen bg-gray-50">
            <div className="text-center">
                <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand-cyan mx-auto mb-4"></div>
                <p className="text-gray-600">Loading course environment...</p>
            </div>
        </div>
    );
};

export default CourseRedirect;
