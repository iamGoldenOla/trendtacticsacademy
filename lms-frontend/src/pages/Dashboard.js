import React, { useState, useEffect } from "react";
import StudentDashboardLayout from "../components/StudentDashboardLayout";
import Profile from "./Profile";
import { Link, useNavigate } from 'react-router-dom';
import { isAuthenticated, logout } from '../services/authService';
import { courseService } from '../services';
import TodoList from "../components/TodoList";
import PlannerPage from "./PlannerPage";
import Calendar from "../components/Calendar";
import CertificateTemplate from "../components/CertificateTemplate";
import {
  BarChart3,
  Clock,
  BookOpen,
  Award,
  ArrowRight,
  TrendingUp,
  PlayCircle,
  Calendar as CalendarIcon,
  MessageSquare
} from 'lucide-react';
import { AIDashboard } from "../components/AIDashboard";

const StatCard = ({ icon, label, value, color }) => (
  <div className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex items-center justify-between hover:shadow-md transition-shadow">
    <div>
      <p className="text-sm font-medium text-gray-500">{label}</p>
      <h3 className="text-2xl font-bold text-gray-900 mt-1">{value}</h3>
    </div>
    <div className={`p-3 rounded-xl ${color} shadow-lg shadow-opacity-20`}>
      {icon}
    </div>
  </div>
);

const SectionHeader = ({ title, icon }) => (
  <div className="flex items-center gap-2 mb-6">
    <div className="p-2 bg-brand-cyan/10 rounded-lg text-brand-cyan">
      {icon}
    </div>
    <h2 className="text-xl font-bold text-gray-900">{title}</h2>
  </div>
);

