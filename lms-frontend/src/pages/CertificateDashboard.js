import React, { useState, useEffect } from "react";
// Removed mock data import to prevent using invalid course IDs
// import { digitalMarketingCourses } from "../data/digitalMarketingCourses";
import { useNavigate } from "react-router-dom";
import StudentDashboardLayout from "../components/StudentDashboardLayout";
import CertificateTemplate from "../components/CertificateTemplate";

const CertificateDashboard = () => {
    const [progress, setProgress] = useState([]);
    const [activeSection, setActiveSection] = useState("certificates");
    const navigate = useNavigate();

    useEffect(() => {
        // Simulate fetching progress data for enrolled courses
        // In real app, replace with API call
        // Using empty array instead of mock data
        const enrolledCourses = [];
        const progressData = enrolledCourses.map(course => {
            // Remove score property since it's not present in course data
            const totalLessons = course.lessons ? course.lessons.length : 0;
            const completedLessons = course.lessons ? course.lessons.filter((l) => l.isCompleted).length : 0;
            const isCompleted = completedLessons === totalLessons && totalLessons > 0;
            return {
                id: course.id,
                title: course.title,
                totalLessons,
                completedLessons,
                isCompleted,
                // score: course.bestScore || 0, // removed
            };
        });
        setProgress(progressData);
    }, []);

    const handleViewCertificate = (courseId) => {
        // Navigate to certificate page (to be implemented)
        navigate(`/certificate/${courseId}`);
    };

    // Back arrow handler
    const handleBack = () => {
        setActiveSection("dashboard");
        navigate("/dashboard");
    };

    return (
        <StudentDashboardLayout activeSection={activeSection} setActiveSection={setActiveSection}>
            <button onClick={handleBack} className="mb-4 flex items-center text-indigo-600 hover:text-indigo-900 font-semibold">
                <span style={{ fontSize: '1.5rem', marginRight: '0.5rem' }}>&larr;</span> Back to Dashboard
            </button>
            <div className="max-w-3xl mx-auto mt-2 p-6 bg-white rounded-2xl shadow-2xl" style={{ boxShadow: "0 8px 32px 0 rgba(31, 38, 135, 0.37)", background: "linear-gradient(135deg, #f8fafc 0%, #e0e7ef 100%)" }}>
                <h2 className="text-3xl font-bold mb-6 text-center">Certificate Dashboard</h2>
                <p className="mb-8 text-center text-gray-600">Track your course progress and see your results. Certificates are only available after completing all lessons in a course.</p>
                <div className="space-y-6">
                    {progress.map(course => (
                        <div key={course.id} className="p-6 rounded-xl bg-white shadow-lg flex flex-col md:flex-row md:items-center justify-between border border-gray-200" style={{ boxShadow: "0 4px 16px 0 rgba(31, 38, 135, 0.17)", background: "linear-gradient(135deg, #f0f4fa 0%, #e9eef6 100%)" }}>
                            <div>
                                <div className="text-xl font-semibold mb-2">{course.title}</div>
                                {/* Remove Score display since not present */}
                                <div className="text-gray-700 mb-1">Progress: {course.completedLessons} / {course.totalLessons} lessons</div>
                                <div className="text-gray-700 mb-1">Status: {course.isCompleted ? <span className="text-green-600 font-semibold">Completed</span> : <span className="text-yellow-600 font-bold">In Progress</span>}</div>
                            </div>
                            <div className="mt-4 md:mt-0">
                                {course.isCompleted ? (
                                    <button className="px-6 py-2 rounded-lg bg-gradient-to-r from-green-400 to-blue-500 text-white font-bold shadow-md hover:scale-105 transition-transform" onClick={() => handleViewCertificate(course.id)}>
                                        View Certificate
                                    </button>
                                ) : (
                                    <span className="px-6 py-2 rounded-lg bg-gray-200 text-gray-500 font-semibold">Not Available</span>
                                )}
                            </div>
                        </div>
                    ))}
                </div>
                {/* Certificate Board Section */}
                <div className="certificate-board mt-8">
                    <CertificateTemplate studentName={"Student Name"} courseTitle={"Course Title"} date={new Date().toLocaleDateString()} certificateId={"CERT-123456"}/>
                </div>
            </div>
        </StudentDashboardLayout>
    );
};

export default CertificateDashboard;