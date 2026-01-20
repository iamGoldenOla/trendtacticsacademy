import React, { useState } from "react";
import { Link, useLocation } from 'react-router-dom';
import {
    LayoutDashboard,
    User,
    BookOpen,
    CheckSquare,
    CalendarDays,
    Calendar as CalendarIcon,
    LogOut,
    GraduationCap,
    Menu,
    X
} from 'lucide-react';

const sidebarItems = [
    { id: 'dashboard', label: 'Dashboard', icon: <LayoutDashboard size={20} /> },
    { id: 'profile', label: 'Profile', icon: <User size={20} /> },
    { id: 'courses', label: 'My Courses', icon: <BookOpen size={20} /> },
    { id: 'certificates', label: 'Certificates', icon: <GraduationCap size={20} /> },
    { id: 'ai-tutor', label: 'AI Tutor', icon: <svg size={20} className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z" /></svg> },
    { id: 'todo', label: 'To-Do List', icon: <CheckSquare size={20} /> },
    { id: 'planner', label: 'Planner', icon: <CalendarDays size={20} /> },
    { id: 'calendar', label: 'Calendar', icon: <CalendarIcon size={20} /> },
    { id: 'signout', label: 'Sign Out', icon: <LogOut size={20} /> }
];

const StudentDashboardLayout = ({ children, activeSection, setActiveSection }) => {
    const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

    const handleMenuItemClick = (itemId) => {
        console.log('Sidebar item clicked:', itemId);
        setActiveSection(itemId);
        setIsMobileMenuOpen(false); // Close mobile menu after selection
    };

    return (
        <div className="min-h-screen flex bg-gray-50">
            {/* Mobile Header with Hamburger */}
            <div className="lg:hidden fixed top-0 left-0 right-0 bg-white border-b border-gray-200 z-40 px-4 py-3 flex items-center justify-between">
                <span className="text-lg font-bold bg-clip-text text-transparent bg-gradient-to-r from-brand-navy to-brand-cyan">
                    Trendtactics Academy
                </span>
                <button
                    onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
                    className="p-2 rounded-lg hover:bg-gray-100 transition-colors"
                    aria-label="Toggle menu"
                >
                    {isMobileMenuOpen ? <X size={24} /> : <Menu size={24} />}
                </button>
            </div>

            {/* Mobile Overlay */}
            {isMobileMenuOpen && (
                <div
                    className="lg:hidden fixed inset-0 bg-black bg-opacity-50 z-40"
                    onClick={() => setIsMobileMenuOpen(false)}
                />
            )}

            {/* Sidebar */}
            <aside className={`
                fixed lg:static inset-y-0 left-0 z-50
                w-64 bg-white border-r border-gray-200 flex flex-col py-6 px-4
                transform transition-transform duration-300 ease-in-out
                ${isMobileMenuOpen ? 'translate-x-0' : '-translate-x-full lg:translate-x-0'}
            `}>
                <div className="mb-10 flex items-center justify-center">
                    <span className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-brand-navy to-brand-cyan">
                        Trendtactics Academy
                    </span>
                </div>

                <nav className="flex-1 space-y-1">
                    {sidebarItems.map((item) => (
                        <button
                            key={item.id}
                            className={`w-full flex items-center gap-3 px-4 py-3 rounded-xl text-left transition-all duration-200 font-medium group
                                ${activeSection === item.id
                                    ? 'bg-brand-navy text-white shadow-md'
                                    : 'text-gray-600 hover:bg-gray-50 hover:text-brand-navy'
                                }`}
                            onClick={() => handleMenuItemClick(item.id)}
                        >
                            <span className={`${activeSection === item.id ? 'text-brand-cyan' : 'text-gray-400 group-hover:text-brand-navy'}`}>
                                {item.icon}
                            </span>
                            {item.label}
                        </button>
                    ))}
                </nav>

                <div className="mt-auto px-4 py-4 border-t border-gray-100">
                    <div className="text-xs text-gray-400 text-center font-medium">
                        &copy; {new Date().getFullYear()} Trendtactics
                    </div>
                </div>
            </aside>

            {/* Main Content */}
            <main className="flex-1 overflow-y-auto h-screen bg-gray-50 lg:ml-0 pt-16 lg:pt-0">
                <div className="max-w-7xl mx-auto p-4 sm:p-6 lg:p-8">
                    {children}
                </div>
            </main>
        </div>
    );
};

export default StudentDashboardLayout;