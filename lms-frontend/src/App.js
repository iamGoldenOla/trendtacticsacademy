import React, { useState, useEffect } from "react";
import { Routes, Route, useParams, Navigate, useNavigate } from "react-router-dom";
import Header from "./components/Header";
import Footer from "./components/Footer";
import LoginModal from "./components/LoginModal";
import SignupModal from "./components/SignupModal";
import Home from "./pages/Home";
import About from "./pages/About";
import Courses from "./pages/Courses";
import CourseDetail from "./pages/CourseDetail";
import InteractiveCourseDetail from "./pages/InteractiveCourseDetail";
import Dashboard from "./pages/Dashboard";
import Profile from "./pages/Profile";
import NotFound from "./pages/NotFound";
import LessonViewer from "./components/LessonViewer";
import ModuleQuiz from "./pages/ModuleQuiz";
import Contact from "./pages/Contact";
import MyCourses from "./pages/MyCourses";
import CourseDashboard from "./pages/CourseDashboard";
import PlannerPage from "./pages/PlannerPage";
import Diagnostic from "./pages/Diagnostic";
import SimpleTest from "./pages/SimpleTest";
import NetworkTest from "./pages/NetworkTest";
import { AIDashboard } from "./components/AIDashboard";
import TestAI from "./pages/TestAI";
import ConversationalCourseTest from "./pages/ConversationalCourseTest";
import ConversationalDemo from "./pages/ConversationalDemo";
import SuperIntelligentTrendyDemo from "./demo/SuperIntelligentTrendyDemo";
import FunctionCallingDemo from "./demo/FunctionCallingDemo";
import { digitalMarketingCourses } from "./data/digitalMarketingCourses";
import { login, signup, logout, getCurrentUser } from "./services/authService";
import "./App.css";
import AdminPage from "./pages/AdminPage";
import Login from "./pages/Login";
import AdminLogin from "./pages/AdminLogin";
import CertificateDashboard from "./pages/CertificateDashboard";
import CertificatePreview from "./pages/CertificatePreview";
import NotificationBell from "./components/NotificationBell";
import TrendyAssistant from "./components/TrendyAssistant";
import CourseCreator from "./pages/CourseCreator";

