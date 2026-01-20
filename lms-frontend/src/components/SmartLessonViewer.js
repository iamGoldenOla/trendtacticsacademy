import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import LessonViewer from './LessonViewer';
import { courseService } from '../services';
import { supabase } from '../services/supabaseClient';

const SmartLessonViewer = () => {
    const { id, lessonId } = useParams();
    const navigate = useNavigate();
    const [course, setCourse] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [isEnrolled, setIsEnrolled] = useState(false);

    useEffect(() => {
        const checkEnrollmentAndFetchCourse = async () => {
            try {
                setLoading(true);

                // Check if user is authenticated
                const { data: { user }, error: authError } = await supabase.auth.getUser();

                if (authError || !user) {
                    setError('Please login to access this course');
                    navigate('/login');
                    return;
                }

                // Check if user is enrolled in this course
                const { data: enrollment, error: enrollError } = await supabase
                    .from('enrollments')
                    .select('*')
                    .eq('user_id', user.id)
                    .eq('course_id', id)
                    .single();

                if (enrollError || !enrollment) {
                    // User is not enrolled - redirect to course detail page for payment
                    console.log('User not enrolled in course:', id);
                    setError('You need to enroll in this course first');
                    navigate(`/course-detail/${id}`);
                    return;
                }

                // User is enrolled - proceed to fetch course
                setIsEnrolled(true);

                // Fetch course by ID
                const fetchedCourse = await courseService.getCourseById(id);

                if (!fetchedCourse) {
                    throw new Error('Course not found');
                }

                // Flatten modules into lessons array
                let normalizedLessons = [];
                if (fetchedCourse.modules) {
                    fetchedCourse.modules.forEach(module => {
                        if (module.lessons) {
                            module.lessons.forEach(lesson => {
                                normalizedLessons.push({
                                    ...lesson,
                                    videoUrl: lesson.video_url || '',
                                    description: lesson.content || lesson.description || '',
                                    isCompleted: false,
                                    quiz: lesson.quiz_questions || lesson.quiz || []
                                });
                            });
                        }
                    });
                } else if (fetchedCourse.lessons) {
                    normalizedLessons = fetchedCourse.lessons.map(lesson => ({
                        ...lesson,
                        videoUrl: lesson.video_url || '',
                        description: lesson.content || lesson.description || '',
                        quiz: lesson.quiz_questions || lesson.quiz || []
                    }));
                }

                if (normalizedLessons.length === 0) {
                    throw new Error('This course has no lessons available yet.');
                }

                // Sort by ordering
                normalizedLessons.sort((a, b) => (a.ordering || 0) - (b.ordering || 0));

                setCourse({
                    ...fetchedCourse,
                    lessons: normalizedLessons
                });

            } catch (err) {
                console.error("Error loading course:", err);
                setError(err.message);
            } finally {
                setLoading(false);
            }
        };

        if (id) {
            checkEnrollmentAndFetchCourse();
        }
    }, [id, navigate]);

    if (loading) {
        return (
            <div className="min-h-screen flex items-center justify-center bg-gray-50">
                <div className="text-center">
                    <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand-navy mx-auto mb-4"></div>
                    <p className="text-gray-600">Loading your lesson...</p>
                </div>
            </div>
        );
    }

    if (error || !course) {
        return (
            <div className="min-h-screen flex items-center justify-center bg-gray-50">
                <div className="text-center">
                    <h2 className="text-2xl font-bold text-gray-900 mb-2">Something went wrong</h2>
                    <p className="text-gray-600 mb-4">{error || 'Course not found'}</p>
                    <button onClick={() => navigate('/dashboard')} className="px-4 py-2 bg-brand-navy text-white rounded-lg">
                        Back to Dashboard
                    </button>
                </div>
            </div>
        );
    }

    return (
        <LessonViewer
            course={course}
            lessonId={lessonId}
            onLessonComplete={(completedId) => {
                console.log("Lesson completed:", completedId);
                // Here you would call courseService to mark it complete in backend
            }}
        />
    );
};

export default SmartLessonViewer;
