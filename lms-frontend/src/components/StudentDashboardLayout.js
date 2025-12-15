import React from "react";
import { Link } from 'react-router-dom';

const sidebarItems = [
    { id: 'dashboard', label: 'Dashboard', icon: '🏠' },
    { id: 'profile', label: 'Profile', icon: '👤' },
    { id: 'courses', label: 'My Courses', icon: '📚' },
    { id: 'todo', label: 'To-Do List', icon: '✅' },
    { id: 'planner', label: 'Planner', icon: '📅' },
    { id: 'calendar', label: 'Calendar', icon: '🗓️' },
    { id: 'signout', label: 'Sign Out', icon: '🚪' }
];

const StudentDashboardLayout = ({ children, activeSection, setActiveSection }) => {
    return (
        <div className="min-h-screen flex bg-gray-50">
            {/* Sidebar */}
            <aside className="w-64 bg-white shadow-lg flex flex-col py-8 px-4">
                <div className="mb-8 text-2xl font-bold text-indigo-700 text-center">Trendtactics Academy</div>
                <nav className="flex-1">
                    {sidebarItems.map((item, idx) => (
                        <React.Fragment key={item.id}>
                            <button 
                                className={`w-full flex items-center gap-3 px-4 py-3 mb-2 rounded-lg text-left transition-colors font-medium text-gray-700 hover:bg-indigo-50 ${activeSection === item.id ? 'bg-indigo-100 text-indigo-700' : ''}`} 
                                onClick={() => setActiveSection(item.id)}
                            >
                                <span className="text-xl">{item.icon}</span>
                                {item.label}
                            </button>
                            {item.id === 'courses' && (
                                <Link 
                                    to="/certificates" 
                                    className="w-full flex items-center gap-3 px-4 py-3 mb-2 rounded-lg text-left transition-colors font-medium bg-gradient-to-r from-pink-100 to-blue-100 text-blue-700 hover:bg-blue-50 shadow" 
                                    style={{ marginBottom: '12px', marginTop: '-4px' }} 
                                    key="certificates-link"
                                >
                                    <span className="text-xl">🎓</span>
                                    Certificates
                                </Link>
                            )}
                        </React.Fragment>
                    ))}
                </nav>
                <div className="mt-auto text-xs text-gray-400 text-center">&copy; {new Date().getFullYear()} Trendtactics Academy</div>
            </aside>
            {/* Main Content */}
            <main className="flex-1 p-8 overflow-y-auto">
                {children}
            </main>
        </div>
    );
};

export default StudentDashboardLayout;