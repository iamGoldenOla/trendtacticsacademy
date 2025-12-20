import React, { useState, useEffect } from "react";
import StudentDashboardLayout from "../components/StudentDashboardLayout";
import Profile from "./Profile";
import { Link, useNavigate } from 'react-router-dom';
// Removed digitalMarketingCourses import to use real course data
import { isAuthenticated } from '../services/authService';
import TodoList from "../components/TodoList";
import PlannerPage from "./PlannerPage";
import Calendar from "../components/Calendar";

const Dashboard = () => {
  const navigate = useNavigate();
  const [userName, setUserName] = useState("");
  const [activeSection, setActiveSection] = useState("dashboard");
  // Use real user and course data
  const user = { name: userName || "John Doe" };
  // TODO: Replace with real enrolled courses data
  const enrolledCourses = [];
  const assignments = [
    { title: "UI Design", status: "Upcoming" },
    { title: "Node.js Project", status: "In Progress" },
    { title: "React Quiz", status: "Completed" }
  ];
  const recentActivity = [
    { type: "lesson_completed", detail: "Completed React Hooks", time: "2 hours ago" },
    { type: "assignment_submitted", detail: "Submitted Node.js Project", time: "1 day ago" },
    { type: "course_enrolled", detail: "Enrolled in UI Design", time: "3 days ago" }
  ];

  useEffect(() => {
    if (!isAuthenticated()) {
      navigate('/login', { replace: true });
    }
  }, [navigate]);

  useEffect(() => {
    const userStr = localStorage.getItem("user");
    if (userStr) {
      try {
        const user = JSON.parse(userStr);
        setUserName(user.name || "");
      } catch {
        setUserName("");
      }
    }
  }, []);

  // Calculate overall progress
  const overallProgress = enrolledCourses.length ? Math.round(enrolledCourses.reduce((acc, c) => acc + c.progress, 0) / enrolledCourses.length) : 0;

  // TodoList state and handlers
  const [tasks, setTasks] = useState([]);

  const handleTaskAdd = (task) => {
    setTasks(prev => [
      { ...task, id: Date.now().toString(), createdAt: new Date(), status: task.status || "pending" },
      ...prev
    ]);
  };

  const handleTaskUpdate = (updatedTask) => {
    setTasks(prev => prev.map(task => task.id === updatedTask.id ? updatedTask : task));
  };

  const handleTaskDelete = (taskId) => {
    setTasks(prev => prev.filter(task => task.id !== taskId));
  };

  return (
    <>
      <StudentDashboardLayout activeSection={activeSection} setActiveSection={setActiveSection}>
        {activeSection === "dashboard" && (
          <>
            {/* End Certificates Section */}
            {/* Bento Grid Layout */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6 bento-grid">
              {/* Welcome + Continue Learning (Parallax Card) */}
              <div className="col-span-1 md:col-span-2 row-span-1 relative overflow-hidden rounded-2xl shadow-xl bg-white bento-card parallax-card flex flex-col justify-between p-8" style={{minHeight:'220px'}}>
                <div className="z-10">
                  <h1 className="text-3xl font-bold mb-1">Welcome back, {user.name}!</h1>
                  <p className="text-gray-600 mb-4">Continue your learning journey and track your progress.</p>
                  {enrolledCourses.length > 0 ? (
                    <div className="flex items-center gap-4">
                      <div>
                        <div className="font-semibold">{enrolledCourses[0].title}</div>
                        <div className="text-sm text-gray-500">Next lesson: {enrolledCourses[0].nextLesson}</div>
                      </div>
                      <Link to={`/course/${enrolledCourses[0].id}/lesson/l1`} className="btn-primary" state={{ fromDashboard: true }} onClick={() => { sessionStorage.setItem('fromDashboard', 'true'); }}>Resume</Link>
                    </div>
                  ) : <div>No courses to resume.</div>}
                </div>
                <div className="absolute right-0 bottom-0 w-40 h-40 bg-gradient-to-tr from-blue-200 to-purple-200 opacity-40 rounded-full blur-2xl z-0"></div>
              </div>
  
              {/* Progress Bar */}
              <div className="col-span-1 row-span-1 rounded-2xl shadow-xl bg-white bento-card flex flex-col justify-center items-center p-6">
                <h2 className="text-lg font-semibold mb-2">Overall Progress</h2>
                <div className="w-full bg-gray-200 rounded-full h-3 mb-2">
                  <div className="bg-brand-cyan h-3 rounded-full transition-all duration-300" style={{ width: `${overallProgress}%` }}></div>
                </div>
                <div className="text-right text-sm text-gray-600">{overallProgress}% complete</div>
              </div>
  
              {/* Your Courses */}
              <div className="col-span-1 md:col-span-1 row-span-1 rounded-2xl shadow-xl bg-white bento-card flex flex-col p-6">
                <h2 className="text-lg font-semibold mb-2">Your Courses</h2>
                <div className="flex flex-col gap-3">
                  {enrolledCourses.map(course => (
                    <div key={course.id} className="bg-blue-50 rounded-lg p-3 flex flex-col shadow-sm">
                      <div className="font-semibold mb-1">{course.title}</div>
                      <div className="text-xs text-gray-500 mb-2">Progress: {course.progress}%</div>
                      {/* Only show the working Go to Course link */}
                      <Link to={`/course/${course.id}/lesson/${course.id === 'dm-2' ? 'l2' : 'l1'}`} className="btn-primary w-full text-center" state={{ fromDashboard: true }} onClick={() => { sessionStorage.setItem('fromDashboard', 'true'); }}>Go to Course</Link>
                    </div>
                  ))}
                </div>
              </div>
  
              {/* Upcoming Event Card */}
              <div className="col-span-1 md:col-span-1 row-span-1 rounded-2xl shadow-xl bg-yellow-50 bento-card flex flex-col p-6">
                <h2 className="text-lg font-semibold mb-2 text-yellow-700">Upcoming Events</h2>
                <div className="flex flex-col gap-2">
                  <div className="font-semibold">Webinar: Career in Tech</div>
                  <div className="text-sm text-gray-600 mb-2">August 20, 2025 &middot; 4:00 PM</div>
                  <div className="font-semibold">Digital marketing for the 4th Generation</div>
                  <div className="text-sm text-gray-600 mb-2">November 15, 2025</div>
                  <div className="font-semibold">Through the eyes of Ai</div>
                  <div className="text-sm text-gray-600 mb-2">September 18, 2025</div>
                  <div className="font-semibold">Vibe Coding</div>
                  <div className="text-sm text-gray-600">October 29, 2025</div>
                </div>
              </div>
  
              {/* Motivation Video - Assignment Card Shape, full width */}
              <div className="col-span-1 md:col-span-2 row-span-1">
                <div className="rounded-2xl shadow-2xl bg-gradient-to-br from-pink-100 via-white to-blue-100 bento-card p-8 flex flex-col justify-between min-h-[220px] md:min-h-[260px]">
                  <h2 className="text-2xl font-bold mb-2 text-brand-cyan drop-shadow">Motivation of the Week</h2>
                  <p className="mb-4 text-gray-700 text-base font-medium">Kickstart your week with a dose of inspiration! Watch this motivational video to boost your learning journey.</p>
                  <div className="w-full flex-1 flex items-center justify-center">
                    <iframe width="100%" height="100%" style={{aspectRatio:'16/9', borderRadius:'0.75rem', minHeight:'140px', maxHeight:'220px', boxShadow:'0 8px 32px rgba(80,80,180,0.10)'}} src="https://www.youtube.com/embed/ZXsQAXx_ao0" title="Motivational Video" frameBorder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowFullScreen></iframe>
                  </div>
                </div>
              </div>
              {/* Assignments */}
              <div className="col-span-1 md:col-span-2 row-span-1 rounded-2xl shadow-xl bg-white bento-card flex flex-col p-6">
                <h2 className="text-lg font-semibold mb-2">Assignments</h2>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                  {assignments.map((a, i) => (
                    <div key={i} className="bg-purple-50 rounded-lg shadow p-4">
                      <div className="font-semibold">{a.title}</div>
                      <div className={`text-xs mt-2 px-2 py-1 rounded-full ${a.status === 'Upcoming' ? 'bg-yellow-100 text-yellow-800' : a.status === 'In Progress' ? 'bg-blue-100 text-blue-800' : 'bg-green-100 text-green-800'}`}>{a.status}</div>
                    </div>
                  ))}
                </div>
              </div>
              {/* Community Card */}
              <div className="col-span-1 md:col-span-1 row-span-1 rounded-2xl shadow-xl bg-pink-50 bento-card flex flex-col p-6">
                <h2 className="text-lg font-semibold mb-2 text-pink-700">Community</h2>
                <div className="flex flex-col gap-2">
                  <div className="font-semibold">Join the Conversation!</div>
                  <div className="text-sm text-gray-600">Connect with peers, ask questions, and share your progress in our student community forum.</div>
                  <a href="#" className="btn-primary mt-2 w-max">Go to Forum</a>
                </div>
              </div>
            </div> {/* End of bento grid */}
          </>
        )}
        {activeSection === "profile" && (
          <Profile user={user} />
        )}
        {activeSection === "courses" && (
          <div className="container mx-auto py-8">
            <h2 className="text-2xl font-bold mb-4">My Courses</h2>
            <div className="bg-white rounded shadow p-6">
              {enrolledCourses.length === 0 ? (
                <p>You are not enrolled in any courses yet.</p>
              ) : (
                <ul className="list-disc pl-6">
                  {enrolledCourses.map((course) => (
                    <li key={course.id} className="mb-3">
                      <div className="p-4 bg-gradient-to-br from-blue-900 via-cyan-700 to-cyan-400 rounded-2xl shadow-2xl flex flex-col md:flex-row md:items-center md:justify-between transform hover:scale-105 transition-transform duration-300 border-4 border-cyan-200" style={{boxShadow:'0 8px 32px rgba(0,40,120,0.18), 0 1.5px 8px rgba(0,255,255,0.08)'}}>
                        <div>
                          <span className="font-semibold text-lg text-white drop-shadow">{course.title}</span>
                          <span className="block text-cyan-100">Progress: {course.progress}%</span>
                          <span className="block text-cyan-100">Next lesson: {course.nextLesson}</span>
                        </div>
                        <Link to={`/course/${course.id}/lesson/${course.id === 'dm-2' ? 'l2' : 'l1'}`} className="btn-primary mt-2 md:mt-0 shadow-lg" state={{ fromDashboard: true }} onClick={() => { sessionStorage.setItem('fromDashboard', 'true'); }}>Go to Course</Link>
                      </div>
                    </li>
                  ))}
                </ul>
              )}
            </div>
          </div>
        )}
        {activeSection === "todo" && (
          <div className="p-6 min-h-screen bg-gradient-to-br from-blue-50 via-white to-purple-100">
            <TodoList
              tasks={tasks}
              onTaskAdd={handleTaskAdd}
              onTaskUpdate={handleTaskUpdate}
              onTaskDelete={handleTaskDelete}
            />
          </div>
        )}
        {activeSection === "planner" && (
          <PlannerPage user={user} />
        )}
        {activeSection === "calendar" && (
          <Calendar events={[]} />
        )}
      </StudentDashboardLayout>
    </>
  );
};

export default Dashboard;

