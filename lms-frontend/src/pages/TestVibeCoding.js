import React from 'react';
import { Link } from 'react-router-dom';

const TestVibeCoding = () => {
  return (
    <div className="min-h-screen bg-gray-50 py-12">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-12">
          <h1 className="text-4xl font-bold text-gray-900 mb-4">Vibe Coding Course</h1>
          <p className="text-xl text-gray-600 max-w-2xl mx-auto">
            Experience the future of digital education with our innovative Vibe Coding approach
          </p>
        </div>

        <div className="bg-white rounded-lg shadow-lg overflow-hidden mb-8">
          <div className="p-8">
            <div className="flex flex-col md:flex-row items-center">
              <div className="md:w-1/3 mb-6 md:mb-0 flex justify-center">
                <div className="bg-gradient-to-br from-blue-500 to-purple-600 rounded-full w-48 h-48 flex items-center justify-center">
                  <span className="text-white text-5xl font-bold">VC</span>
                </div>
              </div>
              <div className="md:w-2/3 md:pl-8">
                <h2 className="text-2xl font-bold text-gray-900 mb-4">What is Vibe Coding?</h2>
                <p className="text-gray-700 mb-6">
                  Vibe Coding is a revolutionary approach to digital creation that focuses on ideas, intention, creativity, and guidance — often with the help of AI — instead of memorizing code syntax or complex technical rules.
                </p>
                <div className="flex flex-wrap gap-2 mb-6">
                  <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-green-100 text-green-800">
                    Beginner-Friendly
                  </span>
                  <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800">
                    AI-Powered
                  </span>
                  <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-purple-100 text-purple-800">
                    No Coding Required
                  </span>
                </div>
                <Link
                  to="/vibe-coding/a1b2c3d4-e5f6-7890-abcd-ef1234567890"
                  className="inline-block bg-gradient-to-r from-blue-500 to-purple-600 text-white font-medium py-3 px-6 rounded-lg hover:from-blue-600 hover:to-purple-700 transition-all duration-300 transform hover:-translate-y-1 shadow-lg"
                >
                  Start Learning Vibe Coding
                </Link>
              </div>
            </div>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-12">
          <div className="bg-white p-6 rounded-lg shadow-md">
            <div className="text-blue-500 text-3xl mb-4">🧠</div>
            <h3 className="text-xl font-semibold text-gray-900 mb-2">Concepts First</h3>
            <p className="text-gray-600">
              Focus on understanding digital creation concepts before diving into tools or technical details.
            </p>
          </div>
          
          <div className="bg-white p-6 rounded-lg shadow-md">
            <div className="text-purple-500 text-3xl mb-4">🤖</div>
            <h3 className="text-xl font-semibold text-gray-900 mb-2">AI Collaboration</h3>
            <p className="text-gray-600">
              Work hand-in-hand with AI assistants to bring your creative visions to life.
            </p>
          </div>
          
          <div className="bg-white p-6 rounded-lg shadow-md">
            <div className="text-green-500 text-3xl mb-4">🚀</div>
            <h3 className="text-xl font-semibold text-gray-900 mb-2">Confidence Building</h3>
            <p className="text-gray-600">
              Build skills and confidence through small wins and safe experimentation.
            </p>
          </div>
        </div>

        <div className="bg-white rounded-lg shadow-lg p-8">
          <h2 className="text-2xl font-bold text-gray-900 mb-6 text-center">Course Modules</h2>
          <div className="space-y-6">
            {[
              {
                title: "Understanding Vibe Coding",
                description: "Learn the foundational concepts and philosophy behind Vibe Coding"
              },
              {
                title: "Thinking Before Coding",
                description: "Develop the skill of expressing ideas clearly before implementation"
              },
              {
                title: "Working with AI as a Creative Partner",
                description: "Learn how to collaborate effectively with AI tools"
              },
              {
                title: "Vibe Coding in Real Life",
                description: "See how Vibe Coding works in practical scenarios"
              },
              {
                title: "Exploring and Building with Confidence",
                description: "Use safe environments to experiment and build complete projects"
              }
            ].map((module, index) => (
              <div key={index} className="border-l-4 border-blue-500 pl-4 py-2">
                <h3 className="text-lg font-semibold text-gray-900">{index + 1}. {module.title}</h3>
                <p className="text-gray-600">{module.description}</p>
              </div>
            ))}
          </div>
          
          <div className="mt-8 text-center">
            <Link
              to="/vibe-coding/a1b2c3d4-e5f6-7890-abcd-ef1234567890"
              className="inline-block bg-gradient-to-r from-blue-500 to-purple-600 text-white font-medium py-3 px-8 rounded-lg hover:from-blue-600 hover:to-purple-700 transition-all duration-300 transform hover:-translate-y-1 shadow-lg"
            >
              Begin Your Vibe Coding Journey
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
};

export default TestVibeCoding;