import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { 
  BookOpen, 
  Users, 
  Award, 
  TrendingUp, 
  CheckCircle, 
  ArrowRight,
  Play,
  Star,
  Clock,
  BarChart,
  Zap,
  Target,
  Shield
} from 'lucide-react';
import * as supabaseCourseService from '../services/supabaseCourseService';
import { Course } from '../services/supabaseCourseService';

const Home: React.FC = () => {
  const [featuredCourses, setFeaturedCourses] = useState<Course[]>([]);
  const [loading, setLoading] = useState(true);
  const [stats, setStats] = useState({
    students: 0,
    courses: 0,
    completion: 0,
    rating: 0
  });

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const courses = await supabaseCourseService.getAllCourses();
        setFeaturedCourses(courses);
        
        // Animate stats
        animateStats();
      } catch (error) {
        console.error('Error fetching courses:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  const animateStats = () => {
    const duration = 2000;
    const steps = 60;
    const interval = duration / steps;
    
    let step = 0;
    const timer = setInterval(() => {
      step++;
      const progress = step / steps;
      
      setStats({
        students: Math.floor(50000 * progress),
        courses: Math.floor(featuredCourses.length * progress),
        completion: Math.floor(95 * progress),
        rating: (4.8 * progress).toFixed(1) as any
      });
      
      if (step >= steps) clearInterval(timer);
    }, interval);
  };

  const features = [
    {
      icon: BookOpen,
      title: 'Expert-Led Courses',
      description: 'Learn from industry professionals with real-world experience'
    },
    {
      icon: Users,
      title: 'Active Community',
      description: 'Connect with thousands of learners worldwide'
    },
    {
      icon: Award,
      title: 'Certifications',
      description: 'Earn recognized certificates to boost your career'
    },
    {
      icon: Zap,
      title: 'Hands-On Projects',
      description: 'Build real projects to solidify your skills'
    }
  ];

  const benefits = [
    'Lifetime access to course materials',
    'Interactive coding exercises',
    'Real-world project portfolio',
    'Career support and guidance',
    'Mobile-friendly learning',
    'Regular content updates'
  ];

  return (
    <div className="min-h-screen bg-white">
      {/* Hero Section */}
      <section className="relative bg-gradient-to-br from-primary-navy via-primary-navyLight to-primary-navyDark text-white overflow-hidden">
        {/* Animated Background Pattern */}
        <div className="absolute inset-0 opacity-10">
          <div className="absolute inset-0" style={{
            backgroundImage: `radial-gradient(circle at 2px 2px, rgba(0, 217, 255, 0.3) 1px, transparent 0)`,
            backgroundSize: '40px 40px'
          }}></div>
        </div>
        
        <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20 lg:py-32">
          <motion.div 
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8 }}
            className="text-center"
          >
            <motion.div
              initial={{ scale: 0.9 }}
              animate={{ scale: 1 }}
              transition={{ duration: 0.5 }}
              className="inline-block mb-6"
            >
              <span className="bg-primary-cyan/20 text-primary-cyan px-4 py-2 rounded-full text-sm font-medium border border-primary-cyan/30">
                Transform Your Career Today
              </span>
            </motion.div>
            
            <h1 className="text-4xl md:text-6xl lg:text-7xl font-bold mb-6 leading-tight">
              Master Digital Skills
              <span className="block text-primary-cyan mt-2">Build Your Future</span>
            </h1>
            
            <p className="text-lg md:text-xl text-gray-300 mb-10 max-w-3xl mx-auto leading-relaxed">
              Join thousands of professionals learning cutting-edge skills in AI, Marketing, and Technology. 
              Start your journey with expert-led courses designed for real-world success.
            </p>
            
            <div className="flex flex-col sm:flex-row gap-4 justify-center items-center">
              <Link 
                to="/courses"
                className="group bg-primary-cyan hover:bg-primary-cyanLight text-primary-navy px-8 py-4 rounded-lg font-semibold transition-all duration-300 flex items-center gap-2 shadow-lg hover:shadow-glow"
              >
                Explore Courses
                <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
              </Link>
              
              <button className="group bg-white/10 hover:bg-white/20 backdrop-blur-sm text-white px-8 py-4 rounded-lg font-semibold transition-all duration-300 flex items-center gap-2 border border-white/20">
                <Play className="w-5 h-5" />
                Watch Demo
              </button>
            </div>
          </motion.div>
        </div>

      {/* Wave Divider */}
        <div className="absolute bottom-0 left-0 right-0">
          <svg viewBox="0 0 1440 120" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M0 120L60 110C120 100 240 80 360 70C480 60 600 60 720 65C840 70 960 80 1080 85C1200 90 1320 90 1380 90L1440 90V120H1380C1320 120 1200 120 1080 120C960 120 840 120 720 120C600 120 480 120 360 120C240 120 120 120 60 120H0Z" fill="white"/>
          </svg>
        </div>
      </section>

      {/* Stats Section */}
      <section className="py-12 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
            {[
              { value: `${stats.students.toLocaleString()}+`, label: 'Students Enrolled', icon: Users },
              { number: featuredCourses.length, label: 'Expert Courses', icon: BookOpen },
              { number: `${stats.completion}%`, label: 'Completion Rate', icon: TrendingUp },
              { number: stats.rating, label: 'Average Rating', icon: Star }
            ].map((stat, index) => (
              <motion.div
                key={stat.label}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.1, duration: 0.5 }}
                className="text-center"
              >
                <div className="bg-white rounded-xl shadow-lg p-8 hover:shadow-xl transition-shadow duration-300">
                  <div className="text-4xl font-bold text-primary-navy mb-2">
                    {stat.number}
                  </div>
                  <div className="text-gray-600 font-medium">{stat.label}</div>
                </div>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-20 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.6 }}
            className="text-center mb-16"
          >
            <h2 className="text-3xl md:text-4xl font-bold text-primary-navy mb-4">
              Why Choose TrendTactics Academy?
            </h2>
            <p className="text-gray-600 text-lg max-w-2xl mx-auto">
              Everything you need to succeed in the digital economy
            </p>
          </motion.div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {features.map((feature, index) => {
              const Icon = feature.icon;
              return (
                <motion.div
                  key={feature.title}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: index * 0.1 }}
                  className="group bg-white rounded-xl p-6 shadow-lg hover:shadow-xl transition-all duration-300 border border-gray-100 hover:border-primary-cyan/30"
                >
                  <div className="bg-primary-cyan/10 w-12 h-12 rounded-lg flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
                    <Icon className="w-6 h-6 text-primary-cyan" />
                  </div>
                  <h3 className="text-xl font-semibold text-primary-navy mb-2">{feature.title}</h3>
                  <p className="text-gray-600">{feature.description}</p>
                </motion.div>
              );
            })}
          </div>
        </div>
      </section>

      {/* Featured Courses Section */}
      <section className="py-20 bg-gray-50">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="text-center mb-12">
              <h2 className="text-3xl md:text-4xl font-bold text-primary-navy mb-4">
                Featured Courses
              </h2>
              <p className="text-gray-600 text-lg max-w-2xl mx-auto">
                Start learning with our most popular courses designed by industry experts
              </p>
            </div>

            {loading ? (
              <div className="flex justify-center items-center py-20">
                <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-cyan"></div>
              </div>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                {featuredCourses.map((course, index) => (
                  <motion.div
                    key={course.id}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: index * 0.1 }}
                    className="group"
                  >
                    <Link to={`/courses/${course.id}`} className="block">
                      <div className="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-glow-strong transition-all duration-300 transform hover:-translate-y-2">
                        {/* Course Image */}
                        <div className="relative h-48 bg-gradient-to-br from-primary-navy to-primary-navyLight overflow-hidden">
                          {course.thumbnail_url ? (
                            <img
                              src={course.thumbnail_url}
                              alt={course.title}
                              className="w-full h-full object-cover"
                            />
                          ) : (
                            <div className="w-full h-full flex items-center justify-center">
                              <BookOpen className="w-16 h-16 text-primary-cyan" />
                            </div>
                          )}
                          <div className="absolute top-4 right-4 bg-primary-cyan text-primary-navy px-3 py-1 rounded-full text-sm font-semibold">
                            {course.level}
                          </div>
                        </div>

                        <div className="p-6">
                          <h3 className="text-xl font-bold text-gray-900 mb-2 line-clamp-2">
                            {course.title}
                          </h3>
                          <p className="text-gray-600 mb-4 line-clamp-2">
                            {course.description}
                          </p>

                          <div className="flex items-center justify-between mb-4">
                            <div className="flex items-center gap-1 text-yellow-500">
                              <Star className="w-4 h-4 fill-current" />
                              <span className="text-sm font-semibold text-gray-900">4.8</span>
                            </div>
                            <div className="flex items-center gap-1 text-gray-600">
                              <Clock className="w-4 h-4" />
                              <span className="text-sm">{course.duration || '8 weeks'}</span>
                            </div>
                          </div>

                          <Link
                            to={`/courses/${course.id}`}
                            className="block w-full bg-primary-navy hover:bg-primary-navyLight text-white text-center py-3 rounded-lg font-semibold transition-colors duration-300"
                          >
                            View Course
                          </Link>
                        </div>
                      </div>
                    </Link>
                  </motion.div>
                ))}
              </div>
            )}
          </div>
      </section>

      {/* CTA Section */}
      <section className="bg-gradient-to-br from-primary-navy to-primary-navyLight text-white py-20">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.6 }}
          >
            <h2 className="text-3xl md:text-4xl font-bold mb-6">
              Ready to Transform Your Career?
            </h2>
            <p className="text-xl text-gray-300 mb-8">
              Join thousands of professionals who have already started their journey to success.
            </p>
            <Link
              to="/courses"
              className="inline-flex items-center gap-2 bg-primary-cyan hover:bg-primary-cyanLight text-primary-navy px-8 py-4 rounded-lg font-semibold transition-all duration-300 shadow-lg hover:shadow-glow"
            >
              Get Started Now
              <ArrowRight className="w-5 h-5" />
            </Link>
          </motion.div>
        </div>
      </section>
    </div>
  );
};

export default Home;


