import React, { useState, useEffect } from "react";
import { useParams, useNavigate, Link } from "react-router-dom";
import LessonViewer from "../components/LessonViewer";
import PaymentModal from "../components/PaymentModal";
import GameHub from "../components/GameHub";
import { courseService, progressService, authService } from "../services";
import LoadingSpinner from "../components/LoadingSpinner";

const CourseDetail = ({ user, onLogin, onSignup }) => {
  const { id } = useParams();
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState('overview');
  const [isEnrolled, setIsEnrolled] = useState(false);
  const [isPaymentModalOpen, setIsPaymentModalOpen] = useState(false);
  const [showGameHub, setShowGameHub] = useState(false);
  const [showSuccessMessage, setShowSuccessMessage] = useState(false);
  const [course, setCourse] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [progress, setProgress] = useState(0);
  const [completedLessons, setCompletedLessons] = useState([]);


  // Set isEnrolled based on user.enrolledCourses and course.id
  useEffect(() => {
    if (user && course && user.enrolledCourses && user.enrolledCourses.includes(course.id)) {
      setIsEnrolled(true);
    } else {
      setIsEnrolled(false);
    }
  }, [user, course]);

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
        // Fetch course details (via resolver)
        const courseData = await courseService.getCourseById(id);
        setCourse(courseData);
      } catch (err) {
        console.error('Error fetching course:', err);
        setError('Failed to load course details. This course may be unavailable.');
      } finally {
        setLoading(false);
      }
    };
    fetchCourseData();
  }, [id, user]);

  if (loading) {
    return (<div className="container mx-auto px-4 py-16 text-center">
      <LoadingSpinner size="large" />
      <p className="mt-4 text-gray-600">Loading course details...</p>
    </div>);
  }

  // Check if the course has valid data for display
  const hasValidCourseData = course && course.id && course.title;

  const handleEnroll = async () => {
    if (!user) {
      if (onLogin) onLogin();
      return;
    }

    try {
      // If the course is free, enroll directly and redirect to interactive course
      if (course.price === 0) {
        await courseService.enrollInCourse(course.id);
        setIsEnrolled(true);
        setShowSuccessMessage(true);
        // Redirect to dashboard courses section
        window.location.href = `/dashboard?section=courses&enrolled=${course.id}`;
        // Hide success message after 5 seconds
        setTimeout(() => {
          setShowSuccessMessage(false);
        }, 5000);
      } else {
        // For paid courses, show payment modal
        setIsPaymentModalOpen(true);
      }
    } catch (err) {
      console.error('Enrollment error:', err);
    }
  };

  const handlePaymentSuccess = async (paymentId) => {
    try {
      // Call API to enroll in the course after payment
      // The enrollInCourse function only takes one parameter
      await courseService.enrollInCourse(course.id);
      setIsEnrolled(true);
      setShowSuccessMessage(true);
      // Hide success message after 5 seconds
      setTimeout(() => {
        setShowSuccessMessage(false);
      }, 5000);
      // Refresh user data to update enrolled courses
      if (authService.isAuthenticated()) {
        await authService.getCurrentUser();
      }
      window.location.href = `/dashboard?section=courses&enrolled=${course.id}`;
      console.log('Payment successful:', paymentId);
    } catch (err) {
      console.error('Error enrolling after payment:', err);
    }
  };

  const handlePaymentError = (error) => {
    console.error('Payment error:', error);
    // In a real app, you might show a toast notification here
  };

  const handleLessonComplete = async (lessonId) => {
    try {
      // Call API to mark lesson as complete
      await progressService.updateProgress(course.id, lessonId, true);
      // Update local state
      if (!completedLessons.includes(lessonId)) {
        const newCompletedLessons = [...completedLessons, lessonId];
        setCompletedLessons(newCompletedLessons);
        // Recalculate progress percentage
        const newProgress = (newCompletedLessons.length / totalLessons) * 100;
        setProgress(newProgress);
      }
      console.log('Lesson completed:', lessonId);
    } catch (err) {
      console.error('Error updating lesson progress:', err);
    }
  };

  const handleGameComplete = (activityId, score) => {
    console.log(`Game ${activityId} completed with score: ${score}`);
    // Here you would typically update the user's progress and unlock next activities
    // For now, we'll just log it
  };

  // Calculate total lessons from modules and lessons structure
  const totalLessons = course?.modules?.reduce((total, module) => total + (module.lessons?.length || 0), 0) || 0;

  if (loading) {
    return (<div className="container mx-auto px-4 py-16 text-center">
      <LoadingSpinner size="large" />
      <p className="mt-4 text-gray-600">Loading course details...</p>
    </div>);
  }

  if (error || !course) {
    return (
      <div className="container mx-auto px-4 py-16 text-center">
        <div className="bg-yellow-50 border-l-4 border-yellow-400 p-4 rounded inline-block text-left">
          <div className="flex">
            <div className="flex-shrink-0">
              <svg className="h-5 w-5 text-yellow-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fillRule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clipRule="evenodd" />
              </svg>
            </div>
            <div className="ml-3">
              <p className="text-sm text-yellow-700">
                <span className="font-medium">Error:</span> {error || 'Course not found'}
              </p>
              <button
                onClick={() => navigate('/dashboard')}
                className="mt-2 text-sm text-yellow-700 hover:text-yellow-600 underline"
              >
                Return to Dashboard
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  const completedLessonsCount = completedLessons.length;
  const progressPercentage = progress || (totalLessons > 0 ? (completedLessonsCount / totalLessons) * 100 : 0);

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Success Message */}
      {showSuccessMessage && (
        <div className="fixed top-4 right-4 z-50 bg-green-500 text-white px-6 py-4 rounded-lg shadow-lg">
          <div className="flex items-center space-x-3">
            <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
              <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
            </svg>
            <div>
              <h4 className="font-semibold">Payment Successful!</h4>
              <p className="text-sm">You're now enrolled in {course.title}</p>
            </div>
          </div>
        </div>
      )}

      {/* Hero Section */}
      <section className="bg-white border-b border-gray-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
            {/* Course Info */}
            <div className="lg:col-span-2">
              <h1 className="text-3xl font-heading font-bold text-gray-900 mb-4">
                {course.title}
              </h1>
              <p className="text-gray-600 text-lg mb-6">
                {course.description}
              </p>

              {/* Course Stats */}
              <div className="flex flex-wrap items-center space-x-6 text-sm text-gray-600 mb-6">
                <div className="flex items-center">
                  <svg className="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                    <path fillRule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clipRule="evenodd" />
                  </svg>
                  By Instructor
                </div>
                <div className="flex items-center">
                  <svg className="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                    <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clipRule="evenodd" />
                  </svg>
                  {course.duration}
                </div>
                <div className="flex items-center">
                  <svg className="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                  </svg>
                  4.5 (120 students)
                </div>
                <div className="flex items-center">
                  <svg className="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                    <path fillRule="evenodd" d="M3 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clipRule="evenodd" />
                  </svg>
                  {course.level}
                </div>
              </div>

              {/* Progress Bar (if enrolled) */}
              {isEnrolled && (
                <div className="mb-6">
                  <div className="flex justify-between text-sm text-gray-600 mb-2">
                    <span>Course Progress</span>
                    <span>{completedLessonsCount} of {totalLessons} lessons completed</span>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-2">
                    <div className="bg-brand-cyan h-2 rounded-full transition-all duration-300" style={{ width: `${progressPercentage}%` }}></div>
                  </div>
                </div>
              )}
            </div>

            {/* Course Card */}
            <div className="lg:col-span-1">
              <div className="bg-white rounded-lg shadow-lg border border-gray-200 p-6 sticky top-4">
                <div className="bg-gray-200 border-2 border-dashed rounded-xl w-full h-48 mb-4" />

                <div className="text-3xl font-heading font-bold text-gray-900 mb-4">
                  ₦{course.price ? Number(course.price).toLocaleString() : '5,000'}
                </div>

                {isEnrolled ? (
                  <div className="flex flex-col gap-3">
                    <button
                      onClick={() => window.location.href = `/course/${course.id}/overview`}
                      className="w-full btn-primary text-center" disabled={!course.modules || course.modules.length === 0 || !course.modules[0].lessons || course.modules[0].lessons.length === 0}>
                      {course.modules && course.modules.length > 0 && course.modules[0].lessons && course.modules[0].lessons.length > 0
                        ? 'Continue Learning'
                        : 'No Lessons Available'}
                    </button>
                    <Link to={`/course/${course.id}/overview`} className="w-full btn-secondary text-center">
                      Go to Course
                    </Link>
                  </div>
                ) : (
                  <button onClick={handleEnroll} className="w-full btn-primary">
                    Enroll Now
                  </button>
                )}

                <div className="mt-6 pt-6 border-t border-gray-200">
                  <h4 className="font-semibold text-gray-900 mb-3">This course includes:</h4>
                  <ul className="space-y-2 text-sm text-gray-600">
                    <li className="flex items-center">
                      <svg className="w-4 h-4 text-green-500 mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                      </svg>
                      {totalLessons} video lessons
                    </li>
                    <li className="flex items-center">
                      <svg className="w-4 h-4 text-green-500 mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                      </svg>
                      Downloadable resources
                    </li>
                    <li className="flex items-center">
                      <svg className="w-4 h-4 text-green-500 mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                      </svg>
                      Certificate of completion
                    </li>
                    <li className="flex items-center">
                      <svg className="w-4 h-4 text-green-500 mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                      </svg>
                      Lifetime access
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Error Message */}
      {error && (
        <div className="container mx-auto px-4 py-4">
          <div className="bg-yellow-50 border-l-4 border-yellow-400 p-4 rounded">
            <div className="flex">
              <div className="flex-shrink-0">
                <svg className="h-5 w-5 text-yellow-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                  <path fillRule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clipRule="evenodd" />
                </svg>
              </div>
              <div className="ml-3">
                <p className="text-sm text-yellow-700">
                  <span className="font-medium">Notice:</span> {error}
                </p>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Course Content */}
      <section className="py-8">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          {/* Tab Navigation */}
          <div className="border-b border-gray-200 mb-8">
            <nav className="flex space-x-8">
              {[
                { id: 'overview', label: 'Overview' },
                { id: 'curriculum', label: 'Curriculum' },
                { id: 'instructor', label: 'Instructor' },
                { id: 'reviews', label: 'Reviews' },
                { id: 'games', label: 'Games' }
              ].map((tab) => (
                <button
                  key={tab.id}
                  onClick={() => setActiveTab(tab.id)}
                  className={`py-2 px-1 border-b-2 font-medium text-sm ${activeTab === tab.id
                    ? 'border-brand-cyan text-brand-cyan'
                    : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                    }`}
                >
                  {tab.label}
                </button>
              ))}
            </nav>
          </div>

          {/* Tab Content */}
          {activeTab === 'overview' && (
            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
              <div className="lg:col-span-2">
                <h2 className="text-2xl font-heading font-bold text-gray-900 mb-6">
                  What you'll learn
                </h2>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8">
                  <div className="flex items-start space-x-3">
                    <svg className="w-5 h-5 text-green-500 mt-1" fill="currentColor" viewBox="0 0 20 20">
                      <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                    </svg>
                    <span className="text-gray-700">Master SEO techniques to improve search rankings</span>
                  </div>
                  <div className="flex items-start space-x-3">
                    <svg className="w-5 h-5 text-green-500 mt-1" fill="currentColor" viewBox="0 0 20 20">
                      <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                    </svg>
                    <span className="text-gray-700">Create compelling content marketing strategies</span>
                  </div>
                  <div className="flex items-start space-x-3">
                    <svg className="w-5 h-5 text-green-500 mt-1" fill="currentColor" viewBox="0 0 20 20">
                      <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                    </svg>
                    <span className="text-gray-700">Build effective social media campaigns</span>
                  </div>
                  <div className="flex items-start space-x-3">
                    <svg className="w-5 h-5 text-green-500 mt-1" fill="currentColor" viewBox="0 0 20 20">
                      <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                    </svg>
                    <span className="text-gray-700">Optimize email marketing for conversions</span>
                  </div>
                  <div className="flex items-start space-x-3">
                    <svg className="w-5 h-5 text-green-500 mt-1" fill="currentColor" viewBox="0 0 20 20">
                      <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                    </svg>
                    <span className="text-gray-700">Manage paid advertising campaigns</span>
                  </div>
                  <div className="flex items-start space-x-3">
                    <svg className="w-5 h-5 text-green-500 mt-1" fill="currentColor" viewBox="0 0 20 20">
                      <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                    </svg>
                    <span className="text-gray-700">Analyze marketing performance metrics</span>
                  </div>
                </div>

                <h3 className="text-xl font-heading font-semibold text-gray-900 mb-4">
                  Course Description
                </h3>
                <p className="text-gray-600 mb-6">
                  This comprehensive digital marketing course is designed for beginners and intermediate marketers who want to master the art of online marketing. You'll learn practical strategies that you can implement immediately to grow your business or career.
                </p>

                <h3 className="text-xl font-heading font-semibold text-gray-900 mb-4">
                  Requirements
                </h3>
                <ul className="space-y-2 text-gray-600 mb-6">
                  <li className="flex items-start">
                    <span className="text-brand-cyan mr-2">•</span>
                    <span>No marketing experience required - we'll start from the basics</span>
                  </li>
                  <li className="flex items-start">
                    <span className="text-brand-cyan mr-2">•</span>
                    <span>A computer with internet access</span>
                  </li>
                  <li className="flex items-start">
                    <span className="text-brand-cyan mr-2">•</span>
                    <span>Willingness to learn and implement marketing strategies</span>
                  </li>
                </ul>
              </div>

              <div className="lg:col-span-1">
                <div className="bg-white rounded-lg shadow-lg border border-gray-200 p-6">
                  <h3 className="text-lg font-heading font-semibold text-gray-900 mb-4">
                    Course Features
                  </h3>
                  <ul className="space-y-3">
                    <li className="flex items-center">
                      <svg className="w-5 h-5 text-brand-cyan mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                      </svg>
                      <span>40+ video lessons</span>
                    </li>
                    <li className="flex items-center">
                      <svg className="w-5 h-5 text-brand-cyan mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                      </svg>
                      <span>Downloadable resources</span>
                    </li>
                    <li className="flex items-center">
                      <svg className="w-5 h-5 text-brand-cyan mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                      </svg>
                      <span>Quizzes and assignments</span>
                    </li>
                    <li className="flex items-center">
                      <svg className="w-5 h-5 text-brand-cyan mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                      </svg>
                      <span>Certificate of completion</span>
                    </li>
                    <li className="flex items-center">
                      <svg className="w-5 h-5 text-brand-cyan mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                      </svg>
                      <span>Lifetime access</span>
                    </li>
                    <li className="flex items-center">
                      <svg className="w-5 h-5 text-brand-cyan mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                      </svg>
                      <span>Mobile friendly</span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          )}

          {activeTab === 'curriculum' && (
            <div className="bg-white rounded-lg shadow-lg border border-gray-200 overflow-hidden">
              <div className="p-6 border-b border-gray-200">
                <h2 className="text-2xl font-heading font-bold text-gray-900">
                  Course Curriculum
                </h2>
                <p className="text-gray-600 mt-2">
                  {totalLessons} lessons • {course.modules?.length || 0} modules
                </p>
              </div>

              {/* Modules and Lessons */}
              <div className="divide-y divide-gray-200">
                {course.modules && course.modules.length > 0 ? (
                  course.modules.map((module, moduleIndex) => (
                    <div key={module.id} className="p-6">
                      <div className="flex items-center justify-between mb-4">
                        <h3 className="text-lg font-semibold text-gray-900">
                          Module {moduleIndex + 1}: {module.title}
                        </h3>
                        <span className="text-sm text-gray-500">
                          {module.lessons?.length || 0} lessons • {module.duration}
                        </span>
                      </div>
                      <p className="text-gray-600 mb-4">{module.description}</p>

                      {/* Lessons */}
                      <div className="space-y-3">
                        {module.lessons && module.lessons.length > 0 ? (
                          module.lessons.map((lesson, lessonIndex) => (
                            <div key={lesson.id} className="flex items-center p-3 bg-gray-50 rounded-lg">
                              <div className="flex-shrink-0 w-8 h-8 rounded-full bg-brand-cyan flex items-center justify-center text-white text-xs font-bold mr-3">
                                {lessonIndex + 1}
                              </div>
                              <div className="flex-grow">
                                <h4 className="font-medium text-gray-900">{lesson.title}</h4>
                                <p className="text-sm text-gray-500">{lesson.duration}</p>
                              </div>
                              <div className="flex-shrink-0">
                                <svg className="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20">
                                  <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM9.555 7.168A1 1 0 008 8v4a1 1 0 001.555.832l3-2a1 1 0 000-1.664l-3-2z" clipRule="evenodd" />
                                </svg>
                              </div>
                            </div>
                          ))
                        ) : (
                          <p className="text-gray-500 italic">No lessons available in this module yet.</p>
                        )}
                      </div>
                    </div>
                  ))
                ) : (
                  <div className="p-6 text-center">
                    <p className="text-gray-500">No modules available for this course yet.</p>
                  </div>
                )}
              </div>
            </div>
          )}

          {activeTab === 'instructor' && (
            <div className="bg-white rounded-lg shadow-lg border border-gray-200 p-6">
              <h2 className="text-2xl font-heading font-bold text-gray-900 mb-6">
                Meet Your Instructor
              </h2>
              <div className="flex items-start space-x-6">
                <div className="bg-gray-200 border-2 border-dashed rounded-xl w-16 h-16 flex-shrink-0" />
                <div>
                  <h3 className="text-xl font-semibold text-gray-900">John Doe</h3>
                  <p className="text-brand-cyan font-medium mb-3">Digital Marketing Expert</p>
                  <p className="text-gray-600 mb-4">
                    John is a seasoned digital marketing professional with over 10 years of experience in helping businesses grow their online presence. He has worked with Fortune 500 companies and startups alike to develop winning marketing strategies.
                  </p>
                  <div className="flex space-x-4 text-sm text-gray-500">
                    <div className="flex items-center">
                      <svg className="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                      </svg>
                      4.8 Instructor Rating
                    </div>
                    <div className="flex items-center">
                      <svg className="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                        <path fillRule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clipRule="evenodd" />
                      </svg>
                      1,250 Students
                    </div>
                    <div className="flex items-center">
                      <svg className="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                        <path fillRule="evenodd" d="M4 4a2 2 0 00-2 2v4a2 2 0 002 2V6h10a2 2 0 00-2 2H4zm2 6a2 2 0 012-2h8a2 2 0 012 2v4a2 2 0 01-2 2H8a2 2 0 01-2-2v-4zm6 4a2 2 0 100-4 2 2 0 000 4z" clipRule="evenodd" />
                      </svg>
                      15 Courses
                    </div>
                  </div>
                </div>
              </div>
            </div>
          )}

          {activeTab === 'reviews' && (
            <div className="bg-white rounded-lg shadow-lg border border-gray-200 p-6">
              <h2 className="text-2xl font-heading font-bold text-gray-900 mb-6">
                Student Reviews
              </h2>
              <div className="flex items-center mb-6">
                <div className="text-4xl font-bold text-gray-900 mr-4">4.5</div>
                <div>
                  <div className="flex items-center">
                    {[...Array(5)].map((_, i) => (
                      <svg key={i} className={`w-5 h-5 ${i < 4 ? 'text-yellow-400' : 'text-gray-300'}`} fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                      </svg>
                    ))}
                  </div>
                  <p className="text-gray-600 text-sm mt-1">Based on 120 reviews</p>
                </div>
              </div>

              {/* Sample Reviews */}
              <div className="space-y-6">
                {[1, 2, 3].map((review) => (
                  <div key={review} className="border-b border-gray-200 pb-6 last:border-0 last:pb-0">
                    <div className="flex items-center justify-between mb-2">
                      <div className="font-medium text-gray-900">Student {review}</div>
                      <div className="flex items-center">
                        {[...Array(5)].map((_, i) => (
                          <svg key={i} className={`w-4 h-4 ${i < (review === 1 ? 5 : review === 2 ? 4 : 3) ? 'text-yellow-400' : 'text-gray-300'}`} fill="currentColor" viewBox="0 0 20 20">
                            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                          </svg>
                        ))}
                      </div>
                    </div>
                    <p className="text-gray-600 text-sm mb-2">
                      {review === 1
                        ? "This course completely transformed my understanding of digital marketing. The instructor explains complex topics in a way that's easy to understand."
                        : review === 2
                          ? "Great content and well-structured curriculum. I particularly enjoyed the hands-on exercises that helped me apply what I learned."
                          : "Very comprehensive course covering all aspects of digital marketing. The instructor is knowledgeable and engaging."}
                    </p>
                    <div className="text-xs text-gray-500">
                      {review === 1 ? "2 weeks ago" : review === 2 ? "1 month ago" : "3 months ago"}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}

          {activeTab === 'games' && (
            <div className="bg-white rounded-lg shadow-lg border border-gray-200 p-6">
              <h2 className="text-2xl font-heading font-bold text-gray-900 mb-6">
                Interactive Learning Games
              </h2>
              <p className="text-gray-600 mb-6">
                Reinforce your learning with fun, interactive games designed to help you master key concepts.
              </p>

              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <div className="border border-gray-200 rounded-lg p-6 text-center hover:shadow-md transition-shadow">
                  <div className="bg-gray-200 border-2 border-dashed rounded-xl w-16 h-16 mx-auto mb-4" />
                  <h3 className="font-semibold text-gray-900 mb-2">Marketing Quiz Challenge</h3>
                  <p className="text-gray-600 text-sm mb-4">
                    Test your knowledge with our interactive quiz game
                  </p>
                  <button
                    onClick={() => setShowGameHub(true)}
                    className="btn-primary text-sm"
                  >
                    Play Now
                  </button>
                </div>

                <div className="border border-gray-200 rounded-lg p-6 text-center hover:shadow-md transition-shadow">
                  <div className="bg-gray-200 border-2 border-dashed rounded-xl w-16 h-16 mx-auto mb-4" />
                  <h3 className="font-semibold text-gray-900 mb-2">SEO Strategy Builder</h3>
                  <p className="text-gray-600 text-sm mb-4">
                    Build and optimize your own SEO strategy
                  </p>
                  <button
                    onClick={() => setShowGameHub(true)}
                    className="btn-primary text-sm"
                  >
                    Play Now
                  </button>
                </div>

                <div className="border border-gray-200 rounded-lg p-6 text-center hover:shadow-md transition-shadow">
                  <div className="bg-gray-200 border-2 border-dashed rounded-xl w-16 h-16 mx-auto mb-4" />
                  <h3 className="font-semibold text-gray-900 mb-2">Social Media Simulator</h3>
                  <p className="text-gray-600 text-sm mb-4">
                    Manage a virtual social media campaign
                  </p>
                  <button
                    onClick={() => setShowGameHub(true)}
                    className="btn-primary text-sm"
                  >
                    Play Now
                  </button>
                </div>
              </div>
            </div>
          )}
        </div>
      </section>

      {/* Game Hub Modal */}
      {showGameHub && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-lg shadow-xl max-w-4xl w-full max-h-[90vh] overflow-hidden">
            <div className="p-4 border-b border-gray-200 flex justify-between items-center">
              <h3 className="text-lg font-semibold text-gray-900">Learning Games</h3>
              <button
                onClick={() => setShowGameHub(false)}
                className="text-gray-400 hover:text-gray-500"
              >
                <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M6 18L18 6M6 6l12 12"></path>
                </svg>
              </button>
            </div>
            <div className="p-4">
              <GameHub onGameComplete={handleGameComplete} />
            </div>
          </div>
        </div>
      )}

      {/* Payment Modal */}
      {isPaymentModalOpen && (
        <PaymentModal
          course={course}
          onClose={() => setIsPaymentModalOpen(false)}
          onSuccess={handlePaymentSuccess}
          onError={handlePaymentError}
        />
      )}
    </div>
  );
};

export default CourseDetail;