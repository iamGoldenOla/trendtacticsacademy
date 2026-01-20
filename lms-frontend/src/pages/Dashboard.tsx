import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import {
  BookOpen,
  Clock,
  Award,
  TrendingUp,
  PlayCircle,
  CheckCircle,
  Calendar,
  Target,
  BarChart3,
  Users
} from 'lucide-react';
import { courseService } from '../api/services/course.service';
import { Course, CourseProgress } from '../types/api.types';

interface DashboardProps {
  user?: any;
}

const Dashboard: React.FC<DashboardProps> = ({ user }) => {
  const navigate = useNavigate();
  const [enrolledCourses, setEnrolledCourses] = useState<Course[]>([]);
  const [loading, setLoading] = useState(true);
  const [stats, setStats] = useState({
    totalCourses: 0,
    completedCourses: 0,
    inProgressCourses: 0,
    totalHours: 0,
    certificates: 0,
    currentStreak: 7,
  });

  useEffect(() => {
    fetchDashboardData();
  }, []);

  const fetchDashboardData = async () => {
    try {
      setLoading(true);
      // Fetch all published courses
      const courses = await courseService.getAllCourses();
      setEnrolledCourses(courses); // Show all published courses

      // Calculate stats from actual course data
      setStats({
        totalCourses: courses.length,
        completedCourses: 0, // TODO: Calculate from progress data
        inProgressCourses: courses.length,
        totalHours: courses.reduce((acc, course) => {
          const duration = parseInt(course.duration || '0') || 0;
          return acc + duration;
        }, 0),
        certificates: 0, // TODO: Fetch from certificates table
        currentStreak: 7, // TODO: Calculate from user activity
      });
    } catch (error) {
      console.error('Error fetching dashboard data:', error);
    } finally {
      setLoading(false);
    }
  };

  const StatCard = ({ icon: Icon, label, value, color, trend }: any) => (
    <motion.div
      whileHover={{ scale: 1.02 }}
      className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"
    >
      <div className="flex items-center justify-between mb-4">
        <div className={`p-3 rounded-lg ${color}`}>
          <Icon className="w-6 h-6 text-white" />
        </div>
        {trend && (
          <div className="flex items-center text-green-600 text-sm font-semibold">
            <TrendingUp className="w-4 h-4 mr-1" />
            {trend}
          </div>
        )}
      </div>
      <h3 className="text-2xl font-bold text-gray-900 mb-1">{value}</h3>
      <p className="text-gray-600 text-sm">{label}</p>
    </motion.div>
  );

  const CourseCard = ({ course }: { course: Course }) => {
    const progress = Math.floor(Math.random() * 100); // Mock progress

    return (
      <motion.div
        whileHover={{ scale: 1.02 }}
        className="bg-white rounded-xl shadow-sm overflow-hidden border border-gray-100 cursor-pointer"
        onClick={() => navigate(`/course/${course.id}`)}
      >
        <div className="aspect-video bg-gradient-to-br from-primary-cyan to-primary-purple relative">
          {course.thumbnail_url ? (
            <img
              src={course.thumbnail_url}
              alt={course.title}
              className="w-full h-full object-cover"
            />
          ) : (
            <div className="w-full h-full flex items-center justify-center">
              <BookOpen className="w-16 h-16 text-white opacity-50" />
            </div>
          )}
          <div className="absolute top-4 right-4 bg-white/90 backdrop-blur-sm px-3 py-1 rounded-full">
            <span className="text-sm font-semibold text-gray-900">{progress}%</span>
          </div>
        </div>

        <div className="p-6">
          <h3 className="text-lg font-bold text-gray-900 mb-2 line-clamp-2">
            {course.title}
          </h3>
          <p className="text-gray-600 text-sm mb-4 line-clamp-2">
            {course.description}
          </p>

          {/* Progress Bar */}
          <div className="mb-4">
            <div className="w-full bg-gray-200 rounded-full h-2">
              <div
                className="bg-gradient-to-r from-primary-cyan to-primary-purple h-2 rounded-full transition-all duration-300"
                style={{ width: `${progress}%` }}
              ></div>
            </div>
          </div>

          <div className="flex items-center justify-between text-sm">
            <div className="flex items-center text-gray-600">
              <Clock className="w-4 h-4 mr-1" />
              <span>{course.duration || '10h'}</span>
            </div>
            <button className="text-primary-cyan hover:text-primary-cyanLight font-semibold">
              Continue Learning →
            </button>
          </div>
        </div>
      </motion.div>
    );
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-16 w-16 border-b-2 border-primary-cyan mx-auto mb-4"></div>
          <p className="text-gray-600">Loading dashboard...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-gradient-to-r from-primary-cyan to-primary-purple text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
          >
            <h1 className="text-4xl font-bold mb-2">
              Welcome back, {user?.firstName || 'Student'}! 👋
            </h1>
            <p className="text-cyan-100 text-lg">
              You're on a {stats.currentStreak}-day learning streak! Keep it up!
            </p>
          </motion.div>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Stats Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
          <StatCard
            icon={BookOpen}
            label="Courses Enrolled"
            value={stats.totalCourses}
            color="bg-gradient-to-br from-blue-500 to-blue-600"
            trend="+2 this month"
          />
          <StatCard
            icon={CheckCircle}
            label="Courses Completed"
            value={stats.completedCourses}
            color="bg-gradient-to-br from-green-500 to-green-600"
            trend="+1 this week"
          />
          <StatCard
            icon={Clock}
            label="Hours Learned"
            value={stats.totalHours}
            color="bg-gradient-to-br from-purple-500 to-purple-600"
            trend="+12h this week"
          />
          <StatCard
            icon={Award}
            label="Certificates Earned"
            value={stats.certificates}
            color="bg-gradient-to-br from-yellow-500 to-yellow-600"
          />
        </div>

        {/* Continue Learning Section */}
        <div className="mb-8">
          <div className="flex items-center justify-between mb-6">
            <h2 className="text-2xl font-bold text-gray-900">Continue Learning</h2>
            <button
              onClick={() => navigate('/courses')}
              className="text-primary-cyan hover:text-primary-cyanLight font-semibold"
            >
              View All Courses →
            </button>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {enrolledCourses.map((course) => (
              <CourseCard key={course.id} course={course} />
            ))}
          </div>
        </div>

        {/* Learning Activity */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Activity Chart */}
          <div className="lg:col-span-2 bg-white rounded-xl shadow-sm p-6 border border-gray-100">
            <h3 className="text-xl font-bold text-gray-900 mb-6 flex items-center">
              <BarChart3 className="w-5 h-5 mr-2" />
              Learning Activity
            </h3>
            <div className="h-64 flex items-end justify-between space-x-2">
              {[40, 65, 45, 80, 55, 90, 70].map((height, index) => (
                <div key={index} className="flex-1 flex flex-col items-center">
                  <motion.div
                    initial={{ height: 0 }}
                    animate={{ height: `${height}%` }}
                    transition={{ duration: 0.5, delay: index * 0.1 }}
                    className="w-full bg-gradient-to-t from-primary-cyan to-primary-purple rounded-t-lg"
                  ></motion.div>
                  <span className="text-xs text-gray-600 mt-2">
                    {['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index]}
                  </span>
                </div>
              ))}
            </div>
          </div>

          {/* Upcoming Deadlines */}
          <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
            <h3 className="text-xl font-bold text-gray-900 mb-6 flex items-center">
              <Calendar className="w-5 h-5 mr-2" />
              Upcoming
            </h3>
            <div className="space-y-4">
              {[
                { title: 'React Quiz', date: 'Tomorrow', color: 'text-red-600' },
                { title: 'Project Submission', date: 'In 3 days', color: 'text-orange-600' },
                { title: 'Live Session', date: 'Friday', color: 'text-blue-600' },
              ].map((item, index) => (
                <div key={index} className="flex items-start space-x-3">
                  <div className={`p-2 rounded-lg bg-gray-100 ${item.color}`}>
                    <Target className="w-4 h-4" />
                  </div>
                  <div>
                    <p className="font-semibold text-gray-900">{item.title}</p>
                    <p className="text-sm text-gray-600">{item.date}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Achievements */}
        <div className="mt-8 bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <h3 className="text-xl font-bold text-gray-900 mb-6 flex items-center">
            <Award className="w-5 h-5 mr-2" />
            Recent Achievements
          </h3>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            {[
              { name: 'First Course', icon: '🎓', unlocked: true },
              { name: '7-Day Streak', icon: '🔥', unlocked: true },
              { name: 'Quick Learner', icon: '⚡', unlocked: true },
              { name: 'Master', icon: '👑', unlocked: false },
            ].map((achievement, index) => (
              <motion.div
                key={index}
                whileHover={{ scale: 1.05 }}
                className={`p-4 rounded-lg text-center ${achievement.unlocked
                  ? 'bg-gradient-to-br from-yellow-50 to-yellow-100 border-2 border-yellow-300'
                  : 'bg-gray-100 opacity-50'
                  }`}
              >
                <div className="text-4xl mb-2">{achievement.icon}</div>
                <p className="font-semibold text-gray-900 text-sm">{achievement.name}</p>
              </motion.div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;

