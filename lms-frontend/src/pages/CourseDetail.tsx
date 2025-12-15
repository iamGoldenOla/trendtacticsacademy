import React, { useState, useEffect } from 'react';
import { useParams, Link, Routes, Route, useNavigate } from 'react-router-dom';
import LessonViewer from '../components/LessonViewer';
import PaymentModal from '../components/PaymentModal';
import GameHub from '../components/GameHub';
import { Course, User } from '../types';
import { GameActivity } from '../services/types';
import { courseService, progressService, authService } from '../services';
import LoadingSpinner from '../components/LoadingSpinner';

// Extended Course interface to match our data structure
interface ExtendedCourse extends Omit<Course, '_id'> {
  id: string;
  gameActivities?: GameActivity[];
}

interface CourseDetailProps {
  user: User | null;
  onLogin?: () => void;
  onSignup?: () => void;
}

const CourseDetail: React.FC<CourseDetailProps> = ({ user, onLogin, onSignup }) => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState('overview');
  const [isEnrolled, setIsEnrolled] = useState(false);
  const [isPaymentModalOpen, setIsPaymentModalOpen] = useState(false);
  const [showGameHub, setShowGameHub] = useState(false);
  const [showSuccessMessage, setShowSuccessMessage] = useState(false);
  const [course, setCourse] = useState<ExtendedCourse | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [progress, setProgress] = useState<number>(0);
  const [completedLessons, setCompletedLessons] = useState<string[]>([]);

  // Debug: Log user prop to inspect enrolledCourses
  useEffect(() => {
    console.log("CourseDetail user prop:", user);
  }, [user]);

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
        
        // Fetch course details
        const courseData = await courseService.getCourseById(id);
        setCourse(courseData as any);
        
        // Check if user is enrolled
        if (user) {
          // Since enrolledCourses doesn't exist in the User type from services/types.ts,
          // we'll assume the user is not enrolled for now
          setIsEnrolled(false);
          
          // If enrolled, fetch progress
          if (isEnrolled) {
            try {
              const progressData = await progressService.getCourseProgress(id);
              if (progressData) {
                // Since the Progress type from services/types.ts doesn't have these properties,
                // we'll set default values for now
                setProgress(0);
                setCompletedLessons([]);
              }
            } catch (progressError) {
              console.error('Error fetching progress:', progressError);
            }
          }
        }
      } catch (err) {
        console.error('Error fetching course:', err);
        setError('Failed to load course details. Please try again later.');
      } finally {
        setLoading(false);
      }
    };
    
    fetchCourseData();
  }, [id, user]);

  if (loading) {
    return (
      <div className="container mx-auto px-4 py-16 text-center">
        <LoadingSpinner size="large" />
        <p className="mt-4 text-gray-600">Loading course details...</p>
      </div>
    );
  }
  
  if (error || !course) {
    return (
      <div className="container mx-auto px-4 py-16 text-center">
        <h1 className="text-2xl font-bold mb-4">Course Not Found</h1>
        <p className="mb-6">{error || 'Sorry, the course you are looking for does not exist.'}</p>
        <Link to="/my-courses" className="btn-primary">Back to My Courses</Link>
      </div>
    );
  }

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
        setShowSuccessMessage(true);
        
        // Hide success message after 5 seconds
        setTimeout(() => {
          setShowSuccessMessage(false);
        }, 5000);
      } catch (err) {
        console.error('Enrollment error:', err);
      }
    } else {
      // For paid courses, show payment modal
      setIsPaymentModalOpen(true);
    }
  };

  const handlePaymentSuccess = async (paymentId: string) => {
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
      
      console.log('Payment successful:', paymentId);
    } catch (err) {
      console.error('Error enrolling after payment:', err);
    }
  };

  const handlePaymentError = (error: string) => {
    console.error('Payment error:', error);
    // In a real app, you might show a toast notification here
  };

  const handleLessonComplete = async (lessonId: string) => {
    try {
      // Call API to mark lesson as complete
      await progressService.updateProgress(course.id, lessonId, true);
      
      // Update local state
      if (!completedLessons.includes(lessonId)) {
        const newCompletedLessons = [...completedLessons, lessonId];
        setCompletedLessons(newCompletedLessons);
        
        // Recalculate progress percentage
        const newProgress = (newCompletedLessons.length / course.lessons.length) * 100;
        setProgress(newProgress);
      }
      
      console.log('Lesson completed:', lessonId);
    } catch (err) {
      console.error('Error updating lesson progress:', err);
    }
  };

  const handleGameComplete = (activityId: string, score: number) => {
    console.log(`Game ${activityId} completed with score: ${score}`);
    // Here you would typically update the user's progress and unlock next activities
    // For now, we'll just log it
  };

  const totalLessons = course.lessons.length;
  const completedLessonsCount = completedLessons.length;
  const progressPercentage = progress || (completedLessonsCount / totalLessons) * 100;

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
                  By {course.instructor.name}
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
                  {course.rating} ({course.enrolledStudents} students)
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
                    <span>{completedLessons} of {totalLessons} lessons completed</span>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-2">
                    <div
                      className="bg-brand-cyan h-2 rounded-full transition-all duration-300"
                      style={{ width: `${progressPercentage}%` }}
                    ></div>
                  </div>
                </div>
              )}
            </div>

            {/* Course Card */}
            <div className="lg:col-span-1">
              <div className="bg-white rounded-lg shadow-lg border border-gray-200 p-6 sticky top-4">
                <img
                  src={course.thumbnail}
                  alt={course.title}
                  className="w-full h-48 object-cover rounded-lg mb-4"
                />
                
                <div className="text-3xl font-heading font-bold text-gray-900 mb-4">
                  ${course.price}
                </div>

                {isEnrolled ? (
                  <div className="flex flex-col gap-3">
                    <Link
                      to={`/course/${course.id}/lesson/${course.lessons[0].id}`}
                      className="w-full btn-primary text-center"
                      state={{ fromDashboard: false }}
                    >
                      Continue Learning
                    </Link>
                    <Link
                      to="/dashboard"
                      className="w-full btn-secondary text-center"
                    >
                      Go to Dashboard
                    </Link>
                  </div>
                ) : (
                  <button
                    onClick={handleEnroll}
                    className="w-full btn-primary"
                  >
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
                  className={`py-2 px-1 border-b-2 font-medium text-sm ${
                    activeTab === tab.id
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
                <p className="text-gray-600 mb-6">
                  The course covers everything from search engine optimization and content marketing to social media management and paid advertising. Each lesson includes real-world examples and hands-on exercises to ensure you understand and can apply the concepts.
                </p>
                <p className="text-gray-600">
                  By the end of this course, you'll have a complete understanding of digital marketing fundamentals and be able to create and execute effective marketing campaigns across multiple channels.
                </p>
              </div>
            </div>
          )}

          {activeTab === 'curriculum' && (
            <div>
              <h2 className="text-2xl font-heading font-bold text-gray-900 mb-6">
                Course Curriculum
              </h2>
              <div className="space-y-4">
                {course.lessons.map((lesson, index) => (
                  <div
                    key={lesson.id}
                    className="border border-gray-200 rounded-lg p-4 hover:border-gray-300 transition-colors"
                  >
                    <div className="flex items-center justify-between">
                      <div className="flex items-center space-x-4">
                        <div className="w-8 h-8 bg-brand-cyan text-white rounded-full flex items-center justify-center text-sm font-medium">
                          {index + 1}
                        </div>
                        <div>
                          <h3 className="font-medium text-gray-900">{lesson.title}</h3>
                          <p className="text-sm text-gray-600">{lesson.description}</p>
                        </div>
                      </div>
                      <div className="flex items-center space-x-4">
                        <span className="text-sm text-gray-500">{lesson.duration}</span>
                        {isEnrolled ? (
                          <Link
                            to={`/course/${course.id}/lesson/${lesson.id}`}
                            className="text-brand-cyan hover:text-brand-navy font-medium text-sm"
                            state={{ fromDashboard: false }}
                          >
                            {lesson.isCompleted ? 'Review' : 'Start'}
                          </Link>
                        ) : (
                          <span className="text-gray-400 text-sm">Preview</span>
                        )}
                      </div>
                    </div>
                  </div>
                ))}
              </div>
              {course.moduleQuiz && course.moduleQuiz.length > 0 && (
                <div className="mt-8 text-center">
                  <Link to={`/course/${course.id}/module-quiz`} className="btn-primary text-lg px-6 py-3">
                    Take Module Quiz (50 Questions)
                  </Link>
                </div>
              )}
            </div>
          )}

          {activeTab === 'instructor' && (
            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
              <div className="lg:col-span-2">
                <h2 className="text-2xl font-heading font-bold text-gray-900 mb-6">
                  About the Instructor
                </h2>
                <div className="flex items-start space-x-6">
                  <div className="w-24 h-24 bg-brand-cyan rounded-full flex items-center justify-center text-white text-2xl font-bold">
                    {course.instructor.name.charAt(0)}
                  </div>
                  <div>
                    <h3 className="text-xl font-heading font-semibold text-gray-900 mb-2">
                      {course.instructor.name}
                    </h3>
                    <p className="text-gray-600 mb-4">
                      Digital Marketing Expert & Consultant
                    </p>
                    <p className="text-gray-600 mb-4">
                      Sarah Johnson is a certified digital marketing professional with over 8 years of experience helping businesses grow their online presence. She has worked with companies ranging from startups to Fortune 500 enterprises, developing and executing successful digital marketing strategies.
                    </p>
                    <p className="text-gray-600">
                      Sarah specializes in SEO, content marketing, social media management, and paid advertising. She has helped hundreds of students master digital marketing through her comprehensive courses and practical approach to learning.
                    </p>
                  </div>
                </div>
              </div>
            </div>
          )}

          {activeTab === 'reviews' && (
            <div>
              <h2 className="text-2xl font-heading font-bold text-gray-900 mb-6">
                Student Reviews
              </h2>
              <div className="space-y-6">
                {[
                  {
                    name: 'Michael Chen',
                    rating: 5,
                    date: '2 weeks ago',
                    comment: 'Excellent course! The content is well-structured and Sarah explains complex concepts in a way that\'s easy to understand. I\'ve already started implementing the strategies and seeing results.'
                  },
                  {
                    name: 'Emily Rodriguez',
                    rating: 5,
                    date: '1 month ago',
                    comment: 'This course exceeded my expectations. The practical examples and downloadable resources are incredibly valuable. Highly recommend for anyone serious about digital marketing.'
                  },
                  {
                    name: 'David Thompson',
                    rating: 4,
                    date: '2 months ago',
                    comment: 'Great course with comprehensive coverage of digital marketing topics. The instructor is knowledgeable and the course materials are top-notch.'
                  }
                ].map((review, index) => (
                  <div key={index} className="border border-gray-200 rounded-lg p-6">
                    <div className="flex items-center justify-between mb-4">
                      <div className="flex items-center space-x-3">
                        <div className="w-10 h-10 bg-gray-300 rounded-full flex items-center justify-center text-gray-600 font-medium">
                          {review.name.charAt(0)}
                        </div>
                        <div>
                          <h4 className="font-medium text-gray-900">{review.name}</h4>
                          <div className="flex items-center space-x-1">
                            {[...Array(5)].map((_, i) => (
                              <svg
                                key={i}
                                className={`w-4 h-4 ${i < review.rating ? 'text-yellow-400' : 'text-gray-300'}`}
                                fill="currentColor"
                                viewBox="0 0 20 20"
                              >
                                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                              </svg>
                            ))}
                          </div>
                        </div>
                      </div>
                      <span className="text-sm text-gray-500">{review.date}</span>
                    </div>
                    <p className="text-gray-600">{review.comment}</p>
                  </div>
                ))}
              </div>
            </div>
          )}

          {activeTab === 'games' && (
             <div>
               <h2 className="text-2xl font-heading font-bold text-gray-900 mb-6">
                 🎮 Course Games & Activities
               </h2>
               <p className="text-gray-600 mb-6">
                 Enhance your learning experience with interactive games and activities related to this course.
               </p>
               
               {course.gameActivities && course.gameActivities.length > 0 ? (
                 <div className="space-y-6">
                   <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                      {course.gameActivities.slice(0, 3).map((activity: GameActivity) => (
                       <div key={activity.id} className="border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow">
                         <div className="flex items-center justify-between mb-3">
                           <span className="text-2xl">
                             {activity.type === 'quiz' ? '🧠' : activity.type === 'memory' ? '🃏' : '🎯'}
                           </span>
                           <span className={`text-xs px-2 py-1 rounded-full ${
                             activity.difficulty === 'easy' ? 'bg-green-100 text-green-700' :
                             activity.difficulty === 'medium' ? 'bg-yellow-100 text-yellow-700' :
                             'bg-red-100 text-red-700'
                           }`}>
                             {activity.difficulty.toUpperCase()}
                           </span>
                         </div>
                         <h3 className="font-semibold text-gray-900 mb-2">{activity.title}</h3>
                         <p className="text-sm text-gray-600 mb-3">{activity.description}</p>
                         <div className="flex items-center justify-between text-xs text-gray-500">
                           <span>🏆 {activity.points} points</span>
                           {activity.timeLimit && (
                             <span>⏱️ {Math.floor(activity.timeLimit / 60)}m</span>
                           )}
                         </div>
                       </div>
                     ))}
                   </div>
                   
                   <div className="text-center">
                     <button
                       onClick={() => setShowGameHub(true)}
                       className="bg-gradient-to-r from-brand-cyan to-brand-navy text-white px-8 py-3 rounded-lg font-semibold hover:shadow-lg transition-all duration-200 transform hover:scale-105"
                     >
                       🎮 Launch Game Hub
                     </button>
                   </div>
                 </div>
               ) : (
                 <div className="text-center py-12">
                   <div className="text-6xl mb-4">🎮</div>
                   <h3 className="text-xl font-semibold text-gray-900 mb-2">No Games Available</h3>
                   <p className="text-gray-600">Games and activities for this course are coming soon!</p>
                 </div>
               )}
             </div>
           )}
        </div>
      </section>

      {/* Lesson Routes */}
      <Routes>
        <Route 
          path="lesson/:lessonId" 
          element={
            <LessonViewer 
              course={course} 
              onLessonComplete={handleLessonComplete}
            />
          } 
        />
      </Routes>

      {/* Payment Modal */}
      <PaymentModal
        isOpen={isPaymentModalOpen}
        onClose={() => setIsPaymentModalOpen(false)}
        course={course}
        onPaymentSuccess={handlePaymentSuccess}
        onPaymentError={handlePaymentError}
      />
      
      {/* Game Hub Modal */}
      {showGameHub && course?.gameActivities && (
        <GameHub
          courseId={course.id}
          courseTitle={course.title}
          gameActivities={course.gameActivities}
          onGameComplete={handleGameComplete}
          onClose={() => setShowGameHub(false)}
        />
      )}
    </div>
  );
};

export default CourseDetail;