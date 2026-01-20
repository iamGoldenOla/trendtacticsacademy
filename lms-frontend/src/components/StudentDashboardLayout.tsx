import React, { useState, ReactNode } from 'react';
import { Link } from 'react-router-dom';
import { Section } from '../types/Section';
import { Menu, X } from 'lucide-react'; // Import icons

interface StudentDashboardLayoutProps {
  children: ReactNode;
  activeSection: Section;
  setActiveSection: (section: Section) => void;
}

const sidebarItems: { id: Section; label: string; icon: string }[] = [
  { id: 'dashboard', label: 'Dashboard', icon: '🏠' },
  { id: 'profile', label: 'Profile', icon: '👤' },
  { id: 'courses', label: 'My Courses', icon: '📚' },
  { id: 'todo', label: 'To-Do List', icon: '✅' },
  { id: 'planner', label: 'Planner', icon: '📅' },
  { id: 'calendar', label: 'Calendar', icon: '🗓️' },
  { id: 'signout', label: 'Sign Out', icon: '🚪' }
];

const StudentDashboardLayout: React.FC<StudentDashboardLayoutProps> = ({ children, activeSection, setActiveSection }) => {
  const [isSidebarOpen, setIsSidebarOpen] = useState(false);

  const toggleSidebar = () => setIsSidebarOpen(!isSidebarOpen);

  return (
    <div className="min-h-screen flex bg-gray-50 relative">
      {/* Mobile Header with Hamburger */}
      <div className="md:hidden fixed top-0 left-0 right-0 bg-white border-b z-20 px-4 py-3 flex items-center justify-between">
        <span className="text-xl font-bold text-indigo-700">Trendtactics</span>
        <button onClick={toggleSidebar} className="p-2 text-gray-700 hover:bg-gray-100 rounded-lg">
          {isSidebarOpen ? <X size={24} /> : <Menu size={24} />}
        </button>
      </div>

      {/* Overlay for mobile sidebar */}
      {isSidebarOpen && (
        <div
          className="md:hidden fixed inset-0 bg-black bg-opacity-50 z-30"
          onClick={() => setIsSidebarOpen(false)}
        />
      )}

      {/* Sidebar */}
      <aside className={`
        fixed md:relative top-0 left-0 h-full z-40 w-64 bg-white shadow-lg flex flex-col py-8 px-4 transition-transform duration-300 ease-in-out
        ${isSidebarOpen ? 'translate-x-0' : '-translate-x-full md:translate-x-0'}
      `}>
        <div className="hidden md:block mb-8 text-2xl font-bold text-indigo-700 text-center">Trendtactics Academy</div>
        {/* Mobile Sidebar Header */}
        <div className="md:hidden flex items-center justify-between mb-8">
          <span className="text-xl font-bold text-indigo-700">Menu</span>
          <button onClick={() => setIsSidebarOpen(false)} className="p-1 text-gray-500">
            <X size={24} />
          </button>
        </div>

        <nav className="flex-1 overflow-y-auto">
          {sidebarItems.map((item, idx) => (
            <React.Fragment key={item.id}>
              <button
                className={`w-full flex items-center gap-3 px-4 py-3 mb-2 rounded-lg text-left transition-colors font-medium text-gray-700 hover:bg-indigo-50 ${activeSection === item.id ? 'bg-indigo-100 text-indigo-700' : ''}`}
                onClick={() => {
                  setActiveSection(item.id);
                  setIsSidebarOpen(false); // Close on selection (mobile)
                }}
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
                  onClick={() => setIsSidebarOpen(false)}
                >
                  <span className="text-xl">🎓</span>
                  Certificates
                </Link>
              )}
            </React.Fragment>
          ))}
        </nav>
        <div className="mt-auto pt-4 text-xs text-gray-400 text-center border-t">&copy; {new Date().getFullYear()} Trendtactics Academy</div>
      </aside>

      {/* Main Content */}
      <main className="flex-1 p-4 md:p-8 overflow-y-auto pt-16 md:pt-8 w-full">
        {children}
      </main>
    </div>
  );
};

export default StudentDashboardLayout;