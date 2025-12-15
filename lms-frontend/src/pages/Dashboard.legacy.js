"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const react_1 = __importStar(require("react"));
const StudentDashboardLayout_1 = __importDefault(require("../components/StudentDashboardLayout"));
const TodoList_1 = __importDefault(require("../components/TodoList"));
const Calendar_1 = __importDefault(require("../components/Calendar"));
const Dashboard = () => {
    const [user, setUser] = (0, react_1.useState)(null);
    const [courses, setCourses] = (0, react_1.useState)([]);
    const [loadingUser, setLoadingUser] = (0, react_1.useState)(true);
    const [loadingCourses, setLoadingCourses] = (0, react_1.useState)(false);
    const [error, setError] = (0, react_1.useState)("");
    const [activeSection, setActiveSection] = (0, react_1.useState)('dashboard');
    const [tasks, setTasks] = (0, react_1.useState)([]); // Placeholder for tasks
    (0, react_1.useEffect)(() => {
        const fetchUser = () => __awaiter(void 0, void 0, void 0, function* () {
            setLoadingUser(true);
            setError("");
            const token = localStorage.getItem("token");
            if (!token) {
                setUser(null);
                setLoadingUser(false);
                return;
            }
            try {
                const res = yield fetch("http://localhost:5001/api/auth/profile", {
                    headers: { "Authorization": `Bearer ${token}` },
                });
                if (!res.ok) {
                    localStorage.removeItem("user");
                    localStorage.removeItem("token");
                    throw new Error("Session expired. Please log in again.");
                }
                const data = yield res.json();
                setUser(data);
            }
            catch (err) {
                setUser(null);
                setError(err.message);
            }
            finally {
                setLoadingUser(false);
            }
        });
        fetchUser();
    }, []);
    (0, react_1.useEffect)(() => {
        const fetchCourses = () => __awaiter(void 0, void 0, void 0, function* () {
            if (!user || user.role !== "student")
                return;
            setLoadingCourses(true);
            setError("");
            const token = localStorage.getItem("token");
            try {
                const res = yield fetch("http://localhost:5001/api/courses/enrolled", {
                    headers: { "Authorization": `Bearer ${token}` },
                });
                if (!res.ok) {
                    const data = yield res.json();
                    throw new Error(data.message || "Failed to fetch courses");
                }
                const data = yield res.json();
                setCourses(data);
            }
            catch (err) {
                setError(err.message);
            }
            finally {
                setLoadingCourses(false);
            }
        });
        fetchCourses();
    }, [user]);
    // Placeholder handlers for TodoList
    const handleTaskAdd = (task) => setTasks([...tasks, Object.assign(Object.assign({}, task), { id: Date.now().toString(), status: 'pending', createdAt: new Date() })]);
    const handleTaskUpdate = (updatedTask) => setTasks(tasks.map(t => t.id === updatedTask.id ? updatedTask : t));
    const handleTaskDelete = (taskId) => setTasks(tasks.filter(t => t.id !== taskId));
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
    return (<StudentDashboardLayout_1.default activeSection={activeSection} setActiveSection={setActiveSection}>
      {activeSection === "dashboard" && (<div className="container mx-auto py-8">
          <div className="bg-gradient-to-r from-blue-500 to-indigo-600 rounded-lg shadow-lg p-8 mb-6 text-white">
            <h1 className="text-4xl font-bold mb-2">Welcome, {user.name}!</h1>
            <p className="mb-2">Email: <span className="font-mono">{user.email}</span></p>
            <p className="mb-2">Role: <span className="capitalize">{user.role}</span></p>
            <p>This is your student dashboard. Here you can view your enrolled courses and progress.</p>
          </div>
          <div className="bg-white rounded shadow p-6">
            <h2 className="text-2xl font-semibold mb-4 text-gray-800">Enrolled Courses</h2>
            {loadingCourses ? (<p>Loading courses...</p>) : error ? (<p className="text-red-600">{error}</p>) : courses.length === 0 ? (<p>You are not enrolled in any courses yet.</p>) : (<ul className="list-disc pl-6">
                {courses.map((course) => (<li key={course._id} className="mb-3">
                    <div className="p-4 bg-gray-100 rounded shadow-sm flex flex-col md:flex-row md:items-center md:justify-between">
                      <div>
                        <span className="font-semibold text-lg">{course.title}</span>
                        <span className="block text-gray-600">{course.description}</span>
                      </div>
                    </div>
                  </li>))}
              </ul>)}
          </div>
        </div>)}
      {activeSection === "profile" && (<div className="container mx-auto py-8">
          <h2 className="text-2xl font-bold mb-4">Profile</h2>
          <div className="bg-white rounded shadow p-6">Profile editing coming soon.</div>
        </div>)}
      {activeSection === "courses" && (<div className="container mx-auto py-8">
          <h2 className="text-2xl font-bold mb-4">My Courses</h2>
          <div className="bg-white rounded shadow p-6">
            {loadingCourses ? (<p>Loading courses...</p>) : error ? (<p className="text-red-600">{error}</p>) : courses.length === 0 ? (<p>You are not enrolled in any courses yet.</p>) : (<ul className="list-disc pl-6">
                {courses.map((course) => (<li key={course._id} className="mb-3">
                    <div className="p-4 bg-gray-100 rounded shadow-sm flex flex-col md:flex-row md:items-center md:justify-between">
                      <div>
                        <span className="font-semibold text-lg">{course.title}</span>
                        <span className="block text-gray-600">{course.description}</span>
                      </div>
                    </div>
                  </li>))}
              </ul>)}
          </div>
        </div>)}
      {activeSection === "todo" && (<div className="container mx-auto py-8">
          <TodoList_1.default tasks={tasks} onTaskAdd={handleTaskAdd} onTaskUpdate={handleTaskUpdate} onTaskDelete={handleTaskDelete}/>
        </div>)}
      {activeSection === "planner" && (<div className="container mx-auto py-8">
          <h2 className="text-2xl font-bold mb-4">Planner</h2>
          <div className="bg-white rounded shadow p-6">Planner coming soon.</div>
        </div>)}
      {activeSection === "calendar" && (<div className="container mx-auto py-8">
          <Calendar_1.default events={[]}/>
        </div>)}
      {activeSection === "signout" && (<div className="container mx-auto py-8">
          <button className="bg-red-500 text-white px-4 py-2 rounded" onClick={() => { localStorage.clear(); window.location.href = "/login"; }}>Sign Out</button>
        </div>)}
    </StudentDashboardLayout_1.default>);
};
exports.default = Dashboard;