const Dashboard = () => {
  const navigate = useNavigate();
  const [userData, setUserData] = useState(null);
  const [activeSection, setActiveSection] = useState("dashboard");
  const [enrolledCourses, setEnrolledCourses] = useState([]);
  const [isLoadingCourses, setIsLoadingCourses] = useState(true);
  const [certificates, setCertificates] = useState([]);


  const assignments = [
    { title: "UI Design Principles", status: "Upcoming", date: "Oct 25" },
    { title: "React Components", status: "In Progress", date: "Oct 28" },
    { title: "API Integration", status: "Completed", date: "Oct 20" }
  ];

  // Auth check
  useEffect(() => {
    if (!isAuthenticated()) {
      navigate('/login', { replace: true });
    }
  }, [navigate]);

  // Sync with URL query param
  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const section = params.get("section");
    if (section) {
      setActiveSection(section);
    }
  }, []);

  // Auth check

  // Load User
  useEffect(() => {
    const userStr = localStorage.getItem("user");
    if (userStr) {
      try {
        const parsedUser = JSON.parse(userStr);
        setUserData(parsedUser);
      } catch (err) {
        console.error("Error parsing user data:", err);
      }
    }
  }, []);

  // Fetch enrolled courses
  useEffect(() => {
    const fetchEnrolledCourses = async () => {
      try {
        setIsLoadingCourses(true);
        const courses = await courseService.getEnrolledCourses();
        setEnrolledCourses(courses || []);
      } catch (error) {
        console.error('Error fetching enrolled courses:', error);
        setEnrolledCourses([]);
      } finally {
        setIsLoadingCourses(false);
      }
    };

    if (isAuthenticated()) {
      fetchEnrolledCourses();
    }
  }, []);

  // Safe checks
  const safeEnrolledCourses = Array.isArray(enrolledCourses) ? enrolledCourses : [];
  const overallProgress = safeEnrolledCourses.length
    ? Math.round(safeEnrolledCourses.reduce((acc, c) => acc + (c.progress || 0), 0) / safeEnrolledCourses.length)
    : 0;

  // Recent Course (Resume Learning)
  const recentCourse = safeEnrolledCourses.length > 0 ? safeEnrolledCourses[0] : null;

  // Simple Weekly Activity Chart (Mock Data for Visuals)
  const weeklyActivity = [30, 45, 20, 60, 50, 80, 40];
  const maxActivity = Math.max(...weeklyActivity);

  // Todo Handling
  const [tasks, setTasks] = useState([]);
  const handleTaskAdd = (task) => setTasks(prev => [{ ...task, id: Date.now().toString(), status: "pending" }, ...prev]);
  const handleTaskUpdate = (updated) => setTasks(prev => prev.map(t => t.id === updated.id ? updated : t));
  const handleTaskDelete = (id) => setTasks(prev => prev.filter(t => t.id !== id));

  return (
    <>
      <StudentDashboardLayout
        activeSection={activeSection}
        setActiveSection={(section) => {
          console.log('Dashboard received activeSection update:', section);
          if (section === 'signout') {
            logout().then(() => {
              localStorage.removeItem("user");
              localStorage.removeItem("token");
              window.location.href = "/login";
            }).catch(err => {
              console.error('Logout error:', err);
              window.location.href = "/login";
            });
            return;
          }
          setActiveSection(section);
        }}
      >
        {activeSection === "dashboard" && (
          <div className="space-y-8">
            {/* Welcome Section */}
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
              <div>
                <h1 className="text-3xl font-heading font-bold text-gray-900">
                  Welcome back, <span className="text-transparent bg-clip-text bg-gradient-to-r from-brand-navy to-brand-cyan">{userData?.name || 'Student'}</span> 👋
                </h1>
                <p className="text-gray-600 mt-1">You're making great progress! Keep it up.</p>
              </div>
              <div className="flex gap-3">
                <Link to="/courses" className="btn-secondary flex items-center gap-2">
                  <BookOpen size={18} />
                  Browse Courses
                </Link>
                {recentCourse && (
                  <button
                    onClick={() => window.location.href = `/course.html?id=${recentCourse.id}`}
                    className="btn-primary flex items-center gap-2 shadow-lg hover:shadow-cyan-500/20"
                  >
                    <PlayCircle size={18} />
                    Resume Learning
                  </button>
                )}
              </div>
            </div>

            {/* Stats Cards */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              <StatCard
                icon={<BookOpen className="text-white" size={24} />}
                label="Courses in Progress"
                value={safeEnrolledCourses.filter(c => c.progress > 0 && c.progress < 100).length}
                color="bg-brand-navy"
              />
              <StatCard
                icon={<TrendingUp className="text-white" size={24} />}
                label="Overall Progress"
                value={`${overallProgress}%`}
                color="bg-brand-cyan"
              />
              <StatCard
                icon={<Clock className="text-white" size={24} />}
                label="Hours Learned"
                value="12.5"
                color="bg-purple-500"
              />
              <StatCard
                icon={<Award className="text-white" size={24} />}
                label="Certificates"
                value="0"
                color="bg-orange-500"
              />
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
            </div>

            {safeEnrolledCourses.length > 0 ? (
              <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                {safeEnrolledCourses.map((course) => (
                  <div key={course.id} className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden group hover:shadow-md transition-shadow">
                    <div className="h-32 bg-gray-200 relative overflow-hidden">
                      <img
                        src={course.thumbnail || course.thumbnail_url || 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=500'}
                        alt={course.title}
                        className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                      />
                      <div className="absolute inset-0 bg-black/20 group-hover:bg-black/10 transition-colors"></div>
                    </div>
                    <div className="p-5">
                      <h3 className="font-bold text-gray-900 mb-2 line-clamp-1">{course.title}</h3>
                      <div className="flex items-center gap-2 mb-4">
                        <div className="flex-1 bg-gray-100 rounded-full h-1.5">
                          <div className="bg-brand-navy h-1.5 rounded-full" style={{ width: `${course.progress || 0}%` }}></div>
                        </div>
                        <span className="text-xs font-medium text-gray-500">{course.progress || 0}%</span>
                      </div>
                      <a
                        href={`/course.html?id=${course.id}`}
                        onClick={() => { sessionStorage.setItem('fromDashboard', 'true'); }}
                        className="w-full block text-center py-2.5 rounded-xl bg-gray-50 text-gray-900 font-medium text-sm hover:bg-brand-navy hover:text-white transition-all duration-200"
                      >
                        Continue
                      </a>
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <div className="bg-gray-50 rounded-2xl p-8 text-center border border-dashed border-gray-200">
                <div className="mx-auto w-16 h-16 bg-white rounded-full flex items-center justify-center shadow-sm mb-4">
                  <BookOpen size={24} className="text-gray-400" />
                </div>
                <h3 className="text-lg font-medium text-gray-900 mb-1">No courses yet</h3>
                <p className="text-gray-500 max-w-md mx-auto mb-6">Start your journey by enrolling in one of our expert-led courses.</p>
                <Link to="/courses" className="btn-primary inline-flex items-center gap-2">
                  Browse Courses <ArrowRight size={16} />
                </Link>
              </div>
            )}
          </div>
        )}

        {activeSection === "profile" && <Profile user={userData} />}
        {activeSection === "courses" && (
          <div className="container mx-auto py-8">
            <h2 className="text-2xl font-bold mb-6">My Courses</h2>
            {/* Reusing the card grid from dashboard for consistency */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              {safeEnrolledCourses.map((course) => (
                <div key={course.id} className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                  {/* Simplified card for this view */}
                  <div className="p-6">
                    <h3 className="font-bold text-lg mb-2">{course.title}</h3>
                    <a href={`/course.html?id=${course.id}`} className="btn-primary w-full text-center block">Go to Course</a>
                  </div>
                </div>
              ))}
              {safeEnrolledCourses.length === 0 && <p className="text-gray-500">No courses found.</p>}
            </div>
          </div>
        )}

        {activeSection === "todo" && (
          <div className="max-w-3xl mx-auto">
            <h2 className="text-2xl font-bold mb-6">My Tasks</h2>
            <TodoList tasks={tasks} onTaskAdd={handleTaskAdd} onTaskUpdate={handleTaskUpdate} onTaskDelete={handleTaskDelete} />
          </div>
        )}

        {activeSection === "planner" && <PlannerPage user={userData} />}
        {activeSection === "ai-tutor" && <AIDashboard userId={userData?._id} onBack={() => setActiveSection('dashboard')} />}
        {activeSection === "calendar" && <Calendar events={[]} />}
        {activeSection === "certificates" && (
          <div className="max-w-4xl mx-auto py-8">
            <h2 className="text-3xl font-bold mb-6 text-gray-900">My Certificates</h2>
            <div className="space-y-6">
              {safeEnrolledCourses.filter(c => c.progress === 100).length > 0 ? (
                safeEnrolledCourses.filter(c => c.progress === 100).map(course => (
                  <div key={course.id} className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col md:flex-row items-center justify-between gap-6">
                    <div>
                      <h3 className="text-xl font-bold text-gray-900">{course.title}</h3>
                      <p className="text-gray-500">Completed on {course.enrolled_at ? new Date(course.enrolled_at).toLocaleDateString() : 'N/A'}</p>
                    </div>
                    <button className="btn-primary">Download Certificate</button>
                  </div>
                ))
              ) : (
                <div className="text-center py-12 bg-white rounded-2xl border border-dashed border-gray-200">
                  <Award size={48} className="mx-auto text-gray-300 mb-4" />
                  <h3 className="text-lg font-medium text-gray-900">No certificates yet</h3>
                  <p className="text-gray-500">Finish all lessons in a course to earn your certificate.</p>
                </div>
              )}
            </div>

            {/* Template Preview */}
            <div className="mt-12 opacity-50 grayscale hover:grayscale-0 hover:opacity-100 transition-all">
              <p className="text-center text-sm text-gray-400 mb-4">Preview of your future certificate</p>
              <CertificateTemplate
                studentName={userData?.name || "Student Name"}
                courseTitle="Example Digital Excellence"
                date={new Date().toLocaleDateString()}
                certificateId="TT-XXXX-XXXX"
              />
            </div>
          </div>
        )}
      </StudentDashboardLayout >
    </>
  );
};

export default Dashboard;

