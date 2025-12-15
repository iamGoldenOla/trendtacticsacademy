import React, { useState } from 'react';
import puterService from '../services/puterService';

const ConversationalCourseTest = () => {
  const [courseTopic, setCourseTopic] = useState('');
  const [conversation, setConversation] = useState([]);
  const [userInput, setUserInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [isInitialized, setIsInitialized] = useState(false);

  // Initialize Puter.js
  const initializeAI = async () => {
    try {
      const success = await puterService.initialize();
      setIsInitialized(success);
      if (success) {
        addToConversation("AI Assistant", "I'm ready to help you create a course! What topic would you like to explore?");
      } else {
        addToConversation("System", "Failed to initialize AI. Please check your connection and try again.");
      }
    } catch (error) {
      console.error('Initialization error:', error);
      addToConversation("System", "Error initializing AI: " + error.message);
    }
  };

  const addToConversation = (sender, text) => {
    const newMessage = {
      id: Date.now(),
      sender,
      text,
      timestamp: new Date()
    };
    setConversation(prev => [...prev, newMessage]);
  };

  const startCourseCreation = async () => {
    if (!courseTopic.trim()) return;
    
    setIsLoading(true);
    try {
      addToConversation("You", `I want to create a course about: ${courseTopic}`);
      
      // Initialize if not already done
      if (!isInitialized) {
        await initializeAI();
      }
      
      const response = await puterService.createConversationalCourse(courseTopic);
      addToConversation("AI Assistant", response);
      setCourseTopic('');
    } catch (error) {
      console.error('Course creation error:', error);
      addToConversation("System", "Error: " + error.message);
    } finally {
      setIsLoading(false);
    }
  };

  const sendUserMessage = async () => {
    if (!userInput.trim() || !isInitialized) return;
    
    setIsLoading(true);
    try {
      addToConversation("You", userInput);
      const userMessage = userInput;
      setUserInput('');
      
      // For demo purposes, we'll simulate a response
      // In a real implementation, this would connect to the AI service
      setTimeout(() => {
        addToConversation("AI Assistant", `Thanks for your input about "${userMessage}". In a full implementation, I would use this to refine your course content. Would you like to continue building your course on "${courseTopic || 'your chosen topic'}"?`);
        setIsLoading(false);
      }, 1000);
    } catch (error) {
      console.error('Message error:', error);
      addToConversation("System", "Error: " + error.message);
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-4xl mx-auto">
        <div className="text-center mb-12">
          <h1 className="text-3xl font-bold text-gray-900 mb-4">Conversational Course Creator Test</h1>
          <p className="text-lg text-gray-600">
            Test the conversational course creation feature with Trendy AI
          </p>
        </div>

        <div className="bg-white rounded-xl shadow-lg p-6 mb-8">
          <h2 className="text-xl font-semibold text-gray-900 mb-4">Create a Course Conversationally</h2>
          
          {!isInitialized ? (
            <div className="mb-6">
              <button
                onClick={initializeAI}
                className="px-6 py-3 bg-brand-cyan text-white font-medium rounded-lg hover:bg-brand-navy transition-colors"
              >
                Initialize AI Assistant
              </button>
              <p className="mt-2 text-sm text-gray-600">
                Click above to initialize the AI assistant for conversational course creation
              </p>
            </div>
          ) : (
            <div className="mb-6 p-4 bg-green-50 rounded-lg border border-green-200">
              <p className="text-green-800">✅ AI Assistant is ready!</p>
            </div>
          )}

          <div className="flex flex-col sm:flex-row gap-4 mb-6">
            <input
              type="text"
              value={courseTopic}
              onChange={(e) => setCourseTopic(e.target.value)}
              className="flex-1 px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-cyan"
              placeholder="Enter a course topic to get started..."
              disabled={!isInitialized || isLoading}
            />
            <button
              onClick={startCourseCreation}
              disabled={isLoading || !courseTopic.trim() || !isInitialized}
              className="px-6 py-3 bg-brand-cyan text-white font-medium rounded-lg hover:bg-brand-navy transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {isLoading ? 'Creating...' : 'Start Creating'}
            </button>
          </div>

          {conversation.length > 0 && (
            <div className="mt-8">
              <h3 className="text-lg font-semibold text-gray-900 mb-4">Conversation</h3>
              <div className="space-y-4 max-h-96 overflow-y-auto p-4 bg-gray-50 rounded-lg">
                {conversation.map((message) => (
                  <div
                    key={message.id}
                    className={`p-4 rounded-lg ${
                      message.sender === 'You'
                        ? 'bg-blue-50 border border-blue-200 ml-8'
                        : message.sender === 'AI Assistant'
                        ? 'bg-purple-50 border border-purple-200 mr-8'
                        : 'bg-red-50 border border-red-200'
                    }`}
                  >
                    <div className="flex justify-between items-start">
                      <div>
                        <span className={`font-medium ${
                          message.sender === 'You' 
                            ? 'text-blue-700' 
                            : message.sender === 'AI Assistant' 
                            ? 'text-purple-700'
                            : 'text-red-700'
                        }`}>
                          {message.sender}
                        </span>
                        <p className="mt-2 text-gray-800 whitespace-pre-wrap">{message.text}</p>
                      </div>
                      <span className="text-xs text-gray-500 ml-2">
                        {message.timestamp.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                      </span>
                    </div>
                  </div>
                ))}
                
                {isLoading && (
                  <div className="p-4 rounded-lg bg-gray-100 border border-gray-200">
                    <div className="flex space-x-2">
                      <div className="w-3 h-3 bg-gray-400 rounded-full animate-bounce"></div>
                      <div className="w-3 h-3 bg-gray-400 rounded-full animate-bounce delay-75"></div>
                      <div className="w-3 h-3 bg-gray-400 rounded-full animate-bounce delay-150"></div>
                    </div>
                  </div>
                )}
              </div>
              
              {isInitialized && conversation.length > 0 && (
                <div className="mt-6 flex flex-col sm:flex-row gap-4">
                  <input
                    type="text"
                    value={userInput}
                    onChange={(e) => setUserInput(e.target.value)}
                    className="flex-1 px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-cyan"
                    placeholder="Continue the conversation..."
                    disabled={isLoading}
                    onKeyPress={(e) => e.key === 'Enter' && sendUserMessage()}
                  />
                  <button
                    onClick={sendUserMessage}
                    disabled={isLoading || !userInput.trim()}
                    className="px-6 py-3 bg-purple-600 text-white font-medium rounded-lg hover:bg-purple-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    Send
                  </button>
                </div>
              )}
            </div>
          )}
        </div>

        <div className="bg-blue-50 border border-blue-200 rounded-xl p-6">
          <h3 className="text-lg font-semibold text-blue-900 mb-2">How It Works</h3>
          <ul className="list-disc pl-5 space-y-2 text-blue-800">
            <li>Initialize the AI assistant to enable conversational course creation</li>
            <li>Enter a topic you'd like to create a course about</li>
            <li>Start a conversation with the AI to define your course structure</li>
            <li>Provide feedback and iterate on the course content</li>
            <li>In a full implementation, this would connect to actual AI services</li>
          </ul>
          <div className="mt-4 p-4 bg-yellow-50 rounded-lg border border-yellow-200">
            <p className="text-yellow-800 text-sm">
              <strong>Note:</strong> This is a demonstration page. In a production environment, 
              this would connect to actual AI services through puter.js to create real courses.
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ConversationalCourseTest;