import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";

const AdminDashboard = () => {
    const [stats, setStats] = useState({
        totalUsers: 0,
        totalCourses: 0,
        totalEnrollments: 0,
        totalRevenue: 0
    });
    const [analytics, setAnalytics] = useState({
        userGrowth: [],
        courseEnrollments: [],
        revenue: []
    });
    const [loading, setLoading] = useState(true);

    // Simulate fetching admin data
    useEffect(() => {
        const fetchAdminData = async () => {
            try {
                // Simulate API call delay
                await new Promise(resolve => setTimeout(resolve, 1000));
                
                // Mock data
                setStats({
                    totalUsers: 1247,
                    totalCourses: 32,
                    totalEnrollments: 8934,
                    totalRevenue: 45670
                });
                
                setAnalytics({
                    userGrowth: [
                        { month: 'Jan', users: 120 },
                        { month: 'Feb', users: 180 },
                        { month: 'Mar', users: 240 },
                        { month: 'Apr', users: 310 },
                        { month: 'May', users: 420 },
                        { month: 'Jun', users: 560 }
                    ],
                    courseEnrollments: [
                        { course: 'Web Dev', enrollments: 420 },
                        { course: 'Digital Marketing', enrollments: 380 },
                        { course: 'Data Science', enrollments: 310 },
                        { course: 'UI/UX Design', enrollments: 270 },
                        { course: 'Mobile Apps', enrollments: 220 }
                    ],
                    revenue: [
                        { month: 'Jan', revenue: 4200 },
                        { month: 'Feb', revenue: 5800 },
                        { month: 'Mar', revenue: 7400 },
                        { month: 'Apr', revenue: 9100 },
                        { month: 'May', revenue: 12200 },
                        { month: 'Jun', revenue: 15600 }
                    ]
                });
            } catch (error) {
                console.error("Error fetching admin data:", error);
            } finally {
                setLoading(false);
            }
        };

        fetchAdminData();
    }, []);

    if (loading) {
        return (
            <div className="min-h-screen bg-gray-50 flex items-center justify-center">
                <div className="text-center">
                    <div className="animate-spin rounded-full h-16 w-16 border-t-2 border-b-2 border-brand-cyan mx-auto"></div>
                    <p className="mt-4 text-gray-600">Loading dashboard...</p>
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
                            Admin Dashboard
                        </h1>
                        <p className="text-xl text-gray-200 max-w-2xl mx-auto">
                            Manage your academy and view analytics
                        </p>
                    </div>
                </div>
            </section>

            <section className="py-12">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    {/* Stats Cards */}
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-12">
                        <div className="stats-card bg-white rounded-lg shadow-md p-6">
                            <div className="flex items-center">
                                <div className="p-3 rounded-full bg-blue-100 text-blue-600">
                                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                                    </svg>
                                </div>
                                <div className="ml-4">
                                    <p className="text-sm font-medium text-gray-600">Total Users</p>
                                    <p className="text-2xl font-bold text-gray-900">{stats.totalUsers.toLocaleString()}</p>
                                </div>
                            </div>
                        </div>

                        <div className="stats-card bg-white rounded-lg shadow-md p-6">
                            <div className="flex items-center">
                                <div className="p-3 rounded-full bg-green-100 text-green-600">
                                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                                    </svg>
                                </div>
                                <div className="ml-4">
                                    <p className="text-sm font-medium text-gray-600">Total Courses</p>
                                    <p className="text-2xl font-bold text-gray-900">{stats.totalCourses}</p>
                                </div>
                            </div>
                        </div>

                        <div className="stats-card bg-white rounded-lg shadow-md p-6">
                            <div className="flex items-center">
                                <div className="p-3 rounded-full bg-purple-100 text-purple-600">
                                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                </div>
                                <div className="ml-4">
                                    <p className="text-sm font-medium text-gray-600">Enrollments</p>
                                    <p className="text-2xl font-bold text-gray-900">{stats.totalEnrollments.toLocaleString()}</p>
                                </div>
                            </div>
                        </div>

                        <div className="stats-card bg-white rounded-lg shadow-md p-6">
                            <div className="flex items-center">
                                <div className="p-3 rounded-full bg-yellow-100 text-yellow-600">
                                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                </div>
                                <div className="ml-4">
                                    <p className="text-sm font-medium text-gray-600">Revenue</p>
                                    <p className="text-2xl font-bold text-gray-900">${stats.totalRevenue.toLocaleString()}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    {/* Charts Section */}
                    <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-12">
                        {/* User Growth Chart */}
                        <div className="bg-white rounded-lg shadow-md p-6">
                            <h3 className="text-xl font-heading font-semibold text-gray-900 mb-6">
                                User Growth
                            </h3>
                            <div className="h-64 flex items-end space-x-2">
                                {analytics.userGrowth.map((data, index) => (
                                    <div key={index} className="flex flex-col items-center flex-1">
                                        <div 
                                            className="w-full bg-brand-cyan rounded-t hover:bg-brand-navy transition-colors"
                                            style={{ height: `${(data.users / 600) * 100}%` }}
                                        ></div>
                                        <span className="text-xs text-gray-600 mt-2">{data.month}</span>
                                    </div>
                                ))}
                            </div>
                        </div>

                        {/* Revenue Chart */}
                        <div className="bg-white rounded-lg shadow-md p-6">
                            <h3 className="text-xl font-heading font-semibold text-gray-900 mb-6">
                                Revenue Trend
                            </h3>
                            <div className="h-64 flex items-end space-x-2">
                                {analytics.revenue.map((data, index) => (
                                    <div key={index} className="flex flex-col items-center flex-1">
                                        <div 
                                            className="w-full bg-green-500 rounded-t hover:bg-green-600 transition-colors"
                                            style={{ height: `${(data.revenue / 16000) * 100}%` }}
                                        ></div>
                                        <span className="text-xs text-gray-600 mt-2">{data.month}</span>
                                    </div>
                                ))}
                            </div>
                        </div>
                    </div>

                    {/* Popular Courses */}
                    <div className="bg-white rounded-lg shadow-md p-6">
                        <h3 className="text-xl font-heading font-semibold text-gray-900 mb-6">
                            Popular Courses
                        </h3>
                        <div className="overflow-x-auto">
                            <table className="min-w-full divide-y divide-gray-200">
                                <thead className="bg-gray-50">
                                    <tr>
                                        <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Course
                                        </th>
                                        <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Enrollments
                                        </th>
                                        <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Actions
                                        </th>
                                    </tr>
                                </thead>
                                <tbody className="bg-white divide-y divide-gray-200">
                                    {analytics.courseEnrollments.map((course, index) => (
                                        <tr key={index}>
                                            <td className="px-6 py-4 whitespace-nowrap">
                                                <div className="text-sm font-medium text-gray-900">{course.course}</div>
                                            </td>
                                            <td className="px-6 py-4 whitespace-nowrap">
                                                <div className="text-sm text-gray-900">{course.enrollments}</div>
                                            </td>
                                            <td className="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                                <Link to={`/course/${index+1}`} className="text-brand-cyan hover:text-brand-navy">
                                                    View
                                                </Link>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>

                    {/* Management Links */}
                    <div className="mt-12 grid grid-cols-1 md:grid-cols-3 gap-6">
                        <Link to="/admin/courses" className="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow">
                            <div className="flex items-center">
                                <div className="p-3 rounded-full bg-blue-100 text-blue-600">
                                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                                    </svg>
                                </div>
                                <div className="ml-4">
                                    <h4 className="text-lg font-medium text-gray-900">Manage Courses</h4>
                                    <p className="text-sm text-gray-500">Add, edit, or remove courses</p>
                                </div>
                            </div>
                        </Link>

                        <Link to="/admin/users" className="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow">
                            <div className="flex items-center">
                                <div className="p-3 rounded-full bg-green-100 text-green-600">
                                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                                    </svg>
                                </div>
                                <div className="ml-4">
                                    <h4 className="text-lg font-medium text-gray-900">Manage Users</h4>
                                    <p className="text-sm text-gray-500">View and manage user accounts</p>
                                </div>
                            </div>
                        </Link>

                        <Link to="/admin/analytics" className="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow">
                            <div className="flex items-center">
                                <div className="p-3 rounded-full bg-purple-100 text-purple-600">
                                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                                    </svg>
                                </div>
                                <div className="ml-4">
                                    <h4 className="text-lg font-medium text-gray-900">View Analytics</h4>
                                    <p className="text-sm text-gray-500">Detailed insights and reports</p>
                                </div>
                            </div>
                        </Link>
                    </div>
                </div>
            </section>
        </div>
    );
};

export default AdminDashboard;