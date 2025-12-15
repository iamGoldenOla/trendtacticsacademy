import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { User } from "../types/api";

interface AdminPageProps {
  user: User | null;
}

const AdminPage: React.FC<AdminPageProps> = ({ user }) => {
  const [showUserModal, setShowUserModal] = useState(false);
  const [users, setUsers] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const navigate = useNavigate();
  // Course Management State
  const [courses, setCourses] = useState([
    { name: "Digital Marketing 101", desc: "Intro to digital marketing concepts" },
    { name: "SEO Fundamentals", desc: "Learn the basics of SEO" },
    { name: "Content Strategy", desc: "Develop effective content strategies" }
  ]);
  const [newCourseName, setNewCourseName] = useState("");
  const [newCourseDesc, setNewCourseDesc] = useState("");
  const [editIdx, setEditIdx] = useState(-1);
  const [editCourseName, setEditCourseName] = useState("");
  const [editCourseDesc, setEditCourseDesc] = useState("");
  // Platform Settings State
  const [platformName, setPlatformName] = useState("Trendtactics Academy");
  const [registrationEnabled, setRegistrationEnabled] = useState(true);

  // Course Management handlers
  const handleAddCourse = () => {
    if (!newCourseName.trim() || !newCourseDesc.trim()) return;
    setCourses([...courses, { name: newCourseName, desc: newCourseDesc }]);
    setNewCourseName("");
    setNewCourseDesc("");
  };
  const handleEditCourse = (idx: number) => {
    setEditIdx(idx);
    setEditCourseName(courses[idx].name);
    setEditCourseDesc(courses[idx].desc);
  };
  const handleSaveCourse = (idx: number) => {
    const updated = [...courses];
    updated[idx] = { name: editCourseName, desc: editCourseDesc };
    setCourses(updated);
    setEditIdx(-1);
    setEditCourseName("");
    setEditCourseDesc("");
  };
  const handleCancelEdit = () => {
    setEditIdx(-1);
    setEditCourseName("");
    setEditCourseDesc("");
  };
  const handleDeleteCourse = (idx: number) => {
    setCourses(courses.filter((_, i) => i !== idx));
  };

  // Platform Settings handlers
  const handleSaveSettings = () => {
    alert(`Settings saved! Platform Name: ${platformName}, Registration: ${registrationEnabled ? "Enabled" : "Disabled"}`);
  };
  const handleViewLogs = () => {
    alert("Viewing platform logs (demo)");
  };

  useEffect(() => {
    // Restrict access to admin only
    if (!user || user.role !== "admin") {
      navigate("/admin-login");
      return;
    }
  }, [navigate, user]);

  useEffect(() => {
    if (showUserModal) {
      setLoading(true);
      setError("");
      // Get token from localStorage
      const token = localStorage.getItem("token");
      fetch("http://localhost:5001/api/auth/users", {
        headers: {
          "Authorization": `Bearer ${token}`,
        },
      })
        .then(async (res) => {
          if (!res.ok) {
            const data = await res.json();
            throw new Error(data.message || "Failed to fetch users");
          }
          return res.json();
        })
        .then((data) => {
          setUsers(data);
          setLoading(false);
        })
        .catch((err) => {
          setError(err.message);
          setLoading(false);
        });
    }
  }, [showUserModal]);

  return (
    <div className="container mx-auto py-8">
      <h1 className="text-3xl font-bold mb-4">Admin Dashboard</h1>
      <p className="mb-6">Welcome to the admin dashboard. Here you can manage users, courses, and platform settings.</p>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div className="bg-white rounded shadow p-6">
          <h2 className="text-xl font-semibold mb-2">User Management</h2>
          <p>View, edit, or remove users.</p>
          <div className="flex items-center gap-2 mt-4">
            <button className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700" onClick={() => setShowUserModal(true)}>Manage Users</button>
          </div>
          {showUserModal && (
            <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-40 z-50">
              <div className="bg-white p-8 rounded shadow-lg w-full max-w-2xl">
                <h3 className="text-xl font-bold mb-4">User Management</h3>
                {loading ? (
                  <p>Loading users...</p>
                ) : error ? (
                  <p className="text-red-600">{error}</p>
                ) : (
                  <div className="overflow-y-auto max-h-80">
                    <table className="min-w-full border">
                      <thead>
                        <tr>
                          <th className="border px-2 py-1">Name</th>
                          <th className="border px-2 py-1">Email</th>
                          <th className="border px-2 py-1">Role</th>
                        </tr>
                      </thead>
                      <tbody>
                        {users.map((user) => (
                          <tr key={user._id}>
                            <td className="border px-2 py-1">{user.name}</td>
                            <td className="border px-2 py-1">{user.email}</td>
                            <td className="border px-2 py-1">{user.role}</td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                )}
                <button className="mt-4 px-4 py-2 bg-gray-600 text-white rounded hover:bg-gray-700" onClick={() => setShowUserModal(false)}>Close</button>
              </div>
            </div>
          )}
        </div>
        <div className="bg-white rounded shadow p-6">
          <h2 className="text-xl font-semibold mb-2">Course Management</h2>
          <p>Create, update, or delete courses.</p>
          <div className="flex gap-2 mb-4">
            <input type="text" placeholder="Course Name" className="border rounded px-2 py-1" value={newCourseName} onChange={e => setNewCourseName(e.target.value)} />
            <input type="text" placeholder="Description" className="border rounded px-2 py-1" value={newCourseDesc} onChange={e => setNewCourseDesc(e.target.value)} />
            <button className="px-3 py-1 bg-green-600 text-white rounded hover:bg-green-700" onClick={handleAddCourse}>Add Course</button>
          </div>
          <div className="overflow-y-auto max-h-60">
            <table className="min-w-full border">
              <thead>
                <tr>
                  <th className="border px-2 py-1">Course Name</th>
                  <th className="border px-2 py-1">Description</th>
                  <th className="border px-2 py-1">Actions</th>
                </tr>
              </thead>
              <tbody>
                {courses.map((course, idx) => (
                  <tr key={idx}>
                    <td className="border px-2 py-1">
                      {editIdx === idx ? (
                        <input type="text" value={editCourseName} onChange={e => setEditCourseName(e.target.value)} className="border rounded px-1" />
                      ) : (
                        course.name
                      )}
                    </td>
                    <td className="border px-2 py-1">
                      {editIdx === idx ? (
                        <input type="text" value={editCourseDesc} onChange={e => setEditCourseDesc(e.target.value)} className="border rounded px-1" />
                      ) : (
                        course.desc
                      )}
                    </td>
                    <td className="border px-2 py-1 flex gap-1">
                      {editIdx === idx ? (
                        <>
                          <button className="px-2 py-1 bg-blue-600 text-white rounded hover:bg-blue-700" onClick={() => handleSaveCourse(idx)}>Save</button>
                          <button className="px-2 py-1 bg-gray-400 text-white rounded hover:bg-gray-500" onClick={handleCancelEdit}>Cancel</button>
                        </>
                      ) : (
                        <>
                          <button className="px-2 py-1 bg-yellow-500 text-white rounded hover:bg-yellow-600" onClick={() => handleEditCourse(idx)}>Edit</button>
                          <button className="px-2 py-1 bg-red-600 text-white rounded hover:bg-red-700" onClick={() => handleDeleteCourse(idx)}>Delete</button>
                        </>
                      )}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
        <div className="bg-white rounded shadow p-6">
          <h2 className="text-xl font-semibold mb-2">Platform Settings</h2>
          <p>Configure platform-wide settings.</p>
          <div className="flex flex-col gap-2 mt-4">
            <label className="flex items-center gap-2">
              <span>Platform Name:</span>
              <input type="text" className="border rounded px-2 py-1" value={platformName} onChange={e => setPlatformName(e.target.value)} />
            </label>
            <label className="flex items-center gap-2">
              <span>Enable Registration:</span>
              <input type="checkbox" checked={registrationEnabled} onChange={e => setRegistrationEnabled(e.target.checked)} />
            </label>
            <button className="px-4 py-2 bg-yellow-500 text-white rounded hover:bg-yellow-600" onClick={handleSaveSettings}>Save Settings</button>
            <button className="px-4 py-2 bg-gray-300 text-gray-700 rounded hover:bg-gray-400" onClick={handleViewLogs}>View Logs</button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default AdminPage; // Only one export default at the end.