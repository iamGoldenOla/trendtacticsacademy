import React from 'react';
import { Link } from 'react-router-dom';
// Removed mock data import to prevent using invalid course IDs
// import { digitalMarketingCourses } from '../data/digitalMarketingCourses';

const TestInteractiveWorkspace = () => {
  return (
    <div className="min-h-screen bg-gray-50 py-12 px-4">
      <div className="max-w-4xl mx-auto">
        <div className="bg-white rounded-xl shadow-lg p-8">
          <h1 className="text-3xl font-bold text-gray-900 mb-6">Test Interactive Learning Workspace</h1>
          
          <div className="mb-8 p-4 bg-blue-50 rounded-lg">
            <h2 className="text-xl font-semibold text-blue-900 mb-2">How to Access the New Workspace</h2>
            <p className="text-gray-700 mb-4">
              The Interactive Learning Workspace has been implemented, but you need to access it through the correct route.
            </p>
            <ul className="list-disc pl-5 space-y-2 text-gray-700">
              <li>Click on any course link below to access the <strong>NEW</strong> Interactive Learning Workspace</li>
              <li>Look for the three-panel layout (navigation, content, playground)</li>
              <li>If you see the old dashboard, you're accessing the wrong route</li>
            </ul>
          </div>
          
          <div className="mb-8">
            <h2 className="text-2xl font-semibold text-gray-900 mb-6">Available Courses</h2>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {/* Using empty array instead of mock data */}
              {[].map((course) => (
                <div key={course.id} className="border border-gray-200 rounded-lg p-6 hover:shadow-lg transition-shadow">
                  <h3 className="text-xl font-semibold text-gray-900 mb-2">{course.title}</h3>
                  <p className="text-gray-600 mb-4">{course.description.substring(0, 100)}...</p>
                  <div className="flex flex-wrap gap-3">
                    <Link 
                      to={`/course/${course.id}`} 
                      className="px-4 py-2 bg-brand-cyan text-white rounded-lg font-medium hover:bg-brand-navy transition-colors"
                    >
                      View NEW Workspace
                    </Link>
                    <Link 
                      to={`/my-courses/${course.id}`} 
                      className="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg font-medium hover:bg-gray-300 transition-colors"
                    >
                      View OLD Dashboard
                    </Link>
                  </div>
                </div>
              ))}
            </div>
          </div>
          
          <div className="p-4 bg-yellow-50 rounded-lg border border-yellow-200">
            <h3 className="font-semibold text-yellow-900 mb-2">💡 Important Notes</h3>
            <ul className="list-disc pl-5 space-y-1 text-yellow-800">
              <li>The <strong>NEW Workspace</strong> has a three-panel layout with navigation, content, and playground</li>
              <li>The <strong>OLD Dashboard</strong> has a single-column layout with lessons listed vertically</li>
              <li>If both links take you to the same page, there may be a routing configuration issue</li>
              <li>Check your browser's address bar to confirm which route you're on</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
};

export default TestInteractiveWorkspace;