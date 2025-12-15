import React, { useState, useEffect, useRef } from 'react';
import { Link } from 'react-router-dom';
import { User } from '../types';

interface HeaderProps {
  user: User | null;
  onLogin?: () => void;
  onSignup?: () => void;
  onLogout?: () => void;
}

const Header: React.FC<HeaderProps> = ({ user, onLogin, onSignup, onLogout }) => {
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [isUserMenuOpen, setIsUserMenuOpen] = useState(false);
  const [isDashboardMenuOpen, setIsDashboardMenuOpen] = useState(false);
  const userMenuRef = useRef<HTMLDivElement>(null);
  const dashboardMenuRef = useRef<HTMLDivElement>(null);

  // Close dropdown when clicking outside
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (userMenuRef.current && !userMenuRef.current.contains(event.target as Node)) {
        setIsUserMenuOpen(false);
      }
      if (dashboardMenuRef.current && !dashboardMenuRef.current.contains(event.target as Node)) {
        setIsDashboardMenuOpen(false);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, []);

  const navigation = [
    { name: 'Home', href: '/' },
    { name: 'About', href: '/about' },
    { name: 'Courses', href: '/courses' },
    { name: 'Contact', href: '/contact' },
  ];

  return (
    <header className="bg-white shadow-sm border-b border-gray-200">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-16">
          {/* Logo */}
          <div className="flex items-center">
            <div className="flex-shrink-0 flex items-center">
              {/* Graduation Cap Badge Icon */}
              <span className="inline-flex items-center justify-center w-10 h-10 rounded-full bg-brand-navy shadow-md mr-2">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 24 24"
                  fill="none"
                  className="w-6 h-6"
                  aria-hidden="true"
                >
                  <path d="M2 7.5L12 3l10 4.5-10 4.5L2 7.5z" fill="white"/>
                  <path d="M22 10.5v3c0 2.5-4.48 4.5-10 4.5S2 16 2 13.5v-3" stroke="white" strokeWidth="1.5" strokeLinejoin="round"/>
                  <path d="M6 17.5v2c0 .28.22.5.5.5h11a.5.5 0 0 0 .5-.5v-2" stroke="white" strokeWidth="1.5" strokeLinecap="round"/>
                </svg>
              </span>
              <Link to="/" className="text-2xl font-heading font-bold text-brand-navy hover:text-brand-cyan transition-colors">
                Trendtactics Academy
              </Link>
            </div>
          </div>

          {/* Desktop Navigation */}
          <nav className="hidden md:flex items-center ml-auto space-x-8">
            <Link to="/" className="transition-colors duration-200 hover:text-brand-cyan hover:font-bold hover:underline underline-offset-4">Home</Link>
            <Link to="/about" className="transition-colors duration-200 hover:text-brand-cyan hover:font-bold hover:underline underline-offset-4">About</Link>
            <Link to="/courses" className="transition-colors duration-200 hover:text-brand-cyan hover:font-bold hover:underline underline-offset-4">Courses</Link>
            
            {/* Dashboard Dropdown */}
            {user && (
              <div className="relative" ref={dashboardMenuRef}>
                <button
                    onClick={() => setIsDashboardMenuOpen(!isDashboardMenuOpen)}
                    className="transition-colors duration-200 hover:text-brand-cyan hover:font-bold hover:underline underline-offset-4 flex items-center gap-1"
                  >
                  Dashboard
                  <svg className="w-4 h-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                  </svg>
                </button>
                
                {isDashboardMenuOpen && (
                  <div className="absolute left-0 mt-2 w-48 bg-white rounded-md shadow-xl py-1 border border-gray-200" style={{zIndex: 9999}}>
                    <Link
                      to="/dashboard"
                      className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                      onClick={() => setIsDashboardMenuOpen(false)}
                    >
                      Overview
                    </Link>
                    <Link
                      to="/my-courses"
                      className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                      onClick={() => setIsDashboardMenuOpen(false)}
                    >
                      My Courses
                    </Link>
                    <Link
                      to="/planner"
                      className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 font-medium"
                      onClick={() => setIsDashboardMenuOpen(false)}
                    >
                      📅 Study Planner
                    </Link>
                    <Link
                      to="/ai-tutor"
                      className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 font-medium"
                      onClick={() => setIsDashboardMenuOpen(false)}
                    >
                      🤖 AI Tutor
                    </Link>
                  </div>
                )}
              </div>
            )}
            
            <Link to="/contact" className="transition-colors duration-200 hover:text-brand-cyan hover:font-bold hover:underline underline-offset-4">Contact</Link>
            {/* Sign In and Get Started buttons remain on the right */}
          </nav>

          {/* User Menu */}
          <div className="flex items-center space-x-4">
            {user ? (
              <div className="relative" ref={userMenuRef}>
                <button
                  onClick={() => {
                    console.log('User menu clicked, current state:', isUserMenuOpen);
                    setIsUserMenuOpen(!isUserMenuOpen);
                  }}
                  className="flex items-center space-x-2 text-gray-700 hover:text-brand-navy focus:outline-none"
                >
                  <div className="w-9 h-9 bg-brand-cyan rounded-full flex items-center justify-center text-white font-bold shadow-md border-2 border-white">
                    {user.name.charAt(0).toUpperCase()}
                  </div>
                  <span className="hidden md:block text-sm font-medium">{user.name}</span>
                  <svg className="w-4 h-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                  </svg>
                </button>

                {isUserMenuOpen && (
                  <div className="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-xl py-1 border border-gray-200" style={{zIndex: 9999, boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)'}}>
                    <Link
                      to="/profile"
                      className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                      onClick={() => setIsUserMenuOpen(false)}
                    >
                      Profile
                    </Link>
                    <hr className="my-1" />
                    <button
                      onClick={() => {
                        onLogout?.();
                        setIsUserMenuOpen(false);
                      }}
                      className="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                    >
                      Sign out
                    </button>
                  </div>
                )}
              </div>
            ) : (
              <div className="flex items-center space-x-4">
                <button
                  onClick={onLogin}
                  className="text-gray-700 hover:text-brand-navy px-3 py-2 text-sm font-medium transition-colors duration-200"
                >
                  Sign In
                </button>
                <button
                  onClick={onSignup}
                  className="btn-secondary"
                >
                  Get Started
                </button>
              </div>
            )}

            {/* Mobile menu button */}
            <button
              onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
              className="md:hidden inline-flex items-center justify-center p-2 rounded-md text-gray-700 hover:text-brand-navy hover:bg-gray-100 focus:outline-none"
            >
              <svg
                className="h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                {isMobileMenuOpen ? (
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                ) : (
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
                )}
              </svg>
            </button>
          </div>
        </div>

        {/* Mobile Navigation */}
        {isMobileMenuOpen && (
          <div className="md:hidden">
            <div className="px-2 pt-2 pb-3 space-y-1 sm:px-3 border-t border-gray-200">
              {navigation.map((item) => (
                <Link
                  key={item.name}
                  to={item.href}
                  className="text-gray-700 transition-colors duration-200 hover:text-brand-cyan hover:font-bold hover:underline underline-offset-4 block px-3 py-2 text-base font-medium"
                  onClick={() => setIsMobileMenuOpen(false)}
                >
                  {item.name}
                </Link>
              ))}
              {user && (
                <>
                  <div className="px-3 py-2 text-base font-medium text-gray-900 border-b border-gray-200">
                    Dashboard
                  </div>
                  <Link
                    to="/dashboard"
                    className="text-gray-700 transition-colors duration-200 hover:text-brand-cyan hover:font-bold hover:underline underline-offset-4 block px-6 py-2 text-base font-medium"
                    onClick={() => setIsMobileMenuOpen(false)}
                  >
                    Overview
                  </Link>
                  <Link
                    to="/my-courses"
                    className="text-gray-700 transition-colors duration-200 hover:text-brand-cyan hover:font-bold hover:underline underline-offset-4 block px-6 py-2 text-base font-medium"
                    onClick={() => setIsMobileMenuOpen(false)}
                  >
                    My Courses
                  </Link>
                  <Link
                    to="/planner"
                    className="text-gray-700 transition-colors duration-200 hover:text-brand-cyan hover:font-bold hover:underline underline-offset-4 block px-6 py-2 text-base font-medium"
                    onClick={() => setIsMobileMenuOpen(false)}
                  >
                    📅 Study Planner
                  </Link>
                  <Link
                    to="/ai-tutor"
                    className="text-gray-700 transition-colors duration-200 hover:text-brand-cyan hover:font-bold hover:underline underline-offset-4 block px-6 py-2 text-base font-medium"
                    onClick={() => setIsMobileMenuOpen(false)}
                  >
                    🤖 AI Tutor
                  </Link>
                </>
              )}
              {!user && (
                <>
                  <button
                    onClick={() => {
                      onLogin?.();
                      setIsMobileMenuOpen(false);
                    }}
                    className="text-gray-700 hover:text-brand-navy block px-3 py-2 text-base font-medium w-full text-left"
                  >
                    Sign In
                  </button>
                  <button
                    onClick={() => {
                      onSignup?.();
                      setIsMobileMenuOpen(false);
                    }}
                    className="btn-secondary block w-full text-center"
                  >
                    Get Started
                  </button>
                </>
              )}
            </div>
          </div>
        )}
      </div>
    </header>
  );
};

export default Header;