function App() {
    const [user, setUser] = useState(null);
    const [isLoginModalOpen, setIsLoginModalOpen] = useState(false);
    const [isSignupModalOpen, setIsSignupModalOpen] = useState(false);
    const [isLoading, setIsLoading] = useState(true);
    // Move useNavigate inside the App function
    const navigate = useNavigate();

    const handleLogin = () => {
        setIsLoginModalOpen(true);
    };

    const handleSignup = () => {
        setIsSignupModalOpen(true);
    };

    const handleLogout = async () => {
        await logout();
        setUser(null);
        // Clear localStorage to remove any stale user/token
        localStorage.removeItem("user");
        localStorage.removeItem("token");
        // Force reload to clear any stale state
        window.location.href = "/login";
    };

    const handleLoginSubmit = async (email, password) => {
        try {
            const response = await login({ email, password });
            if (!response || !response.user) {
                // Clear localStorage on failed login
                localStorage.removeItem("user");
                localStorage.removeItem("token");
                throw new Error('Invalid response from server');
            }
            setUser(response.user);
            setIsLoginModalOpen(false);
            // Use navigate instead of window.location.href
            if (response.user.role === 'admin') {
                navigate('/admin', { replace: true });
            } else {
                navigate('/dashboard', { replace: true });
            }
            return true;
        } catch (error) {
            // Clear localStorage on error
            localStorage.removeItem("user");
            localStorage.removeItem("token");
            console.error('Login failed:', error.message);
            return false;
        }
    };

    const handleSignupSubmit = async (name, email, password) => {
        try {
            const response = await signup({ name, email, password });
            if (!response || !response.user) {
                // Clear localStorage on failed signup
                localStorage.removeItem("user");
                localStorage.removeItem("token");
                throw new Error('Invalid response from server');
            }
            setUser(response.user);
            setIsSignupModalOpen(false);
            // Use navigate instead of window.location.href
            if (response.user.role === 'admin') {
                navigate('/admin', { replace: true });
            } else {
                navigate('/dashboard', { replace: true });
            }
            return true;
        } catch (error) {
            // Clear localStorage on error
            localStorage.removeItem("user");
            localStorage.removeItem("token");
            console.error('Signup failed:', error.message);
            return false;
        }
    };

    const switchToSignup = () => {
        setIsLoginModalOpen(false);
        setIsSignupModalOpen(true);
    };

    const switchToLogin = () => {
        setIsSignupModalOpen(false);
        setIsLoginModalOpen(true);
    };

    // Check for existing user session on app load
    useEffect(() => {
        const checkAuth = async () => {
            try {
                setIsLoading(true);
                const currentUser = await getCurrentUser();
                setUser(currentUser); // Keep as User | null
                // Redirect admin to /admin if on /dashboard or /
                if (currentUser && currentUser.role === 'admin') {
                    const currentPath = window.location.pathname;
                    if (currentPath === '/dashboard' || currentPath === '/') {
                        navigate('/admin', { replace: true });
                    }
                }
                // Redirect student to /dashboard if on /admin
                if (currentUser && currentUser.role === 'student') {
                    const currentPath = window.location.pathname;
                    if (currentPath === '/admin') {
                        navigate('/dashboard', { replace: true });
                    }
                }
            } catch (error) {
                console.error('Error checking authentication:', error);
            } finally {
                setIsLoading(false);
            }
        };
        checkAuth();
    }, []);

    // Wrapper to use useParams for lesson route
    const LessonViewerWrapper = () => {
        const { id, lessonId } = useParams();
        // TODO: Replace with API call to get course
        const course = digitalMarketingCourses.find(c => c.id === id);
        if (!course) return <div>Course Not Found</div>;
        // Pass lessonId as prop to LessonViewer
        return <LessonViewer key={lessonId} course={course} lessonId={lessonId} />;
    };

    return (
        <div className="App min-h-screen flex flex-col">
            <Header user={user} onLogin={handleLogin} onSignup={handleSignup} onLogout={handleLogout} />
            {user && (
                <div className="absolute top-4 right-8 z-50">
                    <NotificationBell userId={user._id} />
                </div>
            )}
            <main className="flex-grow">
                <Routes>
                    <Route path="/" element={<Home />} />
                    <Route path="/about" element={<About />} />
                    <Route path="/courses" element={<Courses />} />
                    <Route path="/course/:id/*" element={<InteractiveCourseDetail user={user} onLogin={handleLogin} onSignup={handleSignup} />} />
                    <Route path="/course/:id/lesson/:lessonId" element={<LessonViewerWrapper />} />
                    <Route path="/course/:id/module-quiz" element={<ModuleQuiz />} />
                    <Route path="/dashboard" element={<Dashboard />} />
                    <Route path="/profile" element={<Profile user={user} />} />
                    <Route path="/contact" element={<Contact />} />
                    <Route path="/my-courses" element={<MyCourses />} />
                    <Route path="/my-courses/:courseId" element={<CourseDashboard />} />
                    <Route path="/planner" element={<PlannerPage user={user} />} />
                    <Route path="/ai-tutor" element={user ? (<AIDashboard userId={user._id} />) : (<AIDashboard userId="demo-user" />)} />
                    <Route path="/test-ai" element={<TestAI />} />
                    <Route path="/test-planner" element={<div style={{ padding: '20px', textAlign: 'center' }}><h1>Test Planner Route Works!</h1><p>This is a simple test to verify routing is working.</p></div>} />
                    <Route path="/diagnostic" element={<Diagnostic />} />
                    <Route path="/simple-test" element={<SimpleTest />} />
                    <Route path="/network-test" element={<NetworkTest />} />
                    <Route path="/admin" element={user && user.role !== 'admin' ? <Navigate to="/dashboard" replace /> : <AdminPage user={user} />} />
                    <Route path="/admin-login" element={<AdminLogin />} />
                    <Route path="/login" element={<Login />} />
                    <Route path="/certificates" element={<CertificateDashboard />} />
                    <Route path="/certificate-preview" element={<CertificatePreview />} />
                    <Route path="/course-creator" element={<CourseCreator />} />
                    <Route path="/conversational-course-test" element={<ConversationalCourseTest />} />
                    <Route path="/conversational-demo" element={<ConversationalDemo />} />
                    <Route path="/super-intelligent-demo" element={<SuperIntelligentTrendyDemo />} />
                    <Route path="/function-calling-demo" element={<FunctionCallingDemo />} />
                    <Route path="*" element={<NotFound />} />
                </Routes>
            </main>
            <Footer />

            {/* Authentication Modals */}
            <LoginModal isOpen={isLoginModalOpen} onClose={() => setIsLoginModalOpen(false)} onLogin={handleLoginSubmit} onSwitchToSignup={switchToSignup} />
            
            <SignupModal isOpen={isSignupModalOpen} onClose={() => setIsSignupModalOpen(false)} onSignup={handleSignupSubmit} onSwitchToLogin={switchToLogin} />
            
            {/* Trendy AI Assistant */}
            <TrendyAssistant />
        </div>
    );
}

export default App;