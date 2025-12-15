import React, { useEffect, useState } from "react";
import StudentDashboardLayout from "../components/StudentDashboardLayout";
import TodoList from "../components/TodoList";
import Calendar from "../components/Calendar";
import { User } from "../types/api";
import { Course } from "../services/types";
import { Task } from "../types";
import { Section } from "../types/Section";

const Dashboard: React.FC = () => {
  const [user, setUser] = useState<User | null>(null);
  const [courses, setCourses] = useState<Course[]>([]);
  const [loadingUser, setLoadingUser] = useState<boolean>(true);
  const [loadingCourses, setLoadingCourses] = useState<boolean>(false);
  const [error, setError] = useState<string>("");
  const [activeSection, setActiveSection] = useState<Section>('dashboard');
  const [tasks, setTasks] = useState<Task[]>([]); // Placeholder for tasks

  useEffect(() => {
    const fetchUser = async () => {
      setLoadingUser(true);
      setError("");
      const token = localStorage.getItem("token");
      if (!token) {
        setUser(null);
        setLoadingUser(false);
        return;
      }
      try {
        const res = await fetch("http://localhost:5001/api/auth/profile", {
          headers: { "Authorization": `Bearer ${token}` },
        });
        if (!res.ok) {
          localStorage.removeItem("user");
          localStorage.removeItem("token");
          throw new Error("Session expired. Please log in again.");
        }
        const data = await res.json();
        setUser(data);
      } catch (err: any) {
        setUser(null);
        setError(err.message);
      } finally {
        setLoadingUser(false);
      }
    };
    fetchUser();
  }, []);

  useEffect(() => {
    const fetchCourses = async () => {
      if (!user || user.role !== "student") return;
      setLoadingCourses(true);
      setError("");
      const token = localStorage.getItem("token");
      try {
        const res = await fetch("http://localhost:5001/api/courses/enrolled", {
          headers: { "Authorization": `Bearer ${token}` },
        });
        if (!res.ok) {
          const data = await res.json();
          throw new Error(data.message || "Failed to fetch courses");
        }
        const data = await res.json();
        setCourses(data);
      } catch (err: any) {
        setError(err.message);
      } finally {
        setLoadingCourses(false);
      }
    };
    fetchCourses();
  }, [user]);

  // Placeholder handlers for TodoList
  const handleTaskAdd = (task: Omit<Task, "id" | "createdAt">) => setTasks([...tasks, { ...task, id: Date.now().toString(), status: 'pending', createdAt: new Date() } as Task]);
  const handleTaskUpdate = (updatedTask: Task) => setTasks(tasks.map(t => t.id === updatedTask.id ? updatedTask : t));
  const handleTaskDelete = (taskId: string) => setTasks(tasks.filter(t => t.id !== taskId));

  if (loadingUser) {
    return <div className="container mx-auto py-8"><p>Loading your dashboard...</p></div>;
  }
  if (!user) {
    localStorage.removeItem("user");
    localStorage.removeItem("token");
    return <div className="container mx-auto py-8"><div className="bg-red-100 text-red-700 p-4 rounded mb-4">Please log in to view your dashboard.</div>{error && <p className="text-red-600">{error}</p>}</div>;
  }
  if (user.role !== "student") {
    return <div className="container mx-auto py-8"><div className="bg-yellow-100 text-yellow-700 p-4 rounded mb-4">Unauthorized: Only students can view this dashboard.</div></div>;
  }

  return (
    <StudentDashboardLayout activeSection={activeSection} setActiveSection={setActiveSection}>
      {activeSection === "dashboard" && (
        <div className="container mx-auto py-8">
          <div className="bg-gradient-to-r from-blue-500 to-indigo-600 rounded-lg shadow-lg p-8 mb-6 text-white">
            <h1 className="text-4xl font-bold mb-2">Welcome, {user.name}!</h1>
            <p className="mb-2">Email: <span className="font-mono">{user.email}</span></p>
            <p className="mb-2">Role: <span className="capitalize">{user.role}</span></p>
            <p>This is your student dashboard. Here you can view your enrolled courses and progress.</p>
          </div>
          <div className="bg-white rounded shadow p-6">
            <h2 className="text-2xl font-semibold mb-4 text-gray-800">Enrolled Courses</h2>
            {loadingCourses ? (
              <p>Loading courses...</p>
            ) : error ? (
              <p className="text-red-600">{error}</p>
            ) : courses.length === 0 ? (
              <p>You are not enrolled in any courses yet.</p>
            ) : (
              <ul className="list-disc pl-6">
                {courses.map((course) => (
                  <li key={course._id} className="mb-3">
                    <div className="p-4 bg-gray-100 rounded shadow-sm flex flex-col md:flex-row md:items-center md:justify-between">
                      <div>
                        <span className="font-semibold text-lg">{course.title}</span>
                        <span className="block text-gray-600">{course.description}</span>
                      </div>
                    </div>
                  </li>
                ))}
              </ul>
            )}
          </div>
        </div>
      )}
      {activeSection === "profile" && (
        <div className="container mx-auto py-8">
          <h2 className="text-2xl font-bold mb-4">Profile</h2>
          <div className="bg-white rounded shadow p-6">Profile editing coming soon.</div>
        </div>
      )}
      {activeSection === "courses" && (
        <div className="container mx-auto py-8">
          <h2 className="text-2xl font-bold mb-4">My Courses</h2>
          <div className="bg-white rounded shadow p-6">
            {loadingCourses ? (
              <p>Loading courses...</p>
            ) : error ? (
              <p className="text-red-600">{error}</p>
            ) : courses.length === 0 ? (
              <p>You are not enrolled in any courses yet.</p>
            ) : (
              <ul className="list-disc pl-6">
                {courses.map((course) => (
                  <li key={course._id} className="mb-3">
                    <div className="p-4 bg-gray-100 rounded shadow-sm flex flex-col md:flex-row md:items-center md:justify-between">
                      <div>
                        <span className="font-semibold text-lg">{course.title}</span>
                        <span className="block text-gray-600">{course.description}</span>
                      </div>
                    </div>
                  </li>
                ))}
              </ul>
            )}
          </div>
        </div>
      )}
      {activeSection === "todo" && (
        <div className="container mx-auto py-8">
          <TodoList tasks={tasks} onTaskAdd={handleTaskAdd} onTaskUpdate={handleTaskUpdate} onTaskDelete={handleTaskDelete} />
        </div>
      )}
      {activeSection === "planner" && (
        <div className="container mx-auto py-8">
          <h2 className="text-2xl font-bold mb-4">Planner</h2>
          <div className="bg-white rounded shadow p-6">Planner coming soon.</div>
        </div>
      )}
      {activeSection === "calendar" && (
        <div className="container mx-auto py-8">
          <Calendar events={[]} />
        </div>
      )}
      {activeSection === "signout" && (
        <div className="container mx-auto py-8">
          <button className="bg-red-500 text-white px-4 py-2 rounded" onClick={() => { localStorage.clear(); window.location.href = "/login"; }}>Sign Out</button>
        </div>
      )}
    </StudentDashboardLayout>
  );
};

export default Dashboard;