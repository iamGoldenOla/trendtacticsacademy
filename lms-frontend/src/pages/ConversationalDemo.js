import React, { useState, useEffect } from 'react';
import conversationalCourseDemo from '../demo/conversationalCourseDemo';

const ConversationalDemo = () => {
  const [currentStep, setCurrentStep] = useState(0);
  const [isPlaying, setIsPlaying] = useState(false);
  const [displayedConversation, setDisplayedConversation] = useState([]);
  const [showCourseContent, setShowCourseContent] = useState(false);

  // Sample prompts for users to try
  const samplePrompts = conversationalCourseDemo.getSamplePrompts();

  // Auto-play conversation
  useEffect(() => {
    let interval;
    if (isPlaying && currentStep < conversationalCourseDemo.sampleConversation.length) {
      interval = setInterval(() => {
        setDisplayedConversation(prev => [
          ...prev,
          conversationalCourseDemo.sampleConversation[currentStep]
        ]);
        setCurrentStep(prev => prev + 1);
      }, 2000);
    } else if (currentStep >= conversationalCourseDemo.sampleConversation.length) {
      setIsPlaying(false);
      setTimeout(() => setShowCourseContent(true), 1000);
    }

    return () => clearInterval(interval);
  }, [isPlaying, currentStep]);

  const startDemo = () => {
    setIsPlaying(true);
    setCurrentStep(0);
    setDisplayedConversation([]);
    setShowCourseContent(false);
  };

  const resetDemo = () => {
    setIsPlaying(false);
    setCurrentStep(0);
    setDisplayedConversation([]);
    setShowCourseContent(false);
  };

  return (
    <div className="min-h-screen bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-4xl mx-auto">
        <div className="text-center mb-12">
          <h1 className="text-3xl font-bold text-gray-900 mb-4">Conversational Course Creation Demo</h1>
          <p className="text-lg text-gray-600">
            See how Trendy AI creates courses through natural conversation
          </p>
        </div>

        <div className="bg-white rounded-xl shadow-lg p-6 mb-8">
          <div className="flex flex-wrap gap-3 mb-6">
            <button
              onClick={startDemo}
              disabled={isPlaying}
              className="px-4 py-2 bg-brand-cyan text-white font-medium rounded-lg hover:bg-brand-navy transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {isPlaying ? 'Playing...' : 'Play Demo'}
            </button>
            <button
              onClick={resetDemo}
              className="px-4 py-2 bg-gray-200 text-gray-700 font-medium rounded-lg hover:bg-gray-300 transition-colors"
            >
              Reset Demo
            </button>
          </div>

          <div className="space-y-4 max-h-96 overflow-y-auto p-4 bg-gray-50 rounded-lg mb-6">
            {displayedConversation.length === 0 && !isPlaying && (
              <div className="text-center py-8 text-gray-500">
                <p>Click "Play Demo" to see a conversation example</p>
              </div>
            )}

            {displayedConversation.map((message, index) => (
              <div
                key={index}
                className={`p-4 rounded-lg ${
                  message.speaker === 'User'
                    ? 'bg-blue-50 border border-blue-200 ml-8'
                    : 'bg-purple-50 border border-purple-200 mr-8'
                }`}
              >
                <div className="flex justify-between items-start">
                  <div>
                    <span className={`font-medium ${
                      message.speaker === 'User' ? 'text-blue-700' : 'text-purple-700'
                    }`}>
                      {message.speaker}
                    </span>
                    <p className="mt-2 text-gray-800 whitespace-pre-wrap">{message.message}</p>
                  </div>
                </div>
              </div>
            ))}

            {isPlaying && currentStep < conversationalCourseDemo.sampleConversation.length && (
              <div className="p-4 rounded-lg bg-gray-100 border border-gray-200">
                <div className="flex space-x-2">
                  <div className="w-3 h-3 bg-gray-400 rounded-full animate-bounce"></div>
                  <div className="w-3 h-3 bg-gray-400 rounded-full animate-bounce delay-75"></div>
                  <div className="w-3 h-3 bg-gray-400 rounded-full animate-bounce delay-150"></div>
                </div>
              </div>
            )}
          </div>

          {showCourseContent && (
            <div className="mt-8 p-6 bg-gradient-to-r from-cyan-50 to-blue-50 rounded-xl border border-cyan-200">
              <h3 className="text-xl font-semibold text-gray-900 mb-4">Generated Course Content</h3>
              <div className="bg-white p-4 rounded-lg whitespace-pre-wrap text-gray-800 border border-gray-200">
                {conversationalCourseDemo.sampleCourseContent}
              </div>
            </div>
          )}
        </div>

        <div className="bg-white rounded-xl shadow-lg p-6">
          <h3 className="text-xl font-semibold text-gray-900 mb-4">Try These Prompts</h3>
          <p className="text-gray-600 mb-4">
            Use these examples to start creating your own courses:
          </p>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {samplePrompts.map((prompt, index) => (
              <div 
                key={index} 
                className="p-4 bg-gray-50 rounded-lg border border-gray-200 hover:bg-gray-100 transition-colors cursor-pointer"
                onClick={() => {
                  // In a real implementation, this would populate the input field
                  alert(`In a real implementation, this would populate the course creator with: "${prompt}"`);
                }}
              >
                <p className="text-gray-800">"{prompt}"</p>
              </div>
            ))}
          </div>
        </div>

        <div className="mt-8 bg-blue-50 border border-blue-200 rounded-xl p-6">
          <h3 className="text-lg font-semibold text-blue-900 mb-2">How It Works</h3>
          <ul className="list-disc pl-5 space-y-2 text-blue-800">
            <li>Trendy AI guides you through course creation with natural conversation</li>
            <li>Simply describe what you want to teach, and the AI asks relevant questions</li>
            <li>Based on your answers, it generates a structured course outline</li>
            <li>You can refine and customize the content as needed</li>
            <li>The final result is a professional course ready for your students</li>
          </ul>
        </div>
      </div>
    </div>
  );
};

export default ConversationalDemo;