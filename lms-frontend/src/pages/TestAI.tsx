import React from 'react';

const TestAI: React.FC = () => {
  return (
    <div className="min-h-screen bg-gray-50 flex items-center justify-center">
      <div className="max-w-md mx-auto bg-white rounded-lg shadow-md p-8">
        <h1 className="text-2xl font-bold text-gray-900 mb-4">AI Tutor Test Page</h1>
        <p className="text-gray-600 mb-4">
          This is a test page to verify that routing is working correctly.
        </p>
        <div className="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded">
          ✅ If you can see this page, the routing system is working!
        </div>
        <div className="mt-6">
          <a 
            href="/ai-tutor" 
            className="inline-block bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition-colors"
          >
            Go to AI Tutor
          </a>
        </div>
      </div>
    </div>
  );
};

export default TestAI;