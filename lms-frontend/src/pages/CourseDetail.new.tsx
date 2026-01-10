import React, { useState, useEffect } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import {
  BookOpen,
  Clock,
  Users,
  Award,
  CheckCircle,
  PlayCircle,
  ChevronDown,
  ChevronUp,
  Star,
  BarChart,
  Target
} from 'lucide-react';
import * as supabaseCourseService from '../services/supabaseCourseService';
import { Course, Module, Lesson } from '../services/supabaseCourseService';

interface CourseDetailProps {
  user?: any;
}

const CourseDetail: React.FC<CourseDetailProps> = ({ user }) => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  
  const [course, setCourse] = useState<Course | null>(null);
  const [modules, setModules] = useState<Module[]>([]);
  const [lessons, setLessons] = useState<{ [moduleId: string]: Lesson[] }>({});
  const [expandedModules, setExpandedModules] = useState<Set<string>>(new Set());
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [isEnrolled, setIsEnrolled] = useState(false);

  useEffect(() => {
    const fetchCourseData = async () => {
      if (!id) return;
      
      try {
        setLoading(true);
        setError(null);
        
        // Fetch course details
        const courseData = await supabaseCourseService.getCourseById(id);
        if (!courseData) {
          setError('Course not found');
          return;
        }
        setCourse(courseData);
        
        // Fetch modules
        const modulesData = await supabaseCourseService.getCourseModules(id);
        setModules(modulesData);
        
        // Fetch lessons for each module
        const lessonsData: { [moduleId: string]: Lesson[] } = {};
        for (const module of modulesData) {
          const moduleLessons = await supabaseCourseService.getModuleLessons(module.id);
          lessonsData[module.id] = moduleLessons;
        }
        setLessons(lessonsData);
        
        // Expand first module by default
        if (modulesData.length > 0) {
          setExpandedModules(new Set([modulesData[0].id]));
        }
        
      } catch (err) {
        console.error('Error fetching course data:', err);
        setError('Failed to load course data');
      } finally {
        setLoading(false);
      }
    };

    fetchCourseData();
  }, [id]);

  const toggleModule = (moduleId: string) => {
    setExpandedModules(prev => {
      const newSet = new Set(prev);
      if (newSet.has(moduleId)) {
        newSet.delete(moduleId);
      } else {
        newSet.add(moduleId);
      }
      return newSet;
    });
  };

  const getTotalLessons = () => {
    return Object.values(lessons).reduce((total, moduleLessons) => total + moduleLessons.length, 0);
  };

  const handleEnroll = () => {
    if (!user) {
      // Redirect to login
      navigate('/login', { state: { from: `/courses/${id}` } });
      return;
    }
    
    // Handle enrollment logic
    setIsEnrolled(true);
  };

  const handleStartLearning = () => {
    if (modules.length > 0 && lessons[modules[0].id]?.length > 0) {
      const firstLesson = lessons[modules[0].id][0];
      navigate(`/courses/${id}/lessons/${firstLesson.id}`);
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-16 w-16 border-b-2 border-primary-cyan mx-auto mb-4"></div>
          <p className="text-gray-600">Loading course...</p>
        </div>
      </div>
    );
  }

  if (error || !course) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <div className="text-center">
          <h2 className="text-2xl font-bold text-gray-900 mb-4">Course Not Found</h2>
          <p className="text-gray-600 mb-6">{error || 'The course you are looking for does not exist.'}</p>
          <Link to="/courses" className="text-primary-cyan hover:text-primary-cyanLight font-semibold">
            Browse All Courses
          </Link>
        </div>
      </div>
    );
  }

  const totalLessons = getTotalLessons();

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Hero Section */}
      <section className="bg-gradient-to-br from-primary-navy via-primary-navyLight to-primary-navyDark text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
            {/* Course Info */}
            <div className="lg:col-span-2">
              <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.6 }}
              >
                <div className="inline-block bg-primary-cyan/20 text-primary-cyan px-3 py-1 rounded-full text-sm font-medium mb-4 border border-primary-cyan/30">
                  {course.level}
                </div>
                
                <h1 className="text-3xl md:text-4xl lg:text-5xl font-bold mb-4 leading-tight">
                  {course.title}
                </h1>
                
                <p className="text-lg text-gray-300 mb-6 leading-relaxed">
                  {course.description}
                </p>
                
                <div className="flex flex-wrap gap-6 text-sm">
                  <div className="flex items-center gap-2">
                    <Star className="w-5 h-5 text-yellow-400 fill-current" />
                    <span className="font-semibold">4.8</span>
                    <span className="text-gray-400">(1,234 ratings)</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <Users className="w-5 h-5 text-primary-cyan" />
                    <span>12,456 students</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <Clock className="w-5 h-5 text-primary-cyan" />
                    <span>{course.duration || '8 weeks'}</span>
                  </div>
                </div>
              </motion.div>
            </div>

            {/* Enrollment Card */}
            <div className="lg:col-span-1">
              <motion.div
                initial={{ opacity: 0, x: 20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ duration: 0.6, delay: 0.2 }}
                className="bg-white rounded-xl shadow-xl p-6 sticky top-24"
              >
                <div className="text-center mb-6">
                  <div className="text-4xl font-bold text-primary-navy mb-2">
                    {course.price ? `$${course.price}` : 'Free'}
                  </div>
                  {course.price && (
                    <div className="text-gray-500 line-through text-sm">$199</div>
                  )}
                </div>

                {isEnrolled ? (
                  <button
                    onClick={handleStartLearning}
                    className="w-full bg-primary-cyan hover:bg-primary-cyanLight text-primary-navy font-semibold py-4 rounded-lg transition-colors duration-300 mb-4 flex items-center justify-center gap-2"
                  >
                    <PlayCircle className="w-5 h-5" />
                    Continue Learning
                  </button>
                ) : (
                  <button
                    onClick={handleEnroll}
                    className="w-full bg-primary-cyan hover:bg-primary-cyanLight text-primary-navy font-semibold py-4 rounded-lg transition-colors duration-300 mb-4"
                  >
                    Enroll Now
                  </button>
                )}

                <div className="space-y-3 text-sm text-gray-600">
                  <div className="flex items-center gap-2">
                    <CheckCircle className="w-5 h-5 text-green-500" />
                    <span>Lifetime access</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <CheckCircle className="w-5 h-5 text-green-500" />
                    <span>{modules.length} modules</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <CheckCircle className="w-5 h-5 text-green-500" />
                    <span>{totalLessons} lessons</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <CheckCircle className="w-5 h-5 text-green-500" />
                    <span>Certificate of completion</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <CheckCircle className="w-5 h-5 text-green-500" />
                    <span>Mobile friendly</span>
                  </div>
                </div>
              </motion.div>
            </div>
          </div>
        </div>
      </section>

      {/* Course Content */}
      <section className="py-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
            {/* Main Content */}
            <div className="lg:col-span-2">
              <h2 className="text-2xl font-bold text-primary-navy mb-6">Course Content</h2>

              <div className="space-y-4">
                {modules.map((module, index) => {
                  const isExpanded = expandedModules.has(module.id);
                  const moduleLessons = lessons[module.id] || [];

                  return (
                    <motion.div
                      key={module.id}
                      initial={{ opacity: 0, y: 20 }}
                      animate={{ opacity: 1, y: 0 }}
                      transition={{ delay: index * 0.1 }}
                      className="bg-white rounded-lg shadow-md overflow-hidden"
                    >
                      <button
                        onClick={() => toggleModule(module.id)}
                        className="w-full px-6 py-4 flex items-center justify-between hover:bg-gray-50 transition-colors"
                      >
                        <div className="flex items-center gap-4">
                          <div className="bg-primary-cyan/10 text-primary-cyan w-10 h-10 rounded-lg flex items-center justify-center font-bold">
                            {index + 1}
                          </div>
                          <div className="text-left">
                            <h3 className="font-semibold text-gray-900">{module.title}</h3>
                            <p className="text-sm text-gray-600">{moduleLessons.length} lessons</p>
                          </div>
                        </div>
                        {isExpanded ? (
                          <ChevronUp className="w-5 h-5 text-gray-400" />
                        ) : (
                          <ChevronDown className="w-5 h-5 text-gray-400" />
                        )}
                      </button>

                      {isExpanded && (
                        <div className="border-t border-gray-200">
                          {moduleLessons.map((lesson, lessonIndex) => (
                            <Link
                              key={lesson.id}
                              to={`/courses/${id}/lessons/${lesson.id}`}
                              className="block px-6 py-3 hover:bg-gray-50 transition-colors border-b border-gray-100 last:border-b-0"
                            >
                              <div className="flex items-center justify-between">
                                <div className="flex items-center gap-3">
                                  <PlayCircle className="w-5 h-5 text-gray-400" />
                                  <span className="text-gray-700">{lesson.title}</span>
                                </div>
                                <span className="text-sm text-gray-500">{lesson.duration || '15 min'}</span>
                              </div>
                            </Link>
                          ))}
                        </div>
                      )}
                    </motion.div>
                  );
                })}
              </div>
            </div>

            {/* Sidebar */}
            <div className="lg:col-span-1">
              <div className="bg-white rounded-lg shadow-md p-6 mb-6">
                <h3 className="font-bold text-gray-900 mb-4">What You'll Learn</h3>
                <ul className="space-y-3">
                  {course.objectives && Array.isArray(course.objectives) ? (
                    course.objectives.map((objective: string, index: number) => (
                      <li key={index} className="flex items-start gap-2">
                        <CheckCircle className="w-5 h-5 text-green-500 flex-shrink-0 mt-0.5" />
                        <span className="text-gray-700 text-sm">{objective}</span>
                      </li>
                    ))
                  ) : (
                    <>
                      <li className="flex items-start gap-2">
                        <CheckCircle className="w-5 h-5 text-green-500 flex-shrink-0 mt-0.5" />
                        <span className="text-gray-700 text-sm">Master core concepts and fundamentals</span>
                      </li>
                      <li className="flex items-start gap-2">
                        <CheckCircle className="w-5 h-5 text-green-500 flex-shrink-0 mt-0.5" />
                        <span className="text-gray-700 text-sm">Build real-world projects</span>
                      </li>
                      <li className="flex items-start gap-2">
                        <CheckCircle className="w-5 h-5 text-green-500 flex-shrink-0 mt-0.5" />
                        <span className="text-gray-700 text-sm">Apply best practices and industry standards</span>
                      </li>
                    </>
                  )}
                </ul>
              </div>

              <div className="bg-white rounded-lg shadow-md p-6">
                <h3 className="font-bold text-gray-900 mb-4">Course Stats</h3>
                <div className="space-y-4">
                  <div className="flex items-center justify-between">
                    <span className="text-gray-600">Level</span>
                    <span className="font-semibold text-primary-navy">{course.level}</span>
                  </div>
                  <div className="flex items-center justify-between">
                    <span className="text-gray-600">Duration</span>
                    <span className="font-semibold text-primary-navy">{course.duration || '8 weeks'}</span>
                  </div>
                  <div className="flex items-center justify-between">
                    <span className="text-gray-600">Modules</span>
                    <span className="font-semibold text-primary-navy">{modules.length}</span>
                  </div>
                  <div className="flex items-center justify-between">
                    <span className="text-gray-600">Lessons</span>
                    <span className="font-semibold text-primary-navy">{totalLessons}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
};

export default CourseDetail;

