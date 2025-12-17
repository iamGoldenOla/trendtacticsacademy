import React, { useState, useEffect } from "react";

const AnalyticsDashboard = () => {
    const [userStats, setUserStats] = useState({
        totalEnrollments: 0,
        completedCourses: 0,
        inProgressCourses: 0,
        avgCourseProgress: 0,
        totalLearningTime: 0,
        completionRate: 0
    });
    const [loading, setLoading] = useState(true);

    // Simulate fetching user analytics data
    useEffect(() => {
        const fetchUserAnalytics = async () => {
            try {
                // Simulate API call delay
                await new Promise(resolve => setTimeout(resolve, 800));
                
                // Mock data
                setUserStats({
                    totalEnrollments: 5,
                    completedCourses: 2,
                    inProgressCourses: 3,
                    avgCourseProgress: 65,
                    totalLearningTime: 42,
                    completionRate: 40
                });
            } catch (error) {
                console.error("Error fetching user analytics:", error);
            } finally {
                setLoading(false);
            }
        };

        fetchUserAnalytics();
    }, []);

    if (loading) {
        return (
            <div className="min-h-screen bg-gray-50 flex items-center justify-center">
                <div className="text-center">
                    <div className="animate-spin rounded-full h-16 w-16 border-t-2 border-b-2 border-brand-cyan mx-auto"></div>
                    <p className="mt-4 text-gray-600">Loading analytics...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="min-h-screen bg-gray-50">
            {/* Hero Section */}
            <section className="bg-brand-navy text-white py-16">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="text-center">
                        <h1 className="text-4xl md:text-5xl font-heading font-bold mb-6">
                            Learning Analytics
                        </h1>
                        <p className="text-xl text-gray-200 max-w-2xl mx-auto">
                            Track your progress and learning achievements
                        </p>
                    </div>
                </div>
            </section>

            <section className="py-12">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    {/* Stats Cards */}
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-12">
                        <div className="stats-card bg-white rounded-lg shadow-md p-6">
                            <div className="flex items-center">
                                <div className="p-3 rounded-full bg-blue-100 text-blue-600">
                                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                                    </svg>
                                </div>
                                <div className="ml-4">
                                    <p className="text-sm font-medium text-gray-600">Enrolled Courses</p>
                                    <p className="text-2xl font-bold text-gray-900">{userStats.totalEnrollments}</p>
                                </div>
                            </div>
                        </div>

                        <div className="stats-card bg-white rounded-lg shadow-md p-6">
                            <div className="flex items-center">
                                <div className="p-3 rounded-full bg-green-100 text-green-600">
                                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                </div>
                                <div className="ml-4">
                                    <p className="text-sm font-medium text-gray-600">Completed Courses</p>
                                    <p className="text-2xl font-bold text-gray-900">{userStats.completedCourses}</p>
                                </div>
                            </div>
                        </div>

                        <div className="stats-card bg-white rounded-lg shadow-md p-6">
                            <div className="flex items-center">
                                <div className="p-3 rounded-full bg-purple-100 text-purple-600">
                                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                </div>
                                <div className="ml-4">
                                    <p className="text-sm font-medium text-gray-600">Learning Hours</p>
                                    <p className="text-2xl font-bold text-gray-900">{userStats.totalLearningTime}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    {/* Progress Section */}
                    <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-12">
                        {/* Overall Progress */}
                        <div className="bg-white rounded-lg shadow-md p-6">
                            <h3 className="text-xl font-heading font-semibold text-gray-900 mb-6">
                                Overall Progress
                            </h3>
                            <div className="space-y-6">
                                <div>
                                    <div className="flex justify-between mb-2">
                                        <span className="text-sm font-medium text-gray-700">Course Completion</span>
                                        <span className="text-sm font-medium text-gray-700">{userStats.completionRate}%</span>
                                    </div>
                                    <div className="w-full bg-gray-200 rounded-full h-2.5">
                                        <div 
                                            className="bg-brand-cyan h-2.5 rounded-full" 
                                            style={{ width: `${userStats.completionRate}%` }}
                                        ></div>
                                    </div>
                                </div>

                                <div>
                                    <div className="flex justify-between mb-2">
                                        <span className="text-sm font-medium text-gray-700">Average Progress</span>
                                        <span className="text-sm font-medium text-gray-700">{userStats.avgCourseProgress}%</span>
                                    </div>
                                    <div className="w-full bg-gray-200 rounded-full h-2.5">
                                        <div 
                                            className="bg-green-500 h-2.5 rounded-full" 
                                            style={{ width: `${userStats.avgCourseProgress}%` }}
                                        ></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        {/* Course Status */}
                        <div className="bg-white rounded-lg shadow-md p-6">
                            <h3 className="text-xl font-heading font-semibold text-gray-900 mb-6">
                                Course Status
                            </h3>
                            <div className="space-y-4">
                                <div className="flex items-center justify-between p-4 bg-green-50 rounded-lg">
                                    <div className="flex items-center">
                                        <div className="p-2 rounded-full bg-green-100 text-green-600">
                                            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                            </svg>
                                        </div>
                                        <div className="ml-3">
                                            <p className="text-sm font-medium text-gray-900">Completed Courses</p>
                                        </div>
                                    </div>
                                    <span className="text-lg font-bold text-green-600">{userStats.completedCourses}</span>
                                </div>

                                <div className="flex items-center justify-between p-4 bg-blue-50 rounded-lg">
                                    <div className="flex items-center">
                                        <div className="p-2 rounded-full bg-blue-100 text-blue-600">
                                            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                            </svg>
                                        </div>
                                        <div className="ml-3">
                                            <p className="text-sm font-medium text-gray-900">In Progress</p>
                                        </div>
                                    </div>
                                    <span className="text-lg font-bold text-blue-600">{userStats.inProgressCourses}</span>
                                </div>

                                <div className="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
                                    <div className="flex items-center">
                                        <div className="p-2 rounded-full bg-gray-100 text-gray-600">
                                            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
                                            </svg>
                                        </div>
                                        <div className="ml-3">
                                            <p className="text-sm font-medium text-gray-900">Not Started</p>
                                        </div>
                                    </div>
                                    <span className="text-lg font-bold text-gray-600">{userStats.totalEnrollments - userStats.completedCourses - userStats.inProgressCourses}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    {/* Achievements */}
                    <div className="bg-white rounded-lg shadow-md p-6">
                        <h3 className="text-xl font-heading font-semibold text-gray-900 mb-6">
                            Recent Achievements
                        </h3>
                        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div className="text-center p-6 border border-gray-200 rounded-lg">
                                <div className="mx-auto w-16 h-16 bg-yellow-100 rounded-full flex items-center justify-center mb-4">
                                    <svg className="w-8 h-8 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                </div>
                                <h4 className="text-lg font-medium text-gray-900 mb-2">Quick Learner</h4>
                                <p className="text-sm text-gray-600">Completed your first course</p>
                            </div>

                            <div className="text-center p-6 border border-gray-200 rounded-lg">
                                <div className="mx-auto w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mb-4">
                                    <svg className="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                </div>
                                <h4 className="text-lg font-medium text-gray-900 mb-2">Dedicated Student</h4>
                                <p className="text-sm text-gray-600">10+ hours of learning</p>
                            </div>

                            <div className="text-center p-6 border border-gray-200 rounded-lg">
                                <div className="mx-auto w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mb-4">
                                    <svg className="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                                    </svg>
                                </div>
                                <h4 className="text-lg font-medium text-gray-900 mb-2">Consistent Progress</h4>
                                <p className="text-sm text-gray-600">3 courses in progress</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    );
};

export default AnalyticsDashboard